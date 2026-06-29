<?php

namespace app\api\controller;

use app\common\model\box\Rechargeorder;
use app\common\model\box\Loginlog;
use app\common\model\box\Parses;
use app\common\model\box\Store;
use app\common\controller\Api;
use think\Config;
use fast\Random;
use fast\Http;
use fast\AES;

/**
 * 首页接口
 */
class Index extends Api
{
    protected $noNeedLogin = ['addLoginLog', 'getLoginlog', 'index', 'store'];
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

        $this->_iKey = Random::alnum(16);
        parent::_initialize();
        $this->checkAuthorize(0);
    }

    /**
     * 解析
     *
     */
    public function index()
    {
        $videoUrl = $this->request->request('videoUrl');
        $parsesId = $this->request->request('parsesId');
        if (!empty($videoUrl) && !empty($parsesId)) {
            $parses = Parses::getApi($parsesId);
            $result = Http::getParses($parses . $videoUrl);
            $result = json_decode($result, true);
            if (empty($result) || empty($result["url"]) || $result["url"] == "") $this->error("解析失败");
            $result['url'] = "https://baidu.con/" . $this->_iKey . AES::CBC($result["url"], $this->_iKey, $this->_iKey);
            echo json_encode($result, 320);
        } else {
            $this->error("请按要求传参");
        }
    }

    /**
     * 仓库加密
     *
     */
    public function store()
    {
        $id = $this->request->request('id');
        if (!empty($id)) {
            $store = Store::getApi($id);
            if (substr($store, 0, 4) === "http") {
                $content = Http::getStore($store);
            } else {
                $content = file_get_contents(ROOT_PATH . "extend/store/" . $store);
            }
            if (empty($content)) $this->error("读取仓库内容失败");
            $content = json_decode($content, true);

            if (!empty(Config::get('site.epg_api'))) {
                $epgConfig = Config::get('site.epg_api');
                if (strpos($epgConfig, '|') !== false) {
                    $epgArr = explode('|', $epgConfig);
                    $epgApi = $epgArr[0];
                    $epgpng = $epgArr[1];
                } else {
                    $epgApi = $epgConfig;
                }
            }

            if (!empty(Config::get('site.live_api')) && isset($content['lives'])) {
                unset($content['lives']);
                $content['lives'][0] = [
                    "name" => "live",
                    "type" => 0,
                    "playerType" => 1,
                    "url"  => Config::get('site.live_api'),
                    "ua"   => "okhttp/3.15",
                    "epg"  => empty($epgApi) ? null : $epgApi,
                    "logo" => empty($epgpng) ? null : $epgpng,
                ];
            }

            if ($content['lives'][0]['epg'] == null) {
                unset($content['lives'][0]['epg']);
            }

            if ($content['lives'][0]['logo'] == null) {
                unset($content['lives'][0]['logo']);
            }
            echo "lvDou+" . $this->_iKey . AES::CBC(json_encode($content, JSON_UNESCAPED_SLASHES), $this->_iKey, $this->_iKey);
        } else {
            $this->error("请按要求传参");
        }
    } 
    
    /**
     * 直播加密
     *
     */
    public function live()
    {
        $live = Config::get('site.live_api');
        if (substr($live, 0, 4) === "http") {
            $content = Http::getLive($live);
        } else {
            $content = file_get_contents(ROOT_PATH . "extend/store/" . $live);
        }
        if (empty($content)) $this->error("读取直播列表失败");
        echo "lvDou+" . $this->_iKey . AES::CBC($content, $this->_iKey, $this->_iKey);
    } 

    /**
     * 查询订单状态
     *
     */
    public function checkOrder()
    {
        $orderId = $this->request->request('orderId');
        $res = Rechargeorder::where("orderid", $orderId)->find();
        if ($res) {
            if ($res['status'] == "created") {
                $this->error("订单未支付");
            }
            if ($res['status'] == "expired") {
                $this->error("订单已过期");
            }
            $this->success("success", "../../../index/recharge/moneylog");
        } else {
            $this->error("订单编号不存在");
        }
    }

    private function checkAuthorize($num)
    {
    }
}