<?php

namespace app\common\model\box;

use think\Model;
use traits\model\SoftDelete;

class Card extends Model
{

    use SoftDelete;

    

    // 表名
    protected $name = 'box_card';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = false;

    // 定义时间戳字段名
    protected $createTime = false;
    protected $updateTime = false;
    protected $deleteTime = 'deletetime';

    // 追加属性
    protected $append = [
        'usagetime_text',
        'creattime_text',
        'status_text'
    ];
    

    
    public function getStatusList()
    {
        return ['normal' => __('Normal'), 'hidden' => __('Hidden')];
    }


    public function getUsagetimeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['usagetime']) ? $data['usagetime'] : '');
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }


    public function getCreattimeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['creattime']) ? $data['creattime'] : '');
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }


    public function getStatusTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['status']) ? $data['status'] : '');
        $list = $this->getStatusList();
        return isset($list[$value]) ? $list[$value] : '';
    }

    protected function setUsagetimeAttr($value)
    {
        return $value === '' ? null : ($value && !is_numeric($value) ? strtotime($value) : $value);
    }

    protected function setCreattimeAttr($value)
    {
        return $value === '' ? null : ($value && !is_numeric($value) ? strtotime($value) : $value);
    }

    public static function useCard($card_id, $user_id)
    {
        $card = self::find($card_id);
        if ($card) $card->save(['status' => "hidden", 'user_id' => $user_id, 'usagetime' => time()]);
    }
}
