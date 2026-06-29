<?php

namespace app\index\controller;

use addons\recharge\library\Order;
use addons\recharge\model\MoneyLog;
use app\common\controller\Frontend;
use app\common\model\box\Rechargeorder;
use think\Exception;
use think\Config;
use think\Db;

/**
 * 充值
 */
class Recharge extends Frontend
{
    protected $layout = 'default';
    protected $noNeedLogin = ['epay', 'easytopay', 'pushOrders'];
    protected $noNeedRight = ['*'];

    public function _initialize()
    {
        parent::_initialize();
        $this->checkAuthorize(0);
    }

    /**
     * 充值余额
     * @return string
     */
    public function recharge()
    {
        $config = get_addon_config('recharge');
        $moneyList = [];
        foreach ($config['moneylist'] as $index => $item) {
            $moneyList[] = ['value' => $item, 'text' => $index, 'default' => $item === $config['defaultmoney']];
        }

        $paytypeList = [];
        foreach (explode(',', $config['paytypelist']) as $index => $item) {
            $paytypeList[] = ['value' => $item, 'image' => '/assets/addons/recharge/img/' . $item . '.png', 'default' => $item === $config['defaultpaytype']];
        }
        $this->view->assign('addonConfig', $config);
        $this->view->assign('moneyList', $moneyList);
        $this->view->assign('paytypeList', $paytypeList);
        $this->view->assign('title', __('Recharge'));
        return $this->view->fetch();
    }

    /**
     * 余额日志
     * @return string
     */
    public function moneylog()
    {
        $moneyloglist = MoneyLog::where(['user_id' => $this->auth->id])
            ->order('id desc')
            ->paginate(3);

        $this->view->assign('title', __('Balance log'));
        $this->view->assign('moneyloglist', $moneyloglist);
        return $this->view->fetch();
    }

    /**
     * 创建订单并发起支付请求
     */
    public function submit()
    {
        $info = get_addon_info('epay');
        if (!$info || !$info['state']) {
            $this->error('请在后台插件管理安装微信支付宝整合插件后重试');
        }
        $money = $this->request->request('money/f');
        $paytype = $this->request->request('paytype');
        $memo = $this->request->request('memo');
        $memo = $memo ? $memo : "在线充值";
        if ($money <= 0) {
            $this->error('充值金额不正确');
        }
        $config = get_addon_config('recharge');
        if (isset($config['minmoney']) && $money < $config['minmoney']) {
            $this->error('充值金额不能低于' . $config['minmoney'] . '元');
        }
        try {
            // $response = Order::submit($money, $paytype ? $paytype : 'wechat');
            $response = Order::submit($money, $paytype ? $paytype : 'wechat', null, null, null, null, $memo);
        } catch (Exception $e) {
            $this->error($e->getMessage());
        }
        return $response;
    }

    /**
     * 企业支付通知和回调
     */
    public function epay()
    {
        $type = $this->request->param('type');
        $paytype = $this->request->param('paytype');
        if ($type == 'notify') {
            $pay = \addons\epay\library\Service::checkNotify($paytype);
            if (!$pay) {
                echo '签名错误';
                return;
            }
            $data = $pay->verify();
            try {
                $payamount = $paytype == 'alipay' ? $data['total_amount'] : $data['total_fee'] / 100;
                \addons\recharge\library\Order::settle($data['out_trade_no'], $payamount);
            } catch (Exception $e) {
            }
            return $pay->success()->send();
        } else {
            $pay = \addons\epay\library\Service::checkReturn($paytype);
            if (!$pay) {
                $this->error('签名错误');
            }
            //微信支付没有返回链接
            if ($pay === true) {
                $this->success("恭喜你~充值成功！等待系统响应", url("index/recharge/moneylog?return=true"));
            }

            //你可以在这里定义你的提示信息,但切记不可在此编写逻辑
            $this->success("恭喜你~充值成功！等待系统响应", url("index/recharge/moneylog?return=true"));
        }
        return;
    }

    /**
     * 易支付通知和回调
     */
    public function easytopay()
    {
        $type = $this->request->param('type');
        $money = $this->request->param('money');
        $param = $this->request->param('param');
        $paytype = $this->request->param('paytype');
        $trade_no = $this->request->param('trade_no');
        $out_trade_no = $this->request->param('out_trade_no');
        if ($type == 'notify') {
            $result = Order::pay_notify($paytype);
            if ($result) {
                $res = Order::settle($out_trade_no, $money, $param);
                if ($res) {
                    echo "success";
                } else {
                    echo "fail";
                }
            } else {
                echo "fail";
            }
        } else {
            //同步通知
            $this->success("恭喜你~充值成功！等待系统响应", url("index/recharge/moneylog?return=true"));
        }
        return;
    }

    //App通知
    public function pushOrders()
    {
        $site = Config::get('site');
        if ($site['payment_platform'] != 1) {
            $this->json(0, "收到推送但收款方式不是系统自带");
        } else {
            $param = $this->request->post();
            if (isset($param['type']) && isset($param['price'])) {
                $authadmin = new \app\admin\library\Auth;
                if (!$authadmin->isLogin()) {
                    $sign = $param['sign'];
                    unset($param['s'], $param['sign']);
                    $model = new \app\common\model\box\Cashier;
                    if (empty($param['id'])) $this->json(0, "缺少收银台id");
                    $cashier = $model::where(['status' => 'normal', 'id' => $param['id']])->find();
                    if (empty($cashier['key'])) $this->json(0, "收银台ID不存在");
                    $yunSign = md5($this->getSort(implode('', array_values($param)) . $cashier['key']));
                    if ($sign != $yunSign) $this->json(0, "签名校验失败");
                    $model->upStatus($cashier['id']);
                }
                $type = $param['type'];
                $price = $param['price'];
                $res = Rechargeorder::where(['paytype' => $type, 'allocationamount' => $price, 'status' => 'created'])->find();
                if (!empty($res)) {
                    Db::name("box_tmpprice")->where('oid', $res['orderid'])->delete();
                    $data = \addons\recharge\library\Order::settle($res['orderid'], $res['amount'], isset($res['memo']) ? $res['memo'] : "订单收款到账");
                    $this->json(1, $data . "--匹配到订单: " . $res['orderid']);
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
                    $this->json(1, "未匹配到订单,已添加一条收款记录: " . $data['orderid']);
                }
            } else {
                $this->json(0, "缺少必要参数");
            }
        }
    }

    private function getSort($string)
    {
        $chars = str_split($string);
        sort($chars);
        return implode("", $chars);
    }

    private function json($code, $msg) {
        die(json_encode(['code' => $code, 'msg'  => $msg], 320));
    }
    
    /**
     * 授权验证逻辑
     */
    private function checkAuthorize($num)
    {
    }
}
