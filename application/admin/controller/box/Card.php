<?php

namespace app\admin\controller\box;

use app\common\model\box\App;
use app\common\model\User;
use app\common\model\UserGroup;
use app\common\controller\Backend;

/**
 * 卡密列表管理
 *
 * @icon fa fa-circle-o
 */
class Card extends Backend
{

    /**
     * Card模型对象
     * @var \app\common\model\box\Card
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->checkAuthorize(0);
        $this->model = new \app\common\model\box\Card;
        $this->view->assign("statusList", $this->model->getStatusList());
    }
    
    /**
     * 查看
     */
    public function index()
    {
        $this->request->filter(['strip_tags', 'trim']);
        if ($this->request->isAjax()) {
            if ($this->request->request('keyField')) {
                return $this->selectpage();
            }
            list($where, $sort, $order, $offset, $limit) = $this->buildparams();
            $list = $this->model
                ->where($where)
                ->order($sort, $order)
                ->paginate($limit);

            foreach ($list as &$item) {
                $item['type'] = UserGroup::where('id', $item['type'])->value('name');
                $boxAppIds = explode(',', $item['box_app_ids']);
                $names = App::whereIn('id', $boxAppIds)->column('name');
                $item['box_app_ids'] = implode(',', $names);
                $item['user_id'] = User::where('id', $item['user_id'])->value('username');
            }
            $result = array("total" => $list->total(), "rows" => $list->items());
            return json($result);
        }
        return $this->view->fetch();
    }

    /**
     * 添加
     *
     * @return string
     * @throws \think\Exception
     */
    public function add()
    {
        if ($this->request->isPost()) {
            $params = $this->request->post("row/a");
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
                $data[$i]['box_app_ids'] = $params['box_app_ids'];
                $data[$i]['card']        = rand(100000000000, 999999999999);
                $data[$i]['type']        = $params['type'];
                $data[$i]['founder']     = $params['founder'] ? $params['founder'] : "管理员";
                $data[$i]['user_id']     = $params['user_id'];
                $data[$i]['creattime']   = time();
            }
            $result = $this->model->saveAll($data);
            if ($result) {
                $this->success('成功生成' . count($result) . '个卡密');
            }
        }
        return $this->view->fetch();
    }

    /**
     * 默认生成的控制器所继承的父类中有index/add/edit/del/multi五个基础方法、destroy/restore/recyclebin三个回收站方法
     * 因此在当前控制器中可不用编写增删改查的代码,除非需要自己控制这部分逻辑
     * 需要将application/admin/library/traits/Backend.php中对应的方法复制到当前控制器,然后进行修改
     */
    
    /**
     * 授权验证逻辑
     */
    private function checkAuthorize($num)
    {
    }
}
