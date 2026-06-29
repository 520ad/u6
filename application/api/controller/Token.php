<?php

namespace app\api\controller;

use app\common\controller\Api;
use fast\Random;
use think\Config;

/**
 * Token接口
 */
class Token extends Api
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

    /**
     * 检测Token是否过期
     *
     */
    public function check()
    {
        $token = $this->auth->getToken();
        $tokenInfo = \app\common\library\Token::get($token);
        $appid = $this->request->request('app_id');
        $apkmark = $this->request->request('apk_mark');
        $data = [
            'token' => $tokenInfo['token'],
            'expires_in' => $tokenInfo['expires_in']
        ];
        $this->success_encrypted($appid, $data, $apkmark);
    }

    /**
     * 刷新Token
     *
     */
    public function refresh()
    {
        //删除源Token
        $token = $this->auth->getToken();
        \app\common\library\Token::delete($token);
        $appid = $this->request->request('app_id');
        $apkmark = $this->request->request('apk_mark');
        //创建新Token
        $token = Random::uuid();
        \app\common\library\Token::set($token, $this->auth->id, $appid, intval(Config::get('site.token_lifespan')));
        $tokenInfo = \app\common\library\Token::get($token);
        $data = [
            'token' => $tokenInfo['token'],
            'expires_in' => $tokenInfo['expires_in']
        ];
        $this->success_encrypted($appid, $data, $apkmark);
    }

    /**
     * 授权验证逻辑
     */
    private function checkAuthorize($num)
    {
    }
}
