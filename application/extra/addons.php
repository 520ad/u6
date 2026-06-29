<?php

return [
    'autoload' => false,
    'hooks' => [
        'epay_config_init' => [
            'epay',
        ],
        'addon_action_begin' => [
            'epay',
        ],
        'action_begin' => [
            'epay',
        ],
        'user_sidenav_after' => [
            'invite',
            'recharge',
            'signin',
        ],
        'user_register_successed' => [
            'invite',
        ],
        'app_init' => [
            'qrcode',
        ],
    ],
    'route' => [
        '/invite/[:id]$' => 'invite/index/index',
        '/qrcode$' => 'qrcode/index/index',
        '/qrcode/build$' => 'qrcode/index/build',
    ],
    'priority' => [],
    'domain' => '',
];
