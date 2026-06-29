<?php

return array (
  'name' => '通用后台',
  'beian' => '',
  'cdnurl' => '',
  'version' => '1.0.24',
  'timezone' => 'Asia/Shanghai',
  'forbiddenip' => '',
  'languages' => 
  array (
    'backend' => 'zh-cn',
    'frontend' => 'zh-cn',
  ),
  'fixedpage' => 'dashboard',
  'categorytype' => 
  array (
    'default' => '默认',
    'page' => '单页',
    'article' => '文章',
    'test' => 'Test',
  ),
  'configgroup' => 
  array (
    'basic' => '基础配置',
    'email' => '邮件配置',
    'user' => '会员配置',
    'payment' => '支付配置',
    'communal' => '通用配置',
    'dictionary' => '字典配置',
  ),
  'mail_type' => '1',
  'mail_smtp_host' => 'smtp.163.com',
  'mail_smtp_port' => '465',
  'mail_smtp_user' => 'auth889@163.com',
  'mail_smtp_pass' => 'EKZLEXRHVGNVVAQU',
  'mail_verify_type' => '2',
  'mail_from' => 'auth889@163.com',
  'attachmentcategory' => 
  array (
    'category1' => '分类一',
    'category2' => '分类二',
    'custom' => '自定义',
  ),
  'send_money' => '10',
  'send_vips' => '10',
  'agency_price' => '88',
  'agency_discount' => '50',
  'token_lifespan' => '2592000',
  'device_overrun' => '2',
  'payment_platform' => '2',
  'amount_conflict' => '1',
  'disconnect' => '1',
  'api_wechat' => 'https://83831.cn/',
  'merchant_id_wechat' => '2937',
  'merchant_key_wechat' => '9SWNRtuIt17V8638Un994s1338Z846r5',
  'api_alipay' => 'https://83831.cn/',
  'merchant_id_alipay' => '2937',
  'merchant_key_alipay' => '9SWNRtuIt17V8638Un994s1338Z846r5',
  'qrcode_display_method' => '1',
  'qrcode_rule' => 
  array (
    'weixin://' => 'weixin://[^"]+#￥(.+?)<',
    'qr.alipay.com' => 'https://qr.alipay.com[^"]+#money">(.+?)<',
  ),
  'live_api' => 'https://gh-proxy.com/raw.githubusercontent.com/dxawi/0/main/tvlive.txt',
  'epg_api' => 'http://epg.112114.xyz/?ch={name}&date={date}|https://epg.112114.xyz/logo/{name}.png',
  'hot_search_api' => 'https://api.web.360kan.com/v1/rank?cat=1|https://www.360kan.com/rank/general',
  'depot_site_hide' => '小爱|小鸭|微信|教育|课堂',
  'depot_class_hide' => '电影',
  'depot_parses_hide' => '官解1|但行好事',
  'maccms_key' => 'ziKv8NzFSwNoBUYRJclwwjRaiTWBb7ON',
  'qweather_key' => 'c1cf1285e58e494d9a7a19818b867f52',
  'service_qq' => '客服QQ:592805093',
  'default_player' => '3',
  'resource_renaming' => 
  array (
    'qq' => '腾讯',
    'qiyi' => '奇艺',
    'youku' => '优酷',
    'douyin' => '抖音',
    '本软件是开源' => '你好',
  ),
);
