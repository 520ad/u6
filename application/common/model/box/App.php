<?php

namespace app\common\model\box;

use think\Model;
use traits\model\SoftDelete;

class App extends Model
{

    use SoftDelete;

    

    // 表名
    protected $name = 'box_app';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'integer';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    protected $deleteTime = 'deletetime';

    // 追加属性
    protected $append = [
        'operationmode_text',
        'status_text'
    ];
    

    
    public function getOperationmodeList()
    {
        return ['0' => __('Operationmode 0'), '1' => __('Operationmode 1'), '2' => __('Operationmode 2'), '3' => __('Operationmode 3')];
    }

    public function getStatusList()
    {
        return ['normal' => __('Normal'), 'hidden' => __('Hidden')];
    }


    public function getOperationmodeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['operationmode']) ? $data['operationmode'] : '');
        $list = $this->getOperationmodeList();
        return isset($list[$value]) ? $list[$value] : '';
    }


    public function getStatusTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['status']) ? $data['status'] : '');
        $list = $this->getStatusList();
        return isset($list[$value]) ? $list[$value] : '';
    }

    public static function gets($where)
    {
        $appConfig = self::where($where)->field('createtime,createtime,updatetime,deletetime', true)->find($where);
        $appConfig["about"] = base64_encode($appConfig["about"]);
        return $appConfig;
    }
}
