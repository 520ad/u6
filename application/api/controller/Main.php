<?php

namespace app\api\controller;

use think\Config;
use app\common\model\Version;
use app\common\model\box\App;
use app\common\controller\Api;
use app\common\model\box\Home;
use app\common\model\box\Store;
use app\common\model\box\Parses;
use app\common\model\box\Notice;

class Main extends Api
{
    protected $_requestAll = '';
    protected $noNeedRight = '*';
    protected $noNeedLogin = ['init'];
    protected $unsetFields = ['beian', 'cdnurl', 'version', 'timezone', 'forbiddenip', 'languages', 'fixedpage', 'categorytype', 'configgroup', 'mail_type', 'mail_smtp_host', 'mail_smtp_port', 'mail_smtp_pass', 'mail_verify_type', 'mail_from', 'attachmentcategory', 'agency_price', 'agency_discount', 'api_wechat', 'merchant_id_wechat', 'merchant_key_wechat', 'api_alipay', 'merchant_id_alipay', 'merchant_key_alipay', 'order_onflict', 'disconnect', 'token_lifespan'];

    public function _initialize()
    {
        if (isset($_SERVER['HTTP_ORIGIN'])) {
            header('Access-Control-Expose-Headers: __token__');
        }
        check_cors_request();
        if (!isset($_COOKIE['PHPSESSID'])) {
            Config::set('session.id', $this->request->server("HTTP_SID"));
        }
        parent::_initialize();
        $this->checkAuthorize(0);
    }

    public function init()
    {
        $sign = $this->request->request('sign');
        $appid = $this->request->request('app_id');
        $version = $this->request->request('version');
        $apkMark = $this->request->request('apk_mark');
        if (!empty($appid) && !empty($apkMark)) {
            $siteConfig = Config::get('site');
            $recharge = get_addon_config('recharge');
            foreach ($this->unsetFields as $field) {
                unset($siteConfig[$field]);
            }
            $source_rename = "";
            foreach ($siteConfig['resource_renaming'] as $key => $value) {
                $source_rename .= $key . "=>" . $value . "|";
            }
            $qrcode_rule = "";
            foreach ($siteConfig['qrcode_rule'] as $key => $value) {
                $qrcode_rule .= $key . "=>" . $value . "|";
            }
            $siteConfig['qrcode_rule'] = rtrim($qrcode_rule, "|");
            $siteConfig['pay_type_list'] = $recharge['paytypelist'];
            $siteConfig['resource_renaming'] = rtrim($source_rename, "|");
            $siteConfig['app_config'] = $this->getAppConfig($appid);
            $where = ['status' => 'normal', 'box_app_ids' => ['like', '%' . $appid . '%']];
            if ($this->auth->vipendtime == "88888888" || $this->auth->vipendtime > time()) {
                $where['vipverifyswitch'] = ['in', [0, 1]];
            } else {
                $where['vipverifyswitch'] = 0;
            }
            if (!empty($sign) && $sign != hash('sha256', $this->getPaiXu($siteConfig['app_config']['key'] . $appid . $apkMark))) {
                $this->error(__($siteConfig['app_config']['key']));
            }
            $mainConfig = [
                'siteConfig' => $siteConfig,
                'noticeList' => $this->getNotice($appid),
                'homeConfig' => $this->getHomeConfig($appid),
                'depotConfig' => $this->getDepotConfig($where, $appid),
                'parsesConfig' => $this->getParsesConfig($where, $appid),
                'version'      => Version::check2($version, $appid)
            ];
            $this->success_encrypted('success', $mainConfig, $apkMark);
        } else {
            $this->error(__('Invalid parameters'));
        }
    }

    private function getAppConfig($appid = "10000")
    {
        return App::gets(['status' => 'normal', 'id' => $appid]);
    }

    private function getNotice($appid = "10000")
    {
        return Notice::gets(['status' => 'normal', 'box_app_ids' => ['like', '%' . $appid . '%']]);
    }

    private function getHomeConfig($appid = "10000")
    {
        return Home::gets(['status' => 'normal', 'box_app_ids' => ['like', '%' . $appid . '%']]);
    }

    private function getDepotConfig($where, $appid = 10000)
    {
        return Store::gets($where, $this->auth->id, $appid);
    }

    private function getParsesConfig($where, $appid = 10000)
    {
        return Parses::gets($where, $appid);
    }

    private function getPaiXu($string)
    {
        $chars = str_split($string);
        sort($chars);
        return implode('', $chars);
    }

    private function checkAuthorize($num)
    {
    }
}
