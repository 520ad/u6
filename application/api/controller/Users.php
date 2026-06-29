<?php

namespace app\api\controller;

use app\common\controller\Api;
use app\common\library\Sms;
use fast\Random;
use think\Config;
use think\Validate;

class Users extends Api
{
    protected $noNeedLogin = ['login', 'mobilelogin', 'register'];
    protected $noNeedRight = '*';

    public function _initialize()
    {
        parent::_initialize();
        $this->checkAuthorize(0);
    }

    public function index()
    {
        $apkMark = $this->request->request('apk_mark');
        $data = ['userinfo' => $this->auth->getUserinfo()];
        $this->success_encrypted('会员中心', $data, $apkMark);
    }

    public function login()
    {
        $appid = $this->request->post('app_id');
        $apkMark = $this->request->post('apk_mark');
        $account = $this->request->post('account');
        $password = $this->request->post('password');
        if (!$account || !$password) {
            $this->error(__('Invalid parameters'));
        }
        if (empty($appid)) $this->error(__('请求参数有误'));
        $this->auth->setAppid($appid);
        $this->auth->keeptime(intval(Config::get('site.token_lifespan')));
        $ret = $this->auth->login($account, $password);
        if ($ret) {
            $data = ['userinfo' => $this->auth->getUserinfo()];
            $this->success_encrypted(__('Logged in successful'), $data, $apkMark);
        } else {
            $this->error($this->auth->getError());
        }
    }

    public function mobilelogin()
    {
        $mobile = $this->request->post('mobile');
        $captcha = $this->request->post('captcha');
        if (!$mobile || !$captcha) {
            $this->error(__('Invalid parameters'));
        }
        if (!Validate::regex($mobile, "^1\d{10}$")) {
            $this->error(__('Mobile is incorrect'));
        }
        if (!Sms::check($mobile, $captcha, 'mobilelogin')) {
            $this->error(__('Captcha is incorrect'));
        }
        $user = \app\common\model\User::getByMobile($mobile);
        if ($user) {
            if ($user->status != 'normal') {
                $this->error(__('Account is locked'));
            }
            $ret = $this->auth->direct($user->id);
        } else {
            $ret = $this->auth->register($mobile, Random::alnum(), '', $mobile, []);
        }
        if ($ret) {
            Sms::flush($mobile, 'mobilelogin');
            $data = ['userinfo' => $this->auth->getUserinfo()];
            $this->success(__('Logged in successful'), $data);
        } else {
            $this->error($this->auth->getError());
        }
    }

    public function register()
    {
        $mark = $this->request->post('mark');
        $appid = $this->request->post('app_id');
        $apkmark = $this->request->request('apk_mark');
        $username = $this->request->post('username');
        $password = $this->request->post('password');
        $mobile = $this->request->post('mobile');
        $email = $this->request->post('email');
        $code = $this->request->post('code');
        if (empty($appid)) {
            $this->error(__('请求参数有误'));
        }
        if (!$username || !$password) {
            $this->error(__('Invalid parameters'));
        }
        if ($email && !Validate::is($email, "email")) {
            $this->error(__('Email is incorrect'));
        }
        if (Validate::regex($username, "^1\d{10}$")) {
            $mobile = $username;
        }
        if ($mobile && !Validate::regex($mobile, "^1\d{10}$")) {
            $this->error(__('Mobile is incorrect'));
        }
        $ret = Sms::check($mobile, $code, 'register');
        if (!$ret && !$mark) {
            $this->error(__('Captcha is incorrect'));
        }
        $extend['mark'] = $mark;
        $site = Config::get('site');
        $this->auth->setAppid($appid);
        $email = $username . "@163.com";
        $extend['money'] = $site['send_money'];
        $extend['vipendtime'] = strtotime('+' . $site['send_vips'] . 'day');
        $this->auth->keeptime(intval($site['token_lifespan']));
        $ret = $this->auth->register($username, $password, $email, $mobile, $extend);
        if ($ret) {
            $data = ['userinfo' => $this->auth->getUserinfo()];
            $this->success_encrypted(__('Sign up successful'), $data, $apkmark);
        } else {
            $this->error($this->auth->getError());
        }
    }

    public function logout()
    {
        if (!$this->request->isPost()) {
            $this->error(__('Invalid parameters'));
        }
        $this->auth->logout();
        $this->success(__('Logout successful'));
    }

    private function checkAuthorize($num)
    {
    }
}
