<?php

namespace app\common\model\box;

use think\Model;
use traits\model\SoftDelete;

class Parses extends Model
{

    use SoftDelete;

    // 表名
    protected $name = 'box_parses';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'integer';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    protected $deleteTime = 'deletetime';

    // 追加属性
    protected $append = [
        'type_text',
        'status_text'
    ];

    protected static function init()
    {
        self::afterInsert(function ($row) {
            $pk = $row->getPk();
            $row->getQuery()->where($pk, $row[$pk])->update(['weigh' => $row[$pk]]);
        });
    }

    public function getTypeList()
    {
        return ['0' => __('Type 0'), '1' => __('Type 1'), '2' => __('Type 2'), '3' => __('Type 3')];
    }

    public function getStatusList()
    {
        return ['normal' => __('Normal'), 'hidden' => __('Hidden')];
    }

    public function getTypeTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['type']) ? $data['type'] : '');
        $list = $this->getTypeList();
        return isset($list[$value]) ? $list[$value] : '';
    }

    public function getStatusTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['status']) ? $data['status'] : '');
        $list = $this->getStatusList();
        return isset($list[$value]) ? $list[$value] : '';
    }

    public static function getApi($id){
        return self::find($id)->url;
    }

    public static function gets($where, $appid)
    {
        $domain = request()->domain();
        $parses = self::where($where)->order('weigh desc')
                      ->field('box_app_ids,createtime,updatetime,deletetime,vipverifyswitch,weigh', true)
                      ->select();
        foreach ($parses as &$parse) {
            if (!empty($parse['encryptionswitch']) && $parse['encryptionswitch'] == "1" && $parse['type'] == "1") {
                $parse['url'] = $domain . "/api/index?parsesId=" . $parse['id'] . "&appid=" . $appid . "&videoUrl=";
            }
            if (empty($parse['ext'])) {
                unset($parse['ext']);
            } else {
                $parse['ext'] = base64_encode($parse['ext']);
            }
            unset($parse['encryptionswitch'], $parse['id']);
        }
        return $parses;
    }
}
