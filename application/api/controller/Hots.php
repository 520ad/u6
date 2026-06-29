<?php

namespace app\api\controller;

use app\common\controller\Api;
use app\common\model\box\Hotsearch;
use think\Config;

/**
 * 公共接口
 */
class Hots extends Api
{
    protected $noNeedLogin = ['init'];
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
    }

    /**
     * 搜索页面推荐
     */
    public function init()
    {
        $appid = $this->request->request('app_id');
        if (empty($appid)) $this->error("appid不能为空");
        if (empty($hotsData)) {
            $hotsData = $this->getHots($appid);
        }
        $this->success('热搜词库', $hotsData); //热搜词库四个字不能改
    }

    
    /**
     * 加载热词库,返回格式如下
     * {"data":[{"title":"王牌对王牌 第八季", "pubdate":"2023", "cover":"http://img.png"}, {"title":"战狼", "pubdate":"2022", "cover":"http://img2.png"}]
     * 可能需要重启几次才会生效,您可以修改相关逻辑,或到其他站点获取数据并通过getHots返回
     * @param $appid 要获取的平台id
     * @return \think\Response
     */
    public function getHots($appid = '10000')
    {
        $where = ['status' => 'normal', 'box_app_ids' => ['like', '%'.$appid.'%']];
        return Hotsearch::where($where)->order('weigh ASC')->field('createtime,updatetime,deletetime,weigh', true)->select();
    }
}
