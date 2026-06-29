<?php

namespace app\admin\controller\user;

use app\common\controller\Backend;
use app\common\library\Auth;
use app\common\model\User as mUser;
use fast\Random;

/**
 * 会员管理
 *
 * @icon fa fa-user
 */
class User extends Backend
{

    protected $relationSearch = true;
    protected $searchFields = 'id,username,nickname';

    /**
     * @var \app\admin\model\User
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\User;
    }

    /**
     * 查看
     */
    public function index()
    {
        //设置过滤方法
        $this->request->filter(['strip_tags', 'trim']);
        if ($this->request->isAjax()) {
            //如果发送的来源是Selectpage，则转发到Selectpage
            if ($this->request->request('keyField')) {
                return $this->selectpage();
            }
            list($where, $sort, $order, $offset, $limit) = $this->buildparams();
            $list = $this->model
                ->with('group')
                ->where($where)
                ->order($sort, $order)
                ->paginate($limit);
            foreach ($list as $k => $v) {
                $v->avatar = $v->avatar ? cdnurl($v->avatar, true) : letter_avatar($v->nickname);
                $v->hidden(['password', 'salt']);
            }
            $result = array("total" => $list->total(), "rows" => $list->items());

            return json($result);
        }
        return $this->view->fetch();
    }

    /**
     * 添加
     */
    public function add()
    {
        if ($this->request->isPost()) {
            $params = $this->request->post("row/a");
            if (empty($params)) {
                $this->error(__("操作失败！请刷新页面后重试"));
            }
            // 验证数据
            $validate = $this->validate(
                $params,
                [
                    'num|生成数量' => 'require|number|between:1,500',
                ]
            );
            if ($validate !== true) {
                $this->error($validate);
            }
            $data = array();
            for ($i = 0; $i < $params['num']; $i++) {
                $salt = Random::alnum();
                $uuid = $this->uuid();
                $data[$i]['group_id']   = $params['type'];
                $data[$i]['username']   = $uuid;
                $data[$i]['nickname']   = $uuid;
                $data[$i]['password']   = md5(md5($params['password']) . $salt);
                $data[$i]['salt']       = $salt;
                $data[$i]['email']      = $uuid . "@163.com";
                $data[$i]['mobile']     = "138" . $uuid;
                $data[$i]['joinip']     = "127.0.0.1";
                $data[$i]['jointime']   = time();
                $data[$i]['loginip']    = "127.0.0.1";
                $data[$i]['status']     = "notactive";
            }
            $result = $this->model->saveAll($data);
            if ($result) {
                $this->success('成功生成' . count($result) . '个账户');
            }
        }
        return $this->view->fetch();
    }

    /**
     * 导出
     * @return string
     */
    public function export_url($data, $password)
    {
        $now_date = date("Y-m-j H:i:s");
        $title = "导出日期:$now_date";
        $content = '';
        foreach ($data as &$item){
            $content .= "用户名: " . $item['username'] . "---密码: " . $password . "---会员组: " . $item['group_id'] . "\r\n";
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

    /**
     * 编辑
     */
    public function edit($ids = null)
    {
        if ($this->request->isPost()) {
            $this->token();
        }
        $row = $this->model->get($ids);
        $this->modelValidate = true;
        if (!$row) {
            $this->error(__('No Results were found'));
        }
        $this->view->assign('groupList', build_select('row[group_id]', \app\admin\model\UserGroup::column('id,name'), $row['group_id'], ['class' => 'form-control selectpicker']));
        return parent::edit($ids);
    }

    /**
     * 删除
     */
    public function del($ids = "")
    {
        if (!$this->request->isPost()) {
            $this->error(__("Invalid parameters"));
        }
        // $ids = $ids ? $ids : $this->request->post("ids");
        $row = $this->model->get($ids);
        $this->modelValidate = true;
        if (!$row) {
            $this->error(__('No Results were found'));
        }
        // Auth::instance()->delete($row['id']);
        // $this->success();
        return parent::del($ids);
    }

    /**
     * 生成随机账号
     */
    public function uuid()
    {
        do { // 循环直到找到一个不存在的用户名
            $account = $this->generateAccount();
        } while (mUser::getByUsername($account));

        return $account;
    }

    /**
     * 生成8位随机数
     */
    public function generateAccount()
    {
        $account = mt_rand(10000000, 99999999);
        return (string)$account;
    }
}
