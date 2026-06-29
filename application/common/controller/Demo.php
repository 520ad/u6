<?php

namespace app\common\controller;
use think\exception\HttpResponseException;
use think\Request;
use think\Response;
use fast\Random;
use fast\AES;

/**
 * API控制器基类
 */
class Demo extends Test
{
    /**
     * 返回封装后的 API 数据到客户端 【加密】
     * @access protected
     * @param mixed  $msg    提示信息
     * @param mixed  $data   要返回的数据
     * @param int    $code   错误码，默认为0
     * @param string $mark   客户端标识
     * @param array  $header 发送的 Header 信息
     * @return void
     * @throws HttpResponseException
     */
    protected function result_encrypted($msg, $data = null, $code = 0, $mark = null, array $header = [])
    {
        $result = [
            'code' => $code,
            'msg'  => $msg,
            'time' => Request::instance()->server('REQUEST_TIME'),
            'data' => $data,
        ];

        $ikey = Random::alnum(16);
        $host = $_SERVER['HTTP_HOST'];
        $result = $ikey . $this->encrypted($result, $mark, $ikey, $host);

        if (isset($header['statuscode'])) {
            $code = $header['statuscode'];
            unset($header['statuscode']);
        } else {
            $code = $code >= 1000 || $code < 200 ? 200 : $code;
        }

        $response = Response::create($result, "json", $code)->header($header);
        throw new HttpResponseException($response);
    }
}
