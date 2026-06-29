<?php

namespace app\api\controller;

use app\common\controller\Api;
use app\common\model\Version;
use think\Config;

/**
 * 版本更新
 */
class Update extends Api
{
    protected $noNeedLogin = ['index', 'app'];
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
     * 检测更新
     *
     * @param string $version 版本号
     * @param string $appid 应用id
     */
    public function index()
    {
        if ($version = $this->request->request('version')) {
            $apkMark = $this->request->request('apk_mark');
            $appid = $this->request->request('appid');
            if (empty($appid)) {
                $this->error(__('Invalid parameters'));
            }
            $this->success_encrypted("检测更新", Version::check($version, $appid), $apkMark);
        } else {
            $this->error(__('Invalid parameters'));
        }
    }

    /**
     * 检测更新
     *
     * @param string $version 版本号
     * @param string $appid 应用id
     */
    public function app()
    {
        if ($version = $this->request->request('version')) {
            $apkMark = $this->request->request('apk_mark');
            $app_id = $this->request->request('app_id');
            if (empty($app_id)) {
                $this->error(__('Invalid parameters'));
            }
            $data = Version::check2($version, $app_id);
            $this->success_encrypted("检测更新", $data, $apkMark);
        } else {
            $this->error(__('Invalid parameters'));
        }
    }

    /**
     * 授权验证逻辑
     */
    private function checkAuthorize($num)
    {
    }
}