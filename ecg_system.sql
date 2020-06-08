/*
SQLyog Ultimate v11.42 (64 bit)
MySQL - 5.6.21 : Database - ecg_system
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`ecg_system` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `ecg_system`;

/*Table structure for table `ecg_admin` */

DROP TABLE IF EXISTS `ecg_admin`;

CREATE TABLE `ecg_admin` (
  `adm_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '序号',
  `adm_name` varchar(50) NOT NULL COMMENT '管理员名',
  `password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`adm_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='管理员信息表';

/*Data for the table `ecg_admin` */

insert  into `ecg_admin`(`adm_id`,`adm_name`,`password`) values (1,'Lin','1998');

/*Table structure for table `ecg_doctor` */

DROP TABLE IF EXISTS `ecg_doctor`;

CREATE TABLE `ecg_doctor` (
  `doc_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '序号',
  `doc_name` varchar(50) NOT NULL COMMENT '医生名',
  `password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`doc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='医生信息表';

/*Data for the table `ecg_doctor` */

/*Table structure for table `ecg_info` */

DROP TABLE IF EXISTS `ecg_info`;

CREATE TABLE `ecg_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '序号',
  `url` varchar(100) NOT NULL COMMENT '心电图URL地址',
  `beizhu` varchar(200) DEFAULT NULL COMMENT '备注',
  `user_name` varchar(50) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `ecg_info_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `ecg_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='心电图信息表';

/*Data for the table `ecg_info` */

/*Table structure for table `ecg_menu` */

DROP TABLE IF EXISTS `ecg_menu`;

CREATE TABLE `ecg_menu` (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '菜单id',
  `parent_id` int(11) NOT NULL COMMENT '上一级菜单id',
  `menu_text` varchar(256) NOT NULL COMMENT '菜单文本',
  `menu_url` varchar(256) NOT NULL COMMENT '菜单url',
  `permis_id` int(11) NOT NULL COMMENT '权限id',
  `enable_flag` tinyint(4) NOT NULL DEFAULT '1' COMMENT '启用标示,1、启用，2、禁用',
  `menu_order` int(11) NOT NULL DEFAULT '0' COMMENT '菜单顺序. 通常一级菜单才需要设置',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='菜单表';

/*Data for the table `ecg_menu` */

/*Table structure for table `ecg_permis` */

DROP TABLE IF EXISTS `ecg_permis`;

CREATE TABLE `ecg_permis` (
  `permis_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '权限id',
  `parent_permis_id` int(11) NOT NULL,
  `permis_name` varchar(80) NOT NULL COMMENT '权限名称',
  `menu_permis_flag` tinyint(4) NOT NULL COMMENT '1:菜单权限\n2:功能权限',
  `permis_code` varchar(100) NOT NULL COMMENT '权限code',
  `remark` varchar(500) NOT NULL DEFAULT '' COMMENT '备注',
  `permis_order` int(11) NOT NULL DEFAULT '0' COMMENT '权限顺序, 通常一级权限才需要设置',
  PRIMARY KEY (`permis_id`),
  UNIQUE KEY `permis_code_UNIQUE` (`permis_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限表';

/*Data for the table `ecg_permis` */

/*Table structure for table `ecg_role` */

DROP TABLE IF EXISTS `ecg_role`;

CREATE TABLE `ecg_role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `role_code` varchar(20) NOT NULL COMMENT '角色code',
  `role_name` varchar(30) NOT NULL COMMENT '角色名称',
  `type` tinyint(4) NOT NULL COMMENT '1、系统管理员\n2、一般用户角色',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色表';

/*Data for the table `ecg_role` */

/*Table structure for table `ecg_user` */

DROP TABLE IF EXISTS `ecg_user`;

CREATE TABLE `ecg_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `user_name` varchar(50) DEFAULT NULL COMMENT '用户姓名',
  `password` varchar(100) DEFAULT NULL COMMENT '登录密码',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='用户表';

/*Data for the table `ecg_user` */

insert  into `ecg_user`(`user_id`,`user_name`,`password`) values (1,'wincy','1998'),(2,'sue','1998'),(3,'zhixin','1998');

/*Table structure for table `role_permis` */

DROP TABLE IF EXISTS `role_permis`;

CREATE TABLE `role_permis` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `permis_id` int(11) NOT NULL COMMENT '权限id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_permis_UNIQUE` (`role_id`,`permis_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色权限关联表';

/*Data for the table `role_permis` */

/*Table structure for table `user_role` */

DROP TABLE IF EXISTS `user_role`;

CREATE TABLE `user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_user_UNIQUE` (`role_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色关联表';

/*Data for the table `user_role` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
