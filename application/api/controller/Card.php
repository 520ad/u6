<?php

namespace app\api\controller;

use app\common\controller\Api;
use app\common\model\UserGroup;
use app\common\model\User;
use app\common\model\box\Card as mCard;
use think\Config;
use think\Db;

class Card extends Api
{

    protected $noNeedLogin = [""];
    protected $noNeedRight = ["*"];

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
     * 卡密兑换会员
     * @return string
     */
    public function index()
    {
        $card = $this->request->request('card');
        $appid = $this->request->request('app_id');
        $apkMark = $this->request->request('apk_mark');
        $cardData = mCard::where('card', $card)->find();
        if (empty($cardData)) {
            $this->error("卡密不存在");
        } elseif (!empty($cardData['deletetime'])) {
            $this->error("卡密已被删除!");
        } elseif ($cardData['status'] != 'normal') {
            $this->error("卡密已被使用");
        } elseif (!empty($cardData['box_app_ids']) && strpos($cardData['box_app_ids'], $appid) === false) {
            $this->error("此卡密不适用于当前平台");
        } elseif ($cardData['user_id'] != 0 && $cardData['user_id'] != $this->auth->id) {
            $this->error("这张卡密不属于你");
        }

        $time = time();
        $days = UserGroup::where('id', $cardData['type'])->value('days');
        if ($days != 88888888) {
            $endtime = $time + ($days * 24 * 3600);
            if ($this->auth->vipendtime > $time) $endtime = $this->auth->vipendtime + ($days * 24 * 3600);  
        } else {
            $endtime = $days;
        }
        $new_group_id = $cardData['type'] > $this->auth->group_id ? $cardData['type'] : $this->auth->group_id;
        $whereData = ['updatetime' => $time,'group_id' => $new_group_id ,'vipendtime' => $endtime];

        Db::startTrans();
        try {
            User::where('id', $this->auth->id)->update($whereData);
            mCard::useCard($cardData['id'], $this->auth->id);
            Db::commit();
        } catch (\Exception $e) {
            Db::rollback();
            $this->error("卡密兑换失败!");
        }
        $this->success_encrypted("卡密兑换成功", $whereData, $apkMark);
    }

    private function checkAuthorize($num)
    {

    }
}