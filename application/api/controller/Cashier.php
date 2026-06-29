<?php

namespace app\api\controller;

use app\common\controller\Api;
use app\common\model\box\Rechargeorder;
use app\common\model\box\Cashier as Cashiers;
use app\common\library\Ems;
use app\common\library\Email;
use fast\Random;
use think\Config;
use think\Hook;
use think\Db;

class Cashier extends Api
{

    protected $param;
    protected $noNeedLogin = '*';
    protected $noNeedRight = '*';

    public function _initialize()
    {
        if (isset($_SERVER['HTTP_ORIGIN'])) {
            header('Access-Control-Expose-Headers: __token__'); //跨域让客户端获取到
        }

        //跨域检测
        check_cors_request();
        if (!isset($_COOKIE['PHPSESSID'])) {
            Config::set('session.id', $this->request->server("HTTP_SID"));
        }

        parent::_initialize();
        $this->checkAuthorize(0);
        $this->closeEndOrder();
        $this->authVerify();
    }

    //检测心跳 https://app.lvdoui.net/api/cashier/heartbeat
    public function heartbeat()
    {
        $this->success(date("Y-m-d H:i:s"));
    }

    //App推送通知 https://app.lvdoui.net/api/cashier/pushOrders?type=1&price=1
    public function pushOrders()
    {
        $site = Config::get('site');
        if ($site['payment_platform'] != 1) {
            $this->error(__('收到推送但收款方式不是系统自带'));
        } else {
            if (isset($this->param['type']) && isset($this->param['price']) ) {
                $type = $this->param['type'];
                $price = $this->param['price'];
                $res = Rechargeorder::where(['paytype' => $type, 'allocationamount' => $price, 'status' => 'created'])->find();
            } else {
                $this->error("缺少必要参数");
            }
            if (!empty($res)) {
                Db::name("box_tmpprice")->where('oid', $res['orderid'])->delete();
                \addons\recharge\library\Order::settle($res['orderid'], $res['amount'], isset($res['memo']) ? $res['memo'] : "订单收款到账");
                $this->success('匹配到订单: ' . $res['orderid']);
            } else {
                $data = [
                    'orderid'     => date("Ymdhis") . sprintf("%08d", 1) . mt_rand(1000, 9999),
                    'user_id'     => 1,
                    'amount'      => $price,
                    'payamount'   => $price,
                    'paytype'     => $type,
                    'ip'          => "127.0.0.1",
                    'useragent'   => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36 Edg/121.0.0.0",
                    'status'      => 'paid',
                    'memo'        => "收款到账但未匹配到订单",
                    'allocationamount' => $price, //实际需支付金额、自带支付平台需要
                ];
                \addons\recharge\model\Order::create($data);
                $this->success('未匹配到订单,已添加一条收款记录');
            }
        }
    }

    //处理超过5分钟未支付订单: 状态:created=未支付,paid=已支付,expired=已过期,close=已关闭
    public function closeEndOrder()  
    {  
        $operationTime = time();   
        $closeDate = $operationTime - 300;  
        Db::startTrans();  
        try {  
            $res = Rechargeorder::where('status', 'created')->where('createtime', '<=', $closeDate)->update(['status' => 'expired', 'updatetime' => $operationTime]);
            if ($res) {  
                $updatedOrderIds = Rechargeorder::where('updatetime', $operationTime)->column('orderid');  
                if (!empty($updatedOrderIds)) {  
                    Db::name("box_tmpprice")->where('oid', 'in', $updatedOrderIds)->delete();  
                }  
                $unmatchedOids = Db::name("box_tmpprice")
                    ->alias('tp')
                    ->field('tp.oid')  
                    ->whereNotExists(function ($query) {  
                        $query->name('Rechargeorder')->field('orderid')->where('Rechargeorder.orderid', 'tp.oid');  
                    })  
                    ->select();  
                if (!empty($unmatchedOids)) {
                    $unmatchedOidList = array_column($unmatchedOids->toArray(), 'oid');  
                    Db::name("box_tmpprice")->where('oid', 'in', $unmatchedOidList)->delete();  
                }  
                Db::commit();  
            } //为空时没有数据需要处理,不需要回滚
        } catch (\Exception $e) {  
            Db::rollback();  
        }  
    }

    //是否有收银台在线
    public function checkHeartbeat($user_id)
    {
        Cashiers::where('jkstate', 1)->where('lasthearttime', '<=', time() - 60)->update(['jkstate' => 0]);
        $cashier = Cashiers::where('jkstate', 1)->find();
        if (empty($cashier)) {
            $admin = \app\admin\model\Admin::where('id', 1)->find(); //获得管理员邮箱
            $last = Ems::get($admin['email'], "cashier");
            if (empty($last) || time() - $last['createtime'] > 43200) {
                $this->send($admin['email'], $user_id, "cashier");
            }
            return false;
        }
        return true;
    }

    /**
     * 发送验证码
     *
     * @param int    $email 邮箱
     * @param int    $code  验证码,为空时将自动生成4位数字
     * @param string $event 事件
     * @return  boolean
     */
    public function send($email, $code = null, $event = 'default')
    {
        $code = is_null($code) ? Random::numeric(config('captcha.length')) : $code;
        $time = time();
        $ip = request()->ip();
        $ems = \app\common\model\Ems::create(['event' => $event, 'email' => $email, 'code' => $code, 'ip' => $ip, 'createtime' => $time]);
        if (!Hook::get('ems_send')) {
            //采用框架默认的邮件推送
            Hook::add('ems_send', function ($params) {
                $obj = new Email();
                $result = $obj
                    ->to($params->email)
                    ->subject('监听端掉线提醒')
                    ->message("您的收银台已掉线，请尽快处理。")
                    ->send();
                return $result;
            });
        }
        $result = Hook::listen('ems_send', $ems, null, true);
        if (!$result) {
            $ems->delete();
            return false;
        }
        return true;
    }

    // 计算签名(拼接所有参数值+key取MD5)
    private function authVerify()
    {
        $authadmin = new \app\admin\library\Auth;
        $this->param = $this->request->request();
        if (!$authadmin->isLogin()) {
            $sign = $this->param['sign'];
            unset($this->param['s'], $this->param['sign']);
            if (empty($this->param['id'])) $this->error('缺少收银台id');
            $cashier = Cashiers::where(['status' => 'normal', 'id' => $this->param['id']])->find();
            if (empty($cashier['key'])) $this->error('收银台ID不存在');
            $yunSign = md5($this->getSort(implode('', array_values($this->param)) . $cashier['key']));
            if ($sign != $yunSign) $this->error('签名校验失败');
            Cashiers::where("id", $cashier['id'])->update(array("lasthearttime" => time(), "jkstate" => 1));
        }
    }

    private function getSort($string) {
        $chars = str_split($string);
        sort($chars);
        return implode("", $chars);
    }

    private function checkAuthorize($num)
    {
    }
}