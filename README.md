# phk
phk

CREATE TABLE `board` (
  `ID` int(20) NOT NULL AUTO_INCREMENT,
  `WRITER` varchar(20) DEFAULT NULL,
  `TITLE` varchar(500) DEFAULT NULL,
  `CONTENT` varchar(4000) DEFAULT NULL,
  `CREATED` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
)

CREATE TABLE `confirmip` (
  `ID` int(20) NOT NULL AUTO_INCREMENT,
  `IP` varchar(30) NOT NULL,
  `CREATED` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
)

CREATE TABLE `customer` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(10) NOT NULL,
  `REG_NUM1` varchar(10) DEFAULT NULL,
  `REG_NUM2` varchar(10) DEFAULT NULL,
  `JOB` varchar(200) DEFAULT NULL,
  `TEL1` varchar(10) DEFAULT NULL,
  `TEL2` varchar(10) DEFAULT NULL,
  `TEL3` varchar(10) DEFAULT NULL,
  `RECEIVE` varchar(50) DEFAULT NULL,
  `MEMO` varchar(500) DEFAULT NULL,
  `STATUS` varchar(200) DEFAULT NULL,
  `MANAGE_YN` varchar(1) DEFAULT NULL,
  `MANAGER` varchar(50) DEFAULT NULL,
  `CREATED` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
)

CREATE TABLE `dailylog` (
  `ID` int(20) NOT NULL AUTO_INCREMENT,
  `REFEREE` varchar(20) DEFAULT NULL,
  `NAME` varchar(20) DEFAULT NULL,
  `CUSTOMERID` int(20) DEFAULT NULL,
  `FC` varchar(50) DEFAULT NULL,
  `MONEY` int(20) DEFAULT NULL,
  `DMONEY` int(20) DEFAULT NULL,
  `DBDATE` varchar(10) DEFAULT NULL,
  `DEPOSITDATE` varchar(10) DEFAULT NULL,
  `MANAGER` varchar(20) DEFAULT NULL,
  `STATUS` int(1) DEFAULT NULL,
  `CREATED` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
)

CREATE TABLE `fc` (
  `ID` int(20) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(20) NOT NULL,
  `CREATED` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
)

CREATE TABLE `manager` (
  `SEQ` int(20) NOT NULL AUTO_INCREMENT,
  `ID` varchar(200) NOT NULL,
  `PW` varchar(100) NOT NULL,
  `NAME` varchar(10) NOT NULL,
  `POSITION` varchar(20) DEFAULT NULL,
  `TEL1` varchar(10) DEFAULT NULL,
  `TEL2` varchar(10) DEFAULT NULL,
  `TEL3` varchar(10) DEFAULT NULL,
  `ETCTEL1` varchar(10) DEFAULT NULL,
  `ETCTEL2` varchar(10) DEFAULT NULL,
  `ETCTEL3` varchar(10) DEFAULT NULL,
  `STATUS` int(1) DEFAULT NULL,
  `CREATED` datetime DEFAULT NULL,
  `team_id` int(20) DEFAULT NULL,
  PRIMARY KEY (`SEQ`)
)

CREATE TABLE `memo` (
  `ID` int(20) NOT NULL AUTO_INCREMENT,
  `CUSTOMERID` int(20) DEFAULT NULL,
  `WRITER` varchar(20) DEFAULT NULL,
  `MEMO` varchar(500) DEFAULT NULL,
  `CREATED` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`ID`)
)

CREATE TABLE `status` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
)

CREATE TABLE `team` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
)
