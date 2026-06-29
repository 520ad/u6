<?php

namespace app\common\model\box;

use think\Model;


class Qrcode extends Model
{

    

    

    // 表名
    protected $name = 'box_qrcode';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = false;

    // 定义时间戳字段名
    protected $createTime = false;
    protected $updateTime = false;
    protected $deleteTime = false;

    // 追加属性
    protected $append = [
        'codedata_text',
        'platformdata_text'
    ];
    

    
    public function getCodedataList()
    {
        return ['currency' => __('Codedata currency'), 'regular' => __('Codedata regular')];
    }

    public function getPlatformdataList()
    {
        return ['wechat' => __('Platformdata wechat'), 'alipay' => __('Platformdata alipay')];
    }


    public function getCodedataTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['codedata']) ? $data['codedata'] : '');
        $list = $this->getCodedataList();
        return isset($list[$value]) ? $list[$value] : '';
    }


    public function getPlatformdataTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['platformdata']) ? $data['platformdata'] : '');
        $list = $this->getPlatformdataList();
        return isset($list[$value]) ? $list[$value] : '';
    }




}
