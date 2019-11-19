USE devops_ci_environment;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for T_ENV
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_ENV` (
  `ENV_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `PROJECT_ID` varchar(64) NOT NULL,
  `ENV_NAME` varchar(128) NOT NULL,
  `ENV_DESC` varchar(128) NOT NULL,
  `ENV_TYPE` varchar(128) NOT NULL,
  `ENV_VARS` text NOT NULL,
  `CREATED_USER` varchar(64) NOT NULL,
  `UPDATED_USER` varchar(64) NOT NULL,
  `CREATED_TIME` timestamp NULL DEFAULT NULL,
  `UPDATED_TIME` timestamp NULL DEFAULT NULL,
  `IS_DELETED` bit(1) NOT NULL,
  PRIMARY KEY (`ENV_ID`),
  KEY `PROJECT_ID` (`PROJECT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_ENVIRONMENT_AGENT_PIPELINE
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_ENVIRONMENT_AGENT_PIPELINE` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `AGENT_ID` bigint(20) NOT NULL,
  `PROJECT_ID` varchar(32) NOT NULL,
  `USER_ID` varchar(32) NOT NULL,
  `CREATED_TIME` datetime NOT NULL,
  `UPDATED_TIME` datetime NOT NULL,
  `STATUS` int(11) NOT NULL,
  `PIPELINE` varchar(1024) NOT NULL,
  `RESPONSE` text,
  PRIMARY KEY (`ID`),
  KEY `AGENT_ID` (`AGENT_ID`),
  KEY `STATUS` (`STATUS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_ENVIRONMENT_SLAVE_GATEWAY
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_ENVIRONMENT_SLAVE_GATEWAY` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(32) NOT NULL,
  `SHOW_NAME` varchar(32) NOT NULL,
  `GATEWAY` varchar(127) DEFAULT '',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `NAME` (`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_ENVIRONMENT_THIRDPARTY_AGENT
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_ENVIRONMENT_THIRDPARTY_AGENT` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `NODE_ID` bigint(20) DEFAULT NULL,
  `PROJECT_ID` varchar(64) NOT NULL,
  `HOSTNAME` varchar(128) DEFAULT '',
  `IP` varchar(64) DEFAULT '',
  `OS` varchar(16) NOT NULL,
  `DETECT_OS` varchar(128) DEFAULT '',
  `STATUS` int(11) NOT NULL,
  `SECRET_KEY` varchar(256) NOT NULL,
  `CREATED_USER` varchar(64) NOT NULL,
  `CREATED_TIME` datetime NOT NULL,
  `START_REMOTE_IP` varchar(64) DEFAULT NULL,
  `GATEWAY` varchar(256) DEFAULT '',
  `VERSION` varchar(128) DEFAULT NULL,
  `MASTER_VERSION` varchar(128) DEFAULT NULL,
  `PARALLEL_TASK_COUNT` int(11) DEFAULT NULL,
  `AGENT_INSTALL_PATH` varchar(512) DEFAULT NULL,
  `STARTED_USER` varchar(64) DEFAULT NULL,
  `AGENT_ENVS` text,
  PRIMARY KEY (`ID`),
  KEY `idx_agent_node` (`NODE_ID`),
  KEY `idx_agent_project` (`PROJECT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_ENVIRONMENT_THIRDPARTY_AGENT_ACTION
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_ENVIRONMENT_THIRDPARTY_AGENT_ACTION` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `AGENT_ID` bigint(20) NOT NULL,
  `PROJECT_ID` varchar(64) NOT NULL,
  `ACTION` varchar(64) NOT NULL,
  `ACTION_TIME` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `AGENT_ID` (`AGENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_ENV_NODE
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_ENV_NODE` (
  `ENV_ID` bigint(20) NOT NULL,
  `NODE_ID` bigint(20) NOT NULL,
  `PROJECT_ID` varchar(64) NOT NULL,
  PRIMARY KEY (`ENV_ID`,`NODE_ID`),
  KEY `PROJECT_ID` (`PROJECT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_NODE
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_NODE` (
  `NODE_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `NODE_STRING_ID` varchar(32) DEFAULT NULL,
  `PROJECT_ID` varchar(64) NOT NULL,
  `NODE_IP` varchar(64) NOT NULL,
  `NODE_NAME` varchar(64) NOT NULL,
  `NODE_STATUS` varchar(64) NOT NULL,
  `NODE_TYPE` varchar(64) NOT NULL,
  `NODE_CLUSTER_ID` varchar(128) DEFAULT NULL,
  `NODE_NAMESPACE` varchar(128) DEFAULT NULL,
  `CREATED_USER` varchar(64) NOT NULL,
  `CREATED_TIME` timestamp NULL DEFAULT NULL,
  `EXPIRE_TIME` timestamp NULL DEFAULT NULL,
  `OS_NAME` varchar(128) DEFAULT NULL,
  `OPERATOR` varchar(256) DEFAULT NULL,
  `BAK_OPERATOR` varchar(256) DEFAULT NULL,
  `AGENT_STATUS` bit(1) DEFAULT NULL,
  `DISPLAY_NAME` varchar(128) NOT NULL DEFAULT '',
  `IMAGE` varchar(512) DEFAULT NULL,
  `TASK_ID` bigint(20) DEFAULT NULL,
  `LAST_MODIFY_TIME` timestamp NULL DEFAULT NULL,
  `LAST_MODIFY_USER` varchar(512) DEFAULT NULL,
  `BIZ_ID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`NODE_ID`),
  KEY `PROJECT_ID` (`PROJECT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_PROJECT_CONFIG
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_PROJECT_CONFIG` (
  `PROJECT_ID` varchar(64) NOT NULL,
  `UPDATED_USER` varchar(64) NOT NULL,
  `UPDATED_TIME` timestamp NULL DEFAULT NULL,
  `BCSVM_ENALBED` bit(1) NOT NULL DEFAULT b'0',
  `BCSVM_QUOTA` int(11) NOT NULL DEFAULT '0',
  `IMPORT_QUOTA` int(11) NOT NULL DEFAULT '30',
  `DEV_CLOUD_ENALBED` bit(1) NOT NULL DEFAULT b'0',
  `DEV_CLOUD_QUOTA` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`PROJECT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `T_AGENT_FAILURE_NOTIFY_USER`
(
    `ID`           bigint(20) NOT NULL AUTO_INCREMENT,
    `USER_ID`      varchar(32) DEFAULT '',
    `NOTIFY_TYPES` varchar(32) DEFAULT '',
    PRIMARY KEY (`ID`),
    UNIQUE KEY `USER_ID` (`USER_ID`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS `T_ENVIRONMENT_THIRDPARTY_ENABLE_PROJECTS`
(
    `PROJECT_ID`   varchar(64) NOT NULL,
    `ENALBE`       tinyint(1) DEFAULT NULL,
    `CREATED_TIME` datetime    NOT NULL,
    `UPDATED_TIME` datetime    NOT NULL,
    PRIMARY KEY (`PROJECT_ID`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

SET FOREIGN_KEY_CHECKS = 1;
