<?php

namespace app\admin\controller;

use app\common\controller\Backend;
use think\addons\Service;
use think\Cache;
use fast\PclZip;
use think\Db;

class Update extends Backend
{

    protected $noNeedLogin = [''];
    protected $noNeedRight = ['', ''];
    protected $layout = '';
    protected $_save_path;
    protected $_url;

    public function __construct()
    {
        parent::__construct();
        $this->_url = "";
        $this->_save_path = './uploads/';
    }

    public function index()
    {
        return $this->view->fetch();
    }

    public function step1($zipurl = '')
    {
        if (empty($zipurl)) return $this->error("获取更新包地址失败");
        $this->_url = $zipurl . '?t=' . time();
        echo "<div class='tab-pane'>正在进行第一步【升级后台文件】...<br><br><textarea rows=\"10\" cols=\"47\" readonly>";
        ob_flush();
        flush();
        sleep(1);
        $save_file = 'upfile.zip';
        if (is_file($this->_save_path . $save_file)) {
            @unlink($this->_save_path . $save_file);
        }

        $res = $this->getFile($this->_url, $this->_save_path, $save_file, 1);
        if (!is_array($res) && empty($res)) {
            echo lang('下载更新包失败...') . "\n";
            exit;
        }

        if (!is_file($this->_save_path . $save_file)) {
            echo lang('下载更新包失败...') . "\n";
            exit;
        }

        if (filesize($this->_save_path . $save_file) < 1) {
            @unlink($this->_save_path . $save_file);
            echo lang('下载更新包失败...') . "\n";
            exit;
        }

        echo lang('下载更新包完毕...') . "\n";
        echo lang('解压更新包文件...') . "\n";
        ob_flush();
        flush();
        sleep(1);

        $archive = new PclZip();
        $archive->PclZip($this->_save_path . $save_file);
        if (!$archive->extract(PCLZIP_OPT_PATH, '../', PCLZIP_OPT_REPLACE_NEWER)) {
            echo $archive->error_string . "\n";
            echo lang('解压更新包文件失败，请检查系统目录及文件权限...') . '' . "\n";;
            exit;
        }

        @unlink($this->_save_path . $save_file);
        echo '</textarea></div>';
        $this->fa_jump(url('update/step2', ['jump' => 1]), 3);
    }

    public function step2()
    {

        $save_file = 'database.php';

        echo "<div class='tab-pane'>正在检测【数据库】是否需要更新...<br><br><textarea rows=\"5\" cols=\"47\" readonly>";
        ob_flush();
        flush();
        sleep(1);

        // 导入SQL
        $sql_file = $this->_save_path . $save_file;

        if (is_file($sql_file)) {
            echo lang('正在更新数据库...') . "\n";
            ob_flush();
            flush();
            $pre = config('database.prefix');
            $schema = Db::query('select * from information_schema.columns where table_schema = ?', [config('database.database')]);
            $col_list = [];
            $sql = '';
            foreach ($schema as $k => $v) {
                $col_list[$v['TABLE_NAME']][$v['COLUMN_NAME']] = $v;
            }
            @include $sql_file;
            if (!empty($sql)) {
                $sql_list = $this->fa_parse_sql($sql, 0, ['fa_' => $pre]);
                if ($sql_list) {
                    $sql_list = array_filter($sql_list);
                    foreach ($sql_list as $v) {
                        echo $v;
                        try {
                            Db::execute($v);
                            echo "    ---" . lang('success') . "\n\n";
                        } catch (\Exception $e) {
                            echo "    ---" . lang('fail') . "\n\n";
                        }
                        ob_flush();
                        flush();
                    }
                }
            } else {
            }
            @unlink($sql_file);
        } else {
            echo lang('无需更新数据库...') . "\n";
        }
        echo '</textarea></div>';
        $this->fa_jump(url('update/step3', ['jump' => 1]), 3);
    }

    public function step3()
    {
        echo "<div class='tab-pane'>最后一步【更新系统缓存】<br><br><textarea rows=\"5\" cols=\"47\" readonly>";
        ob_flush();
        flush();
        sleep(1);
        try {
            //内容缓存
            rmdirs(CACHE_PATH, false);
            Cache::clear();
            // 模板缓存
            rmdirs(TEMP_PATH, false);
            // 插件缓存
            Service::refresh();
            // 浏览器缓存
        } catch (\Exception $e) {
            $this->error($e->getMessage());
        }
        echo lang('正在清理缓存...') . "\n";
        echo lang('更新完成，请刷新后台~') . "";
        ob_flush();
        flush();
        echo '</textarea></div>';
    }

    public function fa_jump($url, $sec = 0)
    {
        echo '<script>setTimeout(function (){location.href="' . $url . '";},' . ($sec * 1000) . ');</script><span>暂停 ' . $sec . ' 秒后继续 >>>  </span><a href="' . $url . '" >如果您的浏览器没有自动跳转，请点击这里</a><br>';
    }

    function getFile($url, $save_dir = '', $filename = '', $type = 0)
    {
        if (trim($url) == '') {
            return false;
        }
        //创建保存目录  
        if (!file_exists($save_dir) && !mkdir($save_dir, 0777, true)) {
            return false;
        }
        //获取远程文件所采用的方法  
        if ($type) {
            $ch = curl_init();
            $timeout = 5;
            curl_setopt($ch, CURLOPT_URL, $url);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $timeout);
            $content = curl_exec($ch);
            curl_close($ch);
        } else {
            ob_start();
            readfile($url);
            $content = ob_get_contents();
            ob_end_clean();
        }
        //echo $content;  
        $size = strlen($content);
        //文件大小  
        $fp2 = @fopen($save_dir . $filename, 'w');
        fwrite($fp2, $content);
        fclose($fp2);
        unset($content, $url);
        if ($size == 0) {
            return false;
        }
        return array(
            'file_name' => $filename,
            'save_path' => $save_dir . $filename,
            'file_size' => $size
        );
    }

    public function fa_parse_sql($sql = '', $limit = 0, $prefix = [])
    {
        // 被替换的前缀
        $from = '';
        // 要替换的前缀
        $to = '';

        // 替换表前缀
        if (!empty($prefix)) {
            $to   = current($prefix);
            $from = current(array_flip($prefix));
        }

        if ($sql != '') {
            // 纯sql内容
            $pure_sql = [];

            // 多行注释标记
            $comment = false;

            // 按行分割，兼容多个平台
            $sql = str_replace(["\r\n", "\r"], "\n", $sql);
            $sql = explode("\n", trim($sql));
            // 循环处理每一行
            foreach ($sql as $key => $line) {
                // 跳过空行
                if ($line == '') {
                    continue;
                }

                // 跳过以#或者--开头的单行注释
                if (preg_match("/^(#|--)/", $line)) {
                    continue;
                }

                // 跳过以/**/包裹起来的单行注释
                if (preg_match("/^\/\*(.*?)\*\//", $line)) {
                    continue;
                }

                // 多行注释开始
                if (substr($line, 0, 2) == '/*') {
                    $comment = true;
                    continue;
                }

                // 多行注释结束
                if (substr($line, -2) == '*/') {
                    $comment = false;
                    continue;
                }

                // 多行注释没有结束，继续跳过
                if ($comment) {
                    continue;
                }

                // 替换表前缀
                if ($from != '') {
                    $line = str_replace('`' . $from, '`' . $to, $line);
                }
                if ($line == 'BEGIN;' || $line == 'COMMIT;') {
                    continue;
                }
                // sql语句
                array_push($pure_sql, $line);
            }

            // 只返回一条语句
            if ($limit == 1) {
                return implode("", $pure_sql);
            }


            // 以数组形式返回sql语句
            $pure_sql = implode("\n", $pure_sql);
            $pure_sql = explode(";\n", $pure_sql);
            return $pure_sql;
        } else {
            return $limit == 1 ? '' : [];
        }
    }
}
