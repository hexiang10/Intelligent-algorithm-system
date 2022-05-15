/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80028
 Source Host           : localhost:3306
 Source Schema         : db_ai_system

 Target Server Type    : MySQL
 Target Server Version : 80028
 File Encoding         : 65001

 Date: 01/05/2022 01:08:51
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ai_pwd
-- ----------------------------
DROP TABLE IF EXISTS `ai_pwd`;
CREATE TABLE `ai_pwd`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '原文',
  `key_word` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'key键',
  `ciphertext` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '密文',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` int NULL DEFAULT 0 COMMENT '删除标志',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `user_id` int NULL DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '测试单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ai_pwd
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (1, 'test_demo', '测试单表', NULL, NULL, 'TestDemo', 'crud', 'com.ruoyi.ai', 'ai', 'obj', '识图辨物', '何翔', '0', '/', '{\"treeCode\":null,\"treeName\":null,\"treeParentCode\":null,\"parentMenuId\":\"2000\"}', 'admin', '2022-04-26 15:06:37', 'admin', '2022-04-27 00:21:01', NULL);
INSERT INTO `gen_table` VALUES (3, 'ai_pwd', '密码管理', NULL, NULL, 'AiPwd', 'crud', 'com.ruoyi.ai.pwd', 'ai', 'pwd', '密码管理', '何翔', '0', '/', '{\"treeCode\":null,\"treeName\":null,\"treeParentCode\":null,\"parentMenuId\":\"2003\"}', 'admin', '2022-04-30 17:16:24', 'admin', '2022-04-30 18:06:33', NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (1, '1', 'id', '主键', 'int', 'Long', 'id', '1', '1', '1', NULL, '1', '1', NULL, 'EQ', 'input', '', 1, 'admin', '2022-04-26 21:13:05', 'admin', '2022-04-27 00:21:01');
INSERT INTO `gen_table_column` VALUES (2, '1', 'dept_id', '部门id', 'int', 'Long', 'deptId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2022-04-26 21:13:05', 'admin', '2022-04-27 00:21:01');
INSERT INTO `gen_table_column` VALUES (3, '1', 'user_id', '用户id', 'int', 'Long', 'userId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2022-04-26 21:13:05', 'admin', '2022-04-27 00:21:01');
INSERT INTO `gen_table_column` VALUES (4, '1', 'order_num', '排序号', 'int', 'Long', 'orderNum', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2022-04-26 21:13:05', 'admin', '2022-04-27 00:21:01');
INSERT INTO `gen_table_column` VALUES (5, '1', 'test_key', 'key键', 'varchar(255)', 'String', 'testKey', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2022-04-26 21:13:05', 'admin', '2022-04-27 00:21:01');
INSERT INTO `gen_table_column` VALUES (6, '1', 'value', '值', 'varchar(255)', 'String', 'value', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2022-04-26 21:13:05', 'admin', '2022-04-27 00:21:01');
INSERT INTO `gen_table_column` VALUES (7, '1', 'version', '版本', 'int', 'Long', 'version', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'input', '', 7, 'admin', '2022-04-26 21:13:05', 'admin', '2022-04-27 00:21:01');
INSERT INTO `gen_table_column` VALUES (8, '1', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 8, 'admin', '2022-04-26 21:13:05', 'admin', '2022-04-27 00:21:01');
INSERT INTO `gen_table_column` VALUES (9, '1', 'create_by', '创建人', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2022-04-26 21:13:05', 'admin', '2022-04-27 00:21:01');
INSERT INTO `gen_table_column` VALUES (10, '1', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 10, 'admin', '2022-04-26 21:13:05', 'admin', '2022-04-27 00:21:01');
INSERT INTO `gen_table_column` VALUES (11, '1', 'update_by', '更新人', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'input', '', 11, 'admin', '2022-04-26 21:13:05', 'admin', '2022-04-27 00:21:01');
INSERT INTO `gen_table_column` VALUES (12, '1', 'del_flag', '删除标志', 'int', 'Long', 'delFlag', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'input', '', 12, 'admin', '2022-04-26 21:13:05', 'admin', '2022-04-27 00:21:01');
INSERT INTO `gen_table_column` VALUES (24, '3', 'id', '主键', 'int', 'Long', 'id', '1', '1', '1', NULL, '1', '1', NULL, 'EQ', 'input', '', 1, 'admin', '2022-04-30 17:19:32', 'admin', '2022-04-30 18:06:33');
INSERT INTO `gen_table_column` VALUES (25, '3', 'text', '原文', 'varchar(255)', 'String', 'text', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'textarea', '', 2, 'admin', '2022-04-30 17:19:32', 'admin', '2022-04-30 18:06:33');
INSERT INTO `gen_table_column` VALUES (28, '3', 'remark', '备注', 'varchar(255)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'textarea', '', 5, 'admin', '2022-04-30 17:19:32', 'admin', '2022-04-30 18:06:33');
INSERT INTO `gen_table_column` VALUES (29, '3', 'del_flag', '删除标志', 'int', 'Long', 'delFlag', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'input', 'sys_normal_disable', 6, 'admin', '2022-04-30 17:19:32', 'admin', '2022-04-30 18:06:33');
INSERT INTO `gen_table_column` VALUES (30, '3', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, NULL, NULL, '1', '1', 'EQ', 'datetime', '', 7, 'admin', '2022-04-30 17:19:32', 'admin', '2022-04-30 18:06:33');
INSERT INTO `gen_table_column` VALUES (31, '3', 'create_by', '创建人', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'input', '', 8, 'admin', '2022-04-30 17:19:32', 'admin', '2022-04-30 18:06:33');
INSERT INTO `gen_table_column` VALUES (32, '3', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 9, 'admin', '2022-04-30 17:19:32', 'admin', '2022-04-30 18:06:33');
INSERT INTO `gen_table_column` VALUES (33, '3', 'update_by', '更新人', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'input', '', 10, 'admin', '2022-04-30 17:19:32', 'admin', '2022-04-30 18:06:33');
INSERT INTO `gen_table_column` VALUES (34, '3', 'user_id', '用户id', 'int', 'Long', 'userId', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'input', '', 11, 'admin', '2022-04-30 17:19:32', 'admin', '2022-04-30 18:06:33');
INSERT INTO `gen_table_column` VALUES (35, '3', 'key_word', 'key键', 'varchar(255)', 'String', 'keyWord', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2022-04-30 18:02:06', 'admin', '2022-04-30 18:06:33');
INSERT INTO `gen_table_column` VALUES (36, '3', 'ciphertext', '密文', 'varchar(255)', 'String', 'ciphertext', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'textarea', '', 4, 'admin', '2022-04-30 18:02:06', 'admin', '2022-04-30 18:06:33');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '参数配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2022-04-21 19:29:57', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2022-04-21 19:29:57', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2022-04-21 19:29:57', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaOnOff', 'true', 'Y', 'admin', '2022-04-21 19:29:57', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2022-04-21 19:29:57', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (11, 'OSS预览列表资源开关', 'sys.oss.previewListResource', 'true', 'Y', 'admin', '2022-04-21 19:29:57', '', NULL, 'true:开启, false:关闭');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-04-21 19:29:57', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-04-21 19:29:57', '', NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-04-21 19:29:57', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-04-21 19:29:57', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-04-21 19:29:57', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-04-21 19:29:57', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-04-21 19:29:57', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-04-21 19:29:57', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-04-21 19:29:57', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-04-21 19:29:57', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2022-04-21 19:29:57', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2022-04-21 19:29:57', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2022-04-21 19:29:57', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2022-04-21 19:29:57', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2022-04-21 19:29:57', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2022-04-21 19:29:57', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2022-04-21 19:29:57', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2022-04-21 19:29:57', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2022-04-21 19:29:57', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2022-04-21 19:29:57', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2022-04-21 19:29:57', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2022-04-21 19:29:57', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2022-04-21 19:29:57', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-04-21 19:29:57', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (19, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-04-21 19:29:57', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (20, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-04-21 19:29:57', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (21, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2022-04-21 19:29:57', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (22, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-04-21 19:29:57', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (23, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-04-21 19:29:57', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (24, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-04-21 19:29:57', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (25, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-04-21 19:29:57', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (26, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-04-21 19:29:57', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (27, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2022-04-21 19:29:57', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (28, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2022-04-21 19:29:57', '', NULL, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2022-04-21 19:29:57', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2022-04-21 19:29:57', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2022-04-21 19:29:57', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2022-04-21 19:29:57', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2022-04-21 19:29:57', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2022-04-21 19:29:57', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2022-04-21 19:29:57', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2022-04-21 19:29:57', '', NULL, '登录状态列表');

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime(0) NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 114 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统访问记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2022-04-26 15:16:02');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2022-04-26 16:33:30');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2022-04-26 17:57:47');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2022-04-26 20:42:50');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2022-04-27 00:12:11');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2022-04-27 22:46:05');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2022-04-28 00:32:56');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '1', '验证码错误', '2022-04-28 23:44:59');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2022-04-28 23:45:03');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2022-04-29 12:23:51');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2022-04-29 14:26:16');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2022-04-29 14:39:21');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2022-04-29 15:16:43');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2022-04-30 17:03:27');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2022-04-30 17:39:59');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2022-04-30 17:45:43');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2022-04-30 19:59:31');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2022-04-30 23:59:09');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '路由参数',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2007 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2022-04-21 19:29:57', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2022-04-21 19:29:57', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2022-04-21 19:29:57', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '我的主页', 0, 4, 'https://github.com/He-Xiang-best', NULL, '', 0, 0, 'M', '1', '1', '', 'guide', 'admin', '2022-04-21 19:29:57', 'admin', '2022-05-01 00:11:43', 'RuoYi-Vue-Plus官网地址');
INSERT INTO `sys_menu` VALUES (5, '测试菜单', 0, 5, 'demo', NULL, NULL, 1, 0, 'M', '1', '1', NULL, 'star', 'admin', '2021-05-30 00:34:26', 'admin', '2022-04-28 23:49:35', '');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2022-04-21 19:29:57', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2022-04-21 19:29:57', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2022-04-21 19:29:57', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2022-04-21 19:29:57', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2022-04-21 19:29:57', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2022-04-21 19:29:57', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2022-04-21 19:29:57', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2022-04-21 19:29:57', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2022-04-21 19:29:57', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2022-04-21 19:29:57', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2022-04-21 19:29:57', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2022-04-21 19:29:57', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '表单构建', 3, 1, 'build', 'tool/build/index', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2022-04-21 19:29:57', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (115, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2022-04-21 19:29:57', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (116, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2022-04-21 19:29:57', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (117, 'Admin监控', 2, 5, 'Admin', 'monitor/admin/index', '', 1, 0, 'C', '0', '0', 'monitor:admin:list', 'dashboard', 'admin', '2022-04-21 19:29:57', '', NULL, 'Admin监控菜单');
INSERT INTO `sys_menu` VALUES (118, '文件管理', 1, 10, 'oss', 'system/oss/index', '', 1, 0, 'C', '0', '0', 'system:oss:list', 'upload', 'admin', '2022-04-21 19:29:57', '', NULL, '文件管理菜单');
INSERT INTO `sys_menu` VALUES (120, '任务调度中心', 2, 5, 'XxlJob', 'monitor/xxljob/index', '', 1, 0, 'C', '0', '0', 'monitor:xxljob:list', 'job', 'admin', '2022-04-21 19:29:57', '', NULL, 'Xxl-Job控制台菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2022-04-21 19:29:57', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2022-04-21 19:29:57', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1001, '用户查询', 100, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户新增', 100, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户修改', 100, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户删除', 100, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导出', 100, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '用户导入', 100, 6, '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '重置密码', 100, 7, '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色查询', 101, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色新增', 101, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色修改', 101, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色删除', 101, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '角色导出', 101, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单查询', 102, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单新增', 102, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单修改', 102, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '菜单删除', 102, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门查询', 103, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门新增', 103, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门修改', 103, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '部门删除', 103, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位查询', 104, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位新增', 104, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位修改', 104, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位删除', 104, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '岗位导出', 104, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典查询', 105, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典新增', 105, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典修改', 105, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典删除', 105, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '字典导出', 105, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数查询', 106, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数新增', 106, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数修改', 106, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数删除', 106, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '参数导出', 106, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告查询', 107, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告新增', 107, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告修改', 107, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '公告删除', 107, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作查询', 500, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '操作删除', 500, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '日志导出', 500, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录查询', 501, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '登录删除', 501, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '日志导出', 501, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 115, 1, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 115, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 115, 3, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 115, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 115, 4, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 115, 5, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1500, '测试单表', 5, 1, 'demo', 'demo/demo/index', NULL, 1, 0, 'C', '0', '0', 'demo:demo:list', '#', 'admin', '2021-05-30 00:39:23', '', NULL, '测试单表菜单');
INSERT INTO `sys_menu` VALUES (1501, '测试单表查询', 1500, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:demo:query', '#', 'admin', '2021-05-30 00:39:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1502, '测试单表新增', 1500, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:demo:add', '#', 'admin', '2021-05-30 00:39:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1503, '测试单表修改', 1500, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:demo:edit', '#', 'admin', '2021-05-30 00:39:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1504, '测试单表删除', 1500, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:demo:remove', '#', 'admin', '2021-05-30 00:39:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1505, '测试单表导出', 1500, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:demo:export', '#', 'admin', '2021-05-30 00:39:23', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1506, '测试树表', 5, 1, 'tree', 'demo/tree/index', NULL, 1, 0, 'C', '0', '0', 'demo:tree:list', '#', 'admin', '2021-05-30 00:39:30', '', NULL, '测试树表菜单');
INSERT INTO `sys_menu` VALUES (1507, '测试树表查询', 1506, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:tree:query', '#', 'admin', '2021-05-30 00:39:30', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1508, '测试树表新增', 1506, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:tree:add', '#', 'admin', '2021-05-30 00:39:30', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1509, '测试树表修改', 1506, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:tree:edit', '#', 'admin', '2021-05-30 00:39:30', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1510, '测试树表删除', 1506, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:tree:remove', '#', 'admin', '2021-05-30 00:39:30', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1511, '测试树表导出', 1506, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'demo:tree:export', '#', 'admin', '2021-05-30 00:39:30', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1600, '文件查询', 118, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:oss:query', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1601, '文件上传', 118, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:oss:upload', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1602, '文件下载', 118, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:oss:download', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1603, '文件删除', 118, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:oss:remove', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1604, '配置添加', 118, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:oss:add', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1605, '配置编辑', 118, 6, '#', '', '', 1, 0, 'F', '0', '0', 'system:oss:edit', '#', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '人脸识别', 0, 5, 'face', NULL, NULL, 1, 0, 'M', '0', '0', NULL, 'eye-open', 'admin', '2022-04-26 16:35:21', 'admin', '2022-04-28 23:55:57', '');
INSERT INTO `sys_menu` VALUES (2002, '识图辨物', 2000, 1, 'obj', 'ai/obj/index', NULL, 1, 0, 'C', '0', '0', 'ai:obj:list', 'eye', 'admin', '2022-04-27 00:26:16', 'admin', '2022-04-27 00:30:17', '识图辨物菜单');
INSERT INTO `sys_menu` VALUES (2003, '密码算法接口', 0, 5, 'pwd', NULL, NULL, 1, 0, 'M', '0', '0', NULL, 'password', 'admin', '2022-04-28 23:47:44', 'admin', '2022-04-29 13:58:09', '');
INSERT INTO `sys_menu` VALUES (2004, 'Base64', 2003, 5, 'base64', 'ai/pwd/base64.vue', NULL, 1, 0, 'C', '0', '0', NULL, 'lock', 'admin', '2022-04-28 23:52:01', 'admin', '2022-05-01 00:33:01', '');
INSERT INTO `sys_menu` VALUES (2005, 'DES加解密', 2003, 8, 'des', 'ai/pwd/des.vue', NULL, 1, 0, 'C', '0', '0', NULL, 'lock', 'admin', '2022-04-29 13:41:03', 'admin', '2022-05-01 00:32:03', '');
INSERT INTO `sys_menu` VALUES (2006, 'AES加解密', 2003, 3, 'aes', 'ai/pwd/aes.vue', NULL, 1, 0, 'C', '0', '0', NULL, 'lock', 'admin', '2022-04-29 14:11:54', 'admin', '2022-04-30 21:49:33', '');
INSERT INTO `sys_menu` VALUES (2019, '密码管理中心', 2003, 0, 'pwd', 'ai/pwd/index.vue', NULL, 1, 0, 'C', '0', '0', 'ai:pwd:list', 'tool', 'admin', '2022-04-30 18:08:37', 'admin', '2022-04-30 22:20:11', '密码管理菜单');
INSERT INTO `sys_menu` VALUES (2020, '密码管理查询', 2019, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'ai:pwd:query', '#', 'admin', '2022-04-30 18:08:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2021, '密码管理新增', 2019, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'ai:pwd:add', '#', 'admin', '2022-04-30 18:08:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2022, '密码管理修改', 2019, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'ai:pwd:edit', '#', 'admin', '2022-04-30 18:08:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2023, '密码管理删除', 2019, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'ai:pwd:remove', '#', 'admin', '2022-04-30 18:08:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2024, '密码管理导出', 2019, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'ai:pwd:export', '#', 'admin', '2022-04-30 18:08:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2025, 'MD5 | SHA', 2003, 1, 'sha', 'ai/pwd/sha.vue', NULL, 1, 0, 'C', '0', '0', NULL, 'lock', 'admin', '2022-04-30 18:48:27', 'admin', '2022-05-01 00:31:33', '');
INSERT INTO `sys_menu` VALUES (2026, 'HMAC加密', 2003, 1, 'hmac', 'ai/pwd/hmac.vue', NULL, 1, 0, 'C', '0', '0', NULL, 'lock', 'admin', '2022-04-30 22:21:36', 'admin', '2022-05-01 00:34:02', '');
INSERT INTO `sys_menu` VALUES (2027, 'RC4加解密', 2003, 3, 'rc4', 'ai/pwd/rc4.vue', NULL, 1, 0, 'C', '0', '0', NULL, 'lock', 'admin', '2022-04-30 22:44:18', 'admin', '2022-05-01 00:31:48', '');
INSERT INTO `sys_menu` VALUES (2028, 'TripleDES', 2003, 7, 'tripleDES', 'ai/pwd/tripleDES.vue', NULL, 1, 0, 'C', '0', '0', NULL, 'lock', 'admin', '2022-05-01 00:01:41', 'admin', '2022-05-01 00:32:27', '');
INSERT INTO `sys_menu` VALUES (2029, 'Rabbit加解密', 2003, 4, 'rabbit', 'ai/pwd/rabbit.vue', NULL, 1, 0, 'C', '0', '0', NULL, 'lock', 'admin', '2022-05-01 00:18:27', 'admin', '2022-05-01 00:34:36', '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '通知公告表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2022-04-21 19:29:57', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2022-04-21 19:29:57', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime(0) NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`oper_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 127 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-21 19:29:57\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-26 15:34:05\",\"params\":{},\"parentName\":null,\"parentId\":0,\"children\":[],\"menuId\":4,\"menuName\":\"PLUS官网\",\"orderNum\":\"4\",\"path\":\"https://github.com/He-Xiang-best\",\"component\":null,\"query\":\"\",\"isFrame\":\"0\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"\",\"icon\":\"guide\",\"remark\":\"RuoYi-Vue-Plus官网地址\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-26 15:34:05');
INSERT INTO `sys_oper_log` VALUES (101, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-21 19:29:57\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-26 15:34:26\",\"params\":{},\"parentName\":null,\"parentId\":0,\"children\":[],\"menuId\":4,\"menuName\":\"我的主页\",\"orderNum\":\"4\",\"path\":\"https://github.com/He-Xiang-best\",\"component\":null,\"query\":\"\",\"isFrame\":\"0\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"\",\"icon\":\"guide\",\"remark\":\"RuoYi-Vue-Plus官网地址\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-26 15:34:27');
INSERT INTO `sys_oper_log` VALUES (102, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-26 16:35:21\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-26 16:35:21\",\"params\":{},\"parentName\":null,\"parentId\":0,\"children\":[],\"menuId\":2000,\"menuName\":\"人脸识别\",\"orderNum\":\"5\",\"path\":\"face\",\"component\":null,\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"eye-open\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-26 16:35:21');
INSERT INTO `sys_oper_log` VALUES (103, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-26 21:02:08\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-26 21:02:08\",\"params\":{},\"parentName\":null,\"parentId\":2000,\"children\":[],\"menuId\":2001,\"menuName\":\"识图辨物\",\"orderNum\":\"1\",\"path\":\"face\",\"component\":\"ai-face/qr-boj/index\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-26 21:02:09');
INSERT INTO `sys_oper_log` VALUES (104, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-26 16:35:21\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-26 21:03:12\",\"params\":{},\"parentName\":null,\"parentId\":0,\"children\":[],\"menuId\":2000,\"menuName\":\"人脸识别\",\"orderNum\":\"5\",\"path\":\"ai-face\",\"component\":null,\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"eye-open\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-26 21:03:13');
INSERT INTO `sys_oper_log` VALUES (105, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-26 21:02:09\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-26 21:05:43\",\"params\":{},\"parentName\":null,\"parentId\":2000,\"children\":[],\"menuId\":2001,\"menuName\":\"识图辨物\",\"orderNum\":\"1\",\"path\":\"ai-face\",\"component\":\"ai-face/qr-boj/index\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"#\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-26 21:05:44');
INSERT INTO `sys_oper_log` VALUES (106, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '', '/ai/system/menu/2001', '0:0:0:0:0:0:0:1', '内网IP', '{menuId=2001}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-26 21:12:28');
INSERT INTO `sys_oper_log` VALUES (107, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '', '/ai/tool/gen/importTable', '0:0:0:0:0:0:0:1', '内网IP', '\"test_demo\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-26 21:13:05');
INSERT INTO `sys_oper_log` VALUES (108, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '', '/ai/tool/gen', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":\"admin\",\"updateTime\":\"2022-04-27 00:18:36\",\"params\":{\"treeCode\":null,\"treeName\":null,\"treeParentCode\":null,\"parentMenuId\":2000},\"tableId\":1,\"tableName\":\"test_demo\",\"tableComment\":\"测试单表\",\"subTableName\":null,\"subTableFkName\":null,\"className\":\"TestDemo\",\"tplCategory\":\"crud\",\"packageName\":\"com.ruoyi.ai\",\"moduleName\":\"ai\",\"businessName\":\"ai\",\"functionName\":\"智能识别\",\"functionAuthor\":\"何翔\",\"genType\":\"0\",\"genPath\":\"/\",\"pkColumn\":null,\"subTable\":null,\"columns\":[{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-26 21:13:05\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-27 00:18:36\",\"params\":{},\"columnId\":1,\"tableId\":1,\"columnName\":\"id\",\"columnComment\":\"主键\",\"columnType\":\"int\",\"javaType\":\"Long\",\"javaField\":\"id\",\"isPk\":\"1\",\"isIncrement\":\"1\",\"isRequired\":\"1\",\"isInsert\":null,\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":null,\"queryType\":\"EQ\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":1,\"required\":true,\"list\":true,\"query\":false,\"edit\":true,\"usableColumn\":false,\"insert\":false,\"capJavaField\":\"id\",\"increment\":true,\"pk\":true,\"superColumn\":false},{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-26 21:13:05\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-27 00:18:36\",\"params\":{},\"columnId\":2,\"tableId\":1,\"columnName\":\"dept_id\",\"columnComment\":\"部门id\",\"columnType\":\"int\",\"javaType\":\"Long\",\"javaField\":\"deptId\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"queryType\":\"EQ\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":2,\"required\":true,\"list\":true,\"query\":true,\"edit\":true,\"usableColumn\":false,\"insert\":true,\"capJavaField\":\"deptId\",\"increment\":false,\"pk\":false,\"superColumn\":false},{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-26 21:13:05\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-27 00:18:36\",\"params\":{},\"columnId\":3,\"tableId\":1,\"columnName\":\"user_id\",\"columnComment\":\"用户id\",\"columnType\":\"int\",\"javaType\":\"Long\",\"javaField\":\"userId\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-27 00:18:37');
INSERT INTO `sys_oper_log` VALUES (109, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '', '/ai/tool/gen', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":\"admin\",\"updateTime\":\"2022-04-27 00:19:12\",\"params\":{\"treeCode\":null,\"treeName\":null,\"treeParentCode\":null,\"parentMenuId\":\"2000\"},\"tableId\":1,\"tableName\":\"test_demo\",\"tableComment\":\"测试单表\",\"subTableName\":null,\"subTableFkName\":null,\"className\":\"TestDemo\",\"tplCategory\":\"crud\",\"packageName\":\"com.ruoyi.ai\",\"moduleName\":\"ai\",\"businessName\":\"ai\",\"functionName\":\"智能识别\",\"functionAuthor\":\"何翔\",\"genType\":\"0\",\"genPath\":\"/\",\"pkColumn\":null,\"subTable\":null,\"columns\":[{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-26 21:13:05\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-27 00:19:12\",\"params\":{},\"columnId\":1,\"tableId\":1,\"columnName\":\"id\",\"columnComment\":\"主键\",\"columnType\":\"int\",\"javaType\":\"Long\",\"javaField\":\"id\",\"isPk\":\"1\",\"isIncrement\":\"1\",\"isRequired\":\"1\",\"isInsert\":null,\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":null,\"queryType\":\"EQ\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":1,\"required\":true,\"list\":true,\"query\":false,\"edit\":true,\"usableColumn\":false,\"insert\":false,\"capJavaField\":\"id\",\"increment\":true,\"pk\":true,\"superColumn\":false},{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-26 21:13:05\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-27 00:19:12\",\"params\":{},\"columnId\":2,\"tableId\":1,\"columnName\":\"dept_id\",\"columnComment\":\"部门id\",\"columnType\":\"int\",\"javaType\":\"Long\",\"javaField\":\"deptId\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"queryType\":\"EQ\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":2,\"required\":true,\"list\":true,\"query\":true,\"edit\":true,\"usableColumn\":false,\"insert\":true,\"capJavaField\":\"deptId\",\"increment\":false,\"pk\":false,\"superColumn\":false},{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-26 21:13:05\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-27 00:19:12\",\"params\":{},\"columnId\":3,\"tableId\":1,\"columnName\":\"user_id\",\"columnComment\":\"用户id\",\"columnType\":\"int\",\"javaType\":\"Long\",\"javaField\":\"userId\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-27 00:19:13');
INSERT INTO `sys_oper_log` VALUES (110, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '', '/ai/tool/gen', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":\"admin\",\"updateTime\":\"2022-04-27 00:21:01\",\"params\":{\"treeCode\":null,\"treeName\":null,\"treeParentCode\":null,\"parentMenuId\":\"2000\"},\"tableId\":1,\"tableName\":\"test_demo\",\"tableComment\":\"测试单表\",\"subTableName\":null,\"subTableFkName\":null,\"className\":\"TestDemo\",\"tplCategory\":\"crud\",\"packageName\":\"com.ruoyi.ai\",\"moduleName\":\"ai\",\"businessName\":\"obj\",\"functionName\":\"识图辨物\",\"functionAuthor\":\"何翔\",\"genType\":\"0\",\"genPath\":\"/\",\"pkColumn\":null,\"subTable\":null,\"columns\":[{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-26 21:13:05\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-27 00:21:01\",\"params\":{},\"columnId\":1,\"tableId\":1,\"columnName\":\"id\",\"columnComment\":\"主键\",\"columnType\":\"int\",\"javaType\":\"Long\",\"javaField\":\"id\",\"isPk\":\"1\",\"isIncrement\":\"1\",\"isRequired\":\"1\",\"isInsert\":null,\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":null,\"queryType\":\"EQ\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":1,\"required\":true,\"list\":true,\"query\":false,\"edit\":true,\"usableColumn\":false,\"insert\":false,\"capJavaField\":\"id\",\"increment\":true,\"pk\":true,\"superColumn\":false},{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-26 21:13:05\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-27 00:21:01\",\"params\":{},\"columnId\":2,\"tableId\":1,\"columnName\":\"dept_id\",\"columnComment\":\"部门id\",\"columnType\":\"int\",\"javaType\":\"Long\",\"javaField\":\"deptId\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"queryType\":\"EQ\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":2,\"required\":true,\"list\":true,\"query\":true,\"edit\":true,\"usableColumn\":false,\"insert\":true,\"capJavaField\":\"deptId\",\"increment\":false,\"pk\":false,\"superColumn\":false},{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-26 21:13:05\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-27 00:21:01\",\"params\":{},\"columnId\":3,\"tableId\":1,\"columnName\":\"user_id\",\"columnComment\":\"用户id\",\"columnType\":\"int\",\"javaType\":\"Long\",\"javaField\":\"userId\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-27 00:21:01');
INSERT INTO `sys_oper_log` VALUES (111, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '', '/ai/tool/gen/batchGenCode', '0:0:0:0:0:0:0:1', '内网IP', '{}', '', 0, '', '2022-04-27 00:22:43');
INSERT INTO `sys_oper_log` VALUES (112, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-27 00:26:16\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-27 00:30:16\",\"params\":{},\"parentName\":null,\"parentId\":2000,\"children\":[],\"menuId\":2002,\"menuName\":\"识图辨物\",\"orderNum\":\"1\",\"path\":\"obj\",\"component\":\"ai/obj/index\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"ai:obj:list\",\"icon\":\"eye\",\"remark\":\"识图辨物菜单\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-27 00:30:17');
INSERT INTO `sys_oper_log` VALUES (113, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-28 23:47:44\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-28 23:47:44\",\"params\":{},\"parentName\":null,\"parentId\":0,\"children\":[],\"menuId\":2003,\"menuName\":\"加解密器\",\"orderNum\":\"4\",\"path\":\"pwd\",\"component\":null,\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"password\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-28 23:47:44');
INSERT INTO `sys_oper_log` VALUES (114, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-26 16:35:21\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-28 23:48:11\",\"params\":{},\"parentName\":null,\"parentId\":0,\"children\":[],\"menuId\":2000,\"menuName\":\"人脸识别\",\"orderNum\":\"5\",\"path\":\"face\",\"component\":null,\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"eye-open\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-28 23:48:12');
INSERT INTO `sys_oper_log` VALUES (115, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2021-05-30 00:34:26\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-28 23:49:35\",\"params\":{},\"parentName\":null,\"parentId\":0,\"children\":[],\"menuId\":5,\"menuName\":\"测试菜单\",\"orderNum\":\"5\",\"path\":\"demo\",\"component\":null,\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"1\",\"status\":\"1\",\"perms\":null,\"icon\":\"star\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-28 23:49:35');
INSERT INTO `sys_oper_log` VALUES (116, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-28 23:47:44\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-28 23:49:57\",\"params\":{},\"parentName\":null,\"parentId\":0,\"children\":[],\"menuId\":2003,\"menuName\":\"加解密器\",\"orderNum\":\"5\",\"path\":\"pwd\",\"component\":null,\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"password\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-28 23:49:57');
INSERT INTO `sys_oper_log` VALUES (117, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-28 23:52:01\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-28 23:52:01\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2004,\"menuName\":\"BASE64加密/解密\",\"orderNum\":\"1\",\"path\":\"pwd/base64\",\"component\":\"ai/pwd/base64\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-28 23:52:01');
INSERT INTO `sys_oper_log` VALUES (118, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-28 23:52:01\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-28 23:52:40\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2004,\"menuName\":\"BASE64加密/解密\",\"orderNum\":\"1\",\"path\":\"/base64\",\"component\":\"ai/pwd/base64\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-28 23:52:40');
INSERT INTO `sys_oper_log` VALUES (119, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-28 23:52:01\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-28 23:53:47\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2004,\"menuName\":\"BASE64加密/解密\",\"orderNum\":\"1\",\"path\":\"pwd/base64\",\"component\":\"ai/pwd/base64\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-28 23:53:47');
INSERT INTO `sys_oper_log` VALUES (120, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-26 16:35:21\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-28 23:55:56\",\"params\":{},\"parentName\":null,\"parentId\":0,\"children\":[],\"menuId\":2000,\"menuName\":\"人脸识别\",\"orderNum\":\"5\",\"path\":\"face\",\"component\":null,\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"eye-open\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-28 23:55:57');
INSERT INTO `sys_oper_log` VALUES (121, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-28 23:52:01\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-28 23:56:32\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2004,\"menuName\":\"BASE64加密/解密\",\"orderNum\":\"1\",\"path\":\"base64\",\"component\":\"ai/pwd/base64\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-28 23:56:33');
INSERT INTO `sys_oper_log` VALUES (122, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-28 23:52:01\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-29 00:03:30\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2004,\"menuName\":\"BASE64\",\"orderNum\":\"1\",\"path\":\"base64\",\"component\":\"ai/pwd/base64\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-29 00:03:30');
INSERT INTO `sys_oper_log` VALUES (123, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-28 23:52:01\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-29 12:44:38\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2004,\"menuName\":\"BASE64\",\"orderNum\":\"1\",\"path\":\"base64\",\"component\":\"ai/pwd/base64.vue\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-29 12:44:39');
INSERT INTO `sys_oper_log` VALUES (124, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-29 13:41:02\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-29 13:41:02\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2005,\"menuName\":\"DES\",\"orderNum\":\"2\",\"path\":\"pwd\",\"component\":\"ai/pwd/des.vue\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-29 13:41:03');
INSERT INTO `sys_oper_log` VALUES (125, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-29 13:41:03\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-29 13:43:32\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2005,\"menuName\":\"DES\",\"orderNum\":\"2\",\"path\":\"des\",\"component\":\"ai/pwd/des.vue\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-29 13:43:33');
INSERT INTO `sys_oper_log` VALUES (126, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-28 23:47:44\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-29 13:58:08\",\"params\":{},\"parentName\":null,\"parentId\":0,\"children\":[],\"menuId\":2003,\"menuName\":\"密码算法接口\",\"orderNum\":\"5\",\"path\":\"pwd\",\"component\":null,\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"password\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-29 13:58:09');
INSERT INTO `sys_oper_log` VALUES (127, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-29 14:11:54\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-29 14:11:54\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2006,\"menuName\":\"AES\",\"orderNum\":\"1\",\"path\":\"aes\",\"component\":\"ai/pwd/aes.vue\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-29 14:11:54');
INSERT INTO `sys_oper_log` VALUES (128, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '', '/ai/tool/gen/importTable', '0:0:0:0:0:0:0:1', '内网IP', '\"ai_pwd\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 17:10:04');
INSERT INTO `sys_oper_log` VALUES (129, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', '', '/ai/tool/gen/synchDb/ai_pwd', '0:0:0:0:0:0:0:1', '内网IP', '{tableName=ai_pwd}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 17:16:57');
INSERT INTO `sys_oper_log` VALUES (130, '代码生成', 3, 'com.ruoyi.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '', '/ai/tool/gen/2', '0:0:0:0:0:0:0:1', '内网IP', '{tableIds=2}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 17:19:28');
INSERT INTO `sys_oper_log` VALUES (131, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '', '/ai/tool/gen/importTable', '0:0:0:0:0:0:0:1', '内网IP', '\"ai_pwd\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 17:19:32');
INSERT INTO `sys_oper_log` VALUES (132, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '', '/ai/tool/gen', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":\"admin\",\"updateTime\":\"2022-04-30 17:25:28\",\"params\":{\"treeCode\":null,\"treeName\":null,\"treeParentCode\":null,\"parentMenuId\":2003},\"tableId\":3,\"tableName\":\"ai_pwd\",\"tableComment\":\"密码保存信息\",\"subTableName\":null,\"subTableFkName\":null,\"className\":\"AiPwd\",\"tplCategory\":\"crud\",\"packageName\":\"com.ruoyi.ai.pwd\",\"moduleName\":\"pwd\",\"businessName\":\"pwd\",\"functionName\":\"密码保存管理\",\"functionAuthor\":\"何翔\",\"genType\":\"0\",\"genPath\":\"/\",\"pkColumn\":null,\"subTable\":null,\"columns\":[{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-30 17:19:32\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-30 17:25:28\",\"params\":{},\"columnId\":24,\"tableId\":3,\"columnName\":\"id\",\"columnComment\":\"主键\",\"columnType\":\"int\",\"javaType\":\"Long\",\"javaField\":\"id\",\"isPk\":\"1\",\"isIncrement\":\"1\",\"isRequired\":\"1\",\"isInsert\":null,\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":null,\"queryType\":\"EQ\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":1,\"list\":true,\"required\":true,\"pk\":true,\"superColumn\":false,\"increment\":true,\"insert\":false,\"edit\":true,\"query\":false,\"usableColumn\":false,\"capJavaField\":\"id\"},{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-30 17:19:32\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-30 17:25:28\",\"params\":{},\"columnId\":25,\"tableId\":3,\"columnName\":\"text\",\"columnComment\":\"原文\",\"columnType\":\"varchar(255)\",\"javaType\":\"String\",\"javaField\":\"text\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"queryType\":\"LIKE\",\"htmlType\":\"textarea\",\"dictType\":\"\",\"sort\":2,\"list\":true,\"required\":true,\"pk\":false,\"superColumn\":false,\"increment\":false,\"insert\":true,\"edit\":true,\"query\":true,\"usableColumn\":false,\"capJavaField\":\"text\"},{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-30 17:19:32\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-30 17:25:28\",\"params\":{},\"columnId\":26,\"tableId\":3,\"columnName\":\"key\",\"columnComment\":\"key键\",\"columnType\":\"varchar(255)\",\"javaType\":\"String\",\"javaField\":\"key\",\"isPk\":\"0\",\"isIncrement\":', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 17:25:28');
INSERT INTO `sys_oper_log` VALUES (133, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '', '/ai/tool/gen/batchGenCode', '0:0:0:0:0:0:0:1', '内网IP', '{}', '', 0, '', '2022-04-30 17:25:32');
INSERT INTO `sys_oper_log` VALUES (134, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '', '/ai/tool/gen', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":\"admin\",\"updateTime\":\"2022-04-30 17:27:24\",\"params\":{\"treeCode\":null,\"treeName\":null,\"treeParentCode\":null,\"parentMenuId\":\"2003\"},\"tableId\":3,\"tableName\":\"ai_pwd\",\"tableComment\":\"密码保存信息\",\"subTableName\":null,\"subTableFkName\":null,\"className\":\"AiPwd\",\"tplCategory\":\"crud\",\"packageName\":\"com.ruoyi.ai.pwd\",\"moduleName\":\"ai\",\"businessName\":\"pwd\",\"functionName\":\"密码保存管理\",\"functionAuthor\":\"何翔\",\"genType\":\"0\",\"genPath\":\"/\",\"pkColumn\":null,\"subTable\":null,\"columns\":[{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-30 17:19:32\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-30 17:27:24\",\"params\":{},\"columnId\":24,\"tableId\":3,\"columnName\":\"id\",\"columnComment\":\"主键\",\"columnType\":\"int\",\"javaType\":\"Long\",\"javaField\":\"id\",\"isPk\":\"1\",\"isIncrement\":\"1\",\"isRequired\":\"1\",\"isInsert\":null,\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":null,\"queryType\":\"EQ\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":1,\"list\":true,\"required\":true,\"pk\":true,\"superColumn\":false,\"increment\":true,\"insert\":false,\"edit\":true,\"query\":false,\"usableColumn\":false,\"capJavaField\":\"id\"},{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-30 17:19:32\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-30 17:27:25\",\"params\":{},\"columnId\":25,\"tableId\":3,\"columnName\":\"text\",\"columnComment\":\"原文\",\"columnType\":\"varchar(255)\",\"javaType\":\"String\",\"javaField\":\"text\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"queryType\":\"LIKE\",\"htmlType\":\"textarea\",\"dictType\":\"\",\"sort\":2,\"list\":true,\"required\":true,\"pk\":false,\"superColumn\":false,\"increment\":false,\"insert\":true,\"edit\":true,\"query\":true,\"usableColumn\":false,\"capJavaField\":\"text\"},{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-30 17:19:32\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-30 17:27:25\",\"params\":{},\"columnId\":26,\"tableId\":3,\"columnName\":\"key\",\"columnComment\":\"key键\",\"columnType\":\"varchar(255)\",\"javaType\":\"String\",\"javaField\":\"key\",\"isPk\":\"0\",\"isIncrement\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 17:27:25');
INSERT INTO `sys_oper_log` VALUES (135, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '', '/ai/tool/gen/batchGenCode', '0:0:0:0:0:0:0:1', '内网IP', '{}', '', 0, '', '2022-04-30 17:27:44');
INSERT INTO `sys_oper_log` VALUES (136, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-30 17:28:56\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-30 17:30:27\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2013,\"menuName\":\"密码保存管理\",\"orderNum\":\"1\",\"path\":\"pwd\",\"component\":\"ai/pwd/index\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"ai:pwd:list\",\"icon\":\"lock\",\"remark\":\"密码保存管理菜单\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 17:30:27');
INSERT INTO `sys_oper_log` VALUES (137, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-30 17:28:56\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-30 17:30:44\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2013,\"menuName\":\"密码保存管理\",\"orderNum\":\"0\",\"path\":\"pwd\",\"component\":\"ai/pwd/index\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"ai:pwd:list\",\"icon\":\"lock\",\"remark\":\"密码保存管理菜单\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 17:30:45');
INSERT INTO `sys_oper_log` VALUES (138, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-30 17:28:56\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-30 17:31:40\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2013,\"menuName\":\"密码管理\",\"orderNum\":\"0\",\"path\":\"pwd\",\"component\":\"ai/pwd/index\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"ai:pwd:list\",\"icon\":\"lock\",\"remark\":\"密码保存管理菜单\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 17:31:40');
INSERT INTO `sys_oper_log` VALUES (139, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-30 17:28:56\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-30 17:43:43\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2013,\"menuName\":\"密码管理\",\"orderNum\":\"0\",\"path\":\"pwd\",\"component\":\"ai/pwd/index.vue\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"ai:pwd:list\",\"icon\":\"lock\",\"remark\":\"密码保存管理菜单\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 17:43:44');
INSERT INTO `sys_oper_log` VALUES (140, '密码保存管理', 1, 'com.ruoyi.ai.pwd.controller.AiPwdController.add()', 'POST', 1, 'admin', '', '/ai/ai/pwd', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"params\":{},\"id\":null,\"text\":\"123\",\"key\":\"123\",\"cipher\":\"123\",\"remark\":\"test\"}', '', 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'key,\ncipher,\nremark,\n\n\ncreate_by,\ncreate_time,\nupdate_by,\nupdate_time )  VALUES \' at line 2\r\n### The error may exist in com/ruoyi/ai/pwd/mapper/AiPwdMapper.java (best guess)\r\n### The error may involve com.ruoyi.ai.pwd.mapper.AiPwdMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO ai_pwd  ( text, key, cipher, remark,   create_by, create_time, update_by, update_time )  VALUES  ( ?, ?, ?, ?,   ?, ?, ?, ? )\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'key,\ncipher,\nremark,\n\n\ncreate_by,\ncreate_time,\nupdate_by,\nupdate_time )  VALUES \' at line 2\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'key,\ncipher,\nremark,\n\n\ncreate_by,\ncreate_time,\nupdate_by,\nupdate_time )  VALUES \' at line 2', '2022-04-30 17:46:19');
INSERT INTO `sys_oper_log` VALUES (141, '密码保存管理', 1, 'com.ruoyi.ai.pwd.controller.AiPwdController.add()', 'POST', 1, 'admin', '', '/ai/ai/pwd', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"params\":{},\"id\":null,\"text\":\"123123\",\"key\":\"123123\",\"cipher\":\"12312\",\"remark\":\"123123123\"}', '', 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'key,\ncipher,\nremark,\n\n\ncreate_by,\ncreate_time,\nupdate_by,\nupdate_time )  VALUES \' at line 2\r\n### The error may exist in com/ruoyi/ai/pwd/mapper/AiPwdMapper.java (best guess)\r\n### The error may involve com.ruoyi.ai.pwd.mapper.AiPwdMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO ai_pwd  ( text, key, cipher, remark,   create_by, create_time, update_by, update_time )  VALUES  ( ?, ?, ?, ?,   ?, ?, ?, ? )\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'key,\ncipher,\nremark,\n\n\ncreate_by,\ncreate_time,\nupdate_by,\nupdate_time )  VALUES \' at line 2\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'key,\ncipher,\nremark,\n\n\ncreate_by,\ncreate_time,\nupdate_by,\nupdate_time )  VALUES \' at line 2', '2022-04-30 17:48:53');
INSERT INTO `sys_oper_log` VALUES (142, '密码保存管理', 1, 'com.ruoyi.ai.pwd.controller.AiPwdController.add()', 'POST', 1, 'admin', '', '/ai/ai/pwd', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"params\":{},\"id\":14,\"text\":\"123\",\"key\":null,\"cipher\":\"12312\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 17:56:08');
INSERT INTO `sys_oper_log` VALUES (143, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', '', '/ai/tool/gen/synchDb/ai_pwd', '0:0:0:0:0:0:0:1', '内网IP', '{tableName=ai_pwd}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 18:02:06');
INSERT INTO `sys_oper_log` VALUES (144, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '', '/ai/tool/gen', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":\"admin\",\"updateTime\":\"2022-04-30 18:06:32\",\"params\":{\"treeCode\":null,\"treeName\":null,\"treeParentCode\":null,\"parentMenuId\":\"2003\"},\"tableId\":3,\"tableName\":\"ai_pwd\",\"tableComment\":\"密码管理\",\"subTableName\":null,\"subTableFkName\":null,\"className\":\"AiPwd\",\"tplCategory\":\"crud\",\"packageName\":\"com.ruoyi.ai.pwd\",\"moduleName\":\"ai\",\"businessName\":\"pwd\",\"functionName\":\"密码管理\",\"functionAuthor\":\"何翔\",\"genType\":\"0\",\"genPath\":\"/\",\"pkColumn\":null,\"subTable\":null,\"columns\":[{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-30 17:19:32\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-30 18:06:32\",\"params\":{},\"columnId\":24,\"tableId\":3,\"columnName\":\"id\",\"columnComment\":\"主键\",\"columnType\":\"int\",\"javaType\":\"Long\",\"javaField\":\"id\",\"isPk\":\"1\",\"isIncrement\":\"1\",\"isRequired\":\"1\",\"isInsert\":null,\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":null,\"queryType\":\"EQ\",\"htmlType\":\"input\",\"dictType\":\"\",\"sort\":1,\"required\":true,\"list\":true,\"pk\":true,\"superColumn\":false,\"increment\":true,\"query\":false,\"usableColumn\":false,\"capJavaField\":\"id\",\"insert\":false,\"edit\":true},{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-30 17:19:32\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-30 18:06:32\",\"params\":{},\"columnId\":25,\"tableId\":3,\"columnName\":\"text\",\"columnComment\":\"原文\",\"columnType\":\"varchar(255)\",\"javaType\":\"String\",\"javaField\":\"text\",\"isPk\":\"0\",\"isIncrement\":\"0\",\"isRequired\":\"1\",\"isInsert\":\"1\",\"isEdit\":\"1\",\"isList\":\"1\",\"isQuery\":\"1\",\"queryType\":\"LIKE\",\"htmlType\":\"textarea\",\"dictType\":\"\",\"sort\":2,\"required\":true,\"list\":true,\"pk\":false,\"superColumn\":false,\"increment\":false,\"query\":true,\"usableColumn\":false,\"capJavaField\":\"text\",\"insert\":true,\"edit\":true},{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-30 18:02:06\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-30 18:06:32\",\"params\":{},\"columnId\":35,\"tableId\":3,\"columnName\":\"key_word\",\"columnComment\":\"key键\",\"columnType\":\"varchar(255)\",\"javaType\":\"String\",\"javaField\":\"keyWord\",\"isPk\":\"0\",\"isIncre', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 18:06:33');
INSERT INTO `sys_oper_log` VALUES (145, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '', '/ai/tool/gen/batchGenCode', '0:0:0:0:0:0:0:1', '内网IP', '{}', '', 0, '', '2022-04-30 18:07:25');
INSERT INTO `sys_oper_log` VALUES (146, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-30 18:08:37\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-30 18:12:11\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2019,\"menuName\":\"密码管理\",\"orderNum\":\"0\",\"path\":\"pwd\",\"component\":\"ai/pwd/index.vue\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"ai:pwd:list\",\"icon\":\"lock\",\"remark\":\"密码管理菜单\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 18:12:11');
INSERT INTO `sys_oper_log` VALUES (147, '密码管理', 3, 'com.ruoyi.ai.pwd.controller.AiPwdController.remove()', 'DELETE', 1, 'admin', '', '/ai/ai/pwd/14', '0:0:0:0:0:0:0:1', '内网IP', '{ids=14}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 18:17:09');
INSERT INTO `sys_oper_log` VALUES (148, '密码管理', 1, 'com.ruoyi.ai.pwd.controller.AiPwdController.add()', 'POST', 1, 'admin', '', '/ai/ai/pwd', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"params\":{},\"id\":15,\"text\":\"1231231123\",\"keyWord\":\"123123\",\"ciphertext\":\"1231\",\"remark\":\"312312\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 18:19:25');
INSERT INTO `sys_oper_log` VALUES (149, '密码管理', 3, 'com.ruoyi.ai.pwd.controller.AiPwdController.remove()', 'DELETE', 1, 'admin', '', '/ai/ai/pwd/15', '0:0:0:0:0:0:0:1', '内网IP', '{ids=15}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 18:19:31');
INSERT INTO `sys_oper_log` VALUES (150, '密码管理', 1, 'com.ruoyi.ai.pwd.controller.AiPwdController.add()', 'POST', 1, 'admin', '', '/ai/ai/pwd', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"params\":{},\"id\":16,\"text\":\"213\",\"keyWord\":\"123\",\"ciphertext\":\"123\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 18:19:42');
INSERT INTO `sys_oper_log` VALUES (151, '密码管理', 2, 'com.ruoyi.ai.pwd.controller.AiPwdController.edit()', 'PUT', 1, 'admin', '', '/ai/ai/pwd', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":null,\"createTime\":\"2022-04-30 18:19:42\",\"updateBy\":null,\"updateTime\":null,\"params\":{},\"id\":16,\"text\":\"213\",\"keyWord\":\"1\",\"ciphertext\":\"123\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 18:19:50');
INSERT INTO `sys_oper_log` VALUES (152, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-30 18:48:26\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-30 18:48:26\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2025,\"menuName\":\"SHA加密\",\"orderNum\":\"1\",\"path\":\"ai/pwd/sha.vue\",\"component\":\"sha\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 18:48:27');
INSERT INTO `sys_oper_log` VALUES (153, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-28 23:52:01\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-30 18:49:54\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2004,\"menuName\":\"BASE64\",\"orderNum\":\"5\",\"path\":\"base64\",\"component\":\"ai/pwd/base64.vue\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 18:49:55');
INSERT INTO `sys_oper_log` VALUES (154, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-30 18:48:27\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-30 18:50:03\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2025,\"menuName\":\"SHA加密\",\"orderNum\":\"2\",\"path\":\"ai/pwd/sha.vue\",\"component\":\"sha\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 18:50:03');
INSERT INTO `sys_oper_log` VALUES (155, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-29 14:11:54\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-30 18:50:10\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2006,\"menuName\":\"AES\",\"orderNum\":\"3\",\"path\":\"aes\",\"component\":\"ai/pwd/aes.vue\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 18:50:10');
INSERT INTO `sys_oper_log` VALUES (156, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-29 13:41:03\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-30 18:50:14\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2005,\"menuName\":\"DES\",\"orderNum\":\"4\",\"path\":\"des\",\"component\":\"ai/pwd/des.vue\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 18:50:15');
INSERT INTO `sys_oper_log` VALUES (157, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-30 18:48:27\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-30 18:50:37\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2025,\"menuName\":\"SHA加密\",\"orderNum\":\"2\",\"path\":\"sha\",\"component\":\"ai/pwd/sha.vue\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 18:50:37');
INSERT INTO `sys_oper_log` VALUES (158, '密码管理', 1, 'com.ruoyi.ai.pwd.controller.AiPwdController.add()', 'POST', 1, 'admin', '', '/ai/ai/pwd', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"params\":{},\"id\":1,\"text\":\"123\",\"keyWord\":null,\"ciphertext\":\"123\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 20:06:01');
INSERT INTO `sys_oper_log` VALUES (159, '密码管理', 1, 'com.ruoyi.ai.pwd.controller.AiPwdController.add()', 'POST', 1, 'admin', '', '/ai/ai/pwd', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"params\":{},\"id\":1,\"text\":\"123\",\"keyWord\":\"123\",\"ciphertext\":\"123\",\"remark\":\"test\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 20:08:06');
INSERT INTO `sys_oper_log` VALUES (160, '密码管理', 1, 'com.ruoyi.ai.pwd.controller.AiPwdController.add()', 'POST', 1, 'admin', '', '/ai/ai/pwd', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"params\":{},\"id\":17,\"text\":\"1231\",\"keyWord\":\"13213\",\"ciphertext\":\"12313\",\"remark\":\"13213\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 20:12:32');
INSERT INTO `sys_oper_log` VALUES (161, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-30 18:48:27\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-30 20:15:01\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2025,\"menuName\":\"MD5 | SHA\",\"orderNum\":\"2\",\"path\":\"sha\",\"component\":\"ai/pwd/sha.vue\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 20:15:02');
INSERT INTO `sys_oper_log` VALUES (162, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-30 18:48:27\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-30 20:15:54\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2025,\"menuName\":\"MD5|SHA 加密\",\"orderNum\":\"2\",\"path\":\"sha\",\"component\":\"ai/pwd/sha.vue\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 20:15:55');
INSERT INTO `sys_oper_log` VALUES (163, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-30 18:48:27\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-30 20:16:26\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2025,\"menuName\":\"MD5 | SHA\",\"orderNum\":\"2\",\"path\":\"sha\",\"component\":\"ai/pwd/sha.vue\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 20:16:26');
INSERT INTO `sys_oper_log` VALUES (164, '密码管理', 1, 'com.ruoyi.ai.pwd.controller.AiPwdController.add()', 'POST', 1, 'admin', '', '/ai/ai/pwd', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"params\":{},\"id\":18,\"text\":\"123123\",\"keyWord\":null,\"ciphertext\":\"4297f44b13955235245b2497399d7a93\",\"remark\":\"test\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 20:45:40');
INSERT INTO `sys_oper_log` VALUES (165, '密码管理', 1, 'com.ruoyi.ai.pwd.controller.AiPwdController.add()', 'POST', 1, 'admin', '', '/ai/ai/pwd', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"params\":{},\"id\":19,\"text\":\"12312\",\"keyWord\":\"123123\",\"ciphertext\":\"U2FsdGVkX1+lQr+TlNQloTjy5Dz5LRb8mH+E5kSzagk=\",\"remark\":\"test\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 21:39:28');
INSERT INTO `sys_oper_log` VALUES (166, '密码管理', 2, 'com.ruoyi.ai.pwd.controller.AiPwdController.edit()', 'PUT', 1, 'admin', '', '/ai/ai/pwd', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":null,\"createTime\":\"2022-04-30 21:39:28\",\"updateBy\":null,\"updateTime\":null,\"params\":{},\"id\":19,\"text\":\"12312\",\"keyWord\":\"12312\",\"ciphertext\":\"U2FsdGVkX1+lQr+TlNQloTjy5Dz5LRb8mH+E5kSzagk=\",\"remark\":\"test\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 21:39:44');
INSERT INTO `sys_oper_log` VALUES (167, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-30 18:08:37\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-30 21:40:47\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2019,\"menuName\":\"密码管理中心\",\"orderNum\":\"0\",\"path\":\"pwd\",\"component\":\"ai/pwd/index.vue\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"ai:pwd:list\",\"icon\":\"lock\",\"remark\":\"密码管理菜单\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 21:40:48');
INSERT INTO `sys_oper_log` VALUES (168, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-29 14:11:54\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-30 21:49:32\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2006,\"menuName\":\"AES加解密\",\"orderNum\":\"3\",\"path\":\"aes\",\"component\":\"ai/pwd/aes.vue\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 21:49:33');
INSERT INTO `sys_oper_log` VALUES (169, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-29 13:41:03\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-30 21:49:39\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2005,\"menuName\":\"DES加解密\",\"orderNum\":\"4\",\"path\":\"des\",\"component\":\"ai/pwd/des.vue\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 21:49:40');
INSERT INTO `sys_oper_log` VALUES (170, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-28 23:52:01\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-30 21:49:55\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2004,\"menuName\":\"BASE64加解密\",\"orderNum\":\"5\",\"path\":\"base64\",\"component\":\"ai/pwd/base64.vue\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 21:49:56');
INSERT INTO `sys_oper_log` VALUES (171, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-28 23:52:01\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-30 21:50:23\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2004,\"menuName\":\"Base64加解密\",\"orderNum\":\"5\",\"path\":\"base64\",\"component\":\"ai/pwd/base64.vue\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 21:50:23');
INSERT INTO `sys_oper_log` VALUES (172, '密码管理', 1, 'com.ruoyi.ai.pwd.controller.AiPwdController.add()', 'POST', 1, 'admin', '', '/ai/ai/pwd', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"params\":{},\"id\":20,\"text\":\"123\",\"keyWord\":\"123\",\"ciphertext\":\"U2FsdGVkX1/5cUD4DwBEi+t7iD2QJiFL\",\"remark\":\"123\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 21:58:54');
INSERT INTO `sys_oper_log` VALUES (173, '密码管理', 1, 'com.ruoyi.ai.pwd.controller.AiPwdController.add()', 'POST', 1, 'admin', '', '/ai/ai/pwd', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"params\":{},\"id\":21,\"text\":\"adas\",\"keyWord\":\"\",\"ciphertext\":\"YWRhcw==\",\"remark\":\"test\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 22:14:47');
INSERT INTO `sys_oper_log` VALUES (174, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-30 18:08:37\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-30 22:20:11\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2019,\"menuName\":\"密码管理中心\",\"orderNum\":\"0\",\"path\":\"pwd\",\"component\":\"ai/pwd/index.vue\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"ai:pwd:list\",\"icon\":\"tool\",\"remark\":\"密码管理菜单\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 22:20:11');
INSERT INTO `sys_oper_log` VALUES (175, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-30 22:21:36\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-30 22:21:36\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2026,\"menuName\":\"HMAC加解密\",\"orderNum\":\"1\",\"path\":\"hmac\",\"component\":\"ai/pwd/hmac.vue\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 22:21:36');
INSERT INTO `sys_oper_log` VALUES (176, '密码管理', 1, 'com.ruoyi.ai.pwd.controller.AiPwdController.add()', 'POST', 1, 'admin', '', '/ai/ai/pwd', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"params\":{},\"id\":22,\"text\":\"23423\",\"keyWord\":\"2342\",\"ciphertext\":\"5f59b3dc626b98b271c6d49a638aa49d\",\"remark\":\"1231\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 22:29:27');
INSERT INTO `sys_oper_log` VALUES (177, '密码管理', 1, 'com.ruoyi.ai.pwd.controller.AiPwdController.add()', 'POST', 1, 'admin', '', '/ai/ai/pwd', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"params\":{},\"id\":23,\"text\":\"123\",\"keyWord\":\"123\",\"ciphertext\":\"f92d8e071adeae514c1ac0f94502e75bb5c28b817e0e0a01e762348f\",\"remark\":\"hhhhhhh\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 22:30:14');
INSERT INTO `sys_oper_log` VALUES (178, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-30 22:44:17\",\"updateBy\":\"admin\",\"updateTime\":\"2022-04-30 22:44:17\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2027,\"menuName\":\"RC4加解密\",\"orderNum\":\"2\",\"path\":\"rc4\",\"component\":\"ai/pwd/rc4.vue\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 22:44:18');
INSERT INTO `sys_oper_log` VALUES (179, '密码管理', 1, 'com.ruoyi.ai.pwd.controller.AiPwdController.add()', 'POST', 1, 'admin', '', '/ai/ai/pwd', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"params\":{},\"id\":24,\"text\":\"rrrrr\",\"keyWord\":\"rr\",\"ciphertext\":\"U2FsdGVkX19YduyvxCs0dsukP2E9\",\"remark\":\"rrr\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-04-30 22:51:14');
INSERT INTO `sys_oper_log` VALUES (180, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-05-01 00:01:40\",\"updateBy\":\"admin\",\"updateTime\":\"2022-05-01 00:01:40\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2028,\"menuName\":\"TripleDES\",\"orderNum\":\"5\",\"path\":\"tripleDES\",\"component\":\"ai/pwd/tripleDES.vue\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-05-01 00:01:41');
INSERT INTO `sys_oper_log` VALUES (181, '密码管理', 1, 'com.ruoyi.ai.pwd.controller.AiPwdController.add()', 'POST', 1, 'admin', '', '/ai/ai/pwd', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"params\":{},\"id\":25,\"text\":\"1231\",\"keyWord\":\"12312\",\"ciphertext\":\"U2FsdGVkX19QQLk+CDhQ0DnTiqcHV4MD\",\"remark\":\"hexiang\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-05-01 00:02:37');
INSERT INTO `sys_oper_log` VALUES (182, '密码管理', 3, 'com.ruoyi.ai.pwd.controller.AiPwdController.remove()', 'DELETE', 1, 'admin', '', '/ai/ai/pwd/25', '0:0:0:0:0:0:0:1', '内网IP', '{ids=25}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-05-01 00:02:43');
INSERT INTO `sys_oper_log` VALUES (183, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-21 19:29:57\",\"updateBy\":\"admin\",\"updateTime\":\"2022-05-01 00:11:42\",\"params\":{},\"parentName\":null,\"parentId\":0,\"children\":[],\"menuId\":4,\"menuName\":\"我的主页\",\"orderNum\":\"4\",\"path\":\"https://github.com/He-Xiang-best\",\"component\":null,\"query\":\"\",\"isFrame\":\"0\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"1\",\"status\":\"1\",\"perms\":\"\",\"icon\":\"guide\",\"remark\":\"RuoYi-Vue-Plus官网地址\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-05-01 00:11:43');
INSERT INTO `sys_oper_log` VALUES (184, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-05-01 00:18:27\",\"updateBy\":\"admin\",\"updateTime\":\"2022-05-01 00:18:27\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2029,\"menuName\":\"Rabbit\",\"orderNum\":\"5\",\"path\":\"rabbit\",\"component\":\"ai/pwd/rabbit.vue\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-05-01 00:18:27');
INSERT INTO `sys_oper_log` VALUES (185, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-05-01 00:18:27\",\"updateBy\":\"admin\",\"updateTime\":\"2022-05-01 00:29:18\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2029,\"menuName\":\"Rabbit加解密\",\"orderNum\":\"5\",\"path\":\"rabbit\",\"component\":\"ai/pwd/rabbit.vue\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-05-01 00:29:19');
INSERT INTO `sys_oper_log` VALUES (186, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-30 18:48:27\",\"updateBy\":\"admin\",\"updateTime\":\"2022-05-01 00:31:32\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2025,\"menuName\":\"MD5 | SHA\",\"orderNum\":\"1\",\"path\":\"sha\",\"component\":\"ai/pwd/sha.vue\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-05-01 00:31:33');
INSERT INTO `sys_oper_log` VALUES (187, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-30 22:21:36\",\"updateBy\":\"admin\",\"updateTime\":\"2022-05-01 00:31:41\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2026,\"menuName\":\"HMAC加解密\",\"orderNum\":\"4\",\"path\":\"hmac\",\"component\":\"ai/pwd/hmac.vue\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-05-01 00:31:41');
INSERT INTO `sys_oper_log` VALUES (188, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-30 22:44:18\",\"updateBy\":\"admin\",\"updateTime\":\"2022-05-01 00:31:48\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2027,\"menuName\":\"RC4加解密\",\"orderNum\":\"3\",\"path\":\"rc4\",\"component\":\"ai/pwd/rc4.vue\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-05-01 00:31:48');
INSERT INTO `sys_oper_log` VALUES (189, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-29 13:41:03\",\"updateBy\":\"admin\",\"updateTime\":\"2022-05-01 00:32:03\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2005,\"menuName\":\"DES加解密\",\"orderNum\":\"8\",\"path\":\"des\",\"component\":\"ai/pwd/des.vue\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-05-01 00:32:03');
INSERT INTO `sys_oper_log` VALUES (190, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-05-01 00:18:27\",\"updateBy\":\"admin\",\"updateTime\":\"2022-05-01 00:32:16\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2029,\"menuName\":\"Rabbit加解密\",\"orderNum\":\"6\",\"path\":\"rabbit\",\"component\":\"ai/pwd/rabbit.vue\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-05-01 00:32:17');
INSERT INTO `sys_oper_log` VALUES (191, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-05-01 00:01:41\",\"updateBy\":\"admin\",\"updateTime\":\"2022-05-01 00:32:27\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2028,\"menuName\":\"TripleDES\",\"orderNum\":\"7\",\"path\":\"tripleDES\",\"component\":\"ai/pwd/tripleDES.vue\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-05-01 00:32:27');
INSERT INTO `sys_oper_log` VALUES (192, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-28 23:52:01\",\"updateBy\":\"admin\",\"updateTime\":\"2022-05-01 00:33:00\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2004,\"menuName\":\"Base64\",\"orderNum\":\"5\",\"path\":\"base64\",\"component\":\"ai/pwd/base64.vue\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-05-01 00:33:01');
INSERT INTO `sys_oper_log` VALUES (193, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-04-30 22:21:36\",\"updateBy\":\"admin\",\"updateTime\":\"2022-05-01 00:34:02\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2026,\"menuName\":\"HMAC加密\",\"orderNum\":\"1\",\"path\":\"hmac\",\"component\":\"ai/pwd/hmac.vue\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-05-01 00:34:02');
INSERT INTO `sys_oper_log` VALUES (194, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-05-01 00:18:27\",\"updateBy\":\"admin\",\"updateTime\":\"2022-05-01 00:34:23\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2029,\"menuName\":\"Rabbit加解密\",\"orderNum\":\"5\",\"path\":\"rabbit\",\"component\":\"ai/pwd/rabbit.vue\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-05-01 00:34:23');
INSERT INTO `sys_oper_log` VALUES (195, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/ai/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"searchValue\":null,\"createBy\":\"admin\",\"createTime\":\"2022-05-01 00:18:27\",\"updateBy\":\"admin\",\"updateTime\":\"2022-05-01 00:34:36\",\"params\":{},\"parentName\":null,\"parentId\":2003,\"children\":[],\"menuId\":2029,\"menuName\":\"Rabbit加解密\",\"orderNum\":\"4\",\"path\":\"rabbit\",\"component\":\"ai/pwd/rabbit.vue\",\"query\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":null,\"icon\":\"lock\",\"remark\":\"\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2022-05-01 00:34:36');

-- ----------------------------
-- Table structure for sys_oss
-- ----------------------------
DROP TABLE IF EXISTS `sys_oss`;
CREATE TABLE `sys_oss`  (
  `oss_id` bigint NOT NULL AUTO_INCREMENT COMMENT '对象存储主键',
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '文件名',
  `original_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '原名',
  `file_suffix` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '文件后缀名',
  `url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'URL地址',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '上传人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新人',
  `service` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'minio' COMMENT '服务商',
  PRIMARY KEY (`oss_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'OSS对象存储表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oss
-- ----------------------------

-- ----------------------------
-- Table structure for sys_oss_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_oss_config`;
CREATE TABLE `sys_oss_config`  (
  `oss_config_id` bigint NOT NULL AUTO_INCREMENT COMMENT '主建',
  `config_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '配置key',
  `access_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT 'accessKey',
  `secret_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '秘钥',
  `bucket_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '桶名称',
  `prefix` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '前缀',
  `endpoint` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '访问站点',
  `is_https` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '是否https（Y=是,N=否）',
  `region` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '域',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '状态（0=正常,1=停用）',
  `ext1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '扩展字段',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`oss_config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '对象存储配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oss_config
-- ----------------------------
INSERT INTO `sys_oss_config` VALUES (1, 'minio', 'ruoyi', 'ruoyi123', 'ruoyi', '', 'http://localhost:9000', 'N', '', '0', '', 'admin', '2022-04-21 19:29:57', 'admin', '2022-04-21 19:29:57', NULL);
INSERT INTO `sys_oss_config` VALUES (2, 'qiniu', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'ruoyi', '', 'http://XXX.XXXX.com', 'N', 'z0', '1', '', 'admin', '2022-04-21 19:29:57', 'admin', '2022-04-21 19:29:57', NULL);
INSERT INTO `sys_oss_config` VALUES (3, 'aliyun', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'ruoyi', '', 'http://oss-cn-beijing.aliyuncs.com', 'N', '', '1', '', 'admin', '2022-04-21 19:29:57', 'admin', '2022-04-21 19:29:57', NULL);
INSERT INTO `sys_oss_config` VALUES (4, 'qcloud', 'XXXXXXXXXXXXXXX', 'XXXXXXXXXXXXXXX', 'ruoyi-1250000000', '', 'http://cos.ap-beijing.myqcloud.com', 'N', 'ap-beijing', '1', '', 'admin', '2022-04-21 19:29:57', 'admin', '2022-04-21 19:29:57', NULL);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '岗位信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2022-04-21 19:29:57', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2022-04-21 19:29:57', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2022-04-21 19:29:57', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2022-04-21 19:29:57', '', NULL, '普通角色');
INSERT INTO `sys_role` VALUES (3, '本部门及以下', 'test1', 3, '4', 1, 1, '0', '0', 'admin', '2021-05-08 22:31:37', 'admin', '2021-05-08 22:32:03', NULL);
INSERT INTO `sys_role` VALUES (4, '仅本人', 'test2', 4, '5', 1, 1, '0', '0', 'admin', '2021-05-30 01:14:52', 'admin', '2021-05-30 01:18:38', NULL);

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和部门关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);
INSERT INTO `sys_role_menu` VALUES (3, 1);
INSERT INTO `sys_role_menu` VALUES (3, 5);
INSERT INTO `sys_role_menu` VALUES (3, 100);
INSERT INTO `sys_role_menu` VALUES (3, 101);
INSERT INTO `sys_role_menu` VALUES (3, 102);
INSERT INTO `sys_role_menu` VALUES (3, 103);
INSERT INTO `sys_role_menu` VALUES (3, 104);
INSERT INTO `sys_role_menu` VALUES (3, 105);
INSERT INTO `sys_role_menu` VALUES (3, 106);
INSERT INTO `sys_role_menu` VALUES (3, 107);
INSERT INTO `sys_role_menu` VALUES (3, 108);
INSERT INTO `sys_role_menu` VALUES (3, 500);
INSERT INTO `sys_role_menu` VALUES (3, 501);
INSERT INTO `sys_role_menu` VALUES (3, 1001);
INSERT INTO `sys_role_menu` VALUES (3, 1002);
INSERT INTO `sys_role_menu` VALUES (3, 1003);
INSERT INTO `sys_role_menu` VALUES (3, 1004);
INSERT INTO `sys_role_menu` VALUES (3, 1005);
INSERT INTO `sys_role_menu` VALUES (3, 1006);
INSERT INTO `sys_role_menu` VALUES (3, 1007);
INSERT INTO `sys_role_menu` VALUES (3, 1008);
INSERT INTO `sys_role_menu` VALUES (3, 1009);
INSERT INTO `sys_role_menu` VALUES (3, 1010);
INSERT INTO `sys_role_menu` VALUES (3, 1011);
INSERT INTO `sys_role_menu` VALUES (3, 1012);
INSERT INTO `sys_role_menu` VALUES (3, 1013);
INSERT INTO `sys_role_menu` VALUES (3, 1014);
INSERT INTO `sys_role_menu` VALUES (3, 1015);
INSERT INTO `sys_role_menu` VALUES (3, 1016);
INSERT INTO `sys_role_menu` VALUES (3, 1017);
INSERT INTO `sys_role_menu` VALUES (3, 1018);
INSERT INTO `sys_role_menu` VALUES (3, 1019);
INSERT INTO `sys_role_menu` VALUES (3, 1020);
INSERT INTO `sys_role_menu` VALUES (3, 1021);
INSERT INTO `sys_role_menu` VALUES (3, 1022);
INSERT INTO `sys_role_menu` VALUES (3, 1023);
INSERT INTO `sys_role_menu` VALUES (3, 1024);
INSERT INTO `sys_role_menu` VALUES (3, 1025);
INSERT INTO `sys_role_menu` VALUES (3, 1026);
INSERT INTO `sys_role_menu` VALUES (3, 1027);
INSERT INTO `sys_role_menu` VALUES (3, 1028);
INSERT INTO `sys_role_menu` VALUES (3, 1029);
INSERT INTO `sys_role_menu` VALUES (3, 1030);
INSERT INTO `sys_role_menu` VALUES (3, 1031);
INSERT INTO `sys_role_menu` VALUES (3, 1032);
INSERT INTO `sys_role_menu` VALUES (3, 1033);
INSERT INTO `sys_role_menu` VALUES (3, 1034);
INSERT INTO `sys_role_menu` VALUES (3, 1035);
INSERT INTO `sys_role_menu` VALUES (3, 1036);
INSERT INTO `sys_role_menu` VALUES (3, 1037);
INSERT INTO `sys_role_menu` VALUES (3, 1038);
INSERT INTO `sys_role_menu` VALUES (3, 1039);
INSERT INTO `sys_role_menu` VALUES (3, 1040);
INSERT INTO `sys_role_menu` VALUES (3, 1041);
INSERT INTO `sys_role_menu` VALUES (3, 1042);
INSERT INTO `sys_role_menu` VALUES (3, 1043);
INSERT INTO `sys_role_menu` VALUES (3, 1044);
INSERT INTO `sys_role_menu` VALUES (3, 1045);
INSERT INTO `sys_role_menu` VALUES (3, 1500);
INSERT INTO `sys_role_menu` VALUES (3, 1501);
INSERT INTO `sys_role_menu` VALUES (3, 1502);
INSERT INTO `sys_role_menu` VALUES (3, 1503);
INSERT INTO `sys_role_menu` VALUES (3, 1504);
INSERT INTO `sys_role_menu` VALUES (3, 1505);
INSERT INTO `sys_role_menu` VALUES (3, 1506);
INSERT INTO `sys_role_menu` VALUES (3, 1507);
INSERT INTO `sys_role_menu` VALUES (3, 1508);
INSERT INTO `sys_role_menu` VALUES (3, 1509);
INSERT INTO `sys_role_menu` VALUES (3, 1510);
INSERT INTO `sys_role_menu` VALUES (3, 1511);
INSERT INTO `sys_role_menu` VALUES (4, 5);
INSERT INTO `sys_role_menu` VALUES (4, 1500);
INSERT INTO `sys_role_menu` VALUES (4, 1501);
INSERT INTO `sys_role_menu` VALUES (4, 1502);
INSERT INTO `sys_role_menu` VALUES (4, 1503);
INSERT INTO `sys_role_menu` VALUES (4, 1504);
INSERT INTO `sys_role_menu` VALUES (4, 1505);
INSERT INTO `sys_role_menu` VALUES (4, 1506);
INSERT INTO `sys_role_menu` VALUES (4, 1507);
INSERT INTO `sys_role_menu` VALUES (4, 1508);
INSERT INTO `sys_role_menu` VALUES (4, 1509);
INSERT INTO `sys_role_menu` VALUES (4, 1510);
INSERT INTO `sys_role_menu` VALUES (4, 1511);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime(0) NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '0:0:0:0:0:0:0:1', '2022-04-30 23:59:08', 'admin', '2022-04-21 19:29:57', 'admin', '2022-04-30 23:59:08', '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2022-04-21 19:29:57', 'admin', '2022-04-21 19:29:57', '', NULL, '测试员');
INSERT INTO `sys_user` VALUES (3, 108, 'test', '本部门及以下 密码666', '00', '', '', '0', '', '$2a$10$M6tZRpUZbWKq11O/z6YISePQc./Jhru8E18mmVJTr9aV8whzfjacC', '0', '0', '127.0.0.1', '2021-05-30 02:00:37', 'admin', '2021-04-22 09:50:41', 'test', '2021-05-30 02:00:37', NULL);
INSERT INTO `sys_user` VALUES (4, 102, 'test1', '仅本人 密码666', '00', '', '', '0', '', '$2a$10$yBSXp5Ba1m402cxXTPSy4eXUO8CXCGvXfquNVP/XMWwZ8nf9GaoMy', '0', '0', '127.0.0.1', '2021-05-30 01:48:03', 'admin', '2021-05-30 01:16:02', 'test1', '2021-05-30 01:48:03', NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);
INSERT INTO `sys_user_role` VALUES (3, 3);
INSERT INTO `sys_user_role` VALUES (4, 4);

-- ----------------------------
-- Table structure for test_demo
-- ----------------------------
DROP TABLE IF EXISTS `test_demo`;
CREATE TABLE `test_demo`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dept_id` int NULL DEFAULT NULL COMMENT '部门id',
  `user_id` int NULL DEFAULT NULL COMMENT '用户id',
  `order_num` int NULL DEFAULT 0 COMMENT '排序号',
  `test_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'key键',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '值',
  `version` int NULL DEFAULT 0 COMMENT '版本',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `del_flag` int NULL DEFAULT 0 COMMENT '删除标志',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '测试单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of test_demo
-- ----------------------------
INSERT INTO `test_demo` VALUES (1, 102, 4, 1, '测试数据权限', '测试', 0, '2021-06-01 10:00:00', 'admin', NULL, NULL, 0);
INSERT INTO `test_demo` VALUES (2, 102, 3, 2, '子节点1', '111', 0, '2021-06-01 10:00:00', 'admin', NULL, NULL, 0);
INSERT INTO `test_demo` VALUES (3, 102, 3, 3, '子节点2', '222', 0, '2021-06-01 10:00:00', 'admin', NULL, NULL, 0);
INSERT INTO `test_demo` VALUES (4, 108, 4, 4, '测试数据', 'demo', 0, '2021-06-01 10:00:00', 'admin', NULL, NULL, 0);
INSERT INTO `test_demo` VALUES (5, 108, 3, 13, '子节点11', '1111', 0, '2021-06-01 10:00:00', 'admin', NULL, NULL, 0);
INSERT INTO `test_demo` VALUES (6, 108, 3, 12, '子节点22', '2222', 0, '2021-06-01 10:00:00', 'admin', NULL, NULL, 0);
INSERT INTO `test_demo` VALUES (7, 108, 3, 11, '子节点33', '3333', 0, '2021-06-01 10:00:00', 'admin', NULL, NULL, 0);
INSERT INTO `test_demo` VALUES (8, 108, 3, 10, '子节点44', '4444', 0, '2021-06-01 10:00:00', 'admin', NULL, NULL, 0);
INSERT INTO `test_demo` VALUES (9, 108, 3, 9, '子节点55', '5555', 0, '2021-06-01 10:00:00', 'admin', NULL, NULL, 0);
INSERT INTO `test_demo` VALUES (10, 108, 3, 8, '子节点66', '6666', 0, '2021-06-01 10:00:00', 'admin', NULL, NULL, 0);
INSERT INTO `test_demo` VALUES (11, 108, 3, 7, '子节点77', '7777', 0, '2021-06-01 10:00:00', 'admin', NULL, NULL, 0);
INSERT INTO `test_demo` VALUES (12, 108, 3, 6, '子节点88', '8888', 0, '2021-06-01 10:00:00', 'admin', NULL, NULL, 0);
INSERT INTO `test_demo` VALUES (13, 108, 3, 5, '子节点99', '9999', 0, '2021-06-01 10:00:00', 'admin', NULL, NULL, 0);

-- ----------------------------
-- Table structure for test_tree
-- ----------------------------
DROP TABLE IF EXISTS `test_tree`;
CREATE TABLE `test_tree`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `parent_id` int NULL DEFAULT 0 COMMENT '父id',
  `dept_id` int NULL DEFAULT NULL COMMENT '部门id',
  `user_id` int NULL DEFAULT NULL COMMENT '用户id',
  `tree_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '值',
  `version` int NULL DEFAULT 0 COMMENT '版本',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `del_flag` int NULL DEFAULT 0 COMMENT '删除标志',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '测试树表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of test_tree
-- ----------------------------
INSERT INTO `test_tree` VALUES (1, 0, 102, 4, '测试数据权限', 0, '2021-06-01 10:00:00', 'admin', NULL, NULL, 0);
INSERT INTO `test_tree` VALUES (2, 1, 102, 3, '子节点1', 0, '2021-06-01 10:00:00', 'admin', NULL, NULL, 0);
INSERT INTO `test_tree` VALUES (3, 2, 102, 3, '子节点2', 0, '2021-06-01 10:00:00', 'admin', NULL, NULL, 0);
INSERT INTO `test_tree` VALUES (4, 0, 108, 4, '测试树1', 0, '2021-06-01 10:00:00', 'admin', NULL, NULL, 0);
INSERT INTO `test_tree` VALUES (5, 4, 108, 3, '子节点11', 0, '2021-06-01 10:00:00', 'admin', NULL, NULL, 0);
INSERT INTO `test_tree` VALUES (6, 4, 108, 3, '子节点22', 0, '2021-06-01 10:00:00', 'admin', NULL, NULL, 0);
INSERT INTO `test_tree` VALUES (7, 4, 108, 3, '子节点33', 0, '2021-06-01 10:00:00', 'admin', NULL, NULL, 0);
INSERT INTO `test_tree` VALUES (8, 5, 108, 3, '子节点44', 0, '2021-06-01 10:00:00', 'admin', NULL, NULL, 0);
INSERT INTO `test_tree` VALUES (9, 6, 108, 3, '子节点55', 0, '2021-06-01 10:00:00', 'admin', NULL, NULL, 0);
INSERT INTO `test_tree` VALUES (10, 7, 108, 3, '子节点66', 0, '2021-06-01 10:00:00', 'admin', NULL, NULL, 0);
INSERT INTO `test_tree` VALUES (11, 7, 108, 3, '子节点77', 0, '2021-06-01 10:00:00', 'admin', NULL, NULL, 0);
INSERT INTO `test_tree` VALUES (12, 10, 108, 3, '子节点88', 0, '2021-06-01 10:00:00', 'admin', NULL, NULL, 0);
INSERT INTO `test_tree` VALUES (13, 10, 108, 3, '子节点99', 0, '2021-06-01 10:00:00', 'admin', NULL, NULL, 0);

-- ----------------------------
-- Table structure for xxl_job_group
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_group`;
CREATE TABLE `xxl_job_group`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '执行器AppName',
  `title` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '执行器名称',
  `address_type` tinyint NOT NULL DEFAULT 0 COMMENT '执行器地址类型：0=自动注册、1=手动录入',
  `address_list` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '执行器地址列表，多地址逗号分隔',
  `update_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of xxl_job_group
-- ----------------------------
INSERT INTO `xxl_job_group` VALUES (1, 'xxl-job-executor', '示例执行器', 0, NULL, '2018-11-03 22:21:31');

-- ----------------------------
-- Table structure for xxl_job_info
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_info`;
CREATE TABLE `xxl_job_info`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `job_group` int NOT NULL COMMENT '执行器主键ID',
  `job_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `add_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `author` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '作者',
  `alarm_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '报警邮件',
  `schedule_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'NONE' COMMENT '调度类型',
  `schedule_conf` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '调度配置，值含义取决于调度类型',
  `misfire_strategy` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'DO_NOTHING' COMMENT '调度过期策略',
  `executor_route_strategy` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '执行器路由策略',
  `executor_handler` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '执行器任务handler',
  `executor_param` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '执行器任务参数',
  `executor_block_strategy` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '阻塞处理策略',
  `executor_timeout` int NOT NULL DEFAULT 0 COMMENT '任务执行超时时间，单位秒',
  `executor_fail_retry_count` int NOT NULL DEFAULT 0 COMMENT '失败重试次数',
  `glue_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'GLUE类型',
  `glue_source` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT 'GLUE源代码',
  `glue_remark` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'GLUE备注',
  `glue_updatetime` datetime(0) NULL DEFAULT NULL COMMENT 'GLUE更新时间',
  `child_jobid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '子任务ID，多个逗号分隔',
  `trigger_status` tinyint NOT NULL DEFAULT 0 COMMENT '调度状态：0-停止，1-运行',
  `trigger_last_time` bigint NOT NULL DEFAULT 0 COMMENT '上次调度时间',
  `trigger_next_time` bigint NOT NULL DEFAULT 0 COMMENT '下次调度时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of xxl_job_info
-- ----------------------------
INSERT INTO `xxl_job_info` VALUES (1, 1, '测试任务1', '2018-11-03 22:21:31', '2018-11-03 22:21:31', 'XXL', '', 'CRON', '0 0 0 * * ? *', 'DO_NOTHING', 'FIRST', 'demoJobHandler', '', 'SERIAL_EXECUTION', 0, 0, 'BEAN', '', 'GLUE代码初始化', '2018-11-03 22:21:31', '', 0, 0, 0);

-- ----------------------------
-- Table structure for xxl_job_lock
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_lock`;
CREATE TABLE `xxl_job_lock`  (
  `lock_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '锁名称',
  PRIMARY KEY (`lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of xxl_job_lock
-- ----------------------------
INSERT INTO `xxl_job_lock` VALUES ('schedule_lock');

-- ----------------------------
-- Table structure for xxl_job_log
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_log`;
CREATE TABLE `xxl_job_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `job_group` int NOT NULL COMMENT '执行器主键ID',
  `job_id` int NOT NULL COMMENT '任务，主键ID',
  `executor_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '执行器地址，本次执行的地址',
  `executor_handler` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '执行器任务handler',
  `executor_param` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '执行器任务参数',
  `executor_sharding_param` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '执行器任务分片参数，格式如 1/2',
  `executor_fail_retry_count` int NOT NULL DEFAULT 0 COMMENT '失败重试次数',
  `trigger_time` datetime(0) NULL DEFAULT NULL COMMENT '调度-时间',
  `trigger_code` int NOT NULL COMMENT '调度-结果',
  `trigger_msg` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '调度-日志',
  `handle_time` datetime(0) NULL DEFAULT NULL COMMENT '执行-时间',
  `handle_code` int NOT NULL COMMENT '执行-状态',
  `handle_msg` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '执行-日志',
  `alarm_status` tinyint NOT NULL DEFAULT 0 COMMENT '告警状态：0-默认、1-无需告警、2-告警成功、3-告警失败',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `I_trigger_time`(`trigger_time`) USING BTREE,
  INDEX `I_handle_code`(`handle_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of xxl_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for xxl_job_log_report
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_log_report`;
CREATE TABLE `xxl_job_log_report`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `trigger_day` datetime(0) NULL DEFAULT NULL COMMENT '调度-时间',
  `running_count` int NOT NULL DEFAULT 0 COMMENT '运行中-日志数量',
  `suc_count` int NOT NULL DEFAULT 0 COMMENT '执行成功-日志数量',
  `fail_count` int NOT NULL DEFAULT 0 COMMENT '执行失败-日志数量',
  `update_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `i_trigger_day`(`trigger_day`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of xxl_job_log_report
-- ----------------------------

-- ----------------------------
-- Table structure for xxl_job_logglue
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_logglue`;
CREATE TABLE `xxl_job_logglue`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `job_id` int NOT NULL COMMENT '任务，主键ID',
  `glue_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'GLUE类型',
  `glue_source` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT 'GLUE源代码',
  `glue_remark` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'GLUE备注',
  `add_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of xxl_job_logglue
-- ----------------------------

-- ----------------------------
-- Table structure for xxl_job_registry
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_registry`;
CREATE TABLE `xxl_job_registry`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `registry_group` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `registry_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `registry_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `i_g_k_v`(`registry_group`, `registry_key`, `registry_value`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of xxl_job_registry
-- ----------------------------

-- ----------------------------
-- Table structure for xxl_job_user
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_user`;
CREATE TABLE `xxl_job_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '账号',
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `role` tinyint NOT NULL COMMENT '角色：0-普通用户、1-管理员',
  `permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限：执行器ID列表，多个逗号分割',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `i_username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of xxl_job_user
-- ----------------------------
INSERT INTO `xxl_job_user` VALUES (1, 'admin', 'e10adc3949ba59abbe56e057f20f883e', 1, NULL);

SET FOREIGN_KEY_CHECKS = 1;
