<?php

namespace app\common\controller;
use think\exception\HttpResponseException;
use fast\AES;

/**
 * API控制器基类
 */
class Test extends Test1
{
    /**
     * 返回封装后的 API 数据到客户端 【加密】
     * @access protected
     * @param string $result   待加密
     * @param string $mark     客户端标识
     * @return void
     * @throws HttpResponseException
     */
    protected function encrypted($result = '', $mark = null, $ikey = '', $host = '')
    {
        // $authFile = ROOT_PATH . "extend/" . md5(base64_encode($host . "_sb")) . ".txt";
        // if (!$this->checkMark($mark, $host, $authFile)) {
        //     // if (file_exists($authFile)) unlink($authFile);
        //     $result['data'] = "";
        // }
        return AES::CBC(json_encode($result, JSON_UNESCAPED_SLASHES), $ikey, $ikey);
    }
}
