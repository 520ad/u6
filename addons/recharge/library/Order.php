<?php

namespace addons\recharge\library;

use app\common\model\box\Qrcode;
use app\common\library\Auth;
use app\common\model\User;
use think\Exception;
use think\Config;
use think\Db;
use epay\AlipayNotify;
use epay\AlipaySubmit;

class Order
{

    /**
     * 发起订单支付
     *
     * @param float  $money     金额
     * @param string $paytype   支付类型
     * @param string $method    支付方法
     * @param string $openid    Openid
     * @param string $notifyurl 通知地址
     * @param string $returnurl 返回地址
     * @return \addons\epay\library\Collection|\addons\epay\library\RedirectResponse|\addons\epay\library\Response
     * @throws Exception
     */
    public static function submit($money, $paytype = 'wechat', $method = 'web', $openid = '', $notifyurl = '', $returnurl = '', $memo = '')
    {
        $auth = Auth::instance();
        $site = Config::get('site');
        $user_id = $auth->isLogin() ? $auth->id : 0;
        $order = null;

        //检测是否有收银台在线
        if ($site['payment_platform'] == 1 && $site['disconnect'] == 2) {
            $modelCashier = new \app\api\controller\Cashier;
            if (!$modelCashier->checkHeartbeat($user_id)) {
                $paydata = [
                    'code'   => 0,
                    'msg'    => "收银台掉线,如果您是用户请联系客服",
                    'url'    => $money,
                    'orderId' => $money,
                    'price'  => $money,
                    'reallyPrice' => $money,
                    'data'  => $money,
                ];
                return json_encode($paydata, 320);
            }
        } 

        $config = get_addon_config('recharge');
        if ($config && $config['ordercreatelimit']) {
            $order = \addons\recharge\model\Order::where('user_id', $user_id)
                ->where('amount', $money)
                ->where('status', 'created')
                ->order('id', 'desc')
                ->find();
        }
        
        $request = \think\Request::instance();
        if (!$order) {
            $qrCodeUrl = false;
            $reallyPrice = $money;
            $orderid = date("Ymdhis") . sprintf("%08d", $user_id) . mt_rand(1000, 9999);
            if ($site['payment_platform'] == 1) { //后台自带平台需要格外处理订单信息
                $ok = false;
                $reallyPrice = bcmul($money, 100);
                for ($i = 0; $i < 20; $i++) { //不同订单创建不同的金额，用于区分回调。尝试20次
                    $tmpPrice = $reallyPrice . "-" . $paytype;
                    $box_tmpprice = config('database.prefix') . 'box_tmpprice';
                    $row = Db::execute("INSERT IGNORE INTO $box_tmpprice (price,oid) VALUES ('" . $tmpPrice . "','" . $orderid . "')");
                    if ($row) { //插入数据成功跳出循环。失败就调整金额重新插入
                        $ok = true;
                        break;
                    }
                    if ($site['amount_conflict'] == 1) {
                        $reallyPrice++;
                    } elseif ($site['amount_conflict'] == 2) {
                        $reallyPrice--;
                    } else {
                        $reallyPrice == 8888;
                        break;
                    }
                }

                if (!$ok || $reallyPrice == 8888) { //未支付且没用过期的订单超出20个
                    $paydata = [
                        'code'    => 0,
                        'msg'     => "订单超出负荷，请过一会再试",
                        'url'     => $money,
                        'orderId' => $orderid,
                        'price'   => $money,
                        'allocationamount' => $money,
                        'data'    => $money,
                    ];
                    return json_encode($paydata, 320); //返回错误信息
                }

                $reallyPrice = bcdiv($reallyPrice, 100, 2);
                
                //尝试分配带金额的支付二维码
                $qrCodeUrl = Qrcode::where(["price" => $reallyPrice, "codedata" => "regular", "platformdata" => $paytype])->value('qrcode');
                if (empty($qrCodeUrl)) $qrCodeUrl = Qrcode::where(["codedata" => "currency", "platformdata" => $paytype])->value('qrcode');
                if (empty($qrCodeUrl) || !$qrCodeUrl) {
                    $paydata = [
                        'code'   => 0,
                        'msg'    => "后台未配置收款二维码",
                        'url'    => $money,
                        'orderid' => $orderid,
                        'price'  => $money,
                        'allocationamount' => $reallyPrice,
                        'data'  => $money,
                    ];
                    return json_encode($paydata, 320); //返回错误信息
                }
            }
            
            $data = [
                'orderid'   => $orderid,
                'user_id'   => $user_id,
                'amount'    => $money,
                'allocationamount' => $reallyPrice, //实际需支付金额、自带支付平台需要
                'payurl'    => $qrCodeUrl, //二维码地址、自带支付平台需要
                'payamount' => 0,
                'paytype'   => $paytype,
                'memo'      => $memo,
                'ip'        => $request->ip(),
                'useragent' => substr($request->server('HTTP_USER_AGENT'), 0, 255),
                'status'    => 'created'
            ];
            $order = \addons\recharge\model\Order::create($data);
        }

        if ($site['payment_platform'] == 1) { //系统自带接口
            $payUrl = $request->root(true) . "/addons/epay/api/default";
            $orderid = $order->orderid;
            return <<<HTML
            <form id="defaultsubmit" name="defaultsubmit" action="{$payUrl}" method="POST">
                <input type="hidden" name="orderid" value="{$orderid}">
                <input type="submit" value="支付跳转中......">
            </form>
            <script>
                document.forms['defaultsubmit'].submit();
            </script>
            HTML;
        }
        if ($site['payment_platform'] == 2) { //聚合支付接口请求订单: 微信、支付宝官方接口
            $epay = get_addon_info('epay');

            if (empty($epay) || !$epay['state']) {
                $result = \think\Hook::listen('recharge_order_submit', $order);
                if (!$result) {
                    throw new Exception("请先在后台安装并配置微信支付宝整合插件");
                }
            }
    
            $notifyurl = $notifyurl ? $notifyurl : $request->root(true) . '/index/recharge/epay/type/notify/paytype/' . $paytype;
            $returnurl = $returnurl ? $returnurl : $request->root(true) . '/index/recharge/epay/type/return/paytype/' . $paytype;
    
            $params = [
                'amount'    => $money,
                'orderid'   => $order->orderid,
                'type'      => $paytype,
                'title'     => "充值{$money}元",
                'notifyurl' => $notifyurl,
                'returnurl' => $returnurl,
                'method'    => $method,
                'openid'    => $openid
            ];
    
            //小程序和公众号openid不能为空
            if (in_array($method, ['mp', 'miniapp']) && empty($openid)) {
                throw new Exception("公众号和小程序支付openid不能为空！");
            }
    
            $response = \addons\epay\library\Service::submitOrder($params);
            return $response;
        }

        if ($site['payment_platform'] == 3) { //易支付接口请求订单: 易支付、码支付
            $paytype = $paytype == "wechat" ? "wxpay" : $paytype;
            $notifyurl = $request->root(true) . '/index/recharge/easytopay/type/notify/paytype/' . $paytype;
            $returnurl = $request->root(true) . '/index/recharge/easytopay/type/return/paytype/' . $paytype;
            $pay_config = \addons\recharge\library\Order::getpay($paytype);
            $payobj = new AlipaySubmit($pay_config);
            $parameter = array( //整合支付数据
                "pid" => $pay_config['partner'],
                "type" => $paytype,
                "notify_url" => $notifyurl,
                "return_url" => $returnurl,
                "out_trade_no" => $order->orderid,
                "name" => $site['name'] . "充值{$money}元",
                "money"    => $money,
                "sitename" => $site['name'],
                "param" => $auth->isLogin() ? $auth->username : "空空如也", //备注会员账户
            );
            return $payobj->buildRequestForm($parameter);
        }
    }

    /**
     * 订单结算
     * @param int    $orderid   订单号
     * @param float  $payamount 支付金额
     * @param string $memo      备注
     * @return bool
     */
    public static function settle($orderid, $payamount, $memo = '')
    {
        $order = \addons\recharge\model\Order::getByOrderid($orderid);
        if (!$order) {
            return false;
        }
        if ($payamount != $order['amount']) {
            \think\Log::write("[recharge][pay][{$orderid}][订单支付金额不一致]");
            return false;
        }
        if ($order['status'] != 'paid') {
            $order->payamount = $payamount;
            $order->paytime = time();
            $order->status = 'paid';
            $order->memo = $memo;
            $order->save();

            // 更新会员余额
            User::money($payamount, $order->user_id, '充值');

            $result = \think\Hook::listen('recharge_order_settled', $order);
        }
        return true;
    }

    public static function pay_notify($type)
    {
        $pay_config = \addons\recharge\library\Order::getpay($type);
        $notifyobj = new AlipayNotify($pay_config);
        $verify_result = $notifyobj->verifyNotify();
        if ($verify_result) {
            return true;
        } else {
            return false;
        }
    }

    //获取易支付配置
    public static function getpay($type)
    {
        $config = Config::get('site');
        $payInfo = null;
        if ($type == 'wxpay') {
            $payInfo['partner'] = $config['merchant_id_wechat'];
            $payInfo['pkey'] = $config['merchant_key_wechat'];
            $payInfo['real_apiurl'] = $config['api_wechat'];
        } else if ($type == 'alipay') {
            $payInfo['partner'] = $config['merchant_id_alipay'];
            $payInfo['pkey'] = $config['merchant_key_alipay'];
            $payInfo['real_apiurl'] = $config['api_alipay'];
        } else if ($type == 'qq') { //暂不支持
            $payInfo['partner'] = $config['merchant_id_qq'];
            $payInfo['pkey'] = $config['merchant_key_qq'];
            $payInfo['real_apiurl'] = $config['api_qq'];
        }
        $data = [
            "partner" => $payInfo['partner'],
            "key" => $payInfo['pkey'],
            "sign_type" => "MD5",
            "input_charset" => "utf-8",
            "transport" => "http://",
            "apiurl" => $payInfo['real_apiurl'],
            "real_apiurl" => $payInfo['real_apiurl'],
        ];
        return $data;
    }      
}
