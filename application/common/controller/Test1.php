<?php

namespace app\common\controller;

/**
 * API控制器基类
 */
class Test1
{
    /**
     * 授权验证逻辑
     */
    protected function checkMark($mark, $host, $authFile)
    {
        if (file_exists($authFile)) {
            $authInfo = file_get_contents($authFile);
            $authData = $this->decrypts($authInfo);
            if ($authData['host'] == base64_encode($host)) {
                $authList = json_decode(base64_decode($authData['list']), true);
                if (in_array($mark, $authList)) return true;
            }
        }
        return false;
    }

    /**
     * 解密授权信息
     */
    protected function decrypts($data)
    {
        $decryptedKey = substr($data, -344);
        $authData = substr($data, 0, strlen($data) - 344);
        openssl_public_decrypt(base64_decode($decryptedKey), $decrypted, "-----BEGIN PUBLIC KEY-----\n" . chunk_split($this->_publicKey, 64, "\n") . "-----END PUBLIC KEY-----\n", OPENSSL_PKCS1_PADDING);
        $authInfo = openssl_decrypt(base64_decode($authData), "AES-128-CBC", substr($decrypted, 16), OPENSSL_RAW_DATA, substr($decrypted, 0, 16));
        return json_decode($authInfo, true);
    }

    protected $_publicKey = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA2JaVDqTX+diSRqJo8KF2uC8/XunFE1iDWxO5nPoFh0HEr93hDXSWDPnfWohUQx3zYB8BoqSwnJLhHZhDQGfOFngRRLbnkOLGTIG2PlS0VF0Safq36VBRvtP5272Ys8Jlm5NznvMew+n6TFMgZ1SbJ/VlMry77nrrwatSUn5eGhWa+MSCeRt1HQBB0S1O+epy/oxhnmNNT+kzA3rWJLeF1JzvkNSG+PUV3GqG4WuWlV3dBGDUpta+JDv94EdckPoHljzlQh8ccxm478eS0oSkBMjPfKZYXbT62YG4nCUg5+P2VdY+JzdEgP79mWc2Lo7iIAi/Ug2QxdbOn1RGVfdicQIDAQAB";
}
