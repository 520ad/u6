<?php

namespace app\admin\controller\box;

use app\common\model\box\App;
use app\common\controller\Backend;

/**
 * 公告动态
 *
 * @icon fa fa-circle-o
 */
class Notice extends Backend
{

    /**
     * Notice模型对象
     * @var \app\common\model\box\Notice
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->checkAuthorize(0);
        $this->model = new \app\common\model\box\Notice;
        $this->view->assign("statusList", $this->model->getStatusList());
    }

    /**
     * 查看
     */
    public function index()
    {
        // 设置过滤方法
        $this->request->filter(['strip_tags', 'trim']);
        if ($this->request->isAjax()) {
            // 如果发送的来源是Selectpage，则转发到Selectpage
            if ($this->request->request('keyField')) {
                return $this->selectpage();
            }
            list($where, $sort, $order, $offset, $limit) = $this->buildparams();
            $list = $this->model->where($where)->order($sort, $order)->paginate($limit);
            foreach ($list as &$item){
                $boxAppIds = explode(',', $item['box_app_ids']);
                $names = App::whereIn('id', $boxAppIds)->column('name');
                $item['box_app_ids'] = implode(',', $names);
            }
            $result = array("total" => $list->total(), "rows" => $list->items());
            return json($result);
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