/*
 SuperAdmin Install SQL
 Date: 2024-03-31 21:38:57
*/

SET FOREIGN_KEY_CHECKS = 0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

-- ----------------------------
-- Table structure for fa_admin
-- ----------------------------
CREATE TABLE `fa_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(20) DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) DEFAULT '' COMMENT '昵称',
  `password` varchar(32) DEFAULT '' COMMENT '密码',
  `salt` varchar(30) DEFAULT '' COMMENT '密码盐',
  `avatar` varchar(255) DEFAULT '' COMMENT '头像',
  `email` varchar(100) DEFAULT '' COMMENT '电子邮箱',
  `mobile` varchar(11) DEFAULT '' COMMENT '手机号码',
  `loginfailure` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '失败次数',
  `logintime` bigint(16) DEFAULT NULL COMMENT '登录时间',
  `loginip` varchar(50) DEFAULT NULL COMMENT '登录IP',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `token` varchar(59) DEFAULT '' COMMENT 'Session标识',
  `status` varchar(30) NOT NULL DEFAULT 'normal' COMMENT '状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='管理员表' AUTO_INCREMENT=2 ;

-- ----------------------------
-- Records of fa_admin
-- ----------------------------
BEGIN;
INSERT INTO `fa_admin` VALUES(1, 'admin', 'Admin', '', '', '/assets/img/avatar.png', 'admin@admin.com', '', 0, 1711781259, '127.0.0.1',1491635035, 1711781259, '', 'normal');
COMMIT;

-- ----------------------------
-- Table structure for fa_admin_log
-- ----------------------------
CREATE TABLE `fa_admin_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `username` varchar(30) DEFAULT '' COMMENT '管理员名字',
  `url` varchar(1500) DEFAULT '' COMMENT '操作页面',
  `title` varchar(100) DEFAULT '' COMMENT '日志标题',
  `content` longtext NOT NULL COMMENT '内容',
  `ip` varchar(50) DEFAULT '' COMMENT 'IP',
  `useragent` varchar(255) DEFAULT '' COMMENT 'User-Agent',
  `createtime` bigint(16) DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`),
  KEY `name` (`username`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='管理员日志表' AUTO_INCREMENT=1 ;

-- ----------------------------
-- Table structure for fa_area
-- ----------------------------
CREATE TABLE `fa_area` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` int(10) DEFAULT NULL COMMENT '父id',
  `shortname` varchar(100) DEFAULT NULL COMMENT '简称',
  `name` varchar(100) DEFAULT NULL COMMENT '名称',
  `mergename` varchar(255) DEFAULT NULL COMMENT '全称',
  `level` tinyint(4) DEFAULT NULL COMMENT '层级:1=省,2=市,3=区/县',
  `pinyin` varchar(100) DEFAULT NULL COMMENT '拼音',
  `code` varchar(100) DEFAULT NULL COMMENT '长途区号',
  `zip` varchar(100) DEFAULT NULL COMMENT '邮编',
  `first` varchar(50) DEFAULT NULL COMMENT '首字母',
  `lng` varchar(100) DEFAULT NULL COMMENT '经度',
  `lat` varchar(100) DEFAULT NULL COMMENT '纬度',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='地区表' AUTO_INCREMENT=1 ;

-- ----------------------------
-- Table structure for fa_attachment
-- ----------------------------
CREATE TABLE `fa_attachment` (
  `id` int(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `category` varchar(50) DEFAULT '' COMMENT '类别',
  `admin_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `url` varchar(255) DEFAULT '' COMMENT '物理路径',
  `imagewidth` varchar(30) DEFAULT '' COMMENT '宽度',
  `imageheight` varchar(30) DEFAULT '' COMMENT '高度',
  `imagetype` varchar(30) DEFAULT '' COMMENT '图片类型',
  `imageframes` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图片帧数',
  `filename` varchar(100) DEFAULT '' COMMENT '文件名称',
  `filesize` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `mimetype` varchar(100) DEFAULT '' COMMENT 'mime类型',
  `extparam` varchar(255) DEFAULT '' COMMENT '透传数据',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建日期',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `uploadtime` bigint(16) DEFAULT NULL COMMENT '上传时间',
  `storage` varchar(100) NOT NULL DEFAULT 'local' COMMENT '存储位置',
  `sha1` varchar(40) DEFAULT '' COMMENT '文件 sha1编码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='附件表' AUTO_INCREMENT=14 ;

-- ----------------------------
-- Records of fa_attachment
-- ----------------------------
BEGIN;
INSERT INTO `fa_attachment` VALUES(1, '', 1, 0, '/assets/img/qrcode.png', '150', '150', 'png', 0, 'qrcode.png', 21859, 'image/png', '', 1491635035, 1491635035, 1491635035, 'local', '17163603d0263e4838b9387ff2cd4877e8b018f6');
INSERT INTO `fa_attachment` VALUES(2, '', 1, 0, '/uploads/20240328/ffb0bf31f6fe6ac87fccc5b44354f855.png', '156', '45', 'png', 0, 'logo.png', 14005, 'image/png', '', 1711632060, 1711632060, 1711632059, 'local', '2318d9236f869baadadbccf9dc764c609a919d24');
INSERT INTO `fa_attachment` VALUES(3, '', 1, 0, '/uploads/20240328/e299dea905d63fd1fce1c641ea080be5.png', '1280', '720', 'png', 0, 'uc.png', 485370, 'image/png', '', 1711632067, 1711632067, 1711632067, 'local', 'db543e01f8cfaf1475feac8fa7423ab09aeff749');
INSERT INTO `fa_attachment` VALUES(4, '', 1, 0, '/uploads/20240328/db5579bd81e4920432790b4daa33cf9e.jpg', '1920', '1080', 'jpg', 0, '200.jpg', 106415, 'image/jpeg', '', 1711632077, 1711632077, 1711632077, 'local', '296ec1614cdf36bde921eedb712004e6fbf219b4');
INSERT INTO `fa_attachment` VALUES(5, '', 1, 0, '/uploads/20240328/cd9ba18c40df20f1102442ac8ccc71d3.jpg', '1125', '618', 'jpg', 0, 'loading_play.jpg', 120780, 'image/jpeg', '', 1711632081, 1711632081, 1711632081, 'local', '3936b288a1583407322a49b1c4e0112bf4760cb5');
INSERT INTO `fa_attachment` VALUES(6, '', 1, 0, '/uploads/20240328/ad57e56a032154c1975cb9630d99a8d8.png', '940', '861', 'png', 0, '1099a3e5da8f386f4032c410f78ac6f3.png', 796713, 'image/png', '', 1711632086, 1711632086, 1711632086, 'local', 'fd13607199f69748143ea3833ad3dd3e6ed0182f');
INSERT INTO `fa_attachment` VALUES(7, '', 1, 0, '/uploads/20240328/78726fc6e4b1d4cb65e004726a902485.png', '1080', '1920', 'png', 0, 'launch.png', 882972, 'image/png', '', 1711632167, 1711632167, 1711632167, 'local', '932c7c464c42422041cd0d2746da7c05eb075e18');
INSERT INTO `fa_attachment` VALUES(8, '', 1, 0, '/uploads/20240330/359879c16b6556e872916c144ec6580b.png', '750', '400', 'png', 0, 'image.png', 322705, 'image/png', '', 1711776346, 1711776346, 1711776346, 'local', '91013acac6d44bd9c344652d1822173c4018966b');
INSERT INTO `fa_attachment` VALUES(9, '', 1, 0, '/uploads/20240330/8b4c27964bd49d2b8449ecaa7f130050.png', '1280', '720', 'png', 0, 'image.png', 1486236, 'image/png', '', 1711776388, 1711776388, 1711776388, 'local', '34a87905132cc7f77b66b0b2237f9a4e55d38bc0');
INSERT INTO `fa_attachment` VALUES(10, '', 1, 0, '/uploads/20240330/ddeeb152e67974d87722416b1576c9b2.png', '1173', '643', 'png', 0, 'image.png', 1125121, 'image/png', '', 1711776439, 1711776439, 1711776439, 'local', '153300e838f83de48466376af05b784d7043e6f1');
INSERT INTO `fa_attachment` VALUES(11, '', 1, 0, '/uploads/20240330/72eeab0c67ff1b87f9de63b23ce4164d.png', '1024', '576', 'png', 0, 'image.png', 897960, 'image/png', '', 1711776486, 1711776486, 1711776486, 'local', '3c6203afdc727689758e089945c1a822576e857f');
INSERT INTO `fa_attachment` VALUES(12, '', 1, 0, '/uploads/20240330/25ade8649122c33b61fee87504aee674.png', '1280', '720', 'png', 0, 'image.png', 1400268, 'image/png', '', 1711776505, 1711776505, 1711776505, 'local', 'd1b35c4f4e916b35c41a8de1ddabb7e704b496e0');
INSERT INTO `fa_attachment` VALUES(13, '', 1, 0, '/uploads/20240330/5eccc7e92f180df338ecec642e64ffd7.png', '650', '365', 'png', 0, 'image.png', 546313, 'image/png', '', 1711776523, 1711776523, 1711776523, 'local', '18b057750108207fcc4f344248cc6062786c429b');
COMMIT;

-- ----------------------------
-- Table structure for fa_auth_group
-- ----------------------------
CREATE TABLE `fa_auth_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父组别',
  `name` varchar(100) DEFAULT '' COMMENT '组名',
  `rules` text NOT NULL COMMENT '规则ID',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `status` varchar(30) DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='分组表' AUTO_INCREMENT=6 ;

-- ----------------------------
-- Records of fa_auth_group
-- ----------------------------
BEGIN;
INSERT INTO `fa_auth_group` VALUES(1, 0, 'Admin group', '*', 1491635035, 1491635035, 'normal');
INSERT INTO `fa_auth_group` VALUES(2, 1, 'Second group', '13,14,16,15,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,40,41,42,43,44,45,46,47,48,49,50,55,56,57,58,59,60,61,62,63,64,65,1,9,10,11,7,6,8,2,4,5', 1491635035, 1491635035, 'normal');
INSERT INTO `fa_auth_group` VALUES(3, 2, 'Third group', '1,4,9,10,11,13,14,15,16,17,40,41,42,43,44,45,46,47,48,49,50,55,56,57,58,59,60,61,62,63,64,65,5', 1491635035, 1491635035, 'normal');
INSERT INTO `fa_auth_group` VALUES(4, 1, 'Second group 2', '1,4,13,14,15,16,17,55,56,57,58,59,60,61,62,63,64,65', 1491635035, 1491635035, 'normal');
INSERT INTO `fa_auth_group` VALUES(5, 2, 'Third group 2', '1,2,6,7,8,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34', 1491635035, 1491635035, 'normal');
COMMIT;

-- ----------------------------
-- Table structure for fa_auth_group_access
-- ----------------------------
CREATE TABLE `fa_auth_group_access` (
  `uid` int(10) unsigned NOT NULL COMMENT '会员ID',
  `group_id` int(10) unsigned NOT NULL COMMENT '级别ID',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='权限分组表';

-- ----------------------------
-- Records of fa_auth_group_access
-- ----------------------------
BEGIN;
INSERT INTO `fa_auth_group_access` VALUES(1, 1);
COMMIT;

-- ----------------------------
-- Table structure for fa_auth_rule
-- ----------------------------
CREATE TABLE `fa_auth_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('menu','file') NOT NULL DEFAULT 'file' COMMENT 'menu为菜单,file为权限节点',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `name` varchar(100) DEFAULT '' COMMENT '规则名称',
  `title` varchar(50) DEFAULT '' COMMENT '规则名称',
  `icon` varchar(50) DEFAULT '' COMMENT '图标',
  `url` varchar(255) DEFAULT '' COMMENT '规则URL',
  `condition` varchar(255) DEFAULT '' COMMENT '条件',
  `remark` varchar(255) DEFAULT '' COMMENT '备注',
  `ismenu` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否为菜单',
  `menutype` enum('addtabs','blank','dialog','ajax') DEFAULT NULL COMMENT '菜单类型',
  `extend` varchar(255) DEFAULT '' COMMENT '扩展属性',
  `py` varchar(30) DEFAULT '' COMMENT '拼音首字母',
  `pinyin` varchar(100) DEFAULT '' COMMENT '拼音',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` varchar(30) DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`) USING BTREE,
  KEY `pid` (`pid`),
  KEY `weigh` (`weigh`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='节点表' AUTO_INCREMENT=210 ;

-- ----------------------------
-- Records of fa_auth_rule
-- ----------------------------
BEGIN;
INSERT INTO `fa_auth_rule` VALUES(1, 'file', 0, 'dashboard', 'Dashboard', 'fa fa-dashboard', '', '', 'Dashboard tips', 1, NULL, '', 'kzt', 'kongzhitai', 1491635035, 1491635035, 143, 'normal');
INSERT INTO `fa_auth_rule` VALUES(2, 'file', 0, 'general', 'General', 'fa fa-cogs', '', '', '', 1, NULL, '', 'cggl', 'changguiguanli', 1491635035, 1491635035, 137, 'normal');
INSERT INTO `fa_auth_rule` VALUES(3, 'file', 0, 'category', 'Category', 'fa fa-leaf', '', '', 'Category tips', 0, NULL, '', 'flgl', 'fenleiguanli', 1491635035, 1491635035, 119, 'normal');
INSERT INTO `fa_auth_rule` VALUES(4, 'file', 5, 'addon', '插件管理', 'fa fa-rocket', '', '', '可在线安装、卸载、禁用、启用、配置、升级插件，插件升级前请做好备份。', 1, 'addtabs', '', 'cjgl', 'chajianguanli', 1491635035, 1711622979, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(5, 'file', 0, 'auth', 'Auth', 'fa fa-group', '', '', '', 1, NULL, '', 'qxgl', 'quanxianguanli', 1491635035, 1491635035, 99, 'normal');
INSERT INTO `fa_auth_rule` VALUES(6, 'file', 2, 'general/config', 'Config', 'fa fa-cog', '', '', 'Config tips', 1, NULL, '', 'xtpz', 'xitongpeizhi', 1491635035, 1491635035, 60, 'normal');
INSERT INTO `fa_auth_rule` VALUES(7, 'file', 2, 'general/attachment', 'Attachment', 'fa fa-file-image-o', '', '', 'Attachment tips', 1, NULL, '', 'fjgl', 'fujianguanli', 1491635035, 1491635035, 53, 'normal');
INSERT INTO `fa_auth_rule` VALUES(8, 'file', 2, 'general/profile', 'Profile', 'fa fa-user', '', '', '', 1, NULL, '', 'grzl', 'gerenziliao', 1491635035, 1491635035, 34, 'normal');
INSERT INTO `fa_auth_rule` VALUES(9, 'file', 5, 'auth/admin', 'Admin', 'fa fa-user', '', '', 'Admin tips', 1, NULL, '', 'glygl', 'guanliyuanguanli', 1491635035, 1491635035, 118, 'normal');
INSERT INTO `fa_auth_rule` VALUES(10, 'file', 5, 'auth/adminlog', 'Admin log', 'fa fa-list-alt', '', '', 'Admin log tips', 1, NULL, '', 'glyrz', 'guanliyuanrizhi', 1491635035, 1491635035, 113, 'normal');
INSERT INTO `fa_auth_rule` VALUES(11, 'file', 5, 'auth/group', '角色管理', 'fa fa-group', '', '', '角色组可以有多个,角色有上下级层级关系,如果子角色有角色组和管理员的权限则可以派生属于自己组别的下级角色组或管理员', 1, 'addtabs', '', 'jsgl', 'jueseguanli', 1491635035, 1711669404, 109, 'normal');
INSERT INTO `fa_auth_rule` VALUES(12, 'file', 5, 'auth/rule', 'Rule', 'fa fa-bars', '', '', 'Rule tips', 1, NULL, '', 'cdgz', 'caidanguize', 1491635035, 1491635035, 104, 'normal');
INSERT INTO `fa_auth_rule` VALUES(13, 'file', 1, 'dashboard/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 136, 'normal');
INSERT INTO `fa_auth_rule` VALUES(14, 'file', 1, 'dashboard/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 135, 'normal');
INSERT INTO `fa_auth_rule` VALUES(15, 'file', 1, 'dashboard/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 133, 'normal');
INSERT INTO `fa_auth_rule` VALUES(16, 'file', 1, 'dashboard/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 134, 'normal');
INSERT INTO `fa_auth_rule` VALUES(17, 'file', 1, 'dashboard/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 132, 'normal');
INSERT INTO `fa_auth_rule` VALUES(18, 'file', 6, 'general/config/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 52, 'normal');
INSERT INTO `fa_auth_rule` VALUES(19, 'file', 6, 'general/config/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 51, 'normal');
INSERT INTO `fa_auth_rule` VALUES(20, 'file', 6, 'general/config/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 50, 'normal');
INSERT INTO `fa_auth_rule` VALUES(21, 'file', 6, 'general/config/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 49, 'normal');
INSERT INTO `fa_auth_rule` VALUES(22, 'file', 6, 'general/config/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 48, 'normal');
INSERT INTO `fa_auth_rule` VALUES(23, 'file', 7, 'general/attachment/index', 'View', 'fa fa-circle-o', '', '', 'Attachment tips', 0, NULL, '', '', '', 1491635035, 1491635035, 59, 'normal');
INSERT INTO `fa_auth_rule` VALUES(24, 'file', 7, 'general/attachment/select', 'Select attachment', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 58, 'normal');
INSERT INTO `fa_auth_rule` VALUES(25, 'file', 7, 'general/attachment/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 57, 'normal');
INSERT INTO `fa_auth_rule` VALUES(26, 'file', 7, 'general/attachment/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 56, 'normal');
INSERT INTO `fa_auth_rule` VALUES(27, 'file', 7, 'general/attachment/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 55, 'normal');
INSERT INTO `fa_auth_rule` VALUES(28, 'file', 7, 'general/attachment/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 54, 'normal');
INSERT INTO `fa_auth_rule` VALUES(29, 'file', 8, 'general/profile/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 33, 'normal');
INSERT INTO `fa_auth_rule` VALUES(30, 'file', 8, 'general/profile/update', 'Update profile', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 32, 'normal');
INSERT INTO `fa_auth_rule` VALUES(31, 'file', 8, 'general/profile/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 31, 'normal');
INSERT INTO `fa_auth_rule` VALUES(32, 'file', 8, 'general/profile/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 30, 'normal');
INSERT INTO `fa_auth_rule` VALUES(33, 'file', 8, 'general/profile/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 29, 'normal');
INSERT INTO `fa_auth_rule` VALUES(34, 'file', 8, 'general/profile/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 28, 'normal');
INSERT INTO `fa_auth_rule` VALUES(35, 'file', 3, 'category/index', 'View', 'fa fa-circle-o', '', '', 'Category tips', 0, NULL, '', '', '', 1491635035, 1491635035, 142, 'normal');
INSERT INTO `fa_auth_rule` VALUES(36, 'file', 3, 'category/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 141, 'normal');
INSERT INTO `fa_auth_rule` VALUES(37, 'file', 3, 'category/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 140, 'normal');
INSERT INTO `fa_auth_rule` VALUES(38, 'file', 3, 'category/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 139, 'normal');
INSERT INTO `fa_auth_rule` VALUES(39, 'file', 3, 'category/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 138, 'normal');
INSERT INTO `fa_auth_rule` VALUES(40, 'file', 9, 'auth/admin/index', 'View', 'fa fa-circle-o', '', '', 'Admin tips', 0, NULL, '', '', '', 1491635035, 1491635035, 117, 'normal');
INSERT INTO `fa_auth_rule` VALUES(41, 'file', 9, 'auth/admin/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 116, 'normal');
INSERT INTO `fa_auth_rule` VALUES(42, 'file', 9, 'auth/admin/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 115, 'normal');
INSERT INTO `fa_auth_rule` VALUES(43, 'file', 9, 'auth/admin/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 114, 'normal');
INSERT INTO `fa_auth_rule` VALUES(44, 'file', 10, 'auth/adminlog/index', 'View', 'fa fa-circle-o', '', '', 'Admin log tips', 0, NULL, '', '', '', 1491635035, 1491635035, 112, 'normal');
INSERT INTO `fa_auth_rule` VALUES(45, 'file', 10, 'auth/adminlog/detail', 'Detail', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 111, 'normal');
INSERT INTO `fa_auth_rule` VALUES(46, 'file', 10, 'auth/adminlog/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 110, 'normal');
INSERT INTO `fa_auth_rule` VALUES(47, 'file', 11, 'auth/group/index', 'View', 'fa fa-circle-o', '', '', 'Group tips', 0, NULL, '', '', '', 1491635035, 1491635035, 108, 'normal');
INSERT INTO `fa_auth_rule` VALUES(48, 'file', 11, 'auth/group/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 107, 'normal');
INSERT INTO `fa_auth_rule` VALUES(49, 'file', 11, 'auth/group/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 106, 'normal');
INSERT INTO `fa_auth_rule` VALUES(50, 'file', 11, 'auth/group/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 105, 'normal');
INSERT INTO `fa_auth_rule` VALUES(51, 'file', 12, 'auth/rule/index', 'View', 'fa fa-circle-o', '', '', 'Rule tips', 0, NULL, '', '', '', 1491635035, 1491635035, 103, 'normal');
INSERT INTO `fa_auth_rule` VALUES(52, 'file', 12, 'auth/rule/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 102, 'normal');
INSERT INTO `fa_auth_rule` VALUES(53, 'file', 12, 'auth/rule/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 101, 'normal');
INSERT INTO `fa_auth_rule` VALUES(54, 'file', 12, 'auth/rule/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 100, 'normal');
INSERT INTO `fa_auth_rule` VALUES(55, 'file', 4, 'addon/index', 'View', 'fa fa-circle-o', '', '', 'Addon tips', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(56, 'file', 4, 'addon/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(57, 'file', 4, 'addon/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(58, 'file', 4, 'addon/del', 'Delete', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(59, 'file', 4, 'addon/downloaded', 'Local addon', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(60, 'file', 4, 'addon/state', 'Update state', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(63, 'file', 4, 'addon/config', 'Setting', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(64, 'file', 4, 'addon/refresh', 'Refresh', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(65, 'file', 4, 'addon/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(66, 'file', 0, 'user', 'User', 'fa fa-user-circle', '', '', '', 1, NULL, '', 'hygl', 'huiyuanguanli', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(67, 'file', 66, 'user/user', '会员管理', 'fa fa-user', '', '', '1972-10-26 03:21:28是永久会员,搜索永久会员的话1972-10-26 03:21:28 - 1972-10-26 03:21:28', 1, 'addtabs', '', 'hygl', 'huiyuanguanli', 1491635035, 1711690722, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(68, 'file', 67, 'user/user/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(69, 'file', 67, 'user/user/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(70, 'file', 67, 'user/user/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(71, 'file', 67, 'user/user/del', 'Del', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(72, 'file', 67, 'user/user/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(73, 'file', 66, 'user/group', 'User group', 'fa fa-users', '', '', '', 1, NULL, '', 'hyfz', 'huiyuanfenzu', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(74, 'file', 73, 'user/group/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(75, 'file', 73, 'user/group/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(76, 'file', 73, 'user/group/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(77, 'file', 73, 'user/group/del', 'Del', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(78, 'file', 73, 'user/group/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(79, 'file', 66, 'user/rule', 'User rule', 'fa fa-circle-o', '', '', '', 1, NULL, '', 'hygz', 'huiyuanguize', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(80, 'file', 79, 'user/rule/index', 'View', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(81, 'file', 79, 'user/rule/del', 'Del', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(82, 'file', 79, 'user/rule/add', 'Add', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(83, 'file', 79, 'user/rule/edit', 'Edit', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(84, 'file', 79, 'user/rule/multi', 'Multi', 'fa fa-circle-o', '', '', '', 0, NULL, '', '', '', 1491635035, 1491635035, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(93, 'file', 0, 'box', '客户端管理', 'fa fa-list', '', '', '', 1, 'addtabs', '', 'khdgl', 'kehuduanguanli', 1711632014, 1711632315, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(94, 'file', 93, 'box/app', '应用管理', 'fa fa-android', '', '', '可添加多个应用。打包时注意appid和key', 1, 'addtabs', '', 'yygl', 'yingyongguanli', 1711632014, 1711677802, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(95, 'file', 94, 'box/app/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1711632014, 1711632014, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(96, 'file', 94, 'box/app/recyclebin', '回收站', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hsz', 'huishouzhan', 1711632014, 1711632014, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(97, 'file', 94, 'box/app/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1711632014, 1711632014, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(98, 'file', 94, 'box/app/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1711632014, 1711632014, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(99, 'file', 94, 'box/app/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1711632014, 1711632014, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(100, 'file', 94, 'box/app/destroy', '真实删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zssc', 'zhenshishanchu', 1711632014, 1711632014, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(101, 'file', 94, 'box/app/restore', '还原', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hy', 'huanyuan', 1711632014, 1711632014, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(102, 'file', 94, 'box/app/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1711632014, 1711632014, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(103, 'file', 93, 'box/home', '首页配置管理', 'fa fa-home', '', '', '注意区分绑定应用，可多选。只有对应绑定应用才能获取到数据', 1, 'addtabs', '', 'sypzgl', 'shouyepeizhiguanli', 1711632354, 1711677871, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(104, 'file', 103, 'box/home/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1711632354, 1711632354, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(105, 'file', 103, 'box/home/recyclebin', '回收站', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hsz', 'huishouzhan', 1711632354, 1711632354, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(106, 'file', 103, 'box/home/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1711632354, 1711632354, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(107, 'file', 103, 'box/home/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1711632354, 1711632354, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(108, 'file', 103, 'box/home/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1711632354, 1711632354, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(109, 'file', 103, 'box/home/destroy', '真实删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zssc', 'zhenshishanchu', 1711632354, 1711632354, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(110, 'file', 103, 'box/home/restore', '还原', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hy', 'huanyuan', 1711632354, 1711632354, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(111, 'file', 103, 'box/home/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1711632354, 1711632354, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(112, 'file', 93, 'box/store', '仓库配置管理', 'fa fa-institution', '', '', '注意区分绑定应用，可多选。只有对应绑定应用才能获取到数据。如需开启加密请将仓库配置文件放到extend/store中，然后仓库地址填写完整的文件名即可。外部仓库不建议开启加密', 1, 'addtabs', '', 'ckpzgl', 'cangkupeizhiguanli', 1711632593, 1711679706, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(113, 'file', 112, 'box/store/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1711632593, 1711632593, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(114, 'file', 112, 'box/store/recyclebin', '回收站', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hsz', 'huishouzhan', 1711632593, 1711632593, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(115, 'file', 112, 'box/store/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1711632593, 1711632593, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(116, 'file', 112, 'box/store/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1711632593, 1711632593, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(117, 'file', 112, 'box/store/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1711632593, 1711632593, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(118, 'file', 112, 'box/store/destroy', '真实删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zssc', 'zhenshishanchu', 1711632593, 1711632593, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(119, 'file', 112, 'box/store/restore', '还原', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hy', 'huanyuan', 1711632593, 1711632593, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(120, 'file', 112, 'box/store/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1711632593, 1711632593, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(121, 'file', 93, 'box/parses', '视频接口管理', 'fa fa-sitemap', '', '', '注意区分绑定应用，可多选。只有对应绑定应用才能获取到数据。开启仅会员可用后只有会员才能获取该接口，并且需要重启应用', 1, 'addtabs', '', 'spjkgl', 'shipinjiekouguanli', 1711632708, 1711678194, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(122, 'file', 121, 'box/parses/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1711632708, 1711632708, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(123, 'file', 121, 'box/parses/recyclebin', '回收站', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hsz', 'huishouzhan', 1711632708, 1711632708, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(124, 'file', 121, 'box/parses/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1711632708, 1711632708, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(125, 'file', 121, 'box/parses/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1711632708, 1711632708, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(126, 'file', 121, 'box/parses/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1711632708, 1711632708, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(127, 'file', 121, 'box/parses/destroy', '真实删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zssc', 'zhenshishanchu', 1711632708, 1711632708, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(128, 'file', 121, 'box/parses/restore', '还原', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hy', 'huanyuan', 1711632708, 1711632708, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(129, 'file', 121, 'box/parses/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1711632708, 1711632708, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(130, 'file', 93, 'box/hotsearch', '搜索内容推荐', 'fa fa-search', '', '', '注意区分绑定应用，可多选。只有【系统配置---通用配置】里面的【点播热搜接口】留空才会调用这边的数据', 1, 'addtabs', '', 'ssnrtj', 'sousuoneirongtuijian', 1711632708, 1711679614, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(131, 'file', 130, 'box/hotsearch/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1711632708, 1711632708, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(132, 'file', 130, 'box/hotsearch/recyclebin', '回收站', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hsz', 'huishouzhan', 1711632708, 1711632708, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(133, 'file', 130, 'box/hotsearch/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1711632708, 1711632708, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(134, 'file', 130, 'box/hotsearch/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1711632708, 1711632708, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(135, 'file', 130, 'box/hotsearch/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1711632709, 1711632709, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(136, 'file', 130, 'box/hotsearch/destroy', '真实删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zssc', 'zhenshishanchu', 1711632709, 1711632709, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(137, 'file', 130, 'box/hotsearch/restore', '还原', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hy', 'huanyuan', 1711632709, 1711632709, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(138, 'file', 130, 'box/hotsearch/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1711632709, 1711632709, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(139, 'file', 93, 'box/notice', '公告动态', 'fa fa-info-circle', '', '', '注意区分绑定应用，可多选。', 1, 'addtabs', '', 'ggdt', 'gonggaodongtai', 1711632709, 1711679740, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(140, 'file', 139, 'box/notice/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1711632709, 1711632709, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(141, 'file', 139, 'box/notice/recyclebin', '回收站', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hsz', 'huishouzhan', 1711632709, 1711632709, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(142, 'file', 139, 'box/notice/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1711632709, 1711632709, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(143, 'file', 139, 'box/notice/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1711632709, 1711632709, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(144, 'file', 139, 'box/notice/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1711632709, 1711632709, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(145, 'file', 139, 'box/notice/destroy', '真实删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zssc', 'zhenshishanchu', 1711632709, 1711632709, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(146, 'file', 139, 'box/notice/restore', '还原', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hy', 'huanyuan', 1711632709, 1711632709, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(147, 'file', 139, 'box/notice/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1711632709, 1711632709, 0, 'normal');
-- INSERT INTO `fa_auth_rule` VALUES(148, 'file', 93, 'box/userstore', '用户私有仓库', 'fa fa-address-card', '', '', '用户自行在网页个人中心前台添加的仓库，仅添加者可用', 1, 'addtabs', '', 'yhsyck', 'yonghusiyoucangku', 1711632709, 1711678480, 0, 'normal');
-- INSERT INTO `fa_auth_rule` VALUES(149, 'file', 148, 'box/userstore/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1711632709, 1711632709, 0, 'normal');
-- INSERT INTO `fa_auth_rule` VALUES(150, 'file', 148, 'box/userstore/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1711632709, 1711632709, 0, 'normal');
-- INSERT INTO `fa_auth_rule` VALUES(151, 'file', 148, 'box/userstore/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1711632709, 1711632709, 0, 'normal');
-- INSERT INTO `fa_auth_rule` VALUES(152, 'file', 148, 'box/userstore/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1711632709, 1711632709, 0, 'normal');
-- INSERT INTO `fa_auth_rule` VALUES(153, 'file', 148, 'box/userstore/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1711632709, 1711632709, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(154, 'file', 0, 'version', '版本管理', 'fa fa-file-text-o', '', '', '注意区分绑定应用。常用于管理移动端应用版本更新。每个应用只需添加一个配置。下次更新版本修改最新版本号即可', 1, 'addtabs', '', 'bbgl', 'banbenguanli', 1711632785, 1711678721, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(155, 'file', 154, 'version/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1711632785, 1711632785, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(156, 'file', 154, 'version/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1711632785, 1711632785, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(157, 'file', 154, 'version/edit', '修改', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'xg', 'xiugai', 1711632785, 1711632785, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(158, 'file', 154, 'version/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1711632785, 1711632785, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(159, 'file', 154, 'version/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1711632785, 1711632785, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(160, 'file', 0, 'signin', '签到管理', 'fa fa-map-marker', '', '', '', 1, NULL, '', 'qdgl', 'qiandaoguanli', 1711632799, 1711632799, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(161, 'file', 160, 'signin/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1711632799, 1711632799, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(162, 'file', 160, 'signin/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1711632799, 1711632799, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(163, 'file', 160, 'signin/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1711632799, 1711632799, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(164, 'file', 160, 'signin/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1711632799, 1711632799, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(165, 'file', 160, 'signin/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1711632799, 1711632799, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(166, 'file', 66, 'user/moneylog', '会员余额日志', 'fa fa-list', '', '', '', 1, NULL, '', 'hyyerz', 'huiyuanyuerizhi', 1711632851, 1711632851, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(167, 'file', 166, 'user/moneylog/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1711632851, 1711632851, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(168, 'file', 166, 'user/moneylog/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1711632851, 1711632851, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(169, 'file', 166, 'user/moneylog/edit', '修改', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'xg', 'xiugai', 1711632851, 1711632851, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(170, 'file', 166, 'user/moneylog/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1711632851, 1711632851, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(171, 'file', 166, 'user/moneylog/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1711632851, 1711632851, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(172, 'file', 66, 'user/scorelog', '会员积分日志', 'fa fa-list', '', '', '', 1, NULL, '', 'hyjfrz', 'huiyuanjifenrizhi', 1711632851, 1711632851, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(173, 'file', 172, 'user/scorelog/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1711632851, 1711632851, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(174, 'file', 172, 'user/scorelog/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1711632851, 1711632851, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(175, 'file', 172, 'user/scorelog/edit', '修改', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'xg', 'xiugai', 1711632851, 1711632851, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(176, 'file', 172, 'user/scorelog/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1711632851, 1711632851, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(177, 'file', 172, 'user/scorelog/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1711632851, 1711632851, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(178, 'file', 5, 'general/database', '数据库管理', 'fa fa-database', '', '', '可进行一些简单的数据库表优化或修复，查看表结构和数据，也可以进行SQL语句的操作', 1, 'addtabs', '', 'sjkgl', 'shujukuguanli', 1711632903, 1711794927, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(179, 'file', 178, 'general/database/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1711632903, 1711632903, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(180, 'file', 178, 'general/database/query', '查询', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'cx', 'chaxun', 1711632903, 1711632903, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(181, 'file', 178, 'general/database/backup', '备份', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bf', 'beifen', 1711632903, 1711632903, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(182, 'file', 178, 'general/database/restore', '恢复', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hf', 'huifu', 1711632903, 1711632903, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(183, 'file', 5, 'box/cashier', '收银台列管理', 'fa fa-creative-commons', '', '', '监控状态是指监听端状态，状态是指此配置是否启用', 1, 'addtabs', '', 'sytlgl', 'shouyintailieguanli', 1711633045, 1711677482, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(184, 'file', 183, 'box/cashier/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1711633045, 1711633045, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(185, 'file', 183, 'box/cashier/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1711633045, 1711633045, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(186, 'file', 183, 'box/cashier/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1711633045, 1711633045, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(187, 'file', 183, 'box/cashier/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1711633045, 1711633045, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(188, 'file', 183, 'box/cashier/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1711633045, 1711633045, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(189, 'file', 5, 'box/qrcode', '收款码列管理', 'fa fa-qrcode', '', '', '请务必修改收款二维码地址。可使用https://cli.im/deqr来解析您的收款码后填入', 1, 'addtabs', '', 'skmlgl', 'shoukuanmalieguanli', 1711633045, 1711677686, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(190, 'file', 189, 'box/qrcode/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1711633045, 1711633045, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(191, 'file', 189, 'box/qrcode/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1711633045, 1711633045, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(192, 'file', 189, 'box/qrcode/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1711633045, 1711633045, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(193, 'file', 189, 'box/qrcode/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1711633045, 1711633045, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(194, 'file', 189, 'box/qrcode/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1711633045, 1711633045, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(195, 'file', 66, 'box/card', '卡密列表管理', 'fa fa-credit-card', '', '', '添加卡密时使用人留空表示所有人可用，否则仅指定账户可用。使用人有两种含义，未使用的卡密表示专属卡密。已使用的卡密表示使用人', 1, 'addtabs', '', 'kmlbgl', 'kamiliebiaoguanli', 1711633269, 1711676942, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(196, 'file', 195, 'box/card/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1711633269, 1711633269, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(197, 'file', 195, 'box/card/recyclebin', '回收站', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hsz', 'huishouzhan', 1711633269, 1711633269, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(198, 'file', 195, 'box/card/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1711633269, 1711633269, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(199, 'file', 195, 'box/card/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1711633269, 1711633269, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(200, 'file', 195, 'box/card/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1711633269, 1711633269, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(201, 'file', 195, 'box/card/destroy', '真实删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zssc', 'zhenshishanchu', 1711633269, 1711633269, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(202, 'file', 195, 'box/card/restore', '还原', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'hy', 'huanyuan', 1711633269, 1711633269, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(203, 'file', 195, 'box/card/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1711633269, 1711633269, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(204, 'file', 66, 'box/rechargeorder', '充值管理', 'fa fa-paypal', '', '', '如果您要为某个订单补单直接点击补单即可。不要在编辑里面修改订单状态为pid', 1, 'addtabs', '', 'czgl', 'chongzhiguanli', 1711633269, 1711677097, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(205, 'file', 204, 'box/rechargeorder/index', '查看', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'zk', 'zhakan', 1711633269, 1711633269, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(206, 'file', 204, 'box/rechargeorder/add', '添加', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'tj', 'tianjia', 1711633269, 1711633269, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(207, 'file', 204, 'box/rechargeorder/edit', '编辑', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'bj', 'bianji', 1711633269, 1711633269, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(208, 'file', 204, 'box/rechargeorder/del', '删除', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'sc', 'shanchu', 1711633269, 1711633269, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES(209, 'file', 204, 'box/rechargeorder/multi', '批量更新', 'fa fa-circle-o', '', '', '', 0, NULL, '', 'plgx', 'pilianggengxin', 1711633269, 1711633269, 0, 'normal');
COMMIT;

-- ----------------------------
-- Table structure for fa_box_app
-- ----------------------------
CREATE TABLE `fa_box_app` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `key` varchar(55) NOT NULL COMMENT '密钥',
  `qqgroup` varchar(255) NOT NULL COMMENT 'QQ群',
  `logincontrol` int(10) NOT NULL DEFAULT '1' COMMENT '最多登录设备数',
  `operationmode` enum('0','1','2','3') NOT NULL DEFAULT '0' COMMENT '运营方式:0=全免费,1=仅点播,2=仅直播,3=全收费',
  `logoimage` varchar(255) NOT NULL COMMENT '全局logo',
  `splashimage` varchar(255) DEFAULT NULL COMMENT '启动图',
  `backdropimage` varchar(255) DEFAULT NULL COMMENT '背景图',
  `playerimage` varchar(255) NOT NULL COMMENT '播放器背景',
  `serviceimage` varchar(255) NOT NULL COMMENT '客服二维码',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `deletetime` bigint(16) DEFAULT NULL COMMENT '删除时间',
  `about` text NOT NULL COMMENT '关于',
  `status` enum('normal','hidden') DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='应用管理' AUTO_INCREMENT=10001 ;

-- ----------------------------
-- Records of fa_box_app
-- ----------------------------
BEGIN;
INSERT INTO `fa_box_app` VALUES(10000, '默认应用', '7E3EFC55E756869192D127584FF280C5', '7E3EFC55E756869192D127584FF280C5', 2, '3', '/uploads/20240328/ffb0bf31f6fe6ac87fccc5b44354f855.png', '/uploads/20240328/78726fc6e4b1d4cb65e004726a902485.png', '/uploads/20240328/78726fc6e4b1d4cb65e004726a902485.png', '/uploads/20240328/cd9ba18c40df20f1102442ac8ccc71d3.jpg', '/uploads/20240328/ad57e56a032154c1975cb9630d99a8d8.png', 1711632248, 1711893095, NULL, '默认应用介绍', 'normal');
COMMIT;

-- ----------------------------
-- Table structure for fa_box_card
-- ----------------------------
CREATE TABLE `fa_box_card` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `box_app_ids` varchar(255) NOT NULL COMMENT '绑定应用',
  `card` varchar(12) NOT NULL COMMENT '卡密',
  `type` int(10) NOT NULL DEFAULT '1' COMMENT '卡密类型',
  `founder` varchar(255) DEFAULT '管理员' COMMENT '创建人',
  `user_id` int(10) unsigned DEFAULT NULL COMMENT '使用人',
  `usagetime` bigint(16) DEFAULT NULL COMMENT '使用时间',
  `creattime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `deletetime` bigint(16) DEFAULT NULL COMMENT '删除时间',
  `status` enum('normal','hidden') DEFAULT 'normal' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='卡密列表管理' AUTO_INCREMENT=1 ;

-- ----------------------------
-- Table structure for fa_box_cashier
-- ----------------------------
CREATE TABLE `fa_box_cashier` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(55) DEFAULT NULL COMMENT '名称',
  `key` varchar(55) DEFAULT NULL COMMENT '秘钥',
  `lasthearttime` bigint(16) DEFAULT NULL COMMENT '最后心跳时间',
  `lastpaytime` bigint(16) DEFAULT NULL COMMENT '最后支付时间',
  `jkstate` int(1) DEFAULT '0' COMMENT '监控状态',
  `status` enum('normal','hidden') NOT NULL DEFAULT 'hidden' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='收银台列表' AUTO_INCREMENT=10003 ;

-- ----------------------------
-- Records of fa_box_cashier
-- ----------------------------
BEGIN;
INSERT INTO `fa_box_cashier` VALUES(10000, '我的手机', 'P6n2x3fahXKPTEdU7JfSaBWCImYZ4LXH', 1711633340, 1711633340, 0, 'normal');
INSERT INTO `fa_box_cashier` VALUES(10001, '媳妇手机', '7E3EFC55E756869192D127584FF280C5', 1711633387, 1711633387, 0, 'normal');
COMMIT;

-- ----------------------------
-- Table structure for fa_box_home
-- ----------------------------
CREATE TABLE `fa_box_home` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `box_app_ids` varchar(255) DEFAULT NULL COMMENT '绑定应用',
  `title` varchar(50) DEFAULT NULL COMMENT '标题',
  `subtitle` varchar(55) NOT NULL DEFAULT '暂无' COMMENT '副标题',
  `parameter` varchar(55) DEFAULT NULL COMMENT '参数',
  `blurbcontent` text COMMENT '简介',
  `coverimage` varchar(255) DEFAULT NULL COMMENT '封面',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `deletetime` bigint(16) DEFAULT NULL COMMENT '删除时间',
  `weigh` int(10) DEFAULT '0' COMMENT '权重',
  `status` enum('normal','hidden') DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='首页配置管理' AUTO_INCREMENT=7 ;

-- ----------------------------
-- Records of fa_box_home
-- ----------------------------
BEGIN;
INSERT INTO `fa_box_home` VALUES(1, '10000', '央视直播', '2023 · 直播 · 央视直播 · 大陆', 'live===1008611', 'CCTV节目官网提供CCTV在线直播及中央电视台节目表预告等服务,中央电视台是中国重要的新闻舆论机构,现已开办众多频道及节目,拥有国内一流的播音员和主持人队伍', '/uploads/20240330/ddeeb152e67974d87722416b1576c9b2.png', 1491635035, 1711776441, NULL, 5, 'normal');
INSERT INTO `fa_box_home` VALUES(2, '10000', '甜蜜的你', '2023 · 蓝光 · 爱情 都市 · 大陆', '南瓜|1===263663', '兽医田甜突遭家庭变故，临危受命接管了家中经营的田林动物医院。就在医院面临倒闭之际，田甜偶然间结识了兽药企业绿川集团的总裁沈觅。沈觅也正巧被爷爷安排，需要完成一个限时一年的任务，于是打算投资田林动物医院，没想到却被田甜以投资理念不合拒绝。正在两人僵持不下时，因为特殊理由，沈觅以投资田林时对经营理念做出让步为交换条件，拜托田甜假扮自己的私人医生，田甜再三思考后答应了沈觅。\r\n合作期间，沈觅渐渐被田甜对待宠物的善良与耐心打动，与田甜携手救治了许多小动物，合力解决了各种难题，帮助前来看病的宠物和主人走向了美好的结局。重振田林的过程中，两人彼此治愈，共同成长，也更加深切地体会到了生命的美好', '/uploads/20240330/5eccc7e92f180df338ecec642e64ffd7.png', 1695450498, 1711776524, NULL, 1, 'normal');
INSERT INTO `fa_box_home` VALUES(3, '10000', '四平警事合集', '2022 · 普法  · 大陆  ·  综艺', 'lvdou|2===5661', '四平警事抖音账号创建于2018年5月，本着扩大宣传面积、拓展宣传途径的目的，四平市公安局政治部新闻宣传处创建了省内第一个政务短视频账号，在运营的三年多时间里获得了公安部、中政委等部门颁发的奖项。四平警事开创的轻喜剧系列普法短视频一经推出，获得广大网友的一致好评，全网播放量超过60亿次，被众多政务媒体、个人自媒体转发传播', '/uploads/20240330/72eeab0c67ff1b87f9de63b23ce4164d.png', 1695450394, 1711776487, NULL, 3, 'normal');
INSERT INTO `fa_box_home` VALUES(4, '10000', '我不是药神', '2018 · 蓝光 · 喜剧 电影 · 内地', '贱贱|1===45094', '普通中年男子程勇经营着一家保健品店，失意又失婚。不速之客吕受益的到来，让他开辟了一条去印度买药做“代购”的新事业，虽然困难重重，但他在这条“买药之路”上发现了商机，一发不可收拾地做起了治疗慢粒白血病的印度仿制药独家代理商。赚钱的同时，他也认识了几个病患及家属，为救女儿被迫做舞女的思慧、说一口流利“神父腔”英语的刘牧师，以及脾气暴烈的“黄毛”，几个人合伙做起了生意，利润倍增的同时也危机四伏。程勇昔日的小舅子曹警官奉命调查仿制药的源头，假药贩子张长林和瑞士正牌医药代表也对其虎视眈眈，生意逐渐变成了一场关于救赎的拉锯战。 　　本片改编自慢粒白血病患者陆勇代购抗癌药的真实事迹。', '/uploads/20240330/25ade8649122c33b61fee87504aee674.png', 1695450576, 1711776507, NULL, 2, 'normal');
INSERT INTO `fa_box_home` VALUES(5, '10000', '完美世界', '动漫', '南瓜|1===122341', '测试更多', '/uploads/20240330/8b4c27964bd49d2b8449ecaa7f130050.png', 1700726147, 1711776390, NULL, 8, 'normal');
INSERT INTO `fa_box_home` VALUES(6, '10000', '百度一下', '广告', 'web===https://wap.baidu.com', '测试更多', '/uploads/20240330/359879c16b6556e872916c144ec6580b.png', 1700726163, 1711776587, NULL, 9, 'normal');
COMMIT;

-- ----------------------------
-- Table structure for fa_box_hotsearch
-- ----------------------------
CREATE TABLE `fa_box_hotsearch` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `box_app_ids` varchar(255) DEFAULT '10000' COMMENT '绑定应用',
  `title` varchar(50) DEFAULT NULL COMMENT '名称',
  `subtitle` varchar(55) NOT NULL COMMENT '副标题',
  `parameter` varchar(55) DEFAULT NULL COMMENT '参数',
  `coverimage` varchar(255) DEFAULT NULL COMMENT '封面',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `deletetime` bigint(16) DEFAULT NULL COMMENT '删除时间',
  `weigh` int(10) DEFAULT '0' COMMENT '权重',
  `status` enum('normal','hidden') DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='搜索页推荐' AUTO_INCREMENT=4 ;

-- ----------------------------
-- Records of fa_box_hotsearch
-- ----------------------------
BEGIN;
INSERT INTO `fa_box_hotsearch` VALUES(1, '10000', '甜蜜的你', '2023', '472947===迷你库', '/assets/img/qrcode.png', 1695450498, 1706601892, NULL, 4, 'normal');
INSERT INTO `fa_box_hotsearch` VALUES(2, '10000', '四平警事合集', '2022 · 普法  · 大陆  ·  综艺', '5661===lvdou', '/assets/img/qrcode.png', 1695450394, 1706601888, NULL, 5, 'normal');
INSERT INTO `fa_box_hotsearch` VALUES(3, '10000', '我不是药神', '2018 · 蓝光 · 喜剧 电影 · 内地', '428593===迷你库', '/assets/img/qrcode.png', 1695450576, 1706601824, NULL, 6, 'normal');
COMMIT;

-- ----------------------------
-- Table structure for fa_box_keep`
-- ----------------------------
CREATE TABLE `fa_box_keep` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `appid` int(16) NOT NULL DEFAULT '10000' COMMENT '应用id',
  `user_id` int(10) NOT NULL COMMENT '用户id',
  `cid` varchar(55) NOT NULL DEFAULT '1' COMMENT '仓库id',
  `key` varchar(255) NOT NULL COMMENT 'sitekey',
  `vodid` varchar(255) NOT NULL COMMENT '视频id',
  `name` varchar(55) NOT NULL COMMENT '视频名称',
  `pic` varchar(255) NOT NULL COMMENT '封面',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='视频收藏' AUTO_INCREMENT=4 ;

-- ----------------------------
-- Records of fa_box_keep
-- ----------------------------
BEGIN;
INSERT INTO `fa_box_keep` VALUES(1, 10000, 1, '1', '迷你影视', '480167', '莲花楼', 'https://oss88.weimeigu.com.cn/uploads/20230929/3ac21f72bb22ce86861481cf6d8d3299.png', 1697782664, 1706601846);
INSERT INTO `fa_box_keep` VALUES(2, 10000, 1, '1', 'lvdou', '5661', '四平警事合集', 'https://pic.wujinpp.com/upload/vod/20210819-1/62693792ae07e70c715f1c81d3d73394.jpg', 1697944517, 1706601841);
INSERT INTO `fa_box_keep` VALUES(3, 10000, 1, '1', '迷你影视', '479135', '超时空护卫队', 'https://snzypic.com/upload/vod/20230928-1/cca99ac322016309ba6ed41448e7b4b0.jpg', 1698321891, 1706601836);
COMMIT;

-- ----------------------------
-- Table structure for fa_box_loginlog
-- ----------------------------
CREATE TABLE `fa_box_loginlog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `markcode` varchar(255) DEFAULT NULL COMMENT '识别码',
  `token` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Token',
  `createtime` bigint(16) unsigned DEFAULT NULL COMMENT '创建时间',
  `expiretime` bigint(16) unsigned DEFAULT NULL COMMENT '过期时间',
  `status` enum('created','paid','expired') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'created' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='远程登录日志' AUTO_INCREMENT=2 ;

-- ----------------------------
-- Records of fa_box_loginlog
-- ----------------------------
BEGIN;
INSERT INTO `fa_box_loginlog` VALUES(1, '5bda028d4138da11', '00f2d29f9ce386b85dcd56ec969751ed181ec7d4', 1701677217, 1710259199, 'paid');
COMMIT;

-- ----------------------------
-- Table structure for fa_box_notice
-- ----------------------------
CREATE TABLE `fa_box_notice` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `box_app_ids` varchar(255) NOT NULL DEFAULT '10000' COMMENT '绑定应用',
  `title` varchar(55) NOT NULL COMMENT '标题',
  `content` text NOT NULL COMMENT '内容',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `deletetime` bigint(16) DEFAULT NULL COMMENT '删除时间',
  `weigh` int(10) DEFAULT NULL COMMENT '权重',
  `status` enum('normal','hidden') DEFAULT 'normal' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='公告动态' AUTO_INCREMENT=4 ;

-- ----------------------------
-- Records of fa_box_notice
-- ----------------------------
BEGIN;
INSERT INTO `fa_box_notice` VALUES(1, '10000', '播放界面黑屏怎么办?', '播放视频时界面黑屏无声音无进度可能是设备不支持硬解码，可尝试到我的---设置---高级设置---IJK解码方式设为软解码，安卓5.0以上可尝试修改播放核心，路径同上', 1711883189, NULL, 3, 'normal');
INSERT INTO `fa_box_notice` VALUES(2, '10000', '电视剧如何设置片头/尾?', '全屏状态下进度条底部右侧可见【设片头】【设片尾】，比如您要跳过片头一分钟，当进度条走到1分钟的时候按下设片头即可获得当前进度并设为跳过片头时间，当电视剧下一集时自动跳过，片尾同理，视频快结束时按下设片尾即可', 1706601898, NULL, 2, 'normal');
INSERT INTO `fa_box_notice` VALUES(3, '10000', '如何在手机或电脑上管理自己的账户?', '如果您需要对账户进行一些深度操作，TV显然不够灵活，超控不如PC或手机丝滑。您可以使用手机或PC访问https://superbox.lvdoui.net并登录自己的账户，或关注微信公众号xxxxx。公众号提供用户登录入口及最新活动通报~赶快试试吧', 1706601902, NULL, 1, 'normal');
COMMIT;

-- ----------------------------
-- Table structure for fa_box_parses
-- ----------------------------
CREATE TABLE `fa_box_parses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `box_app_ids` varchar(255) DEFAULT '10000' COMMENT '绑定应用',
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `url` varchar(255) DEFAULT NULL COMMENT 'url',
  `ext` text COMMENT '扩展(ext)',
  `type` enum('0','1','2','3') NOT NULL DEFAULT '0' COMMENT '接口类型:0=嗅探,1=json,2=Json扩展,3=聚合',
  `encryptionswitch` tinyint(1) DEFAULT '0' COMMENT '是否加密',
  `vipverifyswitch` tinyint(1) DEFAULT '0' COMMENT '仅会员可用',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `deletetime` bigint(16) DEFAULT NULL COMMENT '删除时间',
  `weigh` int(10) DEFAULT '0' COMMENT '权重',
  `status` enum('normal','hidden') DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='视频接口管理' AUTO_INCREMENT=2 ;

-- ----------------------------
-- Records of fa_box_parses
-- ----------------------------
BEGIN;
INSERT INTO `fa_box_parses` VALUES(1, '10000', '使用时请修改或关闭本接口', 'https://www.lvdoui.net/api/text.php?url=', '{\r\n    "flag": [\r\n        "qq",\r\n        "腾讯",\r\n        "qiyi",\r\n        "爱奇艺",\r\n        "奇艺",\r\n        "youku",\r\n        "优酷",\r\n        "mgtv",\r\n        "芒果",\r\n        "imgo",\r\n        "letv",\r\n        "乐视",\r\n        "pptv",\r\n        "PPTV",\r\n        "sohu",\r\n        "bilibili",\r\n        "哔哩哔哩",\r\n        "哔哩"\r\n    ],\r\n    "header": {\r\n        "User-Agent": "okhttp/4.1.0"\r\n    }\r\n}', '1', 1, 0, 1695453708, 1709720196, NULL, 1, 'normal');
COMMIT;

-- ----------------------------
-- Table structure for fa_box_qrcode
-- ----------------------------
CREATE TABLE `fa_box_qrcode` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `price` double DEFAULT '0' COMMENT '金额',
  `qrcode` varchar(255) NOT NULL COMMENT '二维码链接',
  `codedata` enum('currency','regular') NOT NULL DEFAULT 'currency' COMMENT '二维码类型:currency=通用码,regular=固定金额',
  `platformdata` enum('wechat','alipay') NOT NULL DEFAULT 'wechat' COMMENT '收款平台:wechat=微信码,alipay=支付宝码',
  `statusswitch` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='收款码列表' AUTO_INCREMENT=3 ;

-- ----------------------------
-- Records of fa_box_qrcode
-- ----------------------------
BEGIN;
INSERT INTO `fa_box_qrcode` VALUES(1, 0, 'wxp://f2f0xWDJB98wmgZvSy3j5o90i3yQpzKl1CSZuVLqdTNOExwKxTetO-7Cb2U7o7rpNv2R', 'currency', 'wechat', 1);
INSERT INTO `fa_box_qrcode` VALUES(2, 0, 'https://qr.alipay.com/fkx193677lo0ox4wning8c7', 'currency', 'alipay', 1);
COMMIT;

-- ----------------------------
-- Table structure for fa_box_store
-- ----------------------------
CREATE TABLE `fa_box_store` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `box_app_ids` varchar(255) DEFAULT '10000' COMMENT '绑定应用',
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `url` varchar(255) DEFAULT NULL COMMENT '仓库地址',
  `encryptionswitch` tinyint(1) DEFAULT '0' COMMENT '是否加密',
  `vipverifyswitch` tinyint(1) NOT NULL DEFAULT '0' COMMENT '仅会员可用',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `deletetime` bigint(16) DEFAULT NULL COMMENT '删除时间',
  `weigh` int(10) DEFAULT '0' COMMENT '权重',
  `status` enum('normal','hidden') DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='仓库配置管理' AUTO_INCREMENT=2 ;

-- ----------------------------
-- Records of fa_box_store
-- ----------------------------
BEGIN;
INSERT INTO `fa_box_store` VALUES(1, '10000', '默认仓库', 'api.json', 1, 0, 1695453494, 1709962115, NULL, 1, 'normal');
COMMIT;

-- ----------------------------
-- Table structure for fa_box_tmpprice
-- ----------------------------
CREATE TABLE `fa_box_tmpprice` (
  `price` varchar(255) NOT NULL COMMENT '金额',
  `oid` varchar(255) NOT NULL COMMENT '订单号',
  PRIMARY KEY (`price`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='临时金额';

-- -- ----------------------------
-- -- Table structure for fa_box_userstore
-- -- ----------------------------
-- CREATE TABLE `fa_box_userstore` (
--   `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
--   `user_id` int(10) DEFAULT NULL COMMENT '用户id',
--   `name` varchar(50) DEFAULT NULL COMMENT '名称',
--   `url` varchar(255) DEFAULT NULL COMMENT '仓库地址',
--   `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
--   `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
--   `weigh` int(10) DEFAULT '0' COMMENT '权重',
--   `status` enum('normal','hidden') DEFAULT NULL COMMENT '状态',
--   PRIMARY KEY (`id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户私有仓库' AUTO_INCREMENT=1 ;

-- ----------------------------
-- Table structure for fa_category
-- ----------------------------
CREATE TABLE `fa_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `type` varchar(30) DEFAULT '' COMMENT '栏目类型',
  `name` varchar(30) DEFAULT '',
  `nickname` varchar(50) DEFAULT '',
  `flag` set('hot','index','recommend') DEFAULT '',
  `image` varchar(100) DEFAULT '' COMMENT '图片',
  `keywords` varchar(255) DEFAULT '' COMMENT '关键字',
  `description` varchar(255) DEFAULT '' COMMENT '描述',
  `diyname` varchar(30) DEFAULT '' COMMENT '自定义名称',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` varchar(30) DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `weigh` (`weigh`,`id`),
  KEY `pid` (`pid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='分类表' AUTO_INCREMENT=14 ;

-- ----------------------------
-- Records of fa_category
-- ----------------------------
BEGIN;
INSERT INTO `fa_category` VALUES(1, 0, 'page', '官方新闻', 'news', 'recommend', '/assets/img/qrcode.png', '', '', 'news', 1491635035, 1491635035, 1, 'normal');
INSERT INTO `fa_category` VALUES(2, 0, 'page', '移动应用', 'mobileapp', 'hot', '/assets/img/qrcode.png', '', '', 'mobileapp', 1491635035, 1491635035, 2, 'normal');
INSERT INTO `fa_category` VALUES(3, 2, 'page', '微信公众号', 'wechatpublic', 'index', '/assets/img/qrcode.png', '', '', 'wechatpublic', 1491635035, 1491635035, 3, 'normal');
INSERT INTO `fa_category` VALUES(4, 2, 'page', 'Android开发', 'android', 'recommend', '/assets/img/qrcode.png', '', '', 'android', 1491635035, 1491635035, 4, 'normal');
INSERT INTO `fa_category` VALUES(5, 0, 'page', '软件产品', 'software', 'recommend', '/assets/img/qrcode.png', '', '', 'software', 1491635035, 1491635035, 5, 'normal');
INSERT INTO `fa_category` VALUES(6, 5, 'page', '网站建站', 'website', 'recommend', '/assets/img/qrcode.png', '', '', 'website', 1491635035, 1491635035, 6, 'normal');
INSERT INTO `fa_category` VALUES(7, 5, 'page', '企业管理软件', 'company', 'index', '/assets/img/qrcode.png', '', '', 'company', 1491635035, 1491635035, 7, 'normal');
INSERT INTO `fa_category` VALUES(8, 6, 'page', 'PC端', 'website-pc', 'recommend', '/assets/img/qrcode.png', '', '', 'website-pc', 1491635035, 1491635035, 8, 'normal');
INSERT INTO `fa_category` VALUES(9, 6, 'page', '移动端', 'website-mobile', 'recommend', '/assets/img/qrcode.png', '', '', 'website-mobile', 1491635035, 1491635035, 9, 'normal');
INSERT INTO `fa_category` VALUES(10, 7, 'page', 'CRM系统 ', 'company-crm', 'recommend', '/assets/img/qrcode.png', '', '', 'company-crm', 1491635035, 1491635035, 10, 'normal');
INSERT INTO `fa_category` VALUES(11, 7, 'page', 'SASS平台软件', 'company-sass', 'recommend', '/assets/img/qrcode.png', '', '', 'company-sass', 1491635035, 1491635035, 11, 'normal');
INSERT INTO `fa_category` VALUES(12, 0, 'test', '测试1', 'test1', 'recommend', '/assets/img/qrcode.png', '', '', 'test1', 1491635035, 1491635035, 12, 'normal');
INSERT INTO `fa_category` VALUES(13, 0, 'test', '测试2', 'test2', 'recommend', '/assets/img/qrcode.png', '', '', 'test2', 1491635035, 1491635035, 13, 'normal');
COMMIT;

-- ----------------------------
-- Table structure for fa_config
-- ----------------------------
CREATE TABLE `fa_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT '' COMMENT '变量名',
  `group` varchar(30) DEFAULT '' COMMENT '分组',
  `title` varchar(100) DEFAULT '' COMMENT '变量标题',
  `tip` varchar(100) DEFAULT '' COMMENT '变量描述',
  `type` varchar(30) DEFAULT '' COMMENT '类型:string,text,int,bool,array,datetime,date,file',
  `visible` varchar(255) DEFAULT '' COMMENT '可见条件',
  `value` text COMMENT '变量值',
  `content` text COMMENT '变量字典数据',
  `rule` varchar(100) DEFAULT '' COMMENT '验证规则',
  `extend` varchar(255) DEFAULT '' COMMENT '扩展属性',
  `setting` varchar(255) DEFAULT '' COMMENT '配置',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='系统配置' AUTO_INCREMENT=48 ;

-- ----------------------------
-- Records of fa_config
-- ----------------------------
BEGIN;
INSERT INTO `fa_config` VALUES(1, 'name', 'basic', 'Site name', '请填写站点名称', 'string', '', '通用后台', '', 'required', '', '');
INSERT INTO `fa_config` VALUES(2, 'beian', 'basic', 'Beian', '粤ICP备15000000号-1', 'string', '', '', '', '', '', '');
INSERT INTO `fa_config` VALUES(3, 'cdnurl', 'basic', 'Cdn url', '如果全站静态资源使用第三方云储存请配置该值', 'string', '', '', '', '', '', '');
INSERT INTO `fa_config` VALUES(4, 'version', 'basic', 'Version', '如果静态资源有变动请重新配置该值', 'string', '', '1.0.16', '', 'required', '', '');
INSERT INTO `fa_config` VALUES(5, 'timezone', 'basic', 'Timezone', '', 'string', '', 'Asia/Shanghai', '', 'required', '', '');
INSERT INTO `fa_config` VALUES(6, 'forbiddenip', 'basic', 'Forbidden ip', '一行一条记录', 'text', '', '', '', '', '', '');
INSERT INTO `fa_config` VALUES(7, 'languages', 'basic', 'Languages', '', 'array', '', '{"backend":"zh-cn","frontend":"zh-cn"}', '', 'required', '', '');
INSERT INTO `fa_config` VALUES(8, 'fixedpage', 'basic', 'Fixed page', '请输入左侧菜单栏存在的链接', 'string', '', 'dashboard', '', 'required', '', '');
INSERT INTO `fa_config` VALUES(9, 'categorytype', 'dictionary', 'Category type', '', 'array', '', '{"default":"默认","page":"单页","article":"文章","test":"Test"}', '', '', '', NULL);
INSERT INTO `fa_config` VALUES(10, 'configgroup', 'dictionary', 'Config group', '', 'array', '', '{"basic":"基础配置","email":"邮件配置","user":"会员配置","payment":"支付配置","communal":"通用配置","dictionary":"字典配置"}', '', '', '', NULL);
INSERT INTO `fa_config` VALUES(11, 'mail_type', 'email', 'Mail type', '选择邮件发送方式', 'select', '', '1', '["请选择","SMTP"]', '', '', NULL);
INSERT INTO `fa_config` VALUES(12, 'mail_smtp_host', 'email', 'Mail smtp host', '错误的配置发送邮件会导致服务器超时', 'string', '', 'smtp.163.com', '', '', '', NULL);
INSERT INTO `fa_config` VALUES(13, 'mail_smtp_port', 'email', 'Mail smtp port', '(不加密默认25,SSL默认465,TLS默认587)', 'string', '', '465', '', '', '', NULL);
INSERT INTO `fa_config` VALUES(14, 'mail_smtp_user', 'email', 'Mail smtp user', '（填写完整用户名）', 'string', '', 'auth889@163.com', '', '', '', NULL);
INSERT INTO `fa_config` VALUES(15, 'mail_smtp_pass', 'email', 'Mail smtp password', '（填写您的密码或授权码）', 'password', '', 'EKZLEXRHVGNVVAQU', '', '', '', NULL);
INSERT INTO `fa_config` VALUES(16, 'mail_verify_type', 'email', 'Mail vertify type', '（SMTP验证方式[推荐SSL]）', 'select', '', '2', '["无","TLS","SSL"]', '', '', NULL);
INSERT INTO `fa_config` VALUES(17, 'mail_from', 'email', 'Mail from', '', 'string', '', 'auth889@163.com', '', '', '', NULL);
INSERT INTO `fa_config` VALUES(18, 'attachmentcategory', 'dictionary', 'Attachment category', '', 'array', '', '{"category1":"分类一","category2":"分类二","custom":"自定义"}', '', '', '', NULL);
INSERT INTO `fa_config` VALUES(19, 'send_money', 'user', '注册赠送余额', '首次注册送余额', 'string', '', '10', '', '', '', '{"table":"","conditions":"","key":"","value":""}');
INSERT INTO `fa_config` VALUES(20, 'send_vips', 'user', '注册赠送会员', '首次注册送会员天数', 'string', '', '10', '', '', '', '{"table":"","conditions":"","key":"","value":""}');
INSERT INTO `fa_config` VALUES(21, 'agency_price', 'user', '升级代理价格', '代理身份仅对提卡有效，客户端在线充值无折扣', 'string', '', '88', '', '', '', '{"table":"","conditions":"","key":"","value":""}');
INSERT INTO `fa_config` VALUES(22, 'agency_discount', 'user', '代理提卡折扣', '在线升级代理默认折扣，按百分比算。50=50%,60=60%', 'string', '', '50', '', '', '', '{"table":"","conditions":"","key":"","value":""}');
INSERT INTO `fa_config` VALUES(23, 'token_lifespan', 'user', 'TOKEN有效期', '2592000约为30天。0表示永久', 'string', '', '2592000', '', '', '', '{"table":"","conditions":"","key":"","value":""}');
INSERT INTO `fa_config` VALUES(24, 'device_overrun', 'user', '登录设备超过上限时', '拒绝登录时，须token过期或删除才能重新登录', 'radio', '', '2', '{"1":"拒绝登录","2":"下线最早设备"}', '', '', '{"table":"","conditions":"","key":"","value":""}');
INSERT INTO `fa_config` VALUES(25, 'payment_platform', 'payment', '收款平台', '聚合插件的收款配置在插件管理里面找微信支付宝聚合插件配置', 'radio', '', '1', '{"1":"系统自带","2":"聚合插件","3":"易支付"}', '', '', '{"table":"","conditions":"","key":"","value":""}');
INSERT INTO `fa_config` VALUES(26, 'amount_conflict', 'payment', '金额冲突时', '多用户同时下单相同金额时，金额增减0.01或等待其他人支付完成', 'radio', 'payment_platform==1', '1', '{"1":"金额递增","2":"金额递减","3":"等待支付"}', '', '', '{"table":"","conditions":"","key":"","value":""}');
INSERT INTO `fa_config` VALUES(27, 'disconnect', 'payment', '监听端掉线时', '收银台在30秒内无心跳视为掉线，部分设备不需要心跳也能监听收款', 'radio', 'payment_platform==1', '1', '{"1":"允许支付","2":"拦截支付并通知管理员"}', '', '', '{"table":"","conditions":"","key":"","value":""}');
INSERT INTO `fa_config` VALUES(28, 'api_wechat', 'payment', '微信API', '易支付提供的微信网页接口', 'string', 'payment_platform==3', 'http://pay.md214.cn/', '', '', '', '{"table":"","conditions":"","key":"","value":""}');
INSERT INTO `fa_config` VALUES(29, 'merchant_id_wechat', 'payment', '微信商户ID', '易支付提供的微信商户id', 'string', 'payment_platform==3', '195409753', '', '', '', '{"table":"","conditions":"","key":"","value":""}');
INSERT INTO `fa_config` VALUES(30, 'merchant_key_wechat', 'payment', '微信商户密钥', '易支付提供的微信商户密钥', 'string', 'payment_platform==3', 'p9YgWM3A5bz', '', '', '', '{"table":"","conditions":"","key":"","value":""}');
INSERT INTO `fa_config` VALUES(31, 'api_alipay', 'payment', '支付宝接口', '易支付提供的支付宝接口', 'string', 'payment_platform==3', 'http://pay.md214.cn/', '', '', '', '{"table":"","conditions":"","key":"","value":""}');
INSERT INTO `fa_config` VALUES(32, 'merchant_id_alipay', 'payment', '支付宝商户id', '易支付提供的支付宝商户id', 'string', 'payment_platform==3', '195409753', '', '', '', '{"table":"","conditions":"","key":"","value":""}');
INSERT INTO `fa_config` VALUES(33, 'merchant_key_alipay', 'payment', '支付宝商户密钥', '易支付提供的支付宝商户密钥', 'string', 'payment_platform==3', 'p9YgWM3A5bz', '', '', '', '{"table":"","conditions":"","key":"","value":""}');
INSERT INTO `fa_config` VALUES(34, 'qrcode_display_method', 'payment', '二维码展示方式', '浏览器展示收款码兼容性好。匹配二维码需要提供页面的正则表达式', 'radio', '', '1', '{"1":"直接显示","2":"跳转内部浏览器"}', '', '', '{"table":"","conditions":"","key":"","value":""}');
INSERT INTO `fa_config` VALUES(35, 'qrcode_rule', 'payment', '二维码匹配规则', '', 'array', 'qrcode_display_method==1', '{"weixin://":"weixin://[^\\"]+#￥(.+?)<","qr.alipay.com":"https://qr.alipay.com[^\\"]+#money\\">(.+?)<"}', '{"value1":"title1","value2":"title2"}', '', '', '{"table":"","conditions":"","key":"type","value":"rule"}');
INSERT INTO `fa_config` VALUES(36, 'live_api', 'communal', '直播清单接口', '在仓库中插入一条直播源', 'string', '', 'https://agit.ai/Doudou/TVbox/raw/branch/master/tv/live.txt', '', '', '', '{"table":"","conditions":"","key":"","value":""}');
INSERT INTO `fa_config` VALUES(37, 'epg_api', 'communal', 'EPG信息接口', '固定格式及固定返回值', 'string', '', 'http://epg.51zmt.top:8000/api/diyp/?ch={name}&date={date}', '', '', '', '{"table":"","conditions":"","key":"","value":""}');
INSERT INTO `fa_config` VALUES(38, 'hot_search_api', 'communal', '点播热搜接口', '如有请求头使用|分开。留空使用后台推荐', 'string', '', 'https://api.web.360kan.com/v1/rank?cat=1|https://www.360kan.com/rank/general', '', '', '', '{"table":"","conditions":"","key":"","value":""}');
INSERT INTO `fa_config` VALUES(39, 'depot_site_hide', 'communal', '仓库资源屏蔽', '资源名称，多个用|隔开，【如：七七|极品影视】', 'string', '', '小爱|小鸭|微信|教育|课堂', '', '', '', '{"table":"","conditions":"","key":"","value":""}');
INSERT INTO `fa_config` VALUES(40, 'depot_class_hide', 'communal', '仓库分类屏蔽', '分类名称，多个用|隔开【如：电影|电视剧】', 'string', '', '电影', '', '', '', '{"table":"","conditions":"","key":"","value":""}');
INSERT INTO `fa_config` VALUES(41, 'depot_parses_hide', 'communal', '视频接口屏蔽', '接口名称,多个用|隔开【如：线路一|线路二】', 'string', '', '官解1|但行好事', '', '', '', '{"table":"","conditions":"","key":"","value":""}');
INSERT INTO `fa_config` VALUES(42, 'maccms_key', 'communal', '苹果CMS密钥', '与苹果CMS对接文件保持一致,32位', 'string', '', 'ziKv8NzFSwNoBUYRJclwwjRaiTWBb7ON', '', '', '', '{"table":"","conditions":"","key":"","value":""}');
INSERT INTO `fa_config` VALUES(43, 'qweather_key', 'communal', '和风APIKEY', '<a href="https://console.qweather.com/#/apps" target="_blank">点击注册</a>', 'string', '', 'b382d4697acd4f83a5268c397f6a1010', '', '', '', '{"table":"","conditions":"","key":"","value":""}');
INSERT INTO `fa_config` VALUES(44, 'default_player', 'communal', '默认播放器', '首次启动应用时有效，权重小于仓库定义的播放器', 'radio', '', '1', '{"1":"系统","2":"IJK","3":"EXO"}', '', '', '{"table":"","conditions":"","key":"","value":""}');
INSERT INTO `fa_config` VALUES(45, 'custom_depot', 'communal', '自定义仓库', '开启或关闭自定义仓库功能、自动【永久会员才可自定义仓库】', 'radio', '', '1', '{"1":"关闭","2":"开启","3":"自动"}', '', '', '{"table":"","conditions":"","key":"","value":""}');
INSERT INTO `fa_config` VALUES(46, 'service_qq', 'communal', '客服信息', '显示在可能需要的地方', 'string', '', '客服QQ592805093', '', '', '', '{"table":"","conditions":"","key":"","value":""}');
INSERT INTO `fa_config` VALUES(47, 'resource_renaming', 'communal', '播放源重命名', '播放页资源重命名。key=原名称，value新名称', 'array', '', '{"qq":"腾讯","qiyi":"奇艺","youku":"优酷","douyin":"抖音"}', '{"value1":"title1","value2":"title2"}', '', '', '{"table":"","conditions":"","key":"key","value":"value"}');
COMMIT;

-- ----------------------------
-- Table structure for fa_ems
-- ----------------------------
CREATE TABLE `fa_ems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `event` varchar(30) DEFAULT '' COMMENT '事件',
  `email` varchar(100) DEFAULT '' COMMENT '邮箱',
  `code` varchar(10) DEFAULT '' COMMENT '验证码',
  `times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证次数',
  `ip` varchar(30) DEFAULT '' COMMENT 'IP',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='邮箱验证码表' AUTO_INCREMENT=1 ;

-- ----------------------------
-- Table structure for fa_invite
-- ----------------------------
CREATE TABLE `fa_invite` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `invited_user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '被邀请人',
  `ip` varchar(50) NOT NULL DEFAULT '' COMMENT '注册IP',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='邀请表' AUTO_INCREMENT=1 ;

-- ----------------------------
-- Table structure for fa_recharge_order
-- ----------------------------
CREATE TABLE `fa_recharge_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `orderid` varchar(100) DEFAULT NULL COMMENT '订单ID',
  `user_id` int(10) unsigned DEFAULT '0' COMMENT '会员ID',
  `amount` double(10,2) unsigned DEFAULT '0.00' COMMENT '订单金额',
  `allocationamount` double(10,2) DEFAULT '0.00' COMMENT '分配金额',
  `payamount` double(10,2) unsigned DEFAULT '0.00' COMMENT '支付金额',
  `paytype` varchar(50) DEFAULT NULL COMMENT '支付类型',
  `paytime` bigint(16) DEFAULT NULL COMMENT '支付时间',
  `ip` varchar(50) DEFAULT NULL COMMENT 'IP地址',
  `payurl` varchar(255) DEFAULT NULL COMMENT '二维码地址',
  `useragent` varchar(255) DEFAULT NULL COMMENT 'UserAgent',
  `memo` varchar(255) DEFAULT NULL COMMENT '备注',
  `createtime` bigint(16) DEFAULT NULL COMMENT '添加时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `status` enum('created','paid','expired') DEFAULT 'created' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='充值表' AUTO_INCREMENT=1 ;

-- ----------------------------
-- Table structure for fa_signin
-- ----------------------------
CREATE TABLE `fa_signin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `successions` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '连续签到次数',
  `type` enum('normal','fillup') DEFAULT 'normal' COMMENT '签到类型',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='签到表' AUTO_INCREMENT=1 ;

-- ----------------------------
-- Table structure for fa_sms
-- ----------------------------
CREATE TABLE `fa_sms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `event` varchar(30) DEFAULT '' COMMENT '事件',
  `mobile` varchar(20) DEFAULT '' COMMENT '手机号',
  `code` varchar(10) DEFAULT '' COMMENT '验证码',
  `times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证次数',
  `ip` varchar(30) DEFAULT '' COMMENT 'IP',
  `createtime` bigint(16) unsigned DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='短信验证码表' AUTO_INCREMENT=1 ;

-- ----------------------------
-- Table structure for fa_test
-- ----------------------------
CREATE TABLE `fa_test` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) DEFAULT '0' COMMENT '会员ID',
  `admin_id` int(10) DEFAULT '0' COMMENT '管理员ID',
  `category_id` int(10) unsigned DEFAULT '0' COMMENT '分类ID(单选)',
  `category_ids` varchar(100) DEFAULT NULL COMMENT '分类ID(多选)',
  `tags` varchar(255) DEFAULT '' COMMENT '标签',
  `week` enum('monday','tuesday','wednesday') DEFAULT NULL COMMENT '星期(单选):monday=星期一,tuesday=星期二,wednesday=星期三',
  `flag` set('hot','index','recommend') DEFAULT '' COMMENT '标志(多选):hot=热门,index=首页,recommend=推荐',
  `genderdata` enum('male','female') DEFAULT 'male' COMMENT '性别(单选):male=男,female=女',
  `hobbydata` set('music','reading','swimming') DEFAULT NULL COMMENT '爱好(多选):music=音乐,reading=读书,swimming=游泳',
  `title` varchar(100) DEFAULT '' COMMENT '标题',
  `content` text COMMENT '内容',
  `image` varchar(100) DEFAULT '' COMMENT '图片',
  `images` varchar(1500) DEFAULT '' COMMENT '图片组',
  `attachfile` varchar(100) DEFAULT '' COMMENT '附件',
  `keywords` varchar(255) DEFAULT '' COMMENT '关键字',
  `description` varchar(255) DEFAULT '' COMMENT '描述',
  `city` varchar(100) DEFAULT '' COMMENT '省市',
  `array` varchar(255) DEFAULT '' COMMENT '数组:value=值',
  `json` varchar(255) DEFAULT '' COMMENT '配置:key=名称,value=值',
  `multiplejson` varchar(1500) DEFAULT '' COMMENT '二维数组:title=标题,intro=介绍,author=作者,age=年龄',
  `price` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '价格',
  `views` int(10) unsigned DEFAULT '0' COMMENT '点击',
  `workrange` varchar(100) DEFAULT '' COMMENT '时间区间',
  `startdate` date DEFAULT NULL COMMENT '开始日期',
  `activitytime` datetime DEFAULT NULL COMMENT '活动时间(datetime)',
  `year` year(4) DEFAULT NULL COMMENT '年',
  `times` time DEFAULT NULL COMMENT '时间',
  `refreshtime` bigint(16) DEFAULT NULL COMMENT '刷新时间',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `deletetime` bigint(16) DEFAULT NULL COMMENT '删除时间',
  `weigh` int(10) DEFAULT '0' COMMENT '权重',
  `switch` tinyint(1) DEFAULT '0' COMMENT '开关',
  `status` enum('normal','hidden') DEFAULT 'normal' COMMENT '状态',
  `state` enum('0','1','2') DEFAULT '1' COMMENT '状态值:0=禁用,1=正常,2=推荐',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='测试表' AUTO_INCREMENT=2 ;

-- ----------------------------
-- Records of fa_test
-- ----------------------------
BEGIN;
INSERT INTO `fa_test` VALUES(1, 1, 1, 12, '12,13', '互联网,计算机', 'monday', 'hot,index', 'male', 'music,reading', '我是一篇测试文章', '<p>我是测试内容</p>', '/assets/img/avatar.png', '/assets/img/avatar.png,/assets/img/qrcode.png', '/assets/img/avatar.png', '关键字', '我是一篇测试文章描述，内容过多时将自动隐藏', '广西壮族自治区/百色市/平果县', '["a","b"]', '{"a":"1","b":"2"}', '[{"title":"标题一","intro":"介绍一","author":"小明","age":"21"}]', '0.00', 0, '2020-10-01 00:00:00 - 2021-10-31 23:59:59', '2017-07-10', '2017-07-10 18:24:45', 2017, '18:24:45', 1491635035, 1491635035, 1491635035, NULL, 0, 1, 'normal', '1');
COMMIT;


-- ----------------------------
-- Table structure for fa_user
-- ----------------------------
CREATE TABLE `fa_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '组别ID',
  `username` varchar(32) DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) DEFAULT '' COMMENT '昵称',
  `password` varchar(32) DEFAULT '' COMMENT '密码',
  `salt` varchar(30) DEFAULT '' COMMENT '密码盐',
  `email` varchar(100) DEFAULT '' COMMENT '电子邮箱',
  `mobile` varchar(11) DEFAULT '' COMMENT '手机号',
  `avatar` varchar(255) DEFAULT '' COMMENT '头像',
  `level` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '等级',
  `gender` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `bio` varchar(100) DEFAULT '' COMMENT '格言',
  `money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '余额',
  `score` int(10) NOT NULL DEFAULT '0' COMMENT '积分',
  `successions` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '连续登录天数',
  `maxsuccessions` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '最大连续登录天数',
  `prevtime` bigint(16) DEFAULT NULL COMMENT '上次登录时间',
  `logintime` bigint(16) DEFAULT NULL COMMENT '登录时间',
  `loginip` varchar(50) DEFAULT '' COMMENT '登录IP',
  `loginfailure` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '失败次数',
  `joinip` varchar(50) DEFAULT '' COMMENT '加入IP',
  `jointime` bigint(16) DEFAULT NULL COMMENT '加入时间',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `token` varchar(50) DEFAULT '' COMMENT 'Token',
  `status` varchar(30) DEFAULT '' COMMENT '状态',
  `verification` varchar(255) DEFAULT NULL COMMENT '验证',
  `discount` varchar(16) NOT NULL DEFAULT '100' COMMENT '折扣',
  `vipendtime` bigint(16) DEFAULT '0' COMMENT 'VIP到期时间',
  `mark` varchar(55) NOT NULL COMMENT '标识',
  PRIMARY KEY (`id`),
  KEY `username` (`username`),
  KEY `email` (`email`),
  KEY `mobile` (`mobile`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='会员表' AUTO_INCREMENT=2 ;

-- ----------------------------
-- Records of fa_user
-- ----------------------------
BEGIN;
INSERT INTO `fa_user` VALUES(1, 2, 'admin', 'admin', 'b6d0f81f29e0f496ed97da499fe27c7f', 'kVslYy', 'admin@163.com', '13000000000', 'https://app.lvdoui.net/assets/img/avatar.png', 1, 0, '2017-04-08', '', '69.39', 2, 3, 3, 1711888642, 1711890274, '112.51.201.46', 0, '127.0.0.1', 1491635035, 0, 1711890274, '', 'normal', '', '50', 1713338429, '');
COMMIT;


-- ----------------------------
-- Table structure for fa_user_group
-- ----------------------------
CREATE TABLE `fa_user_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT '' COMMENT '组名',
  `rules` text COMMENT '权限节点',
  `price` double(10,2) NOT NULL DEFAULT '0.00' COMMENT '价格',
  `days` int(10) NOT NULL DEFAULT '1' COMMENT '套餐时长(天)',
  `intro` varchar(55) NOT NULL DEFAULT '套餐介绍' COMMENT '套餐介绍',
  `createtime` bigint(16) DEFAULT NULL COMMENT '添加时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `status` enum('normal','hidden') DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='会员组表' AUTO_INCREMENT=7 ;

-- ----------------------------
-- Records of fa_user_group
-- ----------------------------
BEGIN;
INSERT INTO `fa_user_group` VALUES(1, '默认组', '1,2,3,4,5,6,7,8,9,10,11,12', 0.00, 0, '套餐介绍', 1491635035, 1491635035, 'normal');
INSERT INTO `fa_user_group` VALUES(2, '包天', '11,10,9,12,7,6,5,8,4,2,3,1', 1.01, 1, '快乐24小时', 1711630142, 1711630225, 'normal');
INSERT INTO `fa_user_group` VALUES(3, '包周', '11,10,9,12,7,6,5,8,4,2,3,1', 5.01, 7, '七天任性看', 1711630152, 1711630236, 'normal');
INSERT INTO `fa_user_group` VALUES(4, '包月', '11,10,9,12,7,6,5,8,4,2,3,1', 9.98, 31, '足时三十天', 1711630165, 1711630248, 'normal');
INSERT INTO `fa_user_group` VALUES(5, '包年', '', 98.01, 366, '有效期366天', 1711630192, 1711630258, 'normal');
INSERT INTO `fa_user_group` VALUES(6, '永久套餐', '', 298.01, 88888888, '永久套餐', 1711630203, 1711630294, 'normal');
COMMIT;

-- ----------------------------
-- Table structure for fa_user_info
-- ----------------------------
CREATE TABLE `fa_user_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `appid` varchar(32) DEFAULT '10000' COMMENT '平台',
  `client_mark` varchar(50) DEFAULT NULL COMMENT '客户端标识',
  `vipendtime` bigint(16) DEFAULT NULL COMMENT 'VIP到期时间',
  `password` varchar(32) DEFAULT '' COMMENT '密码',
  `discount` varchar(16) NOT NULL DEFAULT '100' COMMENT '折扣',
  PRIMARY KEY (`id`),
  KEY `username` (`appid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='会员表' AUTO_INCREMENT=23 ;

-- ----------------------------
-- Records of fa_user_info
-- ----------------------------
BEGIN;
INSERT INTO `fa_user_info` VALUES(1, 1, 'admin', '1', NULL, 'b6d0f81f29e0f496ed97da499fe27c7f', '50');
COMMIT;

-- ----------------------------
-- Table structure for fa_user_money_log
-- ----------------------------
CREATE TABLE `fa_user_money_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '变更余额',
  `before` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '变更前余额',
  `after` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '变更后余额',
  `memo` varchar(255) DEFAULT '' COMMENT '备注',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会员余额变动表' AUTO_INCREMENT=1 ;

-- ----------------------------
-- Table structure for fa_user_rule
-- ----------------------------
CREATE TABLE `fa_user_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) DEFAULT NULL COMMENT '父ID',
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `title` varchar(50) DEFAULT '' COMMENT '标题',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `ismenu` tinyint(1) DEFAULT NULL COMMENT '是否菜单',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) DEFAULT '0' COMMENT '权重',
  `status` enum('normal','hidden') DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='会员规则表' AUTO_INCREMENT=13 ;

-- ----------------------------
-- Records of fa_user_rule
-- ----------------------------
BEGIN;
INSERT INTO `fa_user_rule` VALUES(1, 0, 'index', 'Frontend', '', 1, 1491635035, 1491635035, 1, 'normal');
INSERT INTO `fa_user_rule` VALUES(2, 0, 'api', 'API Interface', '', 1, 1491635035, 1491635035, 2, 'normal');
INSERT INTO `fa_user_rule` VALUES(3, 1, 'user', 'User Module', '', 1, 1491635035, 1491635035, 12, 'normal');
INSERT INTO `fa_user_rule` VALUES(4, 2, 'user', 'User Module', '', 1, 1491635035, 1491635035, 11, 'normal');
INSERT INTO `fa_user_rule` VALUES(5, 3, 'index/user/login', 'Login', '', 0, 1491635035, 1491635035, 5, 'normal');
INSERT INTO `fa_user_rule` VALUES(6, 3, 'index/user/register', 'Register', '', 0, 1491635035, 1491635035, 7, 'normal');
INSERT INTO `fa_user_rule` VALUES(7, 3, 'index/user/index', 'User Center', '', 0, 1491635035, 1491635035, 9, 'normal');
INSERT INTO `fa_user_rule` VALUES(8, 3, 'index/user/profile', 'Profile', '', 0, 1491635035, 1491635035, 4, 'normal');
INSERT INTO `fa_user_rule` VALUES(9, 4, 'api/user/login', 'Login', '', 0, 1491635035, 1491635035, 6, 'normal');
INSERT INTO `fa_user_rule` VALUES(10, 4, 'api/user/register', 'Register', '', 0, 1491635035, 1491635035, 8, 'normal');
INSERT INTO `fa_user_rule` VALUES(11, 4, 'api/user/index', 'User Center', '', 0, 1491635035, 1491635035, 10, 'normal');
INSERT INTO `fa_user_rule` VALUES(12, 4, 'api/user/profile', 'Profile', '', 0, 1491635035, 1491635035, 3, 'normal');
COMMIT;

-- ----------------------------
-- Table structure for fa_user_score_log
-- ----------------------------
CREATE TABLE `fa_user_score_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `score` int(10) NOT NULL DEFAULT '0' COMMENT '变更积分',
  `before` int(10) NOT NULL DEFAULT '0' COMMENT '变更前积分',
  `after` int(10) NOT NULL DEFAULT '0' COMMENT '变更后积分',
  `memo` varchar(255) DEFAULT '' COMMENT '备注',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会员积分变动表' AUTO_INCREMENT=1 ;

-- ----------------------------
-- Table structure for fa_user_token
-- ----------------------------
CREATE TABLE `fa_user_token` (
  `appid` int(10) NOT NULL DEFAULT '888' COMMENT '所属平台',
  `token` varchar(50) NOT NULL COMMENT 'Token',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `expiretime` bigint(16) DEFAULT NULL COMMENT '过期时间',
  PRIMARY KEY (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会员Token表';

-- ----------------------------
-- Table structure for fa_version
-- ----------------------------
CREATE TABLE `fa_version` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `box_app_ids` int(10) NOT NULL DEFAULT '10000' COMMENT '绑定应用',
  `oldversion` varchar(30) DEFAULT '' COMMENT '旧版本号',
  `newversion` varchar(30) DEFAULT '' COMMENT '新版本号',
  `packagesize` varchar(30) DEFAULT '' COMMENT '包大小',
  `content` varchar(500) DEFAULT '' COMMENT '升级内容',
  `downloadurl` varchar(255) DEFAULT '' COMMENT '下载地址',
  `enforce` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '强制更新',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` varchar(30) DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='版本表' AUTO_INCREMENT=2 ;

-- ----------------------------
-- Records of fa_version
-- ----------------------------
BEGIN;
INSERT INTO `fa_version` VALUES(1, 10000, '', '1.0.1', '2.13', '11', 'lvdou.com3', 1, 1711676023, 1711888576, 0, 'normal');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;

