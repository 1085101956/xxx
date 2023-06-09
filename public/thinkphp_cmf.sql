/*
 Navicat Premium Data Transfer

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : thinkphp_cmf

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 09/06/2023 02:03:51
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for b5net_admin
-- ----------------------------
DROP TABLE IF EXISTS `b5net_admin`;
CREATE TABLE `b5net_admin`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '登录名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '登录密码',
  `realname` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '人员姓名',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '1' COMMENT '状态',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10009 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '管理员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b5net_admin
-- ----------------------------
INSERT INTO `b5net_admin` VALUES (10000, 'admin', 'e10adc3949ba59abbe56e057f20f883e', '超管', '1', '超级管理员', '2020-12-24 10:50:56', '2021-05-21 15:48:25');
INSERT INTO `b5net_admin` VALUES (10007, 'test', 'e10adc3949ba59abbe56e057f20f883e', 'test', '1', '', '2022-03-19 23:55:46', '2022-04-08 12:53:21');
INSERT INTO `b5net_admin` VALUES (10008, 'test1', 'e10adc3949ba59abbe56e057f20f883e', 'test1', '1', '', '2022-03-21 15:27:03', '2022-04-08 12:53:16');

-- ----------------------------
-- Table structure for b5net_admin_pos
-- ----------------------------
DROP TABLE IF EXISTS `b5net_admin_pos`;
CREATE TABLE `b5net_admin_pos`  (
  `admin_id` int(11) NOT NULL COMMENT '用户ID',
  `pos_id` int(11) NOT NULL COMMENT '职位ID',
  UNIQUE INDEX `admin_id`(`admin_id`, `pos_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和职位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b5net_admin_pos
-- ----------------------------
INSERT INTO `b5net_admin_pos` VALUES (10007, 2);
INSERT INTO `b5net_admin_pos` VALUES (10008, 3);

-- ----------------------------
-- Table structure for b5net_admin_role
-- ----------------------------
DROP TABLE IF EXISTS `b5net_admin_role`;
CREATE TABLE `b5net_admin_role`  (
  `admin_id` int(11) NOT NULL COMMENT '用户ID',
  `role_id` int(11) NOT NULL COMMENT '角色ID',
  UNIQUE INDEX `admin_id`(`admin_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b5net_admin_role
-- ----------------------------
INSERT INTO `b5net_admin_role` VALUES (10000, 1);
INSERT INTO `b5net_admin_role` VALUES (10007, 3);
INSERT INTO `b5net_admin_role` VALUES (10008, 3);

-- ----------------------------
-- Table structure for b5net_admin_struct
-- ----------------------------
DROP TABLE IF EXISTS `b5net_admin_struct`;
CREATE TABLE `b5net_admin_struct`  (
  `admin_id` int(11) NOT NULL COMMENT '用户ID',
  `struct_id` int(11) NOT NULL COMMENT '组织ID'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户与组织架构关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b5net_admin_struct
-- ----------------------------
INSERT INTO `b5net_admin_struct` VALUES (10000, 100);
INSERT INTO `b5net_admin_struct` VALUES (10008, 101);
INSERT INTO `b5net_admin_struct` VALUES (10007, 104);

-- ----------------------------
-- Table structure for b5net_books
-- ----------------------------
DROP TABLE IF EXISTS `b5net_books`;
CREATE TABLE `b5net_books`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '数据管理ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '书籍名称',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `status` tinyint(255) UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态:0=正常，1=下架，2=已删除',
  `price` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '售价',
  `borrowing` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '借阅次数',
  `cate_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '书籍类型',
  `number` smallint(6) UNSIGNED NOT NULL DEFAULT 0 COMMENT '书籍库存',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `delete_time` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  `introduce` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '书籍介绍',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '书籍封面图',
  `press` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '出版社',
  `pages` int(255) UNSIGNED NOT NULL DEFAULT 0 COMMENT '书籍页数',
  `publish_date` date NULL DEFAULT NULL COMMENT '出版年',
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '作者',
  `admin_id` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '创建管理ID',
  `struct_id` int(11) NULL DEFAULT 0 COMMENT '部门ID',
  `code` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '书籍编号',
  `sales_number` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '售卖本书',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '书籍信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b5net_books
-- ----------------------------
INSERT INTO `b5net_books` VALUES (1, '高性能MySQL', '2023-06-07 14:23:32', 0, 128.00, 0, 1, 10, '2023-06-07 14:23:32', NULL, '', '/uploads/demo/2023/06/07/ab785bde8e1554c99bdbdfa1b529e57c.png', '电子工业出版社', 764, '2022-05-30', 'Peter Zaitsev', 0, 0, '22', 0);
INSERT INTO `b5net_books` VALUES (2, 'MySQL排错指南', '2023-06-07 15:18:50', 0, 49.00, 1, 2, 6, '2023-06-07 15:18:50', NULL, '', '/uploads/demo/2023/06/07/ab785bde8e1554c99bdbdfa1b529e57c.png', '人民邮电出版社', 100, '2023-06-08', 'Sevta Smirnova', 0, 0, '333', 0);
INSERT INTO `b5net_books` VALUES (3, 'PHP与MySQL程序设计', '2023-06-07 16:55:47', 0, 299.00, 0, 1, 10, '2023-06-07 16:55:47', NULL, 'php与MYSQL5书是久负盛名的经典著作，以涵盖全面详实而著称，对主题的选取和组织从实用出发，在讲述知识之外还加入了作者自己的应用经验，并提供了密集的实战代码示例，充分体现了作者深厚的开发功力。书中对PHP的介绍是迄今为止最为全面的。', '/uploads/demo/2023/06/07/5ee4aa4e685f9fd2c87ad8532d396d6a.png', '人民邮电出版社', 100, '2023-06-07', '朱涛江', 10000, 100, '444', 0);

-- ----------------------------
-- Table structure for b5net_books_borrowing
-- ----------------------------
DROP TABLE IF EXISTS `b5net_books_borrowing`;
CREATE TABLE `b5net_books_borrowing`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `caption` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '说明',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户名称',
  `phone` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户电话',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间 借阅购买时间',
  `code` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '书籍编号',
  `type` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '类型 1借阅 2购买',
  `end_time` datetime(0) NULL DEFAULT NULL COMMENT '归还时间',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 2 COMMENT '状态 1已卖出 2借阅中 3已归还 4已逾期',
  `books_id` int(11) NOT NULL COMMENT '书籍ID',
  `return_time` datetime(0) NULL DEFAULT NULL COMMENT '归还时间',
  `should_time` datetime(0) NULL DEFAULT NULL COMMENT '应归还时间',
  `admin_id` int(10) NOT NULL COMMENT '管理员ID',
  `struct_id` int(10) NOT NULL COMMENT '部门ID',
  `user_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '用户ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `code`(`code`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '借阅/购买记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b5net_books_borrowing
-- ----------------------------
INSERT INTO `b5net_books_borrowing` VALUES (1, '2014级学生借阅一个月', '林志伟', '18225120508', '2023-06-08 23:39:22', 'ZS202306085989', 1, NULL, 2, 2, NULL, '2023-06-30 00:00:00', 10000, 100, 1);

-- ----------------------------
-- Table structure for b5net_cate
-- ----------------------------
DROP TABLE IF EXISTS `b5net_cate`;
CREATE TABLE `b5net_cate`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分类名称',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `status` tinyint(1) NOT NULL COMMENT '状态 0正常 1删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b5net_cate
-- ----------------------------
INSERT INTO `b5net_cate` VALUES (1, 'IT技术', '2023-06-07 14:40:51', 0);
INSERT INTO `b5net_cate` VALUES (2, '文学作品', '2023-06-08 09:38:49', 0);

-- ----------------------------
-- Table structure for b5net_config
-- ----------------------------
DROP TABLE IF EXISTS `b5net_config`;
CREATE TABLE `b5net_config`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '配置名称',
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '配置标识',
  `style` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '配置类型',
  `is_sys` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '是否系统内置 0否 1是',
  `groups` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '配置分组',
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '配置值',
  `extra` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '配置项',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '配置说明',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `type`(`type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b5net_config
-- ----------------------------
INSERT INTO `b5net_config` VALUES (1, '配置分组', 'sys_config_group', 'array', '1', '', 'site:基本设置\r\nwx:微信设置\r\nsms:短信配置\r\nemail:邮箱配置\r\nimgwater:图片水印', '', '', '2020-12-31 14:01:18', '2022-03-22 20:45:21');
INSERT INTO `b5net_config` VALUES (2, '系统名称', 'sys_config_sysname', 'text', '1', 'site', '图书管理系统', '', '系统后台显示的名称', '2020-12-31 14:01:18', '2023-05-30 16:53:28');
INSERT INTO `b5net_config` VALUES (4, '阿里accessKeyId', 'sms_ali_key', 'text', '0', 'sms', '', '', '阿里短信-AccessKey ID', '2021-01-11 19:26:13', '2021-01-17 21:27:04');
INSERT INTO `b5net_config` VALUES (5, '阿里accessSecret', 'sms_ali_secret', 'text', '0', 'sms', '', '', '阿里短信-AccessKey Secret', '2021-01-11 19:26:45', '2021-01-17 21:27:04');
INSERT INTO `b5net_config` VALUES (6, '阿里signName', 'sms_ali_signname', 'text', '0', 'sms', '', '', '阿里短信-签名', '2021-01-11 19:27:53', '2021-01-17 21:27:04');
INSERT INTO `b5net_config` VALUES (7, '阿里tempId', 'sms_ali_temp', 'text', '0', 'sms', '', '', '阿里短信-tempId模板', '2021-01-11 19:30:21', '2021-01-17 21:27:04');
INSERT INTO `b5net_config` VALUES (10, '公众号appid', 'wechat_appid', 'text', '0', 'wx', 'wx2dbcd1ebf29bd18f', '', '微信公众号的AppId', '2021-01-12 11:05:50', '2021-03-27 23:06:59');
INSERT INTO `b5net_config` VALUES (11, '公众号secret', 'wechat_appsecret', 'text', '0', 'wx', '8f2ea486cf4182ba9211d26cdb7c343a', '', '微信公众号-AppSecret', '2021-01-12 11:06:24', '2021-03-27 23:06:59');
INSERT INTO `b5net_config` VALUES (12, '服务地址', 'sys_email_host', 'text', '0', 'email', 'smtp.163.com', '', '类似:smtp.163.com', '2021-01-22 15:28:10', '2021-01-23 13:03:59');
INSERT INTO `b5net_config` VALUES (13, '邮箱地址', 'sys_email_username', 'text', '0', 'email', 'lyyd_lh@163.com', '', '发送邮件的邮箱地址', '2021-01-22 15:28:39', '2021-01-23 13:03:59');
INSERT INTO `b5net_config` VALUES (14, '授权密码', 'sys_email_password', 'text', '0', 'email', 'UCSMPMHNDJSALQVW', '', '', '2021-01-22 15:29:34', '2021-01-23 13:03:59');
INSERT INTO `b5net_config` VALUES (15, '服务端口', 'sys_email_port', 'text', '0', 'email', '465', '', '', '2021-01-22 15:30:05', '2021-01-23 13:03:59');
INSERT INTO `b5net_config` VALUES (16, '是否SSL', 'sys_email_ssl', 'select', '0', 'email', '1', '0:否\r\n1:是', '', '2021-01-22 15:31:23', '2021-01-23 13:03:59');
INSERT INTO `b5net_config` VALUES (17, '网站标题', 'web_site_name', 'text', '0', 'site', '图书管理系统', '', '', '2021-03-24 15:09:24', '2023-05-30 16:53:28');
INSERT INTO `b5net_config` VALUES (18, '水印文字', 'img_water_text', 'text', '0', 'imgwater', '图书管理系统', '', '', '2021-07-29 20:44:32', '2023-05-31 10:03:35');
INSERT INTO `b5net_config` VALUES (19, '水印文字大小', 'img_water_text_font', 'text', '0', 'imgwater', '20', '', '', '2021-07-29 20:44:48', '2023-05-31 10:03:35');
INSERT INTO `b5net_config` VALUES (20, '水印文字颜色', 'img_water_text_color', 'text', '0', 'imgwater', 'ff0000', '', '', '2021-07-29 20:45:03', '2023-05-31 10:03:35');
INSERT INTO `b5net_config` VALUES (21, '水印位置', 'img_water_text_position', 'select', '0', 'imgwater', '1', '1:左上角\r\n3:右上角\r\n5:垂直水平居中\r\n7:左下角\r\n9:右下角', '对应think-image的水印位置 1-9', '2021-07-29 20:45:28', '2023-05-31 10:03:35');
INSERT INTO `b5net_config` VALUES (22, '是否演示模式', 'demo_mode', 'select', '0', '', '1', '1:是\r\n0:否', '', '2022-03-21 16:17:48', '2022-03-21 16:17:48');

-- ----------------------------
-- Table structure for b5net_loginlog
-- ----------------------------
DROP TABLE IF EXISTS `b5net_loginlog`;
CREATE TABLE `b5net_loginlog`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `login_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录账号',
  `ipaddr` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `net` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '访问时间',
  `update_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b5net_loginlog
-- ----------------------------
INSERT INTO `b5net_loginlog` VALUES (40, 'admin', '127.0.0.1', '本机地址', 'Chrome 113.0.0.0', 'Windows 10.0', '', '1', '登录成功', '2023-06-07 16:18:34', '2023-06-07 16:18:34');
INSERT INTO `b5net_loginlog` VALUES (41, 'admin', '127.0.0.1', '本机地址', 'Chrome 113.0.0.0', 'Windows 10.0', '', '1', '登录成功', '2023-06-08 22:37:42', '2023-06-08 22:37:42');

-- ----------------------------
-- Table structure for b5net_menu
-- ----------------------------
DROP TABLE IF EXISTS `b5net_menu`;
CREATE TABLE `b5net_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '菜单名称',
  `parent_id` int(11) NOT NULL DEFAULT 0 COMMENT '父菜单ID',
  `listsort` int(11) NOT NULL DEFAULT 0 COMMENT '显示顺序',
  `url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '请求地址',
  `target` tinyint(1) NOT NULL DEFAULT 0 COMMENT '打开方式（0页签 1新窗口）',
  `type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '1' COMMENT '菜单状态（1显示 0隐藏）',
  `is_refresh` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '是否刷新（0不刷新 1刷新）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单图标',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `note` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `parent_id`(`parent_id`) USING BTREE,
  INDEX `listsort`(`listsort`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10810 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b5net_menu
-- ----------------------------
INSERT INTO `b5net_menu` VALUES (1, '系统管理', 0, 10, '', 0, 'M', '1', '0', '', 'fa fa-cog', '2021-01-03 07:25:11', '2022-03-20 16:00:14', '系统管理');
INSERT INTO `b5net_menu` VALUES (2, '权限管理', 0, 20, '', 0, 'M', '1', '0', '', 'fa fa-id-card-o', '2021-01-03 07:25:11', '2023-05-31 17:07:13', '权限管理');
INSERT INTO `b5net_menu` VALUES (3, '系统工具', 0, 30, '', 0, 'M', '1', '0', '', 'fa fa-cloud', '2021-07-29 20:28:41', '2022-03-20 15:59:55', '');
INSERT INTO `b5net_menu` VALUES (90, '官方网站', 0, 99, 'http://www.b5net.com', 1, 'C', '0', '0', 'administrator', 'fa fa-send', '2021-01-05 12:05:30', '2023-05-31 10:09:14', '官方网站');
INSERT INTO `b5net_menu` VALUES (100, '人员管理', 2, 1, 'admin/index', 0, 'C', '1', '0', 'admin:admin:index', 'fa fa-user-o', '2021-01-03 07:25:11', '2022-03-20 16:02:24', '人员管理');
INSERT INTO `b5net_menu` VALUES (101, '角色管理', 2, 2, 'role/index', 0, 'C', '1', '0', 'admin:role:index', 'fa fa-address-book-o', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '角色管理');
INSERT INTO `b5net_menu` VALUES (102, '组织架构', 2, 3, 'struct/index', 0, 'C', '1', '0', 'admin:struct:index', 'fa fa-sitemap', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '组织架构');
INSERT INTO `b5net_menu` VALUES (103, '菜单管理', 2, 4, 'menu/index', 0, 'C', '1', '0', 'admin:menu:index', 'fa fa-server', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '菜单管理');
INSERT INTO `b5net_menu` VALUES (104, '登录日志', 2, 5, 'loginlog/index', 0, 'C', '1', '0', 'admin:loginlog:index', 'fa fa-paw', '2021-01-03 07:25:11', '2021-01-07 12:54:43', '登录日志');
INSERT INTO `b5net_menu` VALUES (105, '参数配置', 1, 1, 'config/index', 0, 'C', '1', '0', 'admin:config:index', 'fa fa-sliders', '2021-01-03 07:25:11', '2021-01-05 12:20:56', '参数配置');
INSERT INTO `b5net_menu` VALUES (106, '网站设置', 1, 0, 'config/site', 0, 'C', '1', '0', 'admin:config:site', 'fa fa-object-group', '2021-01-11 22:17:31', '2021-01-11 22:39:46', '网站设置');
INSERT INTO `b5net_menu` VALUES (107, '通知公告', 1, 10, 'notice/index', 0, 'C', '1', '0', 'admin:notice:index', 'fa fa-bullhorn', '2021-01-03 07:25:11', '2021-03-17 14:05:34', '通知公告');
INSERT INTO `b5net_menu` VALUES (108, '岗位管理', 2, 2, 'position/index', 0, 'C', '1', '0', 'admin:position:index', '', NULL, '2023-06-08 17:14:15', '');
INSERT INTO `b5net_menu` VALUES (150, '代码生成', 3, 3, 'tool/create', 0, 'C', '1', '0', 'admin:tool:create', '', NULL, NULL, '');
INSERT INTO `b5net_menu` VALUES (151, '表单构建', 3, 2, 'tool/build', 0, 'C', '1', '0', 'admin:tool:build', '', NULL, NULL, '');
INSERT INTO `b5net_menu` VALUES (152, '图片操作', 3, 1, 'demo.media/index', 0, 'C', '1', '0', 'admin:demo.media:index', '', '2021-07-29 20:29:15', '2021-07-29 20:29:15', '');
INSERT INTO `b5net_menu` VALUES (10000, '用户新增', 100, 1, '', 0, 'F', '1', '0', 'admin:admin:add', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '用户新增');
INSERT INTO `b5net_menu` VALUES (10001, '用户修改', 100, 2, '', 0, 'F', '1', '0', 'admin:admin:edit', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '用户修改');
INSERT INTO `b5net_menu` VALUES (10002, '用户删除', 100, 3, '', 0, 'F', '1', '0', 'admin:admin:drop', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '用户删除');
INSERT INTO `b5net_menu` VALUES (10004, '用户状态', 100, 4, '', 0, 'F', '1', '0', 'admin:admin:setstatus', '', '2021-01-03 07:25:11', '2021-01-08 10:47:09', '用户状态');
INSERT INTO `b5net_menu` VALUES (10100, '角色新增', 101, 1, '', 0, 'F', '1', '0', 'admin:role:add', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '角色新增');
INSERT INTO `b5net_menu` VALUES (10101, '角色修改', 101, 2, '', 0, 'F', '1', '0', 'admin:role:edit', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '角色修改');
INSERT INTO `b5net_menu` VALUES (10102, '角色删除', 101, 3, '', 0, 'F', '1', '0', 'admin:role:drop', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '角色删除');
INSERT INTO `b5net_menu` VALUES (10104, '角色状态', 101, 4, '', 0, 'F', '1', '0', 'admin:role:setstatus', '', '2021-01-03 07:25:11', '2021-01-08 10:47:31', '角色状态');
INSERT INTO `b5net_menu` VALUES (10105, '菜单授权', 101, 10, '', 0, 'F', '1', '0', 'admin:role:auth', '', '2021-01-03 07:25:11', '2021-01-07 13:32:41', '菜单授权');
INSERT INTO `b5net_menu` VALUES (10106, '数据权限', 101, 11, '', 0, 'F', '1', '0', 'admin:role:datascope', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '数据权限');
INSERT INTO `b5net_menu` VALUES (10200, '组织新增', 102, 1, '', 0, 'F', '1', '0', 'admin:struct:add', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '组织新增');
INSERT INTO `b5net_menu` VALUES (10201, '组织修改', 102, 2, '', 0, 'F', '1', '0', 'admin:struct:edit', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '组织修改');
INSERT INTO `b5net_menu` VALUES (10202, '组织删除', 102, 3, '', 0, 'F', '1', '0', 'admin:struct:drop', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '组织删除');
INSERT INTO `b5net_menu` VALUES (10300, '菜单新增', 103, 1, '', 0, 'F', '1', '0', 'admin:menu:add', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '菜单新增');
INSERT INTO `b5net_menu` VALUES (10301, '菜单修改', 103, 2, '', 0, 'F', '1', '0', 'admin:menu:edit', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '菜单修改');
INSERT INTO `b5net_menu` VALUES (10302, '菜单删除', 103, 3, '', 0, 'F', '1', '0', 'admin:menu:drop', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '菜单删除');
INSERT INTO `b5net_menu` VALUES (10400, '日志删除', 104, 0, '', 0, 'F', '1', '0', 'admin:loginlog:drop', '', '2021-01-07 13:03:15', '2021-01-07 13:03:15', '日志删除');
INSERT INTO `b5net_menu` VALUES (10401, '日志清空', 104, 0, '', 0, 'F', '1', '0', 'admin:loginlog:trash', '', '2021-01-07 13:04:06', '2021-01-07 13:04:06', '日志清空');
INSERT INTO `b5net_menu` VALUES (10500, '参数新增', 105, 1, '', 0, 'F', '1', '0', 'admin:config:add', '', '2021-01-03 07:25:11', '2021-01-05 06:00:02', '参数新增');
INSERT INTO `b5net_menu` VALUES (10501, '参数修改', 105, 2, '', 0, 'F', '1', '0', 'admin:config:edit', '', '2021-01-03 07:25:11', '2021-01-05 06:00:25', '参数修改');
INSERT INTO `b5net_menu` VALUES (10502, '参数删除', 105, 3, '', 0, 'F', '1', '0', 'admin:config:drop', '', '2021-01-03 07:25:11', '2021-01-05 06:00:59', '参数删除');
INSERT INTO `b5net_menu` VALUES (10503, '参数批量删除', 105, 4, '', 0, 'F', '1', '0', 'admin:config:dropall', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '参数批量删除');
INSERT INTO `b5net_menu` VALUES (10504, '清除缓存', 105, 5, '', 0, 'F', '1', '0', 'admin:config:delcache', '', '2021-01-03 07:25:11', '2021-01-08 10:46:47', '清除缓存');
INSERT INTO `b5net_menu` VALUES (10700, '公告新增', 107, 1, '', 0, 'F', '1', '0', 'admin:notice:add', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '公告新增');
INSERT INTO `b5net_menu` VALUES (10701, '公告修改', 107, 2, '', 0, 'F', '1', '0', 'admin:notice:edit', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '公告修改');
INSERT INTO `b5net_menu` VALUES (10702, '公告删除', 107, 3, '', 0, 'F', '1', '0', 'admin:notice:drop', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '公告删除');
INSERT INTO `b5net_menu` VALUES (10703, '公告批量删除', 107, 4, '', 0, 'F', '1', '0', 'admin:notice:dropall', '', '2021-01-03 07:25:11', '2021-01-03 07:25:11', '公告批量删除');
INSERT INTO `b5net_menu` VALUES (10801, '添加岗位', 108, 1, '', 0, 'F', '1', '0', 'admin:position:add', '', NULL, NULL, '');
INSERT INTO `b5net_menu` VALUES (10802, '编辑岗位', 108, 2, '', 0, 'F', '1', '0', 'admin:position:edit', '', NULL, NULL, '');
INSERT INTO `b5net_menu` VALUES (10803, '删除岗位', 108, 3, '', 0, 'F', '1', '0', 'admin:position:dropall', '', NULL, NULL, '');
INSERT INTO `b5net_menu` VALUES (10804, '图书管理', 0, 40, '', 0, 'M', '1', '0', '', 'fa fa-bars', '2023-05-31 17:07:58', '2023-05-31 17:09:32', '');
INSERT INTO `b5net_menu` VALUES (10805, '图书信息', 10804, 0, 'books/index', 0, 'C', '1', '0', 'admin:books:index', 'fa fa-navicon', '2023-05-31 17:12:22', '2023-05-31 17:12:34', '');
INSERT INTO `b5net_menu` VALUES (10806, '书籍分类管理', 10804, 0, 'cate/index', 0, 'C', '1', '1', 'admin:cate:index', 'fa fa-bars', '2023-06-08 09:32:21', '2023-06-08 09:38:15', '');
INSERT INTO `b5net_menu` VALUES (10807, '会员管理', 0, 100, '', 0, 'M', '1', '0', '', 'fa fa-server', '2023-06-08 15:42:04', '2023-06-08 15:42:57', '');
INSERT INTO `b5net_menu` VALUES (10808, '会员信息', 10807, 0, 'user/index', 0, 'C', '1', '0', 'admin:user:index', 'fa fa-commenting', '2023-06-08 15:44:02', '2023-06-08 15:48:15', '');
INSERT INTO `b5net_menu` VALUES (10809, '图书借阅/购买记录', 10804, 0, 'booksborrowing/index', 0, 'C', '1', '0', 'admin:booksborrowing:index', 'fa fa-navicon', '2023-06-08 16:30:34', '2023-06-08 16:30:51', '');

-- ----------------------------
-- Table structure for b5net_notice
-- ----------------------------
DROP TABLE IF EXISTS `b5net_notice`;
CREATE TABLE `b5net_notice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `title` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '公告标题',
  `type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '公告类型（1通知 2公告）',
  `desc` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '1' COMMENT '公告状态（1正常 0关闭）',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b5net_notice
-- ----------------------------
INSERT INTO `b5net_notice` VALUES (1, '【公告】： 图书管理系统 新版本发布啦', '2', NULL, '<p><b>新版本内容</b></p><p><b><br></b></p><p><b>新版本内容</b></p><p><b>新版本内容</b></p><p><b>新版本内容</b></p><p><br></p>', '1', '2022-03-12 11:33:42', '2023-05-31 10:01:53');
INSERT INTO `b5net_notice` VALUES (2, '【通知】：图书管理系统凌晨维护', '1', NULL, '<p style=\"text-align: center; \"><font color=\"#0000ff\">维护内容</font></p><p style=\"text-align: center;\"><font color=\"#0000ff\"><br></font></p>', '1', '2022-03-20 11:33:42', '2023-05-31 10:02:56');

-- ----------------------------
-- Table structure for b5net_position
-- ----------------------------
DROP TABLE IF EXISTS `b5net_position`;
CREATE TABLE `b5net_position`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '岗位名称',
  `poskey` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '岗位标识',
  `listsort` int(11) NULL DEFAULT 100 COMMENT '排序',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b5net_position
-- ----------------------------
INSERT INTO `b5net_position` VALUES (1, '总经理', 'ceo', 1, 1, '', '2022-04-04 23:04:49', '2022-04-08 12:44:52');
INSERT INTO `b5net_position` VALUES (2, '部门经理', 'cpo', 2, 1, '', '2022-04-04 23:25:34', '2022-04-06 12:48:58');
INSERT INTO `b5net_position` VALUES (3, '组长', 'cgo', 3, 1, '', '2022-04-04 23:26:08', '2022-04-08 12:53:33');
INSERT INTO `b5net_position` VALUES (4, '员工', 'user', 4, 1, '', '2022-04-04 23:26:50', '2022-04-04 23:26:50');

-- ----------------------------
-- Table structure for b5net_role
-- ----------------------------
DROP TABLE IF EXISTS `b5net_role`;
CREATE TABLE `b5net_role`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '角色名称',
  `rolekey` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '角色权限字符串',
  `data_scope` mediumint(5) NOT NULL DEFAULT 1 COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `listsort` int(11) NOT NULL DEFAULT 0 COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '1' COMMENT '角色状态（1正常 0停用）',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `note` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `rolekey`(`rolekey`) USING BTREE,
  INDEX `listsort`(`listsort`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b5net_role
-- ----------------------------
INSERT INTO `b5net_role` VALUES (1, '超级管理员', 'administrator', 1, 0, '1', '2020-12-28 07:42:31', '2022-03-19 23:31:09', '超级管理员');
INSERT INTO `b5net_role` VALUES (3, '测试角色', 'test', 8, 0, '1', '2022-03-19 23:43:03', '2022-03-25 17:55:02', '');

-- ----------------------------
-- Table structure for b5net_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `b5net_role_menu`;
CREATE TABLE `b5net_role_menu`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b5net_role_menu
-- ----------------------------
INSERT INTO `b5net_role_menu` VALUES (3, 1);
INSERT INTO `b5net_role_menu` VALUES (3, 105);
INSERT INTO `b5net_role_menu` VALUES (3, 107);
INSERT INTO `b5net_role_menu` VALUES (3, 2);
INSERT INTO `b5net_role_menu` VALUES (3, 100);
INSERT INTO `b5net_role_menu` VALUES (3, 102);
INSERT INTO `b5net_role_menu` VALUES (3, 104);
INSERT INTO `b5net_role_menu` VALUES (3, 10804);
INSERT INTO `b5net_role_menu` VALUES (3, 10805);

-- ----------------------------
-- Table structure for b5net_role_struct
-- ----------------------------
DROP TABLE IF EXISTS `b5net_role_struct`;
CREATE TABLE `b5net_role_struct`  (
  `role_id` int(10) NOT NULL COMMENT '角色ID',
  `struct_id` int(10) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `struct_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b5net_role_struct
-- ----------------------------
INSERT INTO `b5net_role_struct` VALUES (3, 101);
INSERT INTO `b5net_role_struct` VALUES (3, 103);

-- ----------------------------
-- Table structure for b5net_smscode
-- ----------------------------
DROP TABLE IF EXISTS `b5net_smscode`;
CREATE TABLE `b5net_smscode`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '手机号码',
  `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '验证码',
  `type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '例如：1注册 2登录 3忘记密码',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '状态 0未验证 1已验证',
  `os` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '运营商',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '验证码表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b5net_smscode
-- ----------------------------

-- ----------------------------
-- Table structure for b5net_struct
-- ----------------------------
DROP TABLE IF EXISTS `b5net_struct`;
CREATE TABLE `b5net_struct`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `parent_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `parent_id` int(11) NULL DEFAULT 0 COMMENT '父部门id',
  `levels` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `listsort` int(11) NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '部门状态（1正常 0停用）',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 113 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '组织架构' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b5net_struct
-- ----------------------------
INSERT INTO `b5net_struct` VALUES (100, '重庆科技学院', '', 0, '0', 0, '冰舞', '15888888888', '', '1', '2020-12-24 11:33:42', '2023-06-08 17:11:20');
INSERT INTO `b5net_struct` VALUES (101, '图书登记部门', '重庆科技学院', 100, '0,100', 1, '冰舞', '18888888888', '', '1', '2020-12-24 11:33:42', '2023-06-08 17:13:06');
INSERT INTO `b5net_struct` VALUES (103, '一组', '重庆科技学院,图书登记部门', 101, '0,100,101', 1, '冰舞', '15888888888', '', '1', '2020-12-24 11:33:42', '2023-06-08 17:13:16');
INSERT INTO `b5net_struct` VALUES (104, '二组', '重庆科技学院,图书登记部门', 101, '0,100,101', 2, '冰舞', '15888888888', '', '1', '2020-12-24 11:33:42', '2023-06-08 17:13:23');
INSERT INTO `b5net_struct` VALUES (105, '测试部门', '重庆科技学院,图书登记部门', 101, '0,100,101', 3, '冰舞', '15888888888', '', '1', '2020-12-24 11:33:42', '2023-06-08 17:13:07');
INSERT INTO `b5net_struct` VALUES (110, '图书馆行政部', '重庆科技学院', 100, '0,100', 2, '冰舞', '1888888', '', '1', '2021-01-08 11:11:33', '2023-06-08 17:12:51');
INSERT INTO `b5net_struct` VALUES (112, '书籍整理部', '重庆科技学院,图书登记部门,测试部门', 105, '0,100,101,105', 1, '', '', '', '1', '2021-03-29 18:02:29', '2023-06-08 17:15:29');

-- ----------------------------
-- Table structure for b5net_user
-- ----------------------------
DROP TABLE IF EXISTS `b5net_user`;
CREATE TABLE `b5net_user`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '会员名称',
  `phone` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '会员电话',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `library_card` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '借阅证书编号',
  `margin` decimal(10, 2) NULL DEFAULT NULL COMMENT '保证金',
  `borrowing` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '借阅次数',
  `purchase` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '购买次数',
  `price` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '消费金额',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态 0正常 1拉黑 2借阅违约',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b5net_user
-- ----------------------------
INSERT INTO `b5net_user` VALUES (1, '林志伟', '18225120508', '2023-06-08 16:15:23', 'ZS202306085989', 100.00, 0, 0, 0.00, 0);

-- ----------------------------
-- Table structure for b5net_wechat_access
-- ----------------------------
DROP TABLE IF EXISTS `b5net_wechat_access`;
CREATE TABLE `b5net_wechat_access`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `appid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `access_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `jsapi_ticket` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `access_token_add` int(11) NOT NULL DEFAULT 0,
  `jsapi_ticket_add` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `appid`(`appid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '微信jsapi和access' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b5net_wechat_access
-- ----------------------------

-- ----------------------------
-- Table structure for b5net_wechat_users
-- ----------------------------
DROP TABLE IF EXISTS `b5net_wechat_users`;
CREATE TABLE `b5net_wechat_users`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `openid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '唯一标识',
  `appid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '公众号参数',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '昵称',
  `headimg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '头像地址',
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '所属活动',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '资料更新时间',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '添加时间',
  `sex` tinyint(1) NOT NULL DEFAULT 0 COMMENT '性别',
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '城市',
  `country` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '国家',
  `province` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '省份',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `openid`(`openid`, `appid`, `type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '微信用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b5net_wechat_users
-- ----------------------------
INSERT INTO `b5net_wechat_users` VALUES (2, 'oHwQ-5zzJiXhutCVWmSPfQyAx7Yk', 'wx2dbcd1ebf29bd18f', '简单', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLGqoCcD0iamzHcJDmfU4sKbpqBYxD9icXcTtxlKkia3mB2OZIrIucsnq21FwSvFvBSxsiaTtAm5ZHmeQ/132', 'scratch_1', '2021-04-08 16:47:17', '2021-04-08 16:47:17', 1, '', '中国', '', 1);
INSERT INTO `b5net_wechat_users` VALUES (3, 'oHwQ-5_qj1L9HHnUpclLOJPh_Z7M', 'wx2dbcd1ebf29bd18f', '九方资源ヽ赖小伙 ', 'https://thirdwx.qlogo.cn/mmopen/vi_32/fKibib5mxicWGxOgAQY0PUucIft3D243GXLMkm4vMY7cJmqzR2Zmhr9nrsTR1PFfDXlCsZ3sJcy4UGwptNu7CmSwQ/132', 'scratch_1', '2021-04-14 14:07:13', '2021-04-14 14:07:13', 1, '赣州', '中国', '江西', 1);
INSERT INTO `b5net_wechat_users` VALUES (4, 'oHwQ-54NH0I3WbRt77eF5-EKo-C8', 'wx2dbcd1ebf29bd18f', 'Hello World', 'https://thirdwx.qlogo.cn/mmopen/vi_32/M3PEicW5ziceOUdVDX7vQicZgvxDMPYCaiavl4l2m8IFPyzSHMTbiaeL3mtaXMiafD8CJQicFrNoHiau1ypkJo0m2HYibcw/132', 'scratch_1', '2021-04-19 21:24:36', '2021-04-19 21:24:36', 1, '', '黑山', '', 1);

-- ----------------------------
-- Table structure for demo_media
-- ----------------------------
DROP TABLE IF EXISTS `demo_media`;
CREATE TABLE `demo_media`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `img` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '单图',
  `imgs` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '多图',
  `crop` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '裁剪图片',
  `video` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '视频',
  `file` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '单文件',
  `files` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '多文件',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of demo_media
-- ----------------------------
INSERT INTO `demo_media` VALUES (1, '/uploads/demo/2022/03/22/167cdb475bc8f70805b1d6af37bdb451.jpeg', '/uploads/demo/2022/03/22/e2cb477c6f7b4ed61522f401263e855b.jpeg,/uploads/demo/2022/03/22/6e8c0545c09d524274282264234621db.jpeg,/uploads/demo/2022/03/22/e95bd881e231782acfbacf1ef833a589.jpeg,/uploads/demo/2022/03/22/9092d78f09fcd47728171b3061acbd1e.jpg,/uploads/demo/2022/03/22/7347334e10d823500b85b4e5148d7f78.jpeg', '/uploads/demo/2022/03/22/a8927794241a9afe97a0609c56ea7bb7.jpg,/uploads/demo/2022/03/22/73bbf84a13f7797609568bc3f9c0c2f1.jpg', '/uploads/demo/2022/03/22/fd3118fc7136e94d30c49fd8bc4f18ff.mp4', '/uploads/demo/2022/03/22/320167184252acbd548880a009f6d5c9.txt', '/uploads/demo/2022/03/22/2c657603884aa84e4730986555988154.txt,/uploads/demo/2022/03/22/d2e6263a628dad4cd0841d64a9105a7f.txt,/uploads/demo/2022/03/22/f9311ffe713264fa6ded673b30d9e9ce.txt', '2022-03-22 19:43:57', '2022-03-22 20:42:17');

-- ----------------------------
-- Table structure for test_goods
-- ----------------------------
DROP TABLE IF EXISTS `test_goods`;
CREATE TABLE `test_goods`  (
  `id` int(10) NOT NULL,
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商品名称',
  `price` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '价格',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of test_goods
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
