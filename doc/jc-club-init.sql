/*
 Navicat Premium Dump SQL

 Source Server         : club正式
 Source Server Type    : MySQL
 Source Server Version : 50744 (5.7.44)
 Source Host           : 117.72.10.84:3306
 Source Schema         : jc-club

 Target Server Type    : MySQL
 Target Server Version : 50744 (5.7.44)
 File Encoding         : 65001

 Date: 04/12/2024 10:13:02
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL COMMENT '权限名称',
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父id',
  `type` tinyint(4) DEFAULT NULL COMMENT '权限类型 0菜单 1操作',
  `menu_url` varchar(255) DEFAULT NULL COMMENT '菜单路由',
  `status` tinyint(2) DEFAULT NULL COMMENT '状态 0启用 1禁用',
  `show` tinyint(2) DEFAULT NULL COMMENT '展示状态 0展示 1隐藏',
  `icon` varchar(128) DEFAULT NULL COMMENT '图标',
  `permission_key` varchar(64) DEFAULT NULL COMMENT '权限唯一标识',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` int(11) DEFAULT '0' COMMENT '是否被删除 0为删除 1已删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
BEGIN;
INSERT INTO `auth_permission` (`id`, `name`, `parent_id`, `type`, `menu_url`, `status`, `show`, `icon`, `permission_key`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (1, '新增题目', 0, 1, 'ladiwd/www', 0, 0, 'http://1.png', 'subject:add', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-02-28 03:20:38', '', '2023-11-12 16:17:12', 0);
COMMIT;

-- ----------------------------
-- Table structure for auth_role
-- ----------------------------
DROP TABLE IF EXISTS `auth_role`;
CREATE TABLE `auth_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(32) DEFAULT NULL COMMENT '角色名称',
  `role_key` varchar(64) DEFAULT NULL COMMENT '角色唯一标识',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` int(11) DEFAULT '0' COMMENT '是否被删除 0未删除 1已删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_role
-- ----------------------------
BEGIN;
INSERT INTO `auth_role` (`id`, `role_name`, `role_key`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (1, '管理员', 'admin_user', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-02-28 03:20:44', '', '2023-11-12 16:16:07', 0);
INSERT INTO `auth_role` (`id`, `role_name`, `role_key`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (2, '普通用户', 'normal_user', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-02-28 03:20:44', '', '2023-11-12 16:16:10', 0);
COMMIT;

-- ----------------------------
-- Table structure for auth_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_role_permission`;
CREATE TABLE `auth_role_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色id',
  `permission_id` bigint(20) DEFAULT NULL COMMENT '权限id',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='角色权限关联表';

-- ----------------------------
-- Records of auth_role_permission
-- ----------------------------
BEGIN;
INSERT INTO `auth_role_permission` (`id`, `role_id`, `permission_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (1, 1, 1, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_role_permission` (`id`, `role_id`, `permission_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (2, 2, 1, NULL, NULL, NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_name` varchar(32) DEFAULT NULL COMMENT '用户名称/账号',
  `nick_name` varchar(32) DEFAULT NULL COMMENT '昵称',
  `email` varchar(32) DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(32) DEFAULT NULL COMMENT '手机号',
  `password` varchar(64) DEFAULT NULL COMMENT '密码',
  `sex` tinyint(2) DEFAULT NULL COMMENT '性别',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `status` tinyint(2) DEFAULT NULL COMMENT '状态 0启用 1禁用',
  `introduce` varchar(255) DEFAULT NULL COMMENT '个人介绍',
  `ext_json` varchar(255) DEFAULT NULL COMMENT '特殊字段',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` int(11) DEFAULT '0' COMMENT '是否被删除 0未删除 1已删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='用户信息表';

-- ----------------------------
-- Records of auth_user
-- ----------------------------
BEGIN;
INSERT INTO `auth_user` (`id`, `user_name`, `nick_name`, `email`, `phone`, `password`, `sex`, `avatar`, `status`, `introduce`, `ext_json`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (4, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '鸡翅老鸽', NULL, NULL, NULL, NULL, 'http://117.72.10.84:9000/user/icon/微信图片_20231203153718(1).png', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_user` (`id`, `user_name`, `nick_name`, `email`, `phone`, `password`, `sex`, `avatar`, `status`, `introduce`, `ext_json`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (5, 'oYA4Ht0LYVOCcwevzlImKZHpFSiE', '鸡腿哥', NULL, NULL, NULL, NULL, 'http://117.72.10.84:9000/user/icon/WX20241128-143501@2x.png', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_user` (`id`, `user_name`, `nick_name`, `email`, `phone`, `password`, `sex`, `avatar`, `status`, `introduce`, `ext_json`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (6, 'oYA4Ht6xP95pb7uRxffSycpdJxnk', '鸡翅粉丝', NULL, NULL, NULL, NULL, 'http://117.72.10.84:9000/user/icon/微信图片_20231203153718(1).png', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_user` (`id`, `user_name`, `nick_name`, `email`, `phone`, `password`, `sex`, `avatar`, `status`, `introduce`, `ext_json`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (7, 'oYA4Ht1CcUiPuxGbNmlCzSsrHQBo', '鸡翅粉丝', NULL, NULL, NULL, NULL, 'http://117.72.10.84:9000/user/icon/微信图片_20231203153718(1).png', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_user` (`id`, `user_name`, `nick_name`, `email`, `phone`, `password`, `sex`, `avatar`, `status`, `introduce`, `ext_json`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (8, 'oYA4Ht46Xdf0kmHLwfYHNrXTor9w', '鸡翅粉丝', NULL, NULL, NULL, NULL, 'http://117.72.10.84:9000/user/icon/微信图片_20231203153718(1).png', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_user` (`id`, `user_name`, `nick_name`, `email`, `phone`, `password`, `sex`, `avatar`, `status`, `introduce`, `ext_json`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (9, 'oYA4Ht_HZYqMWNq9Lx6_OX3HHw3M', '鸡翅粉丝', NULL, NULL, NULL, NULL, 'http://117.72.10.84:9000/user/icon/微信图片_20231203153718(1).png', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_user` (`id`, `user_name`, `nick_name`, `email`, `phone`, `password`, `sex`, `avatar`, `status`, `introduce`, `ext_json`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (10, 'oYA4Htx-rtF01b1xwhARkKWe8oAE', '鸡翅粉丝', NULL, NULL, NULL, NULL, 'http://117.72.10.84:9000/user/icon/微信图片_20231203153718(1).png', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_user` (`id`, `user_name`, `nick_name`, `email`, `phone`, `password`, `sex`, `avatar`, `status`, `introduce`, `ext_json`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (11, 'oYA4Ht0j1NRLCDJ6KyTOgzXT2nMQ', 'gg', NULL, NULL, NULL, 1, 'http://117.72.10.84:9000/user/icon/微信图片_20231203153718(1).png', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_user` (`id`, `user_name`, `nick_name`, `email`, `phone`, `password`, `sex`, `avatar`, `status`, `introduce`, `ext_json`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (12, 'oYA4HtxySdme-hGYlWGx-g3TktZE', 'charlief', 'charliefei839@gmail.com', '13277779999', NULL, 1, 'http://117.72.10.84:9000/user/icon/6d47fe1dde2824ea9a1070e5c01032ee.jpg', 0, '123', NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_user` (`id`, `user_name`, `nick_name`, `email`, `phone`, `password`, `sex`, `avatar`, `status`, `introduce`, `ext_json`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (13, 'oYA4Ht8eRWPfRU5UJjIaL2hGpPHo', '鸡翅粉丝', NULL, NULL, NULL, NULL, 'http://117.72.10.84:9000/user/icon/微信图片_20231203153718(1).png', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_user` (`id`, `user_name`, `nick_name`, `email`, `phone`, `password`, `sex`, `avatar`, `status`, `introduce`, `ext_json`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (14, 'oYA4Ht24GEPHSUUDAI0Ps9Qk4ofg', '鸡翅粉丝', NULL, NULL, NULL, NULL, 'http://117.72.10.84:9000/user/icon/微信图片_20231203153718(1).png', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_user` (`id`, `user_name`, `nick_name`, `email`, `phone`, `password`, `sex`, `avatar`, `status`, `introduce`, `ext_json`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (15, 'oYA4Ht4P6CJ04eAWRMLOjUsxAy_c', '鸡翅粉丝', NULL, NULL, NULL, NULL, 'http://117.72.10.84:9000/user/icon/微信图片_20231203153718(1).png', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_user` (`id`, `user_name`, `nick_name`, `email`, `phone`, `password`, `sex`, `avatar`, `status`, `introduce`, `ext_json`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (16, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '鸡翅粉丝', NULL, NULL, NULL, NULL, 'http://117.72.10.84:9000/user/icon/微信图片_20231203153718(1).png', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_user` (`id`, `user_name`, `nick_name`, `email`, `phone`, `password`, `sex`, `avatar`, `status`, `introduce`, `ext_json`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (17, 'oYA4Ht9BalkOl7Pb28EZ220SUagg', '鸡翅粉丝', NULL, NULL, NULL, NULL, 'http://117.72.10.84:9000/user/icon/微信图片_20231203153718(1).png', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_user` (`id`, `user_name`, `nick_name`, `email`, `phone`, `password`, `sex`, `avatar`, `status`, `introduce`, `ext_json`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (18, 'oYA4HtzZ7vsgZ0GVY08B4dnxcZsM', '鸡翅粉丝', NULL, NULL, NULL, NULL, 'http://117.72.10.84:9000/user/icon/微信图片_20231203153718(1).png', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_user` (`id`, `user_name`, `nick_name`, `email`, `phone`, `password`, `sex`, `avatar`, `status`, `introduce`, `ext_json`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (19, 'oYA4HtyOuFyGgQQmFUwm6GKkk9kk', '鸡翅粉丝', NULL, NULL, NULL, NULL, 'http://117.72.10.84:9000/user/icon/微信图片_20231203153718(1).png', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_user` (`id`, `user_name`, `nick_name`, `email`, `phone`, `password`, `sex`, `avatar`, `status`, `introduce`, `ext_json`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (20, 'oYA4Ht7eWG-jY8azs5uaXLEIGgog', '鸡翅粉丝', NULL, NULL, NULL, NULL, 'http://117.72.10.84:9000/user/icon/微信图片_20231203153718(1).png', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_user` (`id`, `user_name`, `nick_name`, `email`, `phone`, `password`, `sex`, `avatar`, `status`, `introduce`, `ext_json`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (21, 'oYA4Ht0hASL-driMQJcCKUSUsdkQ', '鸡翅粉丝', NULL, NULL, NULL, NULL, 'http://117.72.10.84:9000/user/icon/微信图片_20231203153718(1).png', 0, NULL, NULL, NULL, NULL, NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for auth_user_role
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_role`;
CREATE TABLE `auth_user_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色id',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='用户角色表';

-- ----------------------------
-- Records of auth_user_role
-- ----------------------------
BEGIN;
INSERT INTO `auth_user_role` (`id`, `user_id`, `role_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (4, 4, 2, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_user_role` (`id`, `user_id`, `role_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (5, 5, 2, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_user_role` (`id`, `user_id`, `role_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (6, 6, 2, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_user_role` (`id`, `user_id`, `role_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (7, 7, 2, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_user_role` (`id`, `user_id`, `role_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (8, 8, 2, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_user_role` (`id`, `user_id`, `role_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (9, 9, 2, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_user_role` (`id`, `user_id`, `role_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (10, 10, 2, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_user_role` (`id`, `user_id`, `role_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (11, 11, 2, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_user_role` (`id`, `user_id`, `role_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (12, 12, 2, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_user_role` (`id`, `user_id`, `role_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (13, 13, 2, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_user_role` (`id`, `user_id`, `role_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (14, 14, 2, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_user_role` (`id`, `user_id`, `role_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (15, 15, 2, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_user_role` (`id`, `user_id`, `role_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (16, 16, 2, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_user_role` (`id`, `user_id`, `role_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (17, 17, 2, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_user_role` (`id`, `user_id`, `role_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (18, 18, 2, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_user_role` (`id`, `user_id`, `role_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (19, 19, 2, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_user_role` (`id`, `user_id`, `role_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (20, 20, 2, NULL, NULL, NULL, NULL, 0);
INSERT INTO `auth_user_role` (`id`, `user_id`, `role_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (21, 21, 2, NULL, NULL, NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for interview_history
-- ----------------------------
DROP TABLE IF EXISTS `interview_history`;
CREATE TABLE `interview_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `avg_score` double DEFAULT NULL,
  `key_words` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `tip` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `interview_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `created_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of interview_history
-- ----------------------------
BEGIN;
INSERT INTO `interview_history` (`id`, `avg_score`, `key_words`, `tip`, `interview_url`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (1, 1, '后端-Redis', '后端-Redis掌握还是比较弱,多跟鸡哥学学', 'https://gitee.com/lyilan8080/loser-res/raw/master/video/66.pdf', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-12-03 20:31:31', NULL, '2024-12-03 12:31:31', 0);
COMMIT;

-- ----------------------------
-- Table structure for interview_question_history
-- ----------------------------
DROP TABLE IF EXISTS `interview_question_history`;
CREATE TABLE `interview_question_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `interview_id` int(11) NOT NULL,
  `score` double DEFAULT NULL,
  `key_words` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `question` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `answer` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `user_answer` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `created_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of interview_question_history
-- ----------------------------
BEGIN;
INSERT INTO `interview_question_history` (`id`, `interview_id`, `score`, `key_words`, `question`, `answer`, `user_answer`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (1, 1, 1, '后端-Redis', 'redis到底是什么', NULL, '我不知道答案', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-12-03 20:31:31', NULL, '2024-12-03 12:31:31', 0);
COMMIT;

-- ----------------------------
-- Table structure for practice_detail
-- ----------------------------
DROP TABLE IF EXISTS `practice_detail`;
CREATE TABLE `practice_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `practice_id` bigint(20) DEFAULT NULL COMMENT '练题id',
  `subject_id` bigint(20) DEFAULT NULL COMMENT '题目id',
  `subject_type` int(11) DEFAULT NULL COMMENT '题目类型',
  `answer_status` int(11) DEFAULT NULL COMMENT '回答状态',
  `answer_content` varchar(64) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '回答内容',
  `created_by` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '创建人',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` int(11) DEFAULT '0' COMMENT '是否被删除 0为删除 1已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='练习详情表';

-- ----------------------------
-- Records of practice_detail
-- ----------------------------
BEGIN;
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (1, 1, 329, 1, 1, '3', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:07:19', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (2, 1, 330, 1, 0, '2', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:08:17', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (3, 1, 331, 1, 0, '1', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:08:25', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (4, 1, 328, 1, 0, '', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:08:30', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (5, 2, 328, 1, 0, '2', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:08:56', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (6, 4, 330, 1, 0, '2', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:17:02', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (7, 4, 329, 1, 0, '1', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:17:03', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (8, 4, 328, 1, 1, '1', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:17:06', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (9, 4, 331, 1, 1, '2', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:17:08', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (10, 4, 332, 2, 0, '2,3', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:17:10', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (11, 4, 334, 2, 0, '2,4', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:17:14', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (12, 4, 333, 2, 0, '2,3', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:17:17', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (13, 4, 336, 3, 1, '0', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:17:19', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (14, 4, 335, 3, 1, '1', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:17:20', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (15, 4, 337, 3, 0, '', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:17:23', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (16, 5, 328, 1, 1, '1', 'oYA4Ht6xP95pb7uRxffSycpdJxnk', '2024-11-28 15:51:39', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (17, 5, 331, 1, 0, '', 'oYA4Ht6xP95pb7uRxffSycpdJxnk', '2024-11-28 15:51:44', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (18, 5, 330, 1, 0, '', 'oYA4Ht6xP95pb7uRxffSycpdJxnk', '2024-11-28 15:51:44', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (19, 5, 329, 1, 0, '', 'oYA4Ht6xP95pb7uRxffSycpdJxnk', '2024-11-28 15:51:44', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (20, 5, 333, 2, 0, '', 'oYA4Ht6xP95pb7uRxffSycpdJxnk', '2024-11-28 15:51:44', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (21, 5, 334, 2, 0, '', 'oYA4Ht6xP95pb7uRxffSycpdJxnk', '2024-11-28 15:51:44', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (22, 5, 332, 2, 0, '', 'oYA4Ht6xP95pb7uRxffSycpdJxnk', '2024-11-28 15:51:44', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (23, 5, 335, 3, 0, '', 'oYA4Ht6xP95pb7uRxffSycpdJxnk', '2024-11-28 15:51:44', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (24, 5, 337, 3, 0, '', 'oYA4Ht6xP95pb7uRxffSycpdJxnk', '2024-11-28 15:51:44', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (25, 5, 336, 3, 0, '', 'oYA4Ht6xP95pb7uRxffSycpdJxnk', '2024-11-28 15:51:44', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (26, 7, 330, 1, 1, '4', NULL, '2024-11-29 22:01:46', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (27, 7, 329, 1, 1, '3', NULL, '2024-11-29 22:01:51', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (28, 7, 328, 1, 1, '1', NULL, '2024-11-29 22:02:06', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (29, 7, 331, 1, 1, '2', NULL, '2024-11-29 22:02:16', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (30, 7, 332, 2, 1, '1,2', NULL, '2024-11-29 22:02:28', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (31, 7, 334, 2, 0, '1,2,4', NULL, '2024-11-29 22:02:58', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (32, 7, 334, 2, 0, '1,2,3,4', NULL, '2024-11-29 22:03:04', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (33, 7, 333, 2, 0, '1', NULL, '2024-11-29 22:03:29', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (34, 7, 336, 3, 1, '0', NULL, '2024-11-29 22:04:09', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (35, 7, 335, 3, 0, '', NULL, '2024-11-29 22:04:27', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (36, 7, 335, 3, 0, '0', NULL, '2024-11-29 22:04:40', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (37, 7, 335, 3, 0, '0', NULL, '2024-11-29 22:04:46', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (38, 7, 337, 3, 0, '', NULL, '2024-11-29 22:04:56', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (39, 8, 328, 1, 1, '1', 'oYA4Ht0j1NRLCDJ6KyTOgzXT2nMQ', '2024-11-30 13:37:53', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (40, 8, 330, 1, 1, '4', 'oYA4Ht0j1NRLCDJ6KyTOgzXT2nMQ', '2024-11-30 13:37:57', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (41, 8, 329, 1, 1, '3', NULL, '2024-11-30 13:38:05', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (42, 8, 331, 1, 0, '3', 'oYA4Ht0j1NRLCDJ6KyTOgzXT2nMQ', '2024-11-30 13:38:19', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (43, 8, 332, 2, 1, '1,2', 'oYA4Ht0j1NRLCDJ6KyTOgzXT2nMQ', '2024-11-30 13:38:24', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (44, 8, 333, 2, 0, '', 'oYA4Ht0j1NRLCDJ6KyTOgzXT2nMQ', '2024-11-30 13:38:34', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (45, 8, 334, 2, 0, '', 'oYA4Ht0j1NRLCDJ6KyTOgzXT2nMQ', '2024-11-30 13:38:41', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (46, 8, 337, 3, 0, '1', NULL, '2024-11-30 13:38:48', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (47, 8, 336, 3, 1, '0', NULL, '2024-11-30 13:38:54', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (48, 8, 335, 3, 0, '', NULL, '2024-11-30 13:38:59', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (49, 10, 330, 1, 0, '', NULL, '2024-11-30 21:48:40', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (50, 10, 329, 1, 0, '', NULL, '2024-11-30 21:48:40', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (51, 10, 328, 1, 0, '', NULL, '2024-11-30 21:48:40', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (52, 10, 331, 1, 0, '', NULL, '2024-11-30 21:48:40', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (53, 10, 332, 2, 0, '', NULL, '2024-11-30 21:48:40', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (54, 10, 334, 2, 0, '', NULL, '2024-11-30 21:48:40', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (55, 10, 333, 2, 0, '', NULL, '2024-11-30 21:48:40', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (56, 10, 336, 3, 0, '', NULL, '2024-11-30 21:48:40', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (57, 10, 335, 3, 0, '', NULL, '2024-11-30 21:48:40', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (58, 10, 337, 3, 0, '', NULL, '2024-11-30 21:48:40', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (59, 12, 330, 1, 1, '4', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:40:06', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (60, 12, 329, 1, 0, '2', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:40:09', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (61, 12, 328, 1, 0, '2', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:40:11', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (62, 12, 331, 1, 1, '2', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:40:14', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (63, 12, 332, 2, 1, '1,2', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:40:18', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (64, 12, 334, 2, 0, '1,2', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:40:20', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (65, 12, 333, 2, 0, '2,3', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:40:24', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (66, 12, 336, 3, 0, '1', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:40:39', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (67, 12, 335, 3, 1, '1', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:40:42', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (68, 12, 337, 3, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:40:44', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (69, 14, 336, 3, 1, '0', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:52:29', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (70, 14, 335, 3, 1, '1', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:52:32', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (71, 14, 330, 1, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:52:35', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (72, 14, 331, 1, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:52:35', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (73, 14, 328, 1, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:52:35', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (74, 14, 329, 1, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:52:35', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (75, 14, 333, 2, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:52:35', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (76, 14, 334, 2, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:52:35', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (77, 14, 332, 2, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:52:35', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (78, 14, 337, 3, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:52:35', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (79, 15, 335, 3, 1, '1', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:01:49', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (80, 15, 328, 1, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:02:28', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (81, 15, 330, 1, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:02:28', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (82, 15, 329, 1, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:02:28', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (83, 15, 331, 1, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:02:28', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (84, 15, 333, 2, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:02:28', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (85, 15, 334, 2, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:02:28', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (86, 15, 332, 2, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:02:28', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (87, 15, 336, 3, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:02:28', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (88, 15, 337, 3, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:02:28', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (89, 16, 337, 3, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:09:38', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (90, 16, 336, 3, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:09:39', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (91, 16, 328, 1, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:09:40', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (92, 16, 331, 1, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:09:40', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (93, 16, 330, 1, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:09:40', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (94, 16, 329, 1, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:09:40', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (95, 16, 332, 2, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:09:40', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (96, 16, 333, 2, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:09:40', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (97, 16, 334, 2, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:09:40', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (98, 16, 335, 3, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:09:40', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (99, 17, 336, 3, 0, '1', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:10:26', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (100, 17, 335, 3, 0, '0', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:10:29', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (101, 17, 329, 1, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:10:31', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (102, 17, 328, 1, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:10:31', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (103, 17, 331, 1, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:10:31', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (104, 17, 330, 1, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:10:31', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (105, 17, 332, 2, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:10:31', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (106, 17, 334, 2, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:10:31', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (107, 17, 333, 2, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:10:31', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (108, 17, 337, 3, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:10:31', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (109, 34, 330, 1, 0, '1', NULL, '2024-12-03 20:37:58', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (110, 34, 329, 1, 0, '1', 'oYA4Ht9BalkOl7Pb28EZ220SUagg', '2024-12-03 20:38:01', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (111, 34, 331, 1, 0, '3', 'oYA4Ht9BalkOl7Pb28EZ220SUagg', '2024-12-03 20:38:04', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (112, 34, 328, 1, 0, '3', 'oYA4Ht9BalkOl7Pb28EZ220SUagg', '2024-12-03 20:38:06', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (113, 34, 332, 2, 0, '1', 'oYA4Ht9BalkOl7Pb28EZ220SUagg', '2024-12-03 20:38:09', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (114, 34, 334, 2, 0, '', 'oYA4Ht9BalkOl7Pb28EZ220SUagg', '2024-12-03 20:38:12', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (115, 34, 333, 2, 0, '', 'oYA4Ht9BalkOl7Pb28EZ220SUagg', '2024-12-03 20:38:12', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (116, 34, 336, 3, 0, '', 'oYA4Ht9BalkOl7Pb28EZ220SUagg', '2024-12-03 20:38:12', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (117, 34, 337, 3, 0, '', 'oYA4Ht9BalkOl7Pb28EZ220SUagg', '2024-12-03 20:38:12', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (118, 34, 335, 3, 0, '', 'oYA4Ht9BalkOl7Pb28EZ220SUagg', '2024-12-03 20:38:12', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (119, 35, 330, 1, 0, '1', NULL, '2024-12-03 23:48:01', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (120, 35, 328, 1, 0, '', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-12-03 23:48:02', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (121, 35, 331, 1, 0, '', NULL, '2024-12-03 23:48:03', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (122, 35, 329, 1, 0, '', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-12-03 23:48:03', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (123, 35, 332, 2, 0, '', NULL, '2024-12-03 23:48:05', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (124, 35, 333, 2, 0, '', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-12-03 23:48:06', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (125, 35, 334, 2, 0, '', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-12-03 23:48:07', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (126, 35, 337, 3, 0, '1', NULL, '2024-12-03 23:48:09', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (127, 35, 335, 3, 0, '0', NULL, '2024-12-03 23:48:11', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (128, 35, 336, 3, 0, '', NULL, '2024-12-03 23:48:12', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (129, 36, 331, 1, 0, '', NULL, '2024-12-03 23:48:47', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (130, 36, 330, 1, 0, '', NULL, '2024-12-03 23:48:48', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (131, 36, 329, 1, 0, '', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-12-03 23:48:49', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (132, 37, 331, 1, 0, '', NULL, '2024-12-03 23:50:03', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (133, 37, 330, 1, 0, '', NULL, '2024-12-03 23:50:03', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (134, 37, 329, 1, 0, '', NULL, '2024-12-03 23:50:03', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (135, 37, 328, 1, 0, '', NULL, '2024-12-03 23:50:03', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (136, 37, 332, 2, 0, '', NULL, '2024-12-03 23:50:03', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (137, 37, 333, 2, 0, '', NULL, '2024-12-03 23:50:03', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (138, 37, 334, 2, 0, '', NULL, '2024-12-03 23:50:03', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (139, 37, 335, 3, 0, '', NULL, '2024-12-03 23:50:03', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (140, 37, 337, 3, 0, '', NULL, '2024-12-03 23:50:03', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (141, 37, 336, 3, 0, '', NULL, '2024-12-03 23:50:03', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (142, 38, 330, 1, 0, '', NULL, '2024-12-03 23:51:15', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (143, 38, 331, 1, 0, '', NULL, '2024-12-03 23:51:15', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (144, 38, 328, 1, 0, '', NULL, '2024-12-03 23:51:15', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (145, 38, 329, 1, 0, '', NULL, '2024-12-03 23:51:15', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (146, 38, 333, 2, 0, '', NULL, '2024-12-03 23:51:15', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (147, 38, 332, 2, 0, '', NULL, '2024-12-03 23:51:15', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (148, 38, 334, 2, 0, '', NULL, '2024-12-03 23:51:15', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (149, 38, 336, 3, 0, '', NULL, '2024-12-03 23:51:15', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (150, 38, 335, 3, 0, '', NULL, '2024-12-03 23:51:15', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (151, 38, 337, 3, 0, '', NULL, '2024-12-03 23:51:15', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (152, 39, 329, 1, 1, '3', NULL, '2024-12-03 23:51:41', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (153, 41, 329, 1, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-04 00:02:17', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (154, 41, 330, 1, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-04 00:02:31', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (155, 43, 329, 1, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-04 00:09:20', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (156, 43, 330, 1, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-04 00:09:25', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (157, 43, 328, 1, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-04 00:09:28', NULL, NULL, 0);
INSERT INTO `practice_detail` (`id`, `practice_id`, `subject_id`, `subject_type`, `answer_status`, `answer_content`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (158, 43, 331, 1, 0, '', 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-04 00:09:32', NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for practice_info
-- ----------------------------
DROP TABLE IF EXISTS `practice_info`;
CREATE TABLE `practice_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `set_id` bigint(20) DEFAULT NULL COMMENT '套题id',
  `complete_status` int(11) DEFAULT NULL COMMENT '是否完成 1完成 0未完成',
  `time_use` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '用时',
  `submit_time` datetime DEFAULT NULL COMMENT '交卷时间',
  `correct_rate` decimal(10,2) DEFAULT NULL COMMENT '正确率',
  `created_by` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '创建人',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` int(11) DEFAULT '0' COMMENT '是否被删除 0为删除 1已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='练习表';

-- ----------------------------
-- Records of practice_info
-- ----------------------------
BEGIN;
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (1, 1, 1, '00:01:16', '2024-11-28 14:08:29', 25.00, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:07:14', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (2, 2, 0, '00:00:03', '2024-11-28 14:08:56', 0.00, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:08:53', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (3, 2, 0, '00:00:00', '2024-11-28 14:09:02', 0.00, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:09:02', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (4, 3, 1, '00:00:58', '2024-11-28 14:17:22', 40.00, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:16:24', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (5, 4, 1, '00:00:11', '2024-11-28 15:51:42', 10.00, 'oYA4Ht6xP95pb7uRxffSycpdJxnk', '2024-11-28 15:51:32', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (6, 3, 0, '00:00:00', '2024-11-29 16:59:44', 0.00, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-29 16:59:44', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (7, 3, 1, '00:03:21', '2024-11-29 22:04:55', 60.00, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-29 22:01:35', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (8, 5, 1, '00:01:10', '2024-11-30 13:38:58', 50.00, 'oYA4Ht0j1NRLCDJ6KyTOgzXT2nMQ', '2024-11-30 13:37:49', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (9, 3, 0, '00:00:00', '2024-11-30 13:40:50', 0.00, 'oYA4Ht0j1NRLCDJ6KyTOgzXT2nMQ', '2024-11-30 13:40:50', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (10, 3, 1, '00:00:12', '2024-11-30 21:48:39', 0.00, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-30 21:48:28', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (11, 3, 0, '00:00:00', '2024-12-02 23:37:52', 0.00, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:37:52', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (12, 3, 1, '00:00:46', '2024-12-02 23:40:41', 40.00, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:39:58', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (13, 3, 0, '00:00:00', '2024-12-02 23:52:10', 0.00, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:52:10', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (14, 6, 1, '00:00:15', '2024-12-02 23:52:32', 20.00, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:52:19', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (15, 7, 1, '00:00:58', '2024-12-03 00:02:25', 10.00, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:01:29', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (16, 8, 1, '00:00:56', '2024-12-03 00:09:37', 0.00, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:08:43', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (17, 9, 1, '00:00:09', '2024-12-03 00:10:28', 0.00, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:10:21', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (18, 10, 0, '00:00:00', '2024-12-03 00:26:20', 0.00, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:26:20', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (19, 10, 0, '00:00:00', '2024-12-03 00:26:48', 0.00, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:26:48', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (20, 10, 0, '00:00:00', '2024-12-03 00:31:06', 0.00, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:31:06', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (21, 10, 0, '00:00:00', '2024-12-03 00:33:30', 0.00, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:33:30', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (22, 10, 0, '00:00:00', '2024-12-03 00:35:10', 0.00, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:35:10', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (23, 10, 0, '00:00:00', '2024-12-03 00:35:32', 0.00, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:35:32', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (24, 10, 0, '00:00:00', '2024-12-03 00:35:43', 0.00, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:35:43', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (25, 10, 0, '00:00:00', '2024-12-03 00:38:07', 0.00, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:38:07', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (26, 10, 0, '00:00:00', '2024-12-03 00:38:10', 0.00, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:38:10', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (27, 10, 0, '00:00:00', '2024-12-03 00:38:31', 0.00, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:38:31', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (28, 10, 0, '00:00:00', '2024-12-03 00:41:09', 0.00, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:41:09', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (29, 10, 0, '00:00:00', '2024-12-03 00:42:22', 0.00, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:42:22', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (30, 10, 0, '00:00:00', '2024-12-03 00:42:25', 0.00, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:42:25', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (31, 10, 0, '00:00:00', '2024-12-03 00:45:53', 0.00, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:45:53', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (32, 10, 0, '00:00:00', '2024-12-03 00:45:57', 0.00, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:45:57', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (33, 10, 0, '00:00:00', '2024-12-03 00:46:00', 0.00, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:46:00', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (34, 11, 1, '00:00:19', '2024-12-03 20:38:10', 0.00, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-12-03 20:37:52', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (35, 12, 1, '00:00:31', '2024-12-03 23:48:11', 0.00, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-12-03 23:47:41', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (36, 13, 0, '00:00:03', '2024-12-03 23:48:49', 0.00, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-12-03 23:48:46', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (37, 14, 1, '00:00:07', '2024-12-03 23:50:02', 0.00, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-12-03 23:49:56', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (38, 15, 1, '00:00:57', '2024-12-03 23:51:15', 0.00, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-12-03 23:50:18', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (39, 16, 0, '00:00:10', '2024-12-03 23:51:41', 0.00, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-12-03 23:51:30', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (40, 16, 0, '00:00:00', '2024-12-03 23:54:45', 0.00, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-12-03 23:54:45', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (41, 17, 0, '00:00:21', '2024-12-04 00:02:31', 0.00, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-04 00:02:10', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (42, 17, 0, '00:00:00', '2024-12-04 00:09:10', 0.00, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-04 00:09:10', NULL, NULL, 0);
INSERT INTO `practice_info` (`id`, `set_id`, `complete_status`, `time_use`, `submit_time`, `correct_rate`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (43, 17, 0, '00:00:25', '2024-12-04 00:09:41', 0.00, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-04 00:09:16', NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for practice_set
-- ----------------------------
DROP TABLE IF EXISTS `practice_set`;
CREATE TABLE `practice_set` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `set_name` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '套题名称',
  `set_type` int(11) DEFAULT NULL COMMENT '套题类型 1实时生成 2预设套题',
  `set_heat` int(11) DEFAULT NULL COMMENT '热度',
  `set_desc` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '套题描述',
  `primary_category_id` bigint(20) DEFAULT NULL COMMENT '大类id',
  `created_by` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '创建人',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` int(11) DEFAULT '0' COMMENT '是否被删除 0为删除 1已删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='套题信息表';

-- ----------------------------
-- Records of practice_set
-- ----------------------------
BEGIN;
INSERT INTO `practice_set` (`id`, `set_name`, `set_type`, `set_heat`, `set_desc`, `primary_category_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (1, '缓存专项练习', 1, NULL, NULL, 1, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:07:13', NULL, NULL, 0);
INSERT INTO `practice_set` (`id`, `set_name`, `set_type`, `set_heat`, `set_desc`, `primary_category_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (2, '缓存专项练习', 1, NULL, NULL, 1, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:08:53', NULL, NULL, 0);
INSERT INTO `practice_set` (`id`, `set_name`, `set_type`, `set_heat`, `set_desc`, `primary_category_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (3, '2024年redis缓存大练兵', 2, 870, '单选+多选+判断', 1, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:16:24', NULL, NULL, 0);
INSERT INTO `practice_set` (`id`, `set_name`, `set_type`, `set_heat`, `set_desc`, `primary_category_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (4, '缓存专项练习', 1, NULL, NULL, 1, 'oYA4Ht6xP95pb7uRxffSycpdJxnk', '2024-11-28 15:51:31', NULL, NULL, 0);
INSERT INTO `practice_set` (`id`, `set_name`, `set_type`, `set_heat`, `set_desc`, `primary_category_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (5, '缓存专项练习', 1, NULL, NULL, 1, 'oYA4Ht0j1NRLCDJ6KyTOgzXT2nMQ', '2024-11-30 13:37:48', NULL, NULL, 0);
INSERT INTO `practice_set` (`id`, `set_name`, `set_type`, `set_heat`, `set_desc`, `primary_category_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (6, '缓存专项练习', 1, NULL, NULL, 1, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:52:19', NULL, NULL, 0);
INSERT INTO `practice_set` (`id`, `set_name`, `set_type`, `set_heat`, `set_desc`, `primary_category_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (7, '缓存专项练习', 1, NULL, NULL, 1, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:01:29', NULL, NULL, 0);
INSERT INTO `practice_set` (`id`, `set_name`, `set_type`, `set_heat`, `set_desc`, `primary_category_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (8, '缓存专项练习', 1, NULL, NULL, 1, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:08:43', NULL, NULL, 0);
INSERT INTO `practice_set` (`id`, `set_name`, `set_type`, `set_heat`, `set_desc`, `primary_category_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (9, '缓存专项练习', 1, NULL, NULL, 1, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:10:21', NULL, NULL, 0);
INSERT INTO `practice_set` (`id`, `set_name`, `set_type`, `set_heat`, `set_desc`, `primary_category_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (10, '缓存专项练习', 1, NULL, NULL, 1, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:26:20', NULL, NULL, 0);
INSERT INTO `practice_set` (`id`, `set_name`, `set_type`, `set_heat`, `set_desc`, `primary_category_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (11, '缓存专项练习', 1, NULL, NULL, 1, NULL, '2024-12-03 20:37:52', NULL, NULL, 0);
INSERT INTO `practice_set` (`id`, `set_name`, `set_type`, `set_heat`, `set_desc`, `primary_category_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (12, '缓存专项练习', 1, NULL, NULL, 1, NULL, '2024-12-03 23:47:41', NULL, NULL, 0);
INSERT INTO `practice_set` (`id`, `set_name`, `set_type`, `set_heat`, `set_desc`, `primary_category_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (13, '缓存专项练习', 1, NULL, NULL, 1, NULL, '2024-12-03 23:48:45', NULL, NULL, 0);
INSERT INTO `practice_set` (`id`, `set_name`, `set_type`, `set_heat`, `set_desc`, `primary_category_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (14, '缓存专项练习', 1, NULL, NULL, 1, NULL, '2024-12-03 23:49:56', NULL, NULL, 0);
INSERT INTO `practice_set` (`id`, `set_name`, `set_type`, `set_heat`, `set_desc`, `primary_category_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (15, '缓存专项练习', 1, NULL, NULL, 1, NULL, '2024-12-03 23:50:18', NULL, NULL, 0);
INSERT INTO `practice_set` (`id`, `set_name`, `set_type`, `set_heat`, `set_desc`, `primary_category_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (16, '缓存专项练习', 1, NULL, NULL, 1, NULL, '2024-12-03 23:51:30', NULL, NULL, 0);
INSERT INTO `practice_set` (`id`, `set_name`, `set_type`, `set_heat`, `set_desc`, `primary_category_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (17, '缓存专项练习', 1, NULL, NULL, 1, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-04 00:02:10', NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for practice_set_detail
-- ----------------------------
DROP TABLE IF EXISTS `practice_set_detail`;
CREATE TABLE `practice_set_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `set_id` bigint(20) NOT NULL COMMENT '套题id',
  `subject_id` bigint(20) DEFAULT NULL COMMENT '题目id',
  `subject_type` int(11) DEFAULT NULL COMMENT '题目类型',
  `created_by` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '创建人',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` int(11) DEFAULT '0' COMMENT '是否被删除 0为删除 1已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='套题内容表';

-- ----------------------------
-- Records of practice_set_detail
-- ----------------------------
BEGIN;
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (1, 1, 329, 1, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:07:14', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (2, 1, 330, 1, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:07:14', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (3, 1, 331, 1, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:07:14', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (4, 1, 328, 1, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:07:14', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (5, 2, 328, 1, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:08:53', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (6, 2, 330, 1, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:08:53', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (7, 2, 329, 1, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:08:53', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (8, 2, 331, 1, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:08:53', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (9, 3, 330, 1, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:16:24', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (10, 3, 329, 1, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:16:24', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (11, 3, 328, 1, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:16:24', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (12, 3, 331, 1, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:16:24', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (13, 3, 332, 2, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:16:24', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (14, 3, 334, 2, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:16:24', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (15, 3, 333, 2, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:16:24', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (16, 3, 336, 3, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:16:24', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (17, 3, 335, 3, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:16:24', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (18, 3, 337, 3, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:16:24', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (19, 4, 328, 1, 'oYA4Ht6xP95pb7uRxffSycpdJxnk', '2024-11-28 15:51:31', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (20, 4, 331, 1, 'oYA4Ht6xP95pb7uRxffSycpdJxnk', '2024-11-28 15:51:31', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (21, 4, 330, 1, 'oYA4Ht6xP95pb7uRxffSycpdJxnk', '2024-11-28 15:51:31', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (22, 4, 329, 1, 'oYA4Ht6xP95pb7uRxffSycpdJxnk', '2024-11-28 15:51:31', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (23, 4, 333, 2, 'oYA4Ht6xP95pb7uRxffSycpdJxnk', '2024-11-28 15:51:31', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (24, 4, 334, 2, 'oYA4Ht6xP95pb7uRxffSycpdJxnk', '2024-11-28 15:51:31', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (25, 4, 332, 2, 'oYA4Ht6xP95pb7uRxffSycpdJxnk', '2024-11-28 15:51:31', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (26, 4, 335, 3, 'oYA4Ht6xP95pb7uRxffSycpdJxnk', '2024-11-28 15:51:31', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (27, 4, 337, 3, 'oYA4Ht6xP95pb7uRxffSycpdJxnk', '2024-11-28 15:51:31', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (28, 4, 336, 3, 'oYA4Ht6xP95pb7uRxffSycpdJxnk', '2024-11-28 15:51:31', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (29, 5, 328, 1, 'oYA4Ht0j1NRLCDJ6KyTOgzXT2nMQ', '2024-11-30 13:37:48', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (30, 5, 330, 1, 'oYA4Ht0j1NRLCDJ6KyTOgzXT2nMQ', '2024-11-30 13:37:48', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (31, 5, 329, 1, 'oYA4Ht0j1NRLCDJ6KyTOgzXT2nMQ', '2024-11-30 13:37:48', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (32, 5, 331, 1, 'oYA4Ht0j1NRLCDJ6KyTOgzXT2nMQ', '2024-11-30 13:37:48', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (33, 5, 332, 2, 'oYA4Ht0j1NRLCDJ6KyTOgzXT2nMQ', '2024-11-30 13:37:48', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (34, 5, 333, 2, 'oYA4Ht0j1NRLCDJ6KyTOgzXT2nMQ', '2024-11-30 13:37:48', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (35, 5, 334, 2, 'oYA4Ht0j1NRLCDJ6KyTOgzXT2nMQ', '2024-11-30 13:37:48', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (36, 5, 337, 3, 'oYA4Ht0j1NRLCDJ6KyTOgzXT2nMQ', '2024-11-30 13:37:48', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (37, 5, 336, 3, 'oYA4Ht0j1NRLCDJ6KyTOgzXT2nMQ', '2024-11-30 13:37:48', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (38, 5, 335, 3, 'oYA4Ht0j1NRLCDJ6KyTOgzXT2nMQ', '2024-11-30 13:37:48', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (39, 6, 330, 1, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:52:19', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (40, 6, 331, 1, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:52:19', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (41, 6, 328, 1, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:52:19', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (42, 6, 329, 1, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:52:19', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (43, 6, 333, 2, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:52:19', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (44, 6, 334, 2, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:52:19', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (45, 6, 332, 2, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:52:19', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (46, 6, 336, 3, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:52:19', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (47, 6, 335, 3, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:52:19', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (48, 6, 337, 3, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:52:19', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (49, 7, 328, 1, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:01:29', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (50, 7, 330, 1, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:01:29', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (51, 7, 329, 1, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:01:29', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (52, 7, 331, 1, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:01:29', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (53, 7, 333, 2, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:01:29', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (54, 7, 334, 2, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:01:29', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (55, 7, 332, 2, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:01:29', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (56, 7, 335, 3, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:01:29', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (57, 7, 336, 3, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:01:29', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (58, 7, 337, 3, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:01:29', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (59, 8, 328, 1, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:08:43', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (60, 8, 331, 1, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:08:43', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (61, 8, 330, 1, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:08:43', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (62, 8, 329, 1, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:08:43', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (63, 8, 332, 2, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:08:43', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (64, 8, 333, 2, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:08:43', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (65, 8, 334, 2, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:08:43', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (66, 8, 337, 3, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:08:43', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (67, 8, 336, 3, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:08:43', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (68, 8, 335, 3, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:08:43', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (69, 9, 329, 1, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:10:21', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (70, 9, 328, 1, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:10:21', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (71, 9, 331, 1, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:10:21', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (72, 9, 330, 1, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:10:21', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (73, 9, 332, 2, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:10:21', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (74, 9, 334, 2, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:10:21', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (75, 9, 333, 2, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:10:21', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (76, 9, 336, 3, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:10:21', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (77, 9, 335, 3, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:10:21', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (78, 9, 337, 3, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:10:21', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (79, 10, 331, 1, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:26:20', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (80, 10, 329, 1, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:26:20', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (81, 10, 328, 1, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:26:20', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (82, 10, 330, 1, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:26:20', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (83, 10, 332, 2, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:26:20', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (84, 10, 334, 2, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:26:20', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (85, 10, 333, 2, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:26:20', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (86, 10, 337, 3, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:26:20', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (87, 10, 336, 3, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:26:20', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (88, 10, 335, 3, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-03 00:26:20', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (89, 11, 330, 1, NULL, '2024-12-03 20:37:52', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (90, 11, 329, 1, NULL, '2024-12-03 20:37:52', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (91, 11, 331, 1, NULL, '2024-12-03 20:37:52', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (92, 11, 328, 1, NULL, '2024-12-03 20:37:52', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (93, 11, 332, 2, NULL, '2024-12-03 20:37:52', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (94, 11, 334, 2, NULL, '2024-12-03 20:37:52', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (95, 11, 333, 2, NULL, '2024-12-03 20:37:52', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (96, 11, 336, 3, NULL, '2024-12-03 20:37:52', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (97, 11, 337, 3, NULL, '2024-12-03 20:37:52', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (98, 11, 335, 3, NULL, '2024-12-03 20:37:52', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (99, 12, 330, 1, NULL, '2024-12-03 23:47:41', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (100, 12, 328, 1, NULL, '2024-12-03 23:47:41', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (101, 12, 331, 1, NULL, '2024-12-03 23:47:41', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (102, 12, 329, 1, NULL, '2024-12-03 23:47:41', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (103, 12, 332, 2, NULL, '2024-12-03 23:47:41', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (104, 12, 333, 2, NULL, '2024-12-03 23:47:41', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (105, 12, 334, 2, NULL, '2024-12-03 23:47:41', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (106, 12, 337, 3, NULL, '2024-12-03 23:47:41', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (107, 12, 335, 3, NULL, '2024-12-03 23:47:41', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (108, 12, 336, 3, NULL, '2024-12-03 23:47:41', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (109, 13, 331, 1, NULL, '2024-12-03 23:48:45', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (110, 13, 330, 1, NULL, '2024-12-03 23:48:45', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (111, 13, 329, 1, NULL, '2024-12-03 23:48:45', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (112, 13, 328, 1, NULL, '2024-12-03 23:48:45', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (113, 13, 332, 2, NULL, '2024-12-03 23:48:45', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (114, 13, 334, 2, NULL, '2024-12-03 23:48:45', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (115, 13, 333, 2, NULL, '2024-12-03 23:48:45', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (116, 13, 335, 3, NULL, '2024-12-03 23:48:45', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (117, 13, 336, 3, NULL, '2024-12-03 23:48:45', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (118, 13, 337, 3, NULL, '2024-12-03 23:48:45', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (119, 14, 331, 1, NULL, '2024-12-03 23:49:56', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (120, 14, 330, 1, NULL, '2024-12-03 23:49:56', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (121, 14, 329, 1, NULL, '2024-12-03 23:49:56', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (122, 14, 328, 1, NULL, '2024-12-03 23:49:56', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (123, 14, 332, 2, NULL, '2024-12-03 23:49:56', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (124, 14, 333, 2, NULL, '2024-12-03 23:49:56', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (125, 14, 334, 2, NULL, '2024-12-03 23:49:56', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (126, 14, 335, 3, NULL, '2024-12-03 23:49:56', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (127, 14, 337, 3, NULL, '2024-12-03 23:49:56', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (128, 14, 336, 3, NULL, '2024-12-03 23:49:56', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (129, 15, 330, 1, NULL, '2024-12-03 23:50:18', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (130, 15, 331, 1, NULL, '2024-12-03 23:50:18', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (131, 15, 328, 1, NULL, '2024-12-03 23:50:18', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (132, 15, 329, 1, NULL, '2024-12-03 23:50:18', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (133, 15, 333, 2, NULL, '2024-12-03 23:50:18', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (134, 15, 332, 2, NULL, '2024-12-03 23:50:18', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (135, 15, 334, 2, NULL, '2024-12-03 23:50:18', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (136, 15, 336, 3, NULL, '2024-12-03 23:50:18', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (137, 15, 335, 3, NULL, '2024-12-03 23:50:18', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (138, 15, 337, 3, NULL, '2024-12-03 23:50:18', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (139, 16, 329, 1, NULL, '2024-12-03 23:51:30', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (140, 16, 328, 1, NULL, '2024-12-03 23:51:30', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (141, 16, 330, 1, NULL, '2024-12-03 23:51:30', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (142, 16, 331, 1, NULL, '2024-12-03 23:51:30', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (143, 16, 334, 2, NULL, '2024-12-03 23:51:30', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (144, 16, 333, 2, NULL, '2024-12-03 23:51:30', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (145, 16, 332, 2, NULL, '2024-12-03 23:51:30', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (146, 16, 335, 3, NULL, '2024-12-03 23:51:30', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (147, 16, 337, 3, NULL, '2024-12-03 23:51:30', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (148, 16, 336, 3, NULL, '2024-12-03 23:51:30', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (149, 17, 329, 1, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-04 00:02:10', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (150, 17, 330, 1, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-04 00:02:10', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (151, 17, 328, 1, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-04 00:02:10', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (152, 17, 331, 1, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-04 00:02:10', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (153, 17, 334, 2, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-04 00:02:10', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (154, 17, 332, 2, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-04 00:02:10', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (155, 17, 333, 2, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-04 00:02:10', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (156, 17, 337, 3, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-04 00:02:10', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (157, 17, 336, 3, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-04 00:02:10', NULL, NULL, 0);
INSERT INTO `practice_set_detail` (`id`, `set_id`, `subject_id`, `subject_type`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (158, 17, 335, 3, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-04 00:02:10', NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for sensitive_words
-- ----------------------------
DROP TABLE IF EXISTS `sensitive_words`;
CREATE TABLE `sensitive_words` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `words` varchar(1024) DEFAULT NULL COMMENT '内容',
  `type` int(11) DEFAULT '0' COMMENT '1=黑名单 2=白名单',
  `is_deleted` int(11) DEFAULT NULL COMMENT '是否被删除 0为删除 1已删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='敏感词表';

-- ----------------------------
-- Records of sensitive_words
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for share_circle
-- ----------------------------
DROP TABLE IF EXISTS `share_circle`;
CREATE TABLE `share_circle` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '圈子ID',
  `parent_id` bigint(20) NOT NULL COMMENT '父级ID,-1为大类',
  `circle_name` varchar(16) NOT NULL COMMENT '圈子名称',
  `icon` varchar(255) DEFAULT NULL COMMENT '圈子图片',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` int(11) DEFAULT '0' COMMENT '是否被删除 0为删除 1已删除',
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='圈子信息';

-- ----------------------------
-- Records of share_circle
-- ----------------------------
BEGIN;
INSERT INTO `share_circle` (`id`, `parent_id`, `circle_name`, `icon`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (1, -1, 'Java圈子', 'http://1123.img', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:25:24', NULL, NULL, 0);
INSERT INTO `share_circle` (`id`, `parent_id`, `circle_name`, `icon`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (2, 1, '涨薪圈', 'http://117.72.10.84:9000/user/icon/微信图片_20231203153718(1).png', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:26:12', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:29:38', 0);
INSERT INTO `share_circle` (`id`, `parent_id`, `circle_name`, `icon`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (3, 1, '系统设计圈', 'http://117.72.10.84:9000/user/icon/微信图片_20231203153718(1).png', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:26:23', NULL, NULL, 0);
INSERT INTO `share_circle` (`id`, `parent_id`, `circle_name`, `icon`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (4, 1, '性能优化圈', 'http://117.72.10.84:9000/user/icon/微信图片_20231203153718(1).png', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:26:28', NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for share_comment_reply
-- ----------------------------
DROP TABLE IF EXISTS `share_comment_reply`;
CREATE TABLE `share_comment_reply` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `moment_id` int(11) NOT NULL COMMENT '原始动态ID',
  `reply_type` int(11) NOT NULL COMMENT '回复类型 1评论 2回复',
  `to_id` bigint(20) DEFAULT NULL COMMENT '评论目标id',
  `to_user` varchar(32) DEFAULT NULL COMMENT '评论人',
  `to_user_author` int(11) DEFAULT NULL COMMENT '评论人是否作者 1=是 0=否',
  `reply_id` bigint(20) DEFAULT NULL COMMENT '回复目标id',
  `reply_user` varchar(32) DEFAULT NULL COMMENT '回复人',
  `replay_author` int(11) DEFAULT NULL COMMENT '回复人是否作者 1=是 0=否',
  `content` varchar(1024) DEFAULT NULL COMMENT '内容',
  `pic_urls` varchar(1024) DEFAULT NULL COMMENT '图片内容',
  `parent_id` int(11) NOT NULL,
  `leaf_node` varchar(255) DEFAULT NULL,
  `children` varchar(255) DEFAULT NULL,
  `root_node` varchar(255) DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` int(11) DEFAULT '0' COMMENT '是否被删除 0为删除 1已删除',
  PRIMARY KEY (`id`,`parent_id`) USING BTREE,
  KEY `idx_moment_id` (`moment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COMMENT='评论及回复信息';

-- ----------------------------
-- Records of share_comment_reply
-- ----------------------------
BEGIN;
INSERT INTO `share_comment_reply` (`id`, `moment_id`, `reply_type`, `to_id`, `to_user`, `to_user_author`, `reply_id`, `reply_user`, `replay_author`, `content`, `pic_urls`, `parent_id`, `leaf_node`, `children`, `root_node`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (10, 2, 1, 2, 'oYA4Ht0LYVOCcwevzlImKZHpFSiE', 1, NULL, NULL, NULL, '我不信哈哈哈', NULL, -1, NULL, NULL, NULL, 'oYA4Ht0LYVOCcwevzlImKZHpFSiE', '2024-11-28 15:21:57', NULL, NULL, 0);
INSERT INTO `share_comment_reply` (`id`, `moment_id`, `reply_type`, `to_id`, `to_user`, `to_user_author`, `reply_id`, `reply_user`, `replay_author`, `content`, `pic_urls`, `parent_id`, `leaf_node`, `children`, `root_node`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (11, 2, 2, 10, 'oYA4Ht0LYVOCcwevzlImKZHpFSiE', 1, 10, 'oYA4Ht0LYVOCcwevzlImKZHpFSiE', 1, '我信啊', NULL, 10, NULL, NULL, NULL, 'oYA4Ht0LYVOCcwevzlImKZHpFSiE', '2024-11-28 15:22:04', NULL, NULL, 0);
INSERT INTO `share_comment_reply` (`id`, `moment_id`, `reply_type`, `to_id`, `to_user`, `to_user_author`, `reply_id`, `reply_user`, `replay_author`, `content`, `pic_urls`, `parent_id`, `leaf_node`, `children`, `root_node`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (12, 2, 2, 11, 'oYA4Ht0LYVOCcwevzlImKZHpFSiE', 0, 11, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', 0, '我也信了', NULL, 11, NULL, NULL, NULL, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 15:22:41', NULL, NULL, 0);
INSERT INTO `share_comment_reply` (`id`, `moment_id`, `reply_type`, `to_id`, `to_user`, `to_user_author`, `reply_id`, `reply_user`, `replay_author`, `content`, `pic_urls`, `parent_id`, `leaf_node`, `children`, `root_node`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (13, 2, 1, 2, 'oYA4Ht0j1NRLCDJ6KyTOgzXT2nMQ', 0, NULL, NULL, NULL, '把k去掉倒是有可能', NULL, -1, NULL, NULL, NULL, 'oYA4Ht0j1NRLCDJ6KyTOgzXT2nMQ', '2024-11-30 13:42:36', NULL, NULL, 0);
INSERT INTO `share_comment_reply` (`id`, `moment_id`, `reply_type`, `to_id`, `to_user`, `to_user_author`, `reply_id`, `reply_user`, `replay_author`, `content`, `pic_urls`, `parent_id`, `leaf_node`, `children`, `root_node`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (14, 2, 2, 12, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', 0, 12, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', 0, '我不信', NULL, 12, NULL, NULL, NULL, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:48:28', NULL, NULL, 0);
INSERT INTO `share_comment_reply` (`id`, `moment_id`, `reply_type`, `to_id`, `to_user`, `to_user_author`, `reply_id`, `reply_user`, `replay_author`, `content`, `pic_urls`, `parent_id`, `leaf_node`, `children`, `root_node`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (15, 2, 2, 13, 'oYA4Ht0j1NRLCDJ6KyTOgzXT2nMQ', 0, 13, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', 0, '有什么可能', NULL, 13, NULL, NULL, NULL, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:51:14', NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for share_message
-- ----------------------------
DROP TABLE IF EXISTS `share_message`;
CREATE TABLE `share_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `from_id` varchar(32) NOT NULL COMMENT '来自人',
  `to_id` varchar(32) NOT NULL COMMENT '送达人',
  `content` varchar(256) DEFAULT NULL COMMENT '消息内容',
  `is_read` int(11) DEFAULT '0' COMMENT '是否被阅读 1是 2否',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` int(11) DEFAULT '0' COMMENT '是否被删除 0为删除 1已删除',
  PRIMARY KEY (`id`),
  KEY `idx_to_id` (`to_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COMMENT='消息表';

-- ----------------------------
-- Records of share_message
-- ----------------------------
BEGIN;
INSERT INTO `share_message` (`id`, `from_id`, `to_id`, `content`, `is_read`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (10, 'oYA4Ht0LYVOCcwevzlImKZHpFSiE', 'oYA4Ht0LYVOCcwevzlImKZHpFSiE', '{\"msg\":\"评论了你的内容，快来看看把\",\"msgType\":\"COMMENT\",\"targetId\":2}', 2, 'oYA4Ht0LYVOCcwevzlImKZHpFSiE', '2024-11-28 15:21:57', NULL, NULL, 0);
INSERT INTO `share_message` (`id`, `from_id`, `to_id`, `content`, `is_read`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (11, 'oYA4Ht0LYVOCcwevzlImKZHpFSiE', 'oYA4Ht0LYVOCcwevzlImKZHpFSiE', '{\"msg\":\"鸡腿哥 回复了你的评论，快来看看把！\",\"msgType\":\"COMMENT_REPLY\",\"targetId\":2}', 2, 'oYA4Ht0LYVOCcwevzlImKZHpFSiE', '2024-11-28 15:22:04', NULL, NULL, 0);
INSERT INTO `share_message` (`id`, `from_id`, `to_id`, `content`, `is_read`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (12, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', 'oYA4Ht0LYVOCcwevzlImKZHpFSiE', '{\"msg\":\"鸡翅老鸽 回复了你的评论，快来看看把！\",\"msgType\":\"COMMENT_REPLY\",\"targetId\":2}', 2, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 15:22:41', NULL, NULL, 0);
INSERT INTO `share_message` (`id`, `from_id`, `to_id`, `content`, `is_read`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (13, 'oYA4Ht0j1NRLCDJ6KyTOgzXT2nMQ', 'oYA4Ht0LYVOCcwevzlImKZHpFSiE', '{\"msg\":\"评论了你的内容，快来看看把\",\"msgType\":\"COMMENT\",\"targetId\":2}', 2, 'oYA4Ht0j1NRLCDJ6KyTOgzXT2nMQ', '2024-11-30 13:42:36', NULL, NULL, 0);
INSERT INTO `share_message` (`id`, `from_id`, `to_id`, `content`, `is_read`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (14, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '{\"msg\":\"鸡翅粉丝 回复了你的评论，快来看看把！\",\"msgType\":\"COMMENT_REPLY\",\"targetId\":2}', 2, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:48:28', NULL, NULL, 0);
INSERT INTO `share_message` (`id`, `from_id`, `to_id`, `content`, `is_read`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (15, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', 'oYA4Ht0j1NRLCDJ6KyTOgzXT2nMQ', '{\"msg\":\"鸡翅粉丝 回复了你的评论，快来看看把！\",\"msgType\":\"COMMENT_REPLY\",\"targetId\":2}', 2, 'oYA4Ht-ccqtFw0UtHAeQzGfXNaZs', '2024-12-02 23:51:14', NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for share_moment
-- ----------------------------
DROP TABLE IF EXISTS `share_moment`;
CREATE TABLE `share_moment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '动态ID',
  `circle_id` bigint(20) NOT NULL COMMENT '圈子ID',
  `content` varchar(1024) DEFAULT NULL COMMENT '动态内容',
  `pic_urls` varchar(1024) DEFAULT NULL COMMENT '动态图片内容',
  `reply_count` int(11) NOT NULL DEFAULT '0' COMMENT '回复数',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` int(11) DEFAULT '0' COMMENT '是否被删除 0为删除 1已删除',
  PRIMARY KEY (`id`),
  KEY `idx_circle_id` (`circle_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='动态信息';

-- ----------------------------
-- Records of share_moment
-- ----------------------------
BEGIN;
INSERT INTO `share_moment` (`id`, `circle_id`, `content`, `pic_urls`, `reply_count`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (2, 2, '暴涨50k', NULL, 6, 'oYA4Ht0LYVOCcwevzlImKZHpFSiE', '2024-11-28 15:21:50', NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for subject_brief
-- ----------------------------
DROP TABLE IF EXISTS `subject_brief`;
CREATE TABLE `subject_brief` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `subject_id` int(20) DEFAULT NULL COMMENT '题目id',
  `subject_answer` text COMMENT '题目答案',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=281 DEFAULT CHARSET=utf8 COMMENT='简答题';

-- ----------------------------
-- Records of subject_brief
-- ----------------------------
BEGIN;
INSERT INTO `subject_brief` (`id`, `subject_id`, `subject_answer`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (59, 100, '<p><br></p><ol><li>String（字符串）</li><li>List（列表）</li><li>Hash（字典）</li><li>Set（集合）</li><li>Sorted Set（有序集合）</li></ol><p><br></p><p><strong>String</strong></p><p><br></p><p>String是简单的 key-value 键值对，value 不仅可以是 String，也可以是数字。String在redis内部存储默认就是一个字符串，被redisObject所引用，当遇到incr,decr等操作时会转成数值型进行计算，此时redisObject的encoding字段为int。</p><p><br></p><p><strong>List</strong></p><p><br></p><p>Redis列表是简单的字符串列表，可以类比到C++中的std::list，简单的说就是一个链表或者说是一个队列。可以从头部或尾部向Redis列表添加元素。列表的最大长度为2^32 - 1，也即每个列表支持超过40亿个元素。</p><p><br></p><p>Redis list的实现为一个双向链表，即可以支持反向查找和遍历，更方便操作，不过带来了部分额外的内存开销，Redis内部的很多实现，包括发送缓冲队列等也都是用的这个数据结构。</p><p><br></p><p><strong>Hash</strong></p><p><br></p><p>Redis Hash对应Value内部实际就是一个HashMap，实际这里会有2种不同实现，这个Hash的成员比较少时Redis为了节省内存会采用类似一维数组的方式来紧凑存储，而不会采用真正的HashMap结构，对应的value redisObject的encoding为zipmap,当成员数量增大时会自动转成真正的HashMap。</p><p><br></p><p><strong>Set</strong></p><p><br></p><p>set 的内部实现是一个 value永远为null的HashMap，实际就是通过计算hash的方式来快速排重的，这也是set能提供判断一个成员是否在集合内的原因。</p><p><br></p><p><strong>Sorted Set</strong></p><p><br></p><p>Redis有序集合类似Redis集合，不同的是增加了一个功能，即集合是有序的。一个有序集合的每个成员带有分数，用于进行排序。</p><p><br></p><p>Redis有序集合添加、删除和测试的时间复杂度均为O(1)(固定时间，无论里面包含的元素集合的数量)。列表的最大长度为2^32- 1元素(4294967295，超过40亿每个元素的集合)。</p><p><br></p><p>Redis sorted set的内部使用HashMap和跳跃表(SkipList)来保证数据的存储和有序，HashMap里放的是成员到score的映射，而跳跃表里存放的是所有的成员，排序依据是HashMap里存的score,使用跳跃表的结构可以获得比较高的查找效率，并且在实现上比较简单。</p>', NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_brief` (`id`, `subject_id`, `subject_answer`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (60, 101, '<p><br></p><p>bitmap：bitmap是一种位数据类型，常常用于统计，大家比较知名的就是布隆过滤器。也可以统计一些大数据量的东西，比如每天有多少优惠券被使用。</p><p><br></p><p>hyperloglog：用于基数统计，基数是数据集去重后元素个数，运用了LogLog的算法。{1,3,5,7,5,7,8} &nbsp; 基数集:{1,3,5,7,8} &nbsp;基数:5</p><p><br></p><p>geo：应用于地理位置计算，主要是经纬度的计算，常见的就是附近的人，可以以当前人的坐标获取周围附近的成员，可以计算经纬度，计算地理位置</p>', NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_brief` (`id`, `subject_id`, `subject_answer`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (61, 102, '<p><br></p><p>(1) 速度快，因为数据存在内存中，类似于HashMap，HashMap的优势就是查找和操作的时间复杂度都是O(1)</p><p><br></p><p>(2) 支持丰富数据类型，支持string，list，set，Zset，hash等</p><p><br></p><p>(3) 支持事务，操作都是原子性，所谓的原子性就是对数据的更改要么全部执行，要么全部不执行</p><p><br></p><p>(4) 丰富的特性：可用于缓存，消息，按key设置过期时间，过期后将会自动删除</p>', NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_brief` (`id`, `subject_id`, `subject_answer`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (62, 103, '<p><br></p><p>(1) Memcached所有的值均是简单的字符串，redis作为其替代者，支持更为丰富的数据类型</p><p><br></p><p>(2) Redis的速度比Memcached快很多</p><p><br></p><p>(3) Redis可以持久化其数据</p>', NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_brief` (`id`, `subject_id`, `subject_answer`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (63, 104, '<p><br></p><p>Redis采用的是单线程模型，因为Redis是一个基于内存的数据库，将所有的数据放入内存，所以使用单线程的操作效率是最高的，多线程会上下文切换消耗大量时间，对于内存系统来说，单线程才能产生更高的效率。但是单线程不意味着整个Redis就一个线程，Redis其他模块还有各自的线程。</p><p><br></p><p>Redis使用I/O threads 指的是网络I/O处理方面使用了多线程，如网络数据的读写和协议解析等，这是因为读写网络的read/write在Redis执行期间占用了大部分CPU时间，如果把这部分模块使用多线程方式实现会对性能带来极大地提升。但是Redis执行命令的核心模块还是单线程的。</p>', NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_brief` (`id`, `subject_id`, `subject_answer`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (64, 105, '<p><br></p><p>1、更新数据库，同时更新缓存，适合并发场景不高的场景</p><p><br></p><p>2、先删除缓存，再更新数据，再删除缓存</p><p><br></p><p>3、通过消息来更新缓存。</p><p><br></p><p>4、通过canal等消息同步的方式。</p>', NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_brief` (`id`, `subject_id`, `subject_answer`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (65, 106, '<p><br></p><p>noeviction: 当内存不足以容纳新写入数据时，新写入操作会报错。</p><p><br></p><p>allkeys-lru：当内存不足以容纳新写入数据时，在键空间中，移除最近最少使用的 key。</p><p><br></p><p>allkeys-random：当内存不足以容纳新写入数据时，在键空间中，随机移除某个 key，这个一般没人用吧，为啥要随机，肯定是把最近最少使用的 key 给干掉啊。</p><p><br></p><p>volatile-lru：当内存不足以容纳新写入数据时，在设置了过期时间的键空间中，移除最近最少使用的 key。</p><p><br></p><p>volatile-random：当内存不足以容纳新写入数据时，在设置了过期时间的键空间中，随机移除某个 key。</p><p><br></p><p>volatile-ttl：当内存不足以容纳新写入数据时，在设置了过期时间的键空间中，有更早过期时间的 key 优先移除。</p>', NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_brief` (`id`, `subject_id`, `subject_answer`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (66, 107, '<p><br></p><p>缓存穿透是指缓存和数据库中都没有的数据，而用户不断发起请求，如发起为id为“-1”的数据或id为特别大不存在的数据。这时的用户很可能是攻击者，攻击会导致数据库压力过大。</p><p><br></p><p>解决方案</p><p><br></p><p>接口层增加校验，如用户鉴权校验，id做基础校验，id&lt;=0的直接拦截；<br>从缓存取不到的数据，在数据库中也没有取到，这时也可以将key-value对写为key-null，缓存有效时间可以设置短点，如30秒（设置太长会导致正常情况也没法使用）。这样可以防止攻击用户反复用同一个id暴力攻击，也可以使用会话重放，防止不断的攻击。</p><p><br></p><h3></h3>', NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_brief` (`id`, `subject_id`, `subject_answer`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (67, 108, '<p><br></p><p>缓存击穿是指缓存中没有但数据库中有的数据（一般是缓存时间到期），这时由于并发用户特别多，同时读缓存没读到数据，又同时去数据库去取数据，引起数据库压力瞬间增大，造成过大压力</p><p><br></p><p>解决方案：</p><p><br></p><p>设置热点数据永远不过期。<br>加互斥锁</p>', NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_brief` (`id`, `subject_id`, `subject_answer`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (68, 109, '<p><br></p><p>缓存雪崩是指缓存中数据大批量到过期时间，而查询数据量巨大，引起数据库压力过大甚至down机。和缓存击穿不同的是，缓存击穿指并发查同一条数据，缓存雪崩是不同数据都过期了，很多数据都查不到从而查数据库。</p><p><br></p><p>解决方案</p><p><br></p><p>缓存数据的过期时间设置随机，防止同一时间大量数据过期现象发生。<br>如果缓存数据库是分布式部署，将热点数据均匀分布在不同的缓存数据库中。也可以是二级缓存，本地和redis共同使用。<br>设置热点数据永远不过期。</p>', NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_brief` (`id`, `subject_id`, `subject_answer`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (69, 110, '<p>setex：<br>setex key seconds value：将key值设置为value，并将设置key的生存周期<br>1，属于原子操作，作用和set key value、expire key seconds作用一致。<br>2，如果key值存在，使用setex将覆盖原有值<br>setnx:<br>setnx key value:只有当key不存在的情况下，将key设置为value；若key存在，不做任何操作，结果成功返回1，失败返回0</p>', NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_brief` (`id`, `subject_id`, `subject_answer`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (280, 327, '真的好用', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 13:32:21', NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for subject_category
-- ----------------------------
DROP TABLE IF EXISTS `subject_category`;
CREATE TABLE `subject_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `category_name` varchar(16) DEFAULT NULL COMMENT '分类名称',
  `category_type` tinyint(2) DEFAULT NULL COMMENT '分类类型',
  `image_url` varchar(64) DEFAULT NULL COMMENT '图标连接',
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父级id',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除 0: 未删除 1: 已删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='题目分类';

-- ----------------------------
-- Records of subject_category
-- ----------------------------
BEGIN;
INSERT INTO `subject_category` (`id`, `category_name`, `category_type`, `image_url`, `parent_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (1, '后端', 1, 'https://image/category.icon', 0, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-02-28 03:21:09', NULL, NULL, 0);
INSERT INTO `subject_category` (`id`, `category_name`, `category_type`, `image_url`, `parent_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (2, '缓存', 2, 'https://image/category.icon', 1, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-02-28 03:21:09', NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for subject_info
-- ----------------------------
DROP TABLE IF EXISTS `subject_info`;
CREATE TABLE `subject_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `subject_name` varchar(128) DEFAULT NULL COMMENT '题目名称',
  `subject_difficult` tinyint(4) DEFAULT NULL COMMENT '题目难度',
  `settle_name` varchar(32) DEFAULT NULL COMMENT '出题人名',
  `subject_type` tinyint(4) DEFAULT NULL COMMENT '题目类型 1单选 2多选 3判断 4简答',
  `subject_score` tinyint(4) DEFAULT NULL COMMENT '题目分数',
  `subject_parse` varchar(512) DEFAULT NULL COMMENT '题目解析',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `is_deleted` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=338 DEFAULT CHARSET=utf8 COMMENT='题目信息表';

-- ----------------------------
-- Records of subject_info
-- ----------------------------
BEGIN;
INSERT INTO `subject_info` (`id`, `subject_name`, `subject_difficult`, `settle_name`, `subject_type`, `subject_score`, `subject_parse`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (100, 'Redis支持哪几种数据类型？', 1, NULL, 4, 1, '解析什么', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-02-28 03:20:08', NULL, NULL, 0);
INSERT INTO `subject_info` (`id`, `subject_name`, `subject_difficult`, `settle_name`, `subject_type`, `subject_score`, `subject_parse`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (101, 'Redis的高级数据类型有什么？', 2, NULL, 4, 1, '解析什么', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-02-28 03:20:08', NULL, NULL, 0);
INSERT INTO `subject_info` (`id`, `subject_name`, `subject_difficult`, `settle_name`, `subject_type`, `subject_score`, `subject_parse`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (102, 'Redis的优点有什么？', 1, NULL, 4, 1, '解析什么', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-02-28 03:20:08', NULL, NULL, 0);
INSERT INTO `subject_info` (`id`, `subject_name`, `subject_difficult`, `settle_name`, `subject_type`, `subject_score`, `subject_parse`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (103, 'Redis相比Memcached有哪些优势？', 1, NULL, 4, 1, '解析什么', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-02-28 03:20:08', NULL, NULL, 0);
INSERT INTO `subject_info` (`id`, `subject_name`, `subject_difficult`, `settle_name`, `subject_type`, `subject_score`, `subject_parse`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (104, 'Redis是单进程单线程的？', 1, NULL, 4, 1, '解析什么', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-02-28 03:20:08', NULL, NULL, 0);
INSERT INTO `subject_info` (`id`, `subject_name`, `subject_difficult`, `settle_name`, `subject_type`, `subject_score`, `subject_parse`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (105, '数据库和缓存的数据一致性如何保障，有哪些方案？', 2, NULL, 4, 1, '解析什么', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-02-28 03:20:08', NULL, NULL, 0);
INSERT INTO `subject_info` (`id`, `subject_name`, `subject_difficult`, `settle_name`, `subject_type`, `subject_score`, `subject_parse`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (106, 'redis过期策略都有哪些？', 1, NULL, 4, 1, '解析什么', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-02-28 03:20:08', NULL, NULL, 0);
INSERT INTO `subject_info` (`id`, `subject_name`, `subject_difficult`, `settle_name`, `subject_type`, `subject_score`, `subject_parse`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (107, '什么是缓存穿透？', 1, NULL, 4, 1, '解析什么', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-02-28 03:20:08', NULL, NULL, 0);
INSERT INTO `subject_info` (`id`, `subject_name`, `subject_difficult`, `settle_name`, `subject_type`, `subject_score`, `subject_parse`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (108, '什么是缓存击穿', 1, NULL, 4, 1, '解析什么', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-02-28 03:20:08', NULL, NULL, 0);
INSERT INTO `subject_info` (`id`, `subject_name`, `subject_difficult`, `settle_name`, `subject_type`, `subject_score`, `subject_parse`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (109, '什么是缓存雪崩', 1, NULL, 4, 1, '解析什么', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-02-28 03:20:08', NULL, NULL, 0);
INSERT INTO `subject_info` (`id`, `subject_name`, `subject_difficult`, `settle_name`, `subject_type`, `subject_score`, `subject_parse`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (110, 'redis的setnx和setex区别', 1, NULL, 4, 1, '解析什么', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-02-28 03:20:08', NULL, NULL, 0);
INSERT INTO `subject_info` (`id`, `subject_name`, `subject_difficult`, `settle_name`, `subject_type`, `subject_score`, `subject_parse`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (327, '缓存真的好用吗？', 1, NULL, 4, 2, '好用', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 13:32:21', NULL, NULL, 0);
INSERT INTO `subject_info` (`id`, `subject_name`, `subject_difficult`, `settle_name`, `subject_type`, `subject_score`, `subject_parse`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (328, 'Redis有几种基础数据类型？', 1, NULL, 1, 5, 'Redis总共有五种基础数据类型', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 13:38:28', NULL, NULL, 0);
INSERT INTO `subject_info` (`id`, `subject_name`, `subject_difficult`, `settle_name`, `subject_type`, `subject_score`, `subject_parse`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (329, 'Redis 是什么类型的数据库？', 1, NULL, 1, 5, 'Redis 是一种开源的内存中数据结构存储，作为键值存储数据库，它支持多种数据结构如字符串、哈希、列表、集合等。', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:04:36', NULL, NULL, 0);
INSERT INTO `subject_info` (`id`, `subject_name`, `subject_difficult`, `settle_name`, `subject_type`, `subject_score`, `subject_parse`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (330, '以下哪种数据结构不是 Redis 原生支持的？', 1, NULL, 1, 5, 'Redis 原生支持字符串、列表、集合、哈希和有序集合等数据结构，但不支持图结构。图形数据需要通过其他方式模拟。', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:05:58', NULL, NULL, 0);
INSERT INTO `subject_info` (`id`, `subject_name`, `subject_difficult`, `settle_name`, `subject_type`, `subject_score`, `subject_parse`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (331, 'Redis 中用于设置键过期时间的命令是？', 1, NULL, 1, 5, 'EXPIRE 命令用于为指定的键设置过期时间，以秒为单位。当键过期时，它将被自动删除。', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:07:06', NULL, NULL, 0);
INSERT INTO `subject_info` (`id`, `subject_name`, `subject_difficult`, `settle_name`, `subject_type`, `subject_score`, `subject_parse`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (332, '以下哪些是 Redis 支持的持久化机制？', 1, NULL, 2, 5, 'Redis 提供两种主要的持久化机制：AOF 和 RDB。AOF 是通过记录每个写操作来实现持久化，而 RDB 是通过定期生成数据快照来实现的。Snapshotting 其实是 RDB 的工作原理之一，D 选项不正确因为 Redis 确实有持久化选项。', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:12:01', NULL, NULL, 0);
INSERT INTO `subject_info` (`id`, `subject_name`, `subject_difficult`, `settle_name`, `subject_type`, `subject_score`, `subject_parse`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (333, '在 Redis 中，哪些命令可以用于从集合（Set）中随机获取元素？', 1, NULL, 2, 5, 'SRANDMEMBER 命令用于从集合中随机返回一个或多个元素，而 SPOP 命令则用于随机移除并返回一个元素。SINTER 用于求集合的交集，SMEMBERS 则用于返回集合中的所有成员。', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:13:13', NULL, NULL, 0);
INSERT INTO `subject_info` (`id`, `subject_name`, `subject_difficult`, `settle_name`, `subject_type`, `subject_score`, `subject_parse`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (334, '关于 Redis 缓存淘汰策略，以下哪些描述是正确的？', 1, NULL, 2, 5, 'volatile-lru 策略只对设置了过期时间的键进行 LRU 淘汰。allkeys-random 策略会随机淘汰任何键，无论是否设置了过期时间。volatile-ttl 策略实际上是优先淘汰剩余生存时间最短的键，而不是最长的。noeviction 策略在内存不足时不会淘汰任何键，而是返回错误。', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:14:19', NULL, NULL, 0);
INSERT INTO `subject_info` (`id`, `subject_name`, `subject_difficult`, `settle_name`, `subject_type`, `subject_score`, `subject_parse`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (335, 'Redis 支持事务操作，但不支持事务的回滚。', 1, NULL, 3, 5, 'Redis 支持事务操作，通过 MULTI 和 EXEC 命令来执行一组命令。但是，Redis 的事务不支持回滚机制。如果事务中的某个命令出错，其他命令仍会继续执行。Redis 的事务是“乐观锁”的一种实现，主要用于确保一组命令的原子性执行。', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:15:33', NULL, NULL, 0);
INSERT INTO `subject_info` (`id`, `subject_name`, `subject_difficult`, `settle_name`, `subject_type`, `subject_score`, `subject_parse`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (336, '在 Redis 中，所有数据都必须存储在内存中，即使使用持久化机制，数据也不会存储到磁盘。', 1, NULL, 3, 5, '虽然 Redis 是一个内存数据库，所有操作都在内存中进行以保证高速性能，但 Redis 提供了持久化机制（AOF 和 RDB），允许将数据存储到磁盘中。这种机制确保了即使在服务器重启后，数据也可以从磁盘恢复到内存。', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:16:01', NULL, NULL, 0);
INSERT INTO `subject_info` (`id`, `subject_name`, `subject_difficult`, `settle_name`, `subject_type`, `subject_score`, `subject_parse`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (337, 'Redis 的发布/订阅（Pub/Sub）模式可以用于消息队列的持久化存储。', 1, NULL, 3, 5, 'Redis 的发布/订阅（Pub/Sub）模式用于实时消息传递，并不支持消息的持久化存储。一旦消息发布，Redis 不会保留消息历史。因此，Pub/Sub 适合于实时通信场景，但不适合需要消息持久化的场景。如果需要持久化，可以考虑使用 Redis Stream 或其他消息队列系统。', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:16:16', NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for subject_judge
-- ----------------------------
DROP TABLE IF EXISTS `subject_judge`;
CREATE TABLE `subject_judge` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `subject_id` bigint(20) DEFAULT NULL COMMENT '题目id',
  `is_correct` tinyint(2) DEFAULT NULL COMMENT '是否正确',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='判断题';

-- ----------------------------
-- Records of subject_judge
-- ----------------------------
BEGIN;
INSERT INTO `subject_judge` (`id`, `subject_id`, `is_correct`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (1, 335, 1, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:15:33', NULL, NULL, 0);
INSERT INTO `subject_judge` (`id`, `subject_id`, `is_correct`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (2, 336, 0, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:16:01', NULL, NULL, 0);
INSERT INTO `subject_judge` (`id`, `subject_id`, `is_correct`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (3, 337, 0, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-11-28 14:16:16', NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for subject_label
-- ----------------------------
DROP TABLE IF EXISTS `subject_label`;
CREATE TABLE `subject_label` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `label_name` varchar(32) DEFAULT NULL COMMENT '标签分类',
  `sort_num` int(11) DEFAULT NULL COMMENT '排序',
  `category_id` varchar(50) DEFAULT NULL,
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8 COMMENT='题目标签表';

-- ----------------------------
-- Records of subject_label
-- ----------------------------
BEGIN;
INSERT INTO `subject_label` (`id`, `label_name`, `sort_num`, `category_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (1, 'Redis', 1, '1', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-02-28 03:21:27', NULL, NULL, 0);
INSERT INTO `subject_label` (`id`, `label_name`, `sort_num`, `category_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (44, '数据一致性', 1, '1', 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-02-28 03:21:27', NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for subject_liked
-- ----------------------------
DROP TABLE IF EXISTS `subject_liked`;
CREATE TABLE `subject_liked` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `subject_id` bigint(20) DEFAULT NULL COMMENT '题目id',
  `like_user_id` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '点赞人id',
  `status` int(11) DEFAULT NULL COMMENT '点赞状态 1点赞 0不点赞',
  `created_by` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '创建人',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `is_deleted` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_like` (`subject_id`,`like_user_id`) USING BTREE COMMENT '点赞唯一索引'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='题目点赞表';

-- ----------------------------
-- Records of subject_liked
-- ----------------------------
BEGIN;
INSERT INTO `subject_liked` (`id`, `subject_id`, `like_user_id`, `status`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (1, 100, 'oYA4Ht9BalkOl7Pb28EZ220SUagg', 1, NULL, NULL, NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for subject_mapping
-- ----------------------------
DROP TABLE IF EXISTS `subject_mapping`;
CREATE TABLE `subject_mapping` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `subject_id` bigint(20) DEFAULT NULL COMMENT '题目id',
  `category_id` bigint(20) DEFAULT NULL COMMENT '分类id',
  `label_id` bigint(20) DEFAULT NULL COMMENT '标签id',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `is_deleted` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=547 DEFAULT CHARSET=utf8 COMMENT='题目分类关系表';

-- ----------------------------
-- Records of subject_mapping
-- ----------------------------
BEGIN;
INSERT INTO `subject_mapping` (`id`, `subject_id`, `category_id`, `label_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (216, 100, 2, 1, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-02-28 03:21:35', NULL, NULL, 0);
INSERT INTO `subject_mapping` (`id`, `subject_id`, `category_id`, `label_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (217, 101, 2, 1, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-02-28 03:21:35', NULL, NULL, 0);
INSERT INTO `subject_mapping` (`id`, `subject_id`, `category_id`, `label_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (218, 102, 2, 1, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-02-28 03:21:35', NULL, NULL, 0);
INSERT INTO `subject_mapping` (`id`, `subject_id`, `category_id`, `label_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (219, 103, 2, 1, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-02-28 03:21:35', NULL, NULL, 0);
INSERT INTO `subject_mapping` (`id`, `subject_id`, `category_id`, `label_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (220, 104, 2, 1, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-02-28 03:21:35', NULL, NULL, 0);
INSERT INTO `subject_mapping` (`id`, `subject_id`, `category_id`, `label_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (221, 105, 2, 44, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-02-28 03:21:35', NULL, NULL, 0);
INSERT INTO `subject_mapping` (`id`, `subject_id`, `category_id`, `label_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (222, 105, 3, 44, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-02-28 03:21:35', NULL, NULL, 0);
INSERT INTO `subject_mapping` (`id`, `subject_id`, `category_id`, `label_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (223, 106, 2, 1, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-02-28 03:21:35', NULL, NULL, 0);
INSERT INTO `subject_mapping` (`id`, `subject_id`, `category_id`, `label_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (224, 107, 2, 1, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-02-28 03:21:35', NULL, NULL, 0);
INSERT INTO `subject_mapping` (`id`, `subject_id`, `category_id`, `label_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (225, 108, 2, 1, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-02-28 03:21:35', NULL, NULL, 0);
INSERT INTO `subject_mapping` (`id`, `subject_id`, `category_id`, `label_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (226, 109, 2, 1, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-02-28 03:21:35', NULL, NULL, 0);
INSERT INTO `subject_mapping` (`id`, `subject_id`, `category_id`, `label_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (227, 110, 2, 1, 'oYA4HtwGJEsLio6pGrhx5Hzv9XD0', '2024-02-28 03:21:35', NULL, NULL, 0);
INSERT INTO `subject_mapping` (`id`, `subject_id`, `category_id`, `label_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (536, 327, 2, 1, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_mapping` (`id`, `subject_id`, `category_id`, `label_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (537, 328, 2, 1, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_mapping` (`id`, `subject_id`, `category_id`, `label_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (538, 329, 2, 1, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_mapping` (`id`, `subject_id`, `category_id`, `label_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (539, 330, 2, 1, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_mapping` (`id`, `subject_id`, `category_id`, `label_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (540, 331, 2, 1, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_mapping` (`id`, `subject_id`, `category_id`, `label_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (541, 332, 2, 1, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_mapping` (`id`, `subject_id`, `category_id`, `label_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (542, 333, 2, 1, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_mapping` (`id`, `subject_id`, `category_id`, `label_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (543, 334, 2, 1, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_mapping` (`id`, `subject_id`, `category_id`, `label_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (544, 335, 2, 1, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_mapping` (`id`, `subject_id`, `category_id`, `label_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (545, 336, 2, 1, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_mapping` (`id`, `subject_id`, `category_id`, `label_id`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (546, 337, 2, 1, NULL, NULL, NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for subject_multiple
-- ----------------------------
DROP TABLE IF EXISTS `subject_multiple`;
CREATE TABLE `subject_multiple` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `subject_id` bigint(20) DEFAULT NULL COMMENT '题目id',
  `option_type` bigint(4) DEFAULT NULL COMMENT '选项类型',
  `option_content` varchar(64) DEFAULT NULL COMMENT '选项内容',
  `is_correct` tinyint(2) DEFAULT NULL COMMENT '是否正确',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='多选题信息表';

-- ----------------------------
-- Records of subject_multiple
-- ----------------------------
BEGIN;
INSERT INTO `subject_multiple` (`id`, `subject_id`, `option_type`, `option_content`, `is_correct`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (1, 332, 1, 'AOF（Append Only File）', 1, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_multiple` (`id`, `subject_id`, `option_type`, `option_content`, `is_correct`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (2, 332, 2, 'RDB（Redis Database）', 1, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_multiple` (`id`, `subject_id`, `option_type`, `option_content`, `is_correct`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (3, 332, 3, 'Snapshotting', 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_multiple` (`id`, `subject_id`, `option_type`, `option_content`, `is_correct`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (4, 332, 4, 'None of the above', 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_multiple` (`id`, `subject_id`, `option_type`, `option_content`, `is_correct`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (5, 333, 1, 'SRANDMEMBER', 1, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_multiple` (`id`, `subject_id`, `option_type`, `option_content`, `is_correct`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (6, 333, 2, 'SPOP', 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_multiple` (`id`, `subject_id`, `option_type`, `option_content`, `is_correct`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (7, 333, 3, 'SINTER', 1, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_multiple` (`id`, `subject_id`, `option_type`, `option_content`, `is_correct`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (8, 333, 4, 'SMEMBERS', 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_multiple` (`id`, `subject_id`, `option_type`, `option_content`, `is_correct`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (9, 334, 1, 'volatile-lru 只对设置了过期时间的键进行 LRU 淘汰', 1, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_multiple` (`id`, `subject_id`, `option_type`, `option_content`, `is_correct`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (10, 334, 2, 'allkeys-random 随机淘汰任何键，无论是否设置过期时间', 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_multiple` (`id`, `subject_id`, `option_type`, `option_content`, `is_correct`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (11, 334, 3, 'volatile-ttl 优先淘汰剩余生存时间最长的键', 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_multiple` (`id`, `subject_id`, `option_type`, `option_content`, `is_correct`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (12, 334, 4, 'noeviction 不会淘汰任何键，当内存不足时会返回错误', 1, NULL, NULL, NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for subject_radio
-- ----------------------------
DROP TABLE IF EXISTS `subject_radio`;
CREATE TABLE `subject_radio` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `subject_id` bigint(20) DEFAULT NULL COMMENT '题目id',
  `option_type` tinyint(4) DEFAULT NULL COMMENT 'a,b,c,d',
  `option_content` varchar(128) DEFAULT NULL COMMENT '选项内容',
  `is_correct` tinyint(2) DEFAULT NULL COMMENT '是否正确',
  `created_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `created_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `is_deleted` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='单选题信息表';

-- ----------------------------
-- Records of subject_radio
-- ----------------------------
BEGIN;
INSERT INTO `subject_radio` (`id`, `subject_id`, `option_type`, `option_content`, `is_correct`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (1, 328, 1, '5', 1, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_radio` (`id`, `subject_id`, `option_type`, `option_content`, `is_correct`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (2, 328, 2, '4', 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_radio` (`id`, `subject_id`, `option_type`, `option_content`, `is_correct`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (3, 328, 3, '3', 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_radio` (`id`, `subject_id`, `option_type`, `option_content`, `is_correct`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (4, 329, 1, '关系型数据库', 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_radio` (`id`, `subject_id`, `option_type`, `option_content`, `is_correct`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (5, 329, 2, '文档型数据库', 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_radio` (`id`, `subject_id`, `option_type`, `option_content`, `is_correct`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (6, 329, 3, '键值（Key-Value）存储数据库', 1, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_radio` (`id`, `subject_id`, `option_type`, `option_content`, `is_correct`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (7, 329, 4, '图数据库', 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_radio` (`id`, `subject_id`, `option_type`, `option_content`, `is_correct`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (8, 330, 1, '字符串（String）', 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_radio` (`id`, `subject_id`, `option_type`, `option_content`, `is_correct`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (9, 330, 2, '列表（List）', 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_radio` (`id`, `subject_id`, `option_type`, `option_content`, `is_correct`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (10, 330, 3, '集合（Set）', 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_radio` (`id`, `subject_id`, `option_type`, `option_content`, `is_correct`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (11, 330, 4, '图（Graph）', 1, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_radio` (`id`, `subject_id`, `option_type`, `option_content`, `is_correct`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (12, 331, 1, 'SET', 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_radio` (`id`, `subject_id`, `option_type`, `option_content`, `is_correct`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (13, 331, 2, 'EXPIRE', 1, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_radio` (`id`, `subject_id`, `option_type`, `option_content`, `is_correct`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (14, 331, 3, 'TTL', 0, NULL, NULL, NULL, NULL, 0);
INSERT INTO `subject_radio` (`id`, `subject_id`, `option_type`, `option_content`, `is_correct`, `created_by`, `created_time`, `update_by`, `update_time`, `is_deleted`) VALUES (15, 331, 4, 'PERSIST', 0, NULL, NULL, NULL, NULL, 0);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
