-- MySQL dump 10.13  Distrib 5.7.21, for Win32 (AMD64)
--
-- Host: localhost    Database: phase1
-- ------------------------------------------------------
-- Server version	5.7.21-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `collection`
--

DROP TABLE IF EXISTS `collection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `collection` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loanID` int(11) NOT NULL,
  `amount` decimal(10,0) NOT NULL,
  `CollectDate` date NOT NULL,
  `userID` int(11) NOT NULL,
  `areaID` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `loanID` (`loanID`),
  KEY `userID` (`userID`),
  KEY `areaID` (`areaID`),
  CONSTRAINT `collection_ibfk_1` FOREIGN KEY (`loanID`) REFERENCES `loan` (`id`),
  CONSTRAINT `collection_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `users` (`id`),
  CONSTRAINT `collection_ibfk_3` FOREIGN KEY (`areaID`) REFERENCES `area` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collection`
--

LOCK TABLES `collection` WRITE;
/*!40000 ALTER TABLE `collection` DISABLE KEYS */;
INSERT INTO `collection` VALUES (2,2,100,'2017-12-29',1991,NULL),(4,2,100,'2017-12-29',1991,101),(5,2,100,'2017-12-29',1991,101),(6,2,100,'2017-12-29',1991,101),(7,2,100,'2017-12-29',1991,101),(8,2,100,'2017-12-29',1991,101),(9,2,100,'2017-12-29',1991,101),(10,2,100,'2017-12-29',1991,101),(11,2,100,'2017-12-29',1991,101),(12,2,100,'2017-12-29',1991,101),(13,1,100,'2017-12-29',1991,101),(14,6,100,'2017-12-30',1991,101),(15,5,100,'2017-12-30',1991,101),(16,1,100,'2017-12-29',1991,101);
/*!40000 ALTER TABLE `collection` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `decrease_due` AFTER INSERT ON `collection` FOR EACH ROW update loan 
   SET dueAmount = dueAmount - NEW.amount
   where id = new.loanID */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_ledger` AFTER INSERT ON `collection` FOR EACH ROW BEGIN
 if (Select count(*) from ledger where entryDate=new.CollectDate and entryType='Collection' and areaID = new.areaID )=1
 THEN
 UPDATE ledger set amount= amount+new.amount where  entryDate=new.CollectDate;
 ELSE
 INSERT into ledger (EntryDate,entryType,amount,creOrDe,areaID)
 values (new.CollectDate,"Collection", new.amount,"Credit",new.areaID);
 End if;
End */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_collection_entry` AFTER UPDATE ON `collection` FOR EACH ROW BEGIN
 if (old.amount>new.amount)
 THEN
 UPDATE ledger set amount= amount-(old.amount-new.amount) where  entryDate=new.CollectDate and entryType="Collection";
 ELSE
 UPDATE ledger set amount= amount+(new.amount-old.amount) where  entryDate=new.CollectDate and entryType="Collection"; 
 End if;
End */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_due` AFTER UPDATE ON `collection` FOR EACH ROW BEGIN
 if (old.amount>new.amount)
 THEN
 UPDATE loan set dueamount= dueamount+(old.amount-new.amount) where  id=new.LoanID;
 ELSE
 UPDATE loan set dueamount= dueamount-(new.amount-old.amount) where  id=new.LoanID; 
 End if;
End */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(200) DEFAULT NULL,
  `areaID` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `loginID` (`id`),
  UNIQUE KEY `name` (`username`),
  UNIQUE KEY `UK3g1j96g94xpk3lpxl2qbl985x` (`username`),
  UNIQUE KEY `UKr43af9ap4edm43mmtq01oddj6` (`username`),
  KEY `areaID` (`areaID`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`areaID`) REFERENCES `area` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (0,'rajadurai','$2a$10$EpmsM0/vl1uxQKyt2GDF2OG7sa27TDuq63D6ElBgbmV8L2L1tSXFS',NULL,'Rajadurai K'),(1989,'Manikandan','4a06d868d044c50af0cf9bc82d2fc19f',102,'Manikandan'),(1991,'Ramakrishnan','4a06d868d044c50af0cf9bc82d2fc19f',101,'Ramakrishnan'),(2709,'Govindharaj','f5c3dd7514bf620a1b85450d2ae374b1',101,'Govindharaj');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_roles` (
  `id` bigint(20) NOT NULL,
  `roleID` bigint(20) DEFAULT NULL,
  `userID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKji47nlsswey30e4s67uahy9ch` (`roleID`),
  KEY `FK8j1hw00sci6ft982pulb5n06q` (`userID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `area`
--

DROP TABLE IF EXISTS `area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `area` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `details` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `UK226rm1fd8fl8ewh0a7n1k8f94` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `area`
--

LOCK TABLES `area` WRITE;
/*!40000 ALTER TABLE `area` DISABLE KEYS */;
INSERT INTO `area` VALUES (101,'puducherry','Puducherry unit managed my primary stakeholders'),(102,'Cuddalore','Cuddalore unit managed my business partners');
/*!40000 ALTER TABLE `area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan`
--

DROP TABLE IF EXISTS `loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `loan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customerID` int(11) NOT NULL,
  `areaID` int(11) NOT NULL,
  `amount` decimal(10,0) NOT NULL,
  `startDate` date DEFAULT NULL,
  `dueAmount` decimal(10,0) DEFAULT NULL,
  `loanType` tinytext,
  `status` tinytext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `areaID` (`areaID`),
  KEY `customerID` (`customerID`),
  CONSTRAINT `loan_ibfk_1` FOREIGN KEY (`areaID`) REFERENCES `area` (`id`),
  CONSTRAINT `loan_ibfk_2` FOREIGN KEY (`customerID`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loan`
--

LOCK TABLES `loan` WRITE;
/*!40000 ALTER TABLE `loan` DISABLE KEYS */;
INSERT INTO `loan` VALUES (1,1001,101,10000,'2017-12-30',-200,'Daily','Open'),(2,1002,101,10000,'2017-12-28',8800,'Daily','Open'),(3,1003,101,80000,'2017-12-27',77600,'Daily','Open'),(4,1003,101,20000,'2017-12-25',19000,'Daily','Open'),(5,1004,101,20000,'2017-12-25',18900,'Daily','Open'),(6,1005,102,70000,'2017-12-25',66400,'Daily','Open'),(7,1002,101,10000,'2017-12-28',9800,'Daily','Open'),(8,1002,101,10000,'2017-12-28',9800,'Daily','WriteOff'),(9,1002,101,10000,'2017-12-28',9800,'Daily','Open');
/*!40000 ALTER TABLE `loan` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_loan_to_ledger` AFTER INSERT ON `loan` FOR EACH ROW BEGIN
INSERT INTO ledger ( EntryDate, loanID, entryType, amount, creOrDe,areaID) values
        (new.startDate, new.id, 'New Loan',new.amount,'Debit', new.areaID);
INSERT INTO ledger ( EntryDate, loanID, entryType, amount, creOrDe,areaID) values
        (new.startDate, new.id, 'Interest-New Loan',round(new.amount*.10),'Credit', new.areaID);
End */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_writeoff` AFTER UPDATE ON `loan` FOR EACH ROW begin
INSERT INTO ledger ( EntryDate, loanID, entryType, amount, creOrDe,areaID) values
        (new.startDate, new.id, 'WriteOff-Loss',new.dueAmount,'Debit', new.areaID);
End */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` bigint(20) NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `phoneNumber` varchar(10) NOT NULL,
  `areaID` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `UKcrkjmjk1oj8gb6j6t5kt7gcxm` (`name`),
  KEY `areaID` (`areaID`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`areaID`) REFERENCES `area` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1006 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1001,'Shakthi Govi','9894314840',101),(1002,'Sivagami','9894314840',101),(1003,'Sankar','9894314840',101),(1004,'Velu','9894314840',101),(1005,'Leo Terence','9894314840',102);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ledger`
--

DROP TABLE IF EXISTS `ledger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ledger` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `EntryDate` date NOT NULL,
  `loanID` int(11) DEFAULT NULL,
  `entryType` tinytext NOT NULL,
  `amount` decimal(10,0) NOT NULL,
  `creOrDe` tinytext NOT NULL,
  `userID` int(11) DEFAULT NULL,
  `areaID` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `loanID` (`loanID`),
  KEY `userID` (`userID`),
  KEY `areaID` (`areaID`),
  CONSTRAINT `ledger_ibfk_1` FOREIGN KEY (`loanID`) REFERENCES `loan` (`id`),
  CONSTRAINT `ledger_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `users` (`id`),
  CONSTRAINT `ledger_ibfk_3` FOREIGN KEY (`areaID`) REFERENCES `area` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ledger`
--

LOCK TABLES `ledger` WRITE;
/*!40000 ALTER TABLE `ledger` DISABLE KEYS */;
INSERT INTO `ledger` VALUES (1,'2017-12-29',NULL,'Collection',1100,'Credit',NULL,101),(2,'2017-12-30',NULL,'Collection',200,'Credit',NULL,101),(3,'2017-12-28',8,'New Loan',10000,'Debit',NULL,101),(4,'2017-12-28',8,'Interest-New Loan',10000,'Credit',NULL,101),(5,'2017-12-28',9,'New Loan',10000,'Debit',NULL,101),(6,'2017-12-28',9,'Interest-New Loan',1000,'Credit',NULL,101),(7,'2017-12-28',8,'WriteOff-Loss',9800,'Debit',NULL,101);
/*!40000 ALTER TABLE `ledger` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-05-20  4:24:58
