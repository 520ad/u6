<?php

namespace app\api\controller;

use app\common\controller\Api;
use app\common\model\UserGroup;
use think\Config;

/**
 * 升级会员组
 */
class Group extends Api
{
    protected $noNeedLogin = ['index'];
    protected $noNeedRight = ['*'];

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
     * 获取会员组
     *
     */
    public function index()
    {
        $apkMark = $this->request->request('apk_mark');
        if (empty($ruleList)) {
            $ruleList = UserGroup::where('status', 'normal')->field('rules,createtime,updatetime', true)->select();
            if ($ruleList == null) {
                $this->error('获取会员组失败');
            }
        }
        $this->success_encrypted('请求成功', $ruleList, $apkMark);
    }

    /**
     * 余额升级会员
     * @return string
     */
    public function upgradeGroup()
    {
        $groupid = $this->request->param('group_id');
        $apkMark = $this->request->request('apk_mark');
        if (empty($groupid)) $this->error("参数有误!");
        $data = UserGroup::upGroup($groupid, $this->auth->id, "money");
        if (strpos($data, "升级失败") !== false) {
            $this->error($data);
        } else {
            $this->success_encrypted("升级成功", $data, $apkMark);
        }
    }

    /**
     * 积分升级会员
     * @return string
     */
    public function scoreUpgradeGroup()
    {
        $groupid = $this->request->param('group_id');
        $apkMark = $this->request->request('apk_mark');
        if (empty($groupid)) $this->error("参数有误!");
        $data = UserGroup::upGroup($groupid, $this->auth->id, "score");
        if (strpos($data, "升级失败") !== false) {
            $this->error($data);
        } else {
            $this->success_encrypted("升级成功", $data, $apkMark);
        }
    }

    private function checkAuthorize($num)
    {
    }
}