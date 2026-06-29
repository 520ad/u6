<?php

namespace app\admin\controller\box;

use app\common\controller\Backend;
use app\common\model\box\App;
use fast\Http;

/**
 * 商城任务
 *
 * @icon fa fa-circle-o
 */
class Compile extends Backend
{

    /**
     * Compile模型对象
     * @var \app\admin\model\box\Compile
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\box\Compile;
    }
}
