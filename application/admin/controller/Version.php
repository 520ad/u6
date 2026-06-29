<?php

namespace app\admin\controller;

use app\common\controller\Backend;
use app\common\model\box\App;

/**
 * 版本管理
 *
 * @icon fa fa-circle-o
 */
class Version extends Backend
{

    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('Version');
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
                $item['box_app_ids'] = App::whereIn('id', $item['box_app_ids'])->column('name');
            }
            $result = array("total" => $list->total(), "rows" => $list->items());
            return json($result);
        }
        return $this->view->fetch();
    }
}
