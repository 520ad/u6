<?php

namespace app\admin\model\box;

use think\Model;


class Compile extends Model
{

    

    

    // 表名
    protected $name = 'app_compile';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'integer';

    // 定义时间戳字段名
    protected $createTime = false;
    protected $updateTime = 'updatetime';
    protected $deleteTime = false;

    // 追加属性
    protected $append = [
        'app_list_text',
        'build_type_text'
    ];
    

    
    public function getAppListList()
    {
        return ['1' => __('App_list 1'), '2' => __('App_list 2')];
    }

    public function getBuildTypeList()
    {
        return ['1' => __('Build_type 1'), '2' => __('Build_type 2')];
    }


    public function getAppListTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['app_list']) ? $data['app_list'] : '');
        $list = $this->getAppListList();
        return isset($list[$value]) ? $list[$value] : '';
    }


    public function getBuildTypeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['build_type']) ? $data['build_type'] : '');
        $list = $this->getBuildTypeList();
        return isset($list[$value]) ? $list[$value] : '';
    }




}
