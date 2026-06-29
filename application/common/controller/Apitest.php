<?php

namespace app\common\controller;

/**
 * API控制器基类
 */
class Apitest extends Demo
{

    /**
     * 操作成功返回的数据【加密】
     * @param string $msg    提示信息
     * @param mixed  $data   要返回的数据
     * @param int    $code   错误码，默认为1
     * @param string $mark   客户端标识
     * @param array  $header 发送的 Header 信息
     */
    protected function success_encrypted($msg = '', $data = null, $mark = "null", $code = 1, array $header = [])
    {
        $this->result_encrypted($msg, $data, $code, $mark, $header);
    }
}
