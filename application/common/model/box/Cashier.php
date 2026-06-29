<?php

namespace app\common\model\box;

use think\Model;


class Cashier extends Model
{

    

    

    // 表名
    protected $name = 'box_cashier';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = false;

    // 定义时间戳字段名
    protected $createTime = false;
    protected $updateTime = false;
    protected $deleteTime = false;

    // 追加属性
    protected $append = [
        'lasthearttime_text',
        'lastpaytime_text',
        'status_text'
    ];
    

    
    public function getStatusList()
    {
        return ['normal' => __('Normal'), 'hidden' => __('Hidden')];
    }


    public function getLasthearttimeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['lasthearttime']) ? $data['lasthearttime'] : '');
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }


    public function getLastpaytimeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['lastpaytime']) ? $data['lastpaytime'] : '');
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }


    public function getStatusTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['status']) ? $data['status'] : '');
        $list = $this->getStatusList();
        return isset($list[$value]) ? $list[$value] : '';
    }

    protected function setLasthearttimeAttr($value)
    {
        return $value === '' ? null : ($value && !is_numeric($value) ? strtotime($value) : $value);
    }

    protected function setLastpaytimeAttr($value)
    {
        return $value === '' ? null : ($value && !is_numeric($value) ? strtotime($value) : $value);
    }

    protected function chcekStatus() {
        self::where('jkstate', 1)->where('lasthearttime', '<=', time() - 60)->update(['jkstate' => 0]);
        $cashier = self::where('jkstate', 1)->find();
        if (empty($cashier)) return false;
        return true;
    }

    public function upStatus($id) {
        self::where("id", $id)->update(array("lasthearttime" => time(), "jkstate" => 1));
    }
}
