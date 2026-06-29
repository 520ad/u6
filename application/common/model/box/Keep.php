<?php

namespace app\common\model\box;

use think\Model;


class Keep extends Model
{

    

    

    // 表名
    protected $name = 'box_keep';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'integer';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    protected $deleteTime = false;

    // 追加属性
    protected $append = [

    ];
    
    public static function creates($data){
        self::create($data);
    }
}
