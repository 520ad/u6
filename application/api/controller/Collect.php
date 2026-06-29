<?php

namespace app\api\controller;

use app\common\controller\Api;
use app\common\model\box\Keep;
use think\Config;

/**
 * 收藏接口
 */
class Collect extends Api
{

    // 无需登录的接口,*表示全部
    protected $noNeedLogin = [''];
    // 无需鉴权的接口,*表示全部
    protected $noNeedRight = ['*'];

    public function _initialize()
    {
        if (isset($_SERVER['HTTP_ORIGIN'])) {
            header('Access-Control-Expose-Headers: __token__');//跨域让客户端获取到
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
     * 添加收藏
     *
     */
    public function addCollect()
    {
        $appid = $this->request->request('app_id');
        $apkmark = $this->request->request('apk_mark');
        $key = $this->request->request('key');
        $cid = $this->request->request('cid');
        $vodid = $this->request->request('vod_id');
        $name = $this->request->request('name');
        $pic = $this->request->request('pic');
        $data = [
            'user_id'   => $this->auth->id,
            'appid'     => $appid,
            'key'       => $key,
            'cid'       => $cid,
            'vodid'     => $vodid,
            'name'      => $name,
            'pic'       => $pic
        ];
        Keep::creates($data);
        $this->success_encrypted('添加收藏成功', $data, $apkmark);
    }

    /**
     * 获取收藏
     *
     */
    public function getCollect()
    {
        $appid = $this->request->request('app_id');
        $apkmark = $this->request->request('apk_mark');
        $vodid = $this->request->request('vod_id');
        if (empty($vodid)) { //获取所有记录
            $where = ['user_id'   => $this->auth->id];
        } else { //获取单条记录
            $where = [
                'vodid'     => $vodid,
                'appid'     => $appid,
                'key'       => $this->request->request('key'),
                'cid'       => $this->request->request('cid'),
                'user_id'   => $this->auth->id
            ];
        }
        $vollect = Keep::where($where)->select();
        $this->success_encrypted('获取收藏列表', $vollect, $apkmark);
    }

    /**
     * 删除收藏
     *
     */
    public function deleteCollect()
    {
        $appid = $this->request->request('app_id');
        $apkmark = $this->request->request('apk_mark');
        $key = $this->request->request('key');
        $vod_id = $this->request->request('vod_id');
        $data = [
            'user_id'   => $this->auth->id,
            'appid'     => $appid,
            'vodid'     => $vod_id,
            'key'       => $key,
        ];
        Keep::destroy($data);
        $this->success_encrypted('删除收藏成功', $data, $apkmark);
    }

    private function checkAuthorize($num)
    {
    }
}