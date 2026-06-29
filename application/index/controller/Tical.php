<?php

namespace app\index\controller;

use think\Config;
use think\Db;
use app\common\model\User;
use app\common\model\UserGroup;
use app\common\controller\Frontend;

/**
 * 充值
 */
class Tical extends Frontend
{
    protected $noNeedRight = ['*'];
    protected $layout = 'default';
    protected $_card = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->checkAuthorize(0);
        $this->_card = new \app\common\model\box\Card;
    }

    /**
     * 自助提卡
     * @return string
     */
    public function index()
    {
        if ($this->request->isPost()) {
            $id = $this->request->post('id');
            $num = $this->request->post('num');
            if ($id == 1) {
                $this->error("不能创建默认组卡密", "tical/index");
            }
            $user_group = UserGroup::where(['id' => $id])->find();
            if (empty($user_group)) {
                $this->error("卡密类型错误");
            }
            $jiage = $user_group['price'] * $num;
            if ($this->auth->discount > 0) {
                $jiage = ($user_group['price'] * ($this->auth->discount / 100)) * $num;
            }
            if ($this->auth->money < $jiage) $this->error("余额不足！请充值");
            $data = array();
            for ($i = 0; $i < $num; $i++) {
                $data[$i]['card']       = rand(100000000000, 999999999999);
                $data[$i]['type']       = $user_group['id'];
                $data[$i]['founder']    = $this->auth->username;
                $data[$i]['creattime']  = time();
            }
            $addCard = $this->_card->saveAll($data);
            if (!$addCard) $this->error(__("操作失败"));
            User::money("-" . $jiage, $this->auth->id, "用户自助提卡: 卡密id: " . $id . " 数量: " . $num);
            $this->success("操作成功", "tical/mycal");
        }

        if ($this->auth->discount == 100) $unit_price = 1;
        else $unit_price = $this->auth->discount / 100;
        $list = UserGroup::where('status', 'normal')->where('id', "neq", '1')->select();
        foreach ($list as &$item) {
            $item['price'] *= $unit_price;
        }
        unset($item);
        $this->view->assign('title', "自助提卡");
        $this->view->assign('list', $list);
        return $this->view->fetch();
    }

    /**
     * 我的卡密
     * @return string
     */
    public function mycal()
    {
        $mycallist = $this->_card->where(['founder' => $this->auth->username])
            ->order('id desc')
            ->paginate(10);
        foreach ($mycallist as &$item){
            $item['type'] = UserGroup::where('id', $item['type'])->value('name');
        }
        unset($item);
        $this->view->assign('title', __('我的卡密'));
        $this->view->assign('mycallist', $mycallist);
        return $this->view->fetch();
    }

    /**
     * 删除卡密
     * @return string
     */
    public function deletemycal($id = '')
    {
        if ($id != "allhidden") $where = ['founder' => $this->auth->username, 'id' => $id];
        else $where = ['founder' => $this->auth->username, 'status' => 'hidden'];
        $delete = $this->_card->where($where)->delete();
        if (!$delete) $this->error("没有数据可删除", "tical/mycal");
        $this->success("操作成功", "tical/mycal");
    }

    /**
     * 导出
     * @return string
     */
    public function leading_out($type = '未知类型', $name = "未知类型")
    {
        if ($type == '未知类型') $this->error("要导出的卡密类型错误", "tical/mycal");
        $mycal = $this->_card->where(['founder' => $this->auth->username, 'status' => 'normal', 'type' => $type])->order('id ASC')->select();
        if (empty($mycal)) $this->error("没有属于您的卡密可以导出", "tical/mycal");
        $now_date = date("Y-m-j H:i:s");
        $title = "$name-导出日期:$now_date";
        $content = '';
        foreach ($mycal as &$item){
            $content .= "类型: " . $name . "---卡号: " . $item['card'] . "\r\n";
        }
        unset($item);
        Header("Content-type:application/octet-stream");
        Header("Accept-Ranges:bytes");
        header("Content-Disposition:attachment;filename=$title.txt");
        header("Expires:0");
        header("Cache-Control:must-revalidate,post-check=0,pre-check=0 ");
        header("Pragma:public");
        echo $content;
    }

    public function tical($id = '')
    {
        $user_group = UserGroup::where(['id' => $id])->find();
        if ($this->auth->discount == 100) $unit_price = $user_group['price']; //1.01
        else $unit_price = $user_group['price'] * ($this->auth->discount / 100); //50
        $this->view->assign('user_group', $user_group);
        $this->view->assign('unit_price', $unit_price);
        $this->view->assign('title', __('提卡明细'));
        return $this->view->fetch();
    }

    public function buydaili()
    {
        if ($this->request->isPost()) {
            if ($this->auth->discount != 100) {
                $this->error("您已是代理,如有疑问请联系客服!");
            }
            $config = Config::get('site');
            if ($this->auth->money < $config['agency_price']) {
                $this->error("余额不足请先充值!", "/index/recharge/recharge");
            }
            Db::startTrans();
            try {
                User::where('id', $this->auth->id)->update(['discount' => $config['agency_discount']]);
                User::money('-' . $config['agency_price'], $this->auth->id, '用户在线购买代理权限');
                Db::commit();
            } catch (\Exception $e) {
                Db::rollback();
                $this->error(__('购买失败'), "/user/index");
            }
            $this->success(__('购买成功'), url('user/index'));
        }
        $this->view->assign('title', __('加入代理'));
        return $this->view->fetch();
    }

     /**
     * 授权验证逻辑
     */
    private function checkAuthorize($num)
    {
    }
}