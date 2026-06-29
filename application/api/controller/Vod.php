<?php

namespace app\api\controller;

use app\common\controller\Api;
use think\Config;
use fast\Http;

/**
 * 获取视频详情
 */
class Vod extends Api
{
    protected $noNeedLogin = ['index'];
    protected $noNeedRight = ['*'];
    protected $_iKey = '';

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
    }

    /**
     * 解析
     *
     */
    public function index()
    {
        $name = $this->request->request('name');
        if (!empty($name)) {
            //请求接口
            $result = Http::get("https://api.tiankongapi.com/api.php/provide/vod/?wd=" . $name);
            if (empty($result)) {
                die("检索视频失败,但这并不影响视频播放。您可以点击影片进入视频页查看或反馈给客服处理。我们很期待收到您的反馈");
            }
            //格式化为json
            $result = json_decode($result, true);
            if ($result['code'] != 1) {
                die("没有找到相关视频结果,但这并不影响视频播放。您可以点击影片进入视频页查看或反馈给客服处理。我们很期待收到您的反馈！感谢支持~~~");
            }
            //苹果CMS默认是模糊搜索，比如搜索战狼。他会返回，战狼、战狼2、战狼特攻队等等
            //循环数据，找出一个绝对匹配的名称
            $vod_id = 0;
            for ($i=0; $i < count($result['list']); $i++) { 
                if ($result['list'][$i]['vod_name'] == $name) {
                    //找到之后给vod_id赋值
                    $vod_id = $result['list'][$i]['vod_id'];
                }
            }
            //0表示没找到
            if ($vod_id == 0) {
                die("没有找到相关视频结果,但这并不影响视频播放。您可以点击影片进入视频页查看或反馈给客服处理。我们很期待收到您的反馈！感谢支持~~~");
            }
            //苹果cms的搜索里面不带视频详情，如果您是自己的苹果CMS可以在搜索接口直接返回视频简介，如果不是自己的苹果CMS接口，需要用视频ID取获取视频详情
            $result = Http::get("https://api.tiankongapi.com/api.php/provide/vod/?ac=videolist&ids=" . $vod_id);
            if (empty($result)) {
                die("检索视频失败,但这并不影响视频播放。您可以点击影片进入视频页查看或反馈给客服处理。我们很期待收到您的反馈");
            }
            $result = json_decode($result, true);
            if ($result['code'] != 1) {
                die("没有找到相关视频结果,但这并不影响视频播放。您可以点击影片进入视频页查看或反馈给客服处理。我们很期待收到您的反馈！感谢支持~~~");
            }
            //返回vod_blurb字段
            die($result['list'][0]['vod_blurb']);
        } else {
            echo "缺少name";
        }
    }
}