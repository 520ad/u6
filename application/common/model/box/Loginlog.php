<?php

namespace app\common\model\box;

use think\Model;


class Loginlog extends Model
{

    // 表名
    protected $name = 'box_loginlog';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'integer';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = false;
    protected $deleteTime = false;

    // 追加属性
    protected $append = [
        
    ];

    /**
     * 创建登录日志
     *
     * @param string $markcode 识别码
     * @return boolean
     */
    public static function adds($mark)
    {
        try {
            list($y, $m, $d) = explode('-', date('Y-m-d'));
            $data = ['token' => null, 'status' => 'created'];
            $params = array_merge($data, ['markcode' => $mark, 'expiretime' => mktime(23, 59, 59, $m, $d, $y)]);
            $markCode = self::getByMarkcode($mark);
            if ($markCode) $markCode->save($params);
            else self::create($params, true);
        } catch (\Exception $e) {
            return false;
        }
        return true;
    }

    /**
     * 更新登录状态
     * @param string markcode 识别码
     */
    public static function ups($mark, $token)
    {
        $markCode = self::getByMarkcode($mark);
        if ($markCode) {
            try {
                $markCode->save(['token' => $token, 'status' => 'paid', 'createtime' => time()]);
            } catch (\Exception $e) {
                return false;
            }
        }
        return true;
    }

    /**
     * 查询授权登录日志
     *
     * @param array $markcode 识别码
     * @return boolean
     */
    public static function gets($mark)
    {
        $markCode = self::getByMarkcode($mark);
        if (empty($markCode)) {
            return "失败-未找到记录";
        } elseif ($markCode->status == "paid") {
            return $markCode->token;
        } elseif ($markCode->status == "created") {
            return "失败-未授权登录";
        } elseif ($markCode->status == 'expired') {
            return "失败-授权已过期";
        }
        return "失败-未知错误";
    }
}
