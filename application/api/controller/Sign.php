<?php

namespace app\api\controller;

use app\common\controller\Api;
use think\Config;
use fast\Date;
use think\Db;
use think\Exception;

/**
 * 公共接口
 */
class Sign extends Api
{
    protected $noNeedLogin = [''];
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
     * 签到
     *
     */
    public function init()
    {
        $appid = $this->request->request('app_id');
        $apkmark = $this->request->request('apk_mark');
        $config = get_addon_config('signin');
        $signdata = $config['signinscore'];
        $lastdata = \addons\signin\model\Signin::where('user_id', $this->auth->id)->order('createtime', 'desc')->find();
        $successions = $lastdata && $lastdata['createtime'] > Date::unixtime('day', -1) ? $lastdata['successions'] : 0;
        $signin = \addons\signin\model\Signin::where('user_id', $this->auth->id)->whereTime('createtime', 'today')->find();
        if ($signin) {
            $this->error('今天已签到,请明天再来吧!');
        } else {
            $successions++;
            $score = isset($signdata['s' . $successions]) ? $signdata['s' . $successions] : $signdata['sn'];
            Db::startTrans();
            try {
                \addons\signin\model\Signin::create(['user_id' => $this->auth->id, 'successions' => $successions, 'createtime' => time()]);
                \app\common\model\User::score($score, $this->auth->id, "连续签到{$successions}天");
                Db::commit();
            } catch (Exception $e) {
                Db::rollback();
                $this->error("签到失败,请稍后再试");
            }

            $userScore = $this->auth->score;
            if ($userScore >= 100) {
                $money = $userScore / 100;
                \app\common\model\User::money($money, $this->auth->id, '积分兑换成余额');
                \app\common\model\User::score("-" . $userScore, $this->auth->id, '积分自动转换为余额');
            }
            $this->success_encrypted('签到成功!连续签到' . $successions . '天!获得' . $score . '积分', $appid, $apkmark);
        }
    }

    /**
     * 是否签到
     *
     */
    public function isSign()
    {
        $appid = $this->request->request('app_id');
        $apkmark = $this->request->request('apk_mark');
        $signin = \addons\signin\model\Signin::where('user_id', $this->auth->id)->whereTime('createtime', 'today')->find();
        $this->success_encrypted($appid, $signin ? "已签到" : "未签到", $apkmark);
    }

    /**
     * 授权验证逻辑
     */
    private function checkAuthorize($num)
    {
    }
}