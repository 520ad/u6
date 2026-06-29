<?php

namespace fast;
use think\Exception;

/**
 * AES加密
 */
class AES {

    public static function CBC($data, $key, $iv) {
        try {
            $cipher = openssl_encrypt($data, "AES-128-CBC", $key, OPENSSL_RAW_DATA, $iv);
            return base64_encode($cipher);
        } catch (Exception $e) {
            return $e->getMessage();
        }
        
        return null;
    }
}