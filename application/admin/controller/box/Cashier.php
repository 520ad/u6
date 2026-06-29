<?php

namespace app\admin\controller\box;

use app\common\controller\Backend;

/**
 * 收银台列管理
 *
 * @icon fa fa-circle-o
 */
class Cashier extends Backend
{

    /**
     * Cashier模型对象
     * @var \app\common\model\box\Cashier
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->checkAuthorize(0);
        $this->model = new \app\common\model\box\Cashier;
        $this->view->assign("statusList", $this->model->getStatusList());
        $this->view->assign("uuid", $this->create_uuid());
    }

    function create_uuid()
    {
        if (function_exists('com_create_guid')) {
            $uuid = com_create_guid();
        } else {
            mt_srand((float)microtime() * 10000); //optional for php 4.2.0 and up.
            $charid = strtoupper(md5(uniqid(rand(), true)));
            $hyphen = chr(45); // "-"
            $uuid = chr(123) // "{"
                . substr($charid, 0, 8) . $hyphen
                . substr($charid, 8, 4) . $hyphen
                . substr($charid, 12, 4) . $hyphen
                . substr($charid, 16, 4) . $hyphen
                . substr($charid, 20, 12)
                . chr(125); // "}"
        }
        $uuid = str_replace(array('-', '{', '}'), '', $uuid);
        return $uuid;
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
