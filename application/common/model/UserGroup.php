<?php

namespace app\common\model;

use app\common\model\User;
use think\Model;
use think\Db;

class UserGroup extends Model
{

    // 表名
    protected $name = 'user_group';
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';
    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    // 追加属性
    protected $append = [];

    /**
     * 余额升级会员组
     * @return string
     */
    public static function upGroup($groupid, $id, $type)
    {
        $user = User::lock(true)->find($id);
        $group = self::lock(true)->find($groupid);
        if (!$group || !$user) {
            return "升级失败-获取基本信息失败";
        }
        if ($type == "money") {
            return self::money($group, $user);
        } else {
            return self::score($group, $user);
        }
    }

    private static function money($group, $user)
    {
        Db::startTrans();
        try {
            if ($user->money < $group['price']) {
                return "升级失败-余额不足,请先充值";
            }
            $endDay = $group['days']; //会员组设置的VIP天数
            if ($endDay != 88888888) { // VIP天数不是88888888计算实际的VIP天数。88888888是永久会员
                $vipTime = strtotime('+' . $endDay . 'day'); //取N天后时间截
                if ($user->vipendtime > time()) { //如果会员有效期大于当前时间。叠加会员有效期
                    $vipTime = $user->vipendtime + ($endDay * 86400); // 86400 秒是一天的秒数
                }
            } else {
                $vipTime = $endDay;
            }
            User::money(-$group['price'], $user->id, "余额升级会员");
            User::where('id', $user->id)->update(['group_id' => $group['id'], 'vipendtime' => $vipTime]);
            Db::commit();
        } catch (\Exception $e) {
            Db::rollback();
            return "升级失败-未知错误";
        }
        return $user->money - $group['price'];
    }

    private static function score($group, $user)
    {
        Db::startTrans();
        try {
            if ($user->score < $group['price'] * 100) {
                return "升级失败-积分不足,继续去赚积分吧";
            }
            $endDay = $group['days']; //会员组设置的VIP天数
            if ($endDay != 88888888) { // VIP天数不是88888888计算实际的VIP天数。88888888是永久会员
                $vipTime = strtotime('+' . $endDay . 'day'); //取N天后时间截
                if ($user->vipendtime > time()) { //如果会员有效期大于当前时间。叠加会员有效期
                    $vipTime = $user->vipendtime + ($endDay * 86400); // 86400 秒是一天的秒数
                }
            } else {
                $vipTime = $endDay;
            }
            User::score(-$group['price'] * 100, $user->id, "积分升级会员");
            User::where('id', $user->id)->update(['group_id' => $group['id'], 'vipendtime' => $vipTime]);
            Db::commit();
        } catch (\Exception $e) {
            Db::rollback();
            return "升级失败-未知错误";
        }
        return $user->score - $group['price'] * 100;
    }   
}
