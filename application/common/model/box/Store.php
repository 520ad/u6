<?php

namespace app\common\model\box;

use think\Model;
use traits\model\SoftDelete;

class Store extends Model
{

    use SoftDelete;



    // 表名
    protected $name = 'box_store';

    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'integer';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    protected $deleteTime = 'deletetime';

    // 追加属性
    protected $append = [
        'status_text'
    ];


    protected static function init()
    {
        self::afterInsert(function ($row) {
            $pk = $row->getPk();
            $row->getQuery()->where($pk, $row[$pk])->update(['weigh' => $row[$pk]]);
        });
    }


    public function getStatusList()
    {
        return ['normal' => __('Normal'), 'hidden' => __('Hidden')];
    }


    public function getStatusTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['status']) ? $data['status'] : '');
        $list = $this->getStatusList();
        return isset($list[$value]) ? $list[$value] : '';
    }

    public static function getApi($id)
    {
        return self::find($id)->url;
    }

    public static function gets($where, $userId, $appId)
    {
        $domain = request()->domain();
        $stores = self::where($where)
            ->order('weigh desc')
            ->field('box_app_ids,vipverifyswitch,createtime,updatetime,deletetime,weigh', true)
            ->select();
        $processedStores = array_map(function($store) use ($appId, $domain) {
            if (!empty($store['encryptionswitch']) && $store['encryptionswitch'] == "1") {
                $store['url'] = $domain . "/api/index/store?id=" . $store['id'] . "&appid=" . $appId;
            }
            unset($store['encryptionswitch'], $store['id']);
            return $store;
        }, $stores);
        return $processedStores;
    }
}
