<?php

namespace app\index\controller;

use app\common\controller\Frontend;

class Share extends Frontend
{

    protected $noNeedLogin = '*';
    protected $noNeedRight = '*';
    protected $layout = '';

    public function index()
    {
        $user_id = $this->request->request('user_id', ''); //通过邀请连接打开本页面
        if (!empty($user_id)) {
            $this->success('即将跳转,稍后进行注册即可获得奖励', 'https://app.lvdoui.net/invite/' . $user_id); //域名改成自己的
        }

        //视频分享
        $name = $this->request->request('name', '');
        $pics = $this->request->request('pics', '');
        $keys = $this->request->request('keys', '');
        $cid = $this->request->request('cid', '');
        $id = $this->request->request('id', '');
        
        //mobilebox协议头不能修改
        $button = "立即播放";
        $url = "mobilebox://open?name={$name}&keys={$keys}&id={$id}&pics={$pics}&cid={$cid}";
        if (empty($name)) { //如果不是视频分享，提示下载App
            $button = "我要下载";
            $name = "一款永久免费的App";
            $url = "https://lvdoui.lanzoul.com/i4xkP1ft9udi"; //你App下载地址
            $pics = "http://superbox.lvdoui.net/assets/img/avatar.png"; //封面地址
        }
        $this->view->assign('button', $button);
        $this->view->assign('name', $name);
        $this->view->assign('url', $url);
        $this->view->assign('pics', $pics);
        $this->view->assign('id', $id);
        return $this->view->fetch();
    }
}
