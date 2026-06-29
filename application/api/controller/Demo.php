<?php

namespace app\api\controller;

use app\common\controller\Api;
use think\Config;

/**
 * 示例接口
 */
class Demo extends Api
{
    // 无需登录的接口,*表示全部
    protected $noNeedLogin = ['*'];
    // 无需鉴权的接口,*表示全部
    protected $noNeedRight = ['*'];

    public function depot()
    {
        // JSON文件的路径
        $jsonFilePath = ROOT_PATH . 'public/uploads/tvbox/api.json';
        // 读取JSON文件内容
        $jsonContent = file_get_contents($jsonFilePath);
        // 检查是否成功读取文件内容
        if ($jsonContent === false) $this->error('无法读取文件' . $jsonFilePath);
        // 解析JSON内容
        $data = json_decode($jsonContent, true); // 第二个参数设置为true，返回数组而非对象
        // 检查是否成功解析JSON
        if (json_last_error() !== JSON_ERROR_NONE) $this->error('解析JSON时出错: ' . json_last_error_msg());
        //删除仓库原有lives配置
        unset($data['lives']);
        //调用后台live配置
        $data['lives'][0] = [
            "name" => "live",
            "name" => "live",
            "type" => 0,
            "url" => Config::get('site.live_api'),
            "playerType" => 1,
            "ua" => "okhttp/3.15",
            "epg" => Config::get('site.epg_api'),
            "logo" => "https://epg.112114.xyz/logo/{name}.png"
        ];
        echo json_encode($data, 320);
    }
}
