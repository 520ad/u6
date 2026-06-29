<?php

namespace app\api\controller;

use app\common\controller\Api;
use think\Config;

class Invite extends Api
{

    protected $noNeedLogin = [];
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
    }

    public function index()
    {
        $appid = $this->request->request('app_id');
        $apkmark = $this->request->request('apk_mark');
        $inviteCount = \addons\invite\model\Invite::where(['user_id' => $this->auth->id])->count();
        $invite = get_addon_config('invite');
        $this->success_encrypted("+" . $invite['invitedscore'] . "/人", "已邀请" . $inviteCount . "人", $apkmark);
    }

    /**
     * 授权验证逻辑
     */
    private function checkAuthorize($num)
    {
    }
}