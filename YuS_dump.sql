CREATE DATABASE  IF NOT EXISTS `laundromat` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `laundromat`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: laundromat
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `all_tickets`
--

DROP TABLE IF EXISTS `all_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `all_tickets` (
  `phone_number` varchar(15) DEFAULT NULL,
  `ticket_number` int NOT NULL DEFAULT '0',
  `total_cost` decimal(8,2) NOT NULL,
  `pick_up` date DEFAULT NULL,
  `weight` int DEFAULT NULL,
  `washing_method` enum('machine','hand') DEFAULT NULL,
  `drying_method` enum('dryer','hang_dry') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_tickets`
--

LOCK TABLES `all_tickets` WRITE;
/*!40000 ALTER TABLE `all_tickets` DISABLE KEYS */;
INSERT INTO `all_tickets` VALUES ('987-654-3210',2,15.75,'2222-05-01',8,'hand','hang_dry'),('929-228-8261',3,32.00,'2024-04-20',23,'machine','dryer'),('999-999-9999',4,10.00,'2024-04-18',10,'machine','dryer'),('313-333-3335',5,30.00,'2024-04-18',30,'machine','dryer'),('917-770-8028',6,49.00,'2024-04-18',49,'hand','hang_dry');
/*!40000 ALTER TABLE `all_tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `age` int NOT NULL,
  `customer_level` enum('old','new') DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Simon','Yu',21,'old'),(2,'John','Doe',30,'new'),(3,'Jane','Smith',25,'old'),(4,'John','Doe',30,'new'),(5,'Simon','Yu',21,'old'),(6,'Brandon','Huang',21,'new');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dryer`
--

DROP TABLE IF EXISTS `dryer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dryer` (
  `dryer_id` int NOT NULL AUTO_INCREMENT,
  `use_cost` decimal(8,2) DEFAULT NULL,
  `heat_type` enum('low','medium','high') DEFAULT NULL,
  `total_time` int DEFAULT '60',
  `bag_id` int NOT NULL,
  PRIMARY KEY (`dryer_id`),
  KEY `bag_id` (`bag_id`),
  CONSTRAINT `dryer_ibfk_1` FOREIGN KEY (`bag_id`) REFERENCES `ticket` (`ticket_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dryer`
--

LOCK TABLES `dryer` WRITE;
/*!40000 ALTER TABLE `dryer` DISABLE KEYS */;
INSERT INTO `dryer` VALUES (2,2.00,'high',60,2),(3,2.00,'high',60,3),(4,2.50,'high',60,5);
/*!40000 ALTER TABLE `dryer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fold`
--

DROP TABLE IF EXISTS `fold`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fold` (
  `total_bag` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(64) DEFAULT NULL,
  `last_name` varchar(64) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `efficiency` enum('slow','normal','fast') DEFAULT NULL,
  `work_hour` enum('part-time','full-time') DEFAULT NULL,
  `bag_id` int NOT NULL,
  PRIMARY KEY (`total_bag`),
  KEY `bag_id` (`bag_id`),
  CONSTRAINT `fold_ibfk_1` FOREIGN KEY (`bag_id`) REFERENCES `ticket` (`ticket_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fold`
--

LOCK TABLES `fold` WRITE;
/*!40000 ALTER TABLE `fold` DISABLE KEYS */;
INSERT INTO `fold` VALUES (2,'Ling','Zheng',20,'fast','full-time',3),(3,'Ling','Zheng',25,'fast','full-time',5);
/*!40000 ALTER TABLE `fold` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hand_wash`
--

DROP TABLE IF EXISTS `hand_wash`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hand_wash` (
  `laundry_id` int NOT NULL,
  `product_used` varchar(64) DEFAULT NULL,
  `wash_time` time DEFAULT '00:00:15',
  PRIMARY KEY (`laundry_id`),
  CONSTRAINT `hand_wash_ibfk_1` FOREIGN KEY (`laundry_id`) REFERENCES `ticket` (`ticket_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hand_wash`
--

LOCK TABLES `hand_wash` WRITE;
/*!40000 ALTER TABLE `hand_wash` DISABLE KEYS */;
INSERT INTO `hand_wash` VALUES (2,'Gentle detergent','00:00:15'),(6,'OXI CLEAN','00:00:15');
/*!40000 ALTER TABLE `hand_wash` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hang_dry`
--

DROP TABLE IF EXISTS `hang_dry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hang_dry` (
  `rack` int NOT NULL AUTO_INCREMENT,
  `ticket_id` int NOT NULL,
  PRIMARY KEY (`rack`),
  KEY `ticket_id` (`ticket_id`),
  CONSTRAINT `hang_dry_ibfk_1` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`ticket_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hang_dry`
--

LOCK TABLES `hang_dry` WRITE;
/*!40000 ALTER TABLE `hang_dry` DISABLE KEYS */;
INSERT INTO `hang_dry` VALUES (1,2),(2,6);
/*!40000 ALTER TABLE `hang_dry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `laundry_bag`
--

DROP TABLE IF EXISTS `laundry_bag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `laundry_bag` (
  `bag_id` int NOT NULL AUTO_INCREMENT,
  `color_bag` varchar(50) DEFAULT NULL,
  `customer_id` int NOT NULL,
  PRIMARY KEY (`bag_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `laundry_bag_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laundry_bag`
--

LOCK TABLES `laundry_bag` WRITE;
/*!40000 ALTER TABLE `laundry_bag` DISABLE KEYS */;
INSERT INTO `laundry_bag` VALUES (1,'blue',1),(2,'green',2),(3,'grey',3),(4,'blue',4),(5,'red',5),(6,'red',6);
/*!40000 ALTER TABLE `laundry_bag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket` (
  `phone_number` varchar(15) DEFAULT NULL,
  `ticket_number` int NOT NULL AUTO_INCREMENT,
  `total_cost` decimal(8,2) NOT NULL,
  `pick_up` date DEFAULT NULL,
  `weight` int DEFAULT NULL,
  `washing_method` enum('machine','hand') DEFAULT NULL,
  `drying_method` enum('dryer','hang_dry') DEFAULT NULL,
  PRIMARY KEY (`ticket_number`),
  UNIQUE KEY `phone_number` (`phone_number`),
  CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`ticket_number`) REFERENCES `laundry_bag` (`bag_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
INSERT INTO `ticket` VALUES ('987-654-3210',2,15.75,'2222-05-01',8,'hand','hang_dry'),('929-228-8261',3,32.00,'2024-04-20',23,'machine','dryer'),('999-999-9999',4,10.00,'2024-04-18',10,'machine','dryer'),('313-333-3335',5,30.00,'2024-04-18',30,'machine','dryer'),('917-770-8028',6,49.00,'2024-04-18',49,'hand','hang_dry');
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `create_wash_process` AFTER INSERT ON `ticket` FOR EACH ROW BEGIN
    DECLARE wash_size VARCHAR(10);
    DECLARE use_cost DECIMAL(8,2);
    
    -- Determine the size based on the weight
    SET wash_size = calculate_size(NEW.weight);
    
    -- Determine the use cost based on the size
    SET use_cost = calculate_use_cost(wash_size);
    
    -- Insert into washing_machine or hand_wash based on washing method
    IF NEW.washing_method = 'machine' THEN
        INSERT INTO washing_machine (size, detergent_type, softener_type, use_cost, bag_id)
        VALUES (wash_size, 'Tide', 'Downey Liquid', use_cost, NEW.ticket_number);
    ELSE
        INSERT INTO hand_wash (laundry_id, product_used)
        VALUES (NEW.ticket_number, 'OXI CLEAN');
    END IF;
END */;;
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
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `create_dry_process` AFTER INSERT ON `ticket` FOR EACH ROW BEGIN
    -- Declare a variable to store the new rack number
    DECLARE new_rack INT;

    -- Check if the drying method is 'dryer'
    IF NEW.drying_method = 'dryer' THEN
        -- Insert into dryer table
        INSERT INTO dryer (use_cost, heat_type, bag_id)
        VALUES (2.50, 'high', NEW.ticket_number);
    ELSE
        -- Insert into hang_dry table
        INSERT INTO hang_dry (ticket_id)
        VALUES (NEW.ticket_number);

        -- Retrieve the last inserted ID, which will be the new rack number
        SET new_rack = LAST_INSERT_ID();
    END IF;

    -- Use the new_rack variable as needed
END */;;
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
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `create_fold_process` AFTER INSERT ON `ticket` FOR EACH ROW BEGIN
	DECLARE bag_fold INT;
    -- Check if the drying method is 'dryer'
    IF NEW.drying_method = 'dryer' THEN
        -- Insert a new fold entry
        INSERT INTO fold (first_name, last_name, age, efficiency, work_hour, bag_id)
        VALUES ('Ling', 'Zheng', 25, 'fast', 'full-time', NEW.ticket_number);
        SET bag_fold = LAST_INSERT_ID();
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tickets_over_25`
--

DROP TABLE IF EXISTS `tickets_over_25`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets_over_25` (
  `phone_number` varchar(15) DEFAULT NULL,
  `ticket_number` int NOT NULL DEFAULT '0',
  `total_cost` decimal(8,2) NOT NULL,
  `pick_up` date DEFAULT NULL,
  `weight` int DEFAULT NULL,
  `washing_method` enum('machine','hand') DEFAULT NULL,
  `drying_method` enum('dryer','hang_dry') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets_over_25`
--

LOCK TABLES `tickets_over_25` WRITE;
/*!40000 ALTER TABLE `tickets_over_25` DISABLE KEYS */;
INSERT INTO `tickets_over_25` VALUES ('313-333-3335',5,30.00,'2024-04-18',30,'machine','dryer'),('917-770-8028',6,49.00,'2024-04-18',49,'hand','hang_dry');
/*!40000 ALTER TABLE `tickets_over_25` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `washing_machine`
--

DROP TABLE IF EXISTS `washing_machine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `washing_machine` (
  `washer_id` int NOT NULL AUTO_INCREMENT,
  `size` enum('regular','large') DEFAULT NULL,
  `detergent_type` varchar(255) DEFAULT NULL,
  `softener_type` varchar(255) DEFAULT NULL,
  `use_cost` decimal(8,2) DEFAULT NULL,
  `total_time` int DEFAULT '25',
  `bag_id` int NOT NULL,
  PRIMARY KEY (`washer_id`),
  KEY `bag_id` (`bag_id`),
  CONSTRAINT `washing_machine_ibfk_1` FOREIGN KEY (`bag_id`) REFERENCES `ticket` (`ticket_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `washing_machine`
--

LOCK TABLES `washing_machine` WRITE;
/*!40000 ALTER TABLE `washing_machine` DISABLE KEYS */;
INSERT INTO `washing_machine` VALUES (3,'large','Tide','softener Y',3.00,25,3),(4,'large','Tide','Downey Liquid',3.00,25,5);
/*!40000 ALTER TABLE `washing_machine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'laundromat'
--

--
-- Dumping routines for database 'laundromat'
--
/*!50003 DROP FUNCTION IF EXISTS `calculate_cost_per_pound` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `calculate_cost_per_pound`(weight INT) RETURNS decimal(8,2)
    DETERMINISTIC
BEGIN
    DECLARE cost DECIMAL(8,2);
    SET cost = weight * 1.0; -- $1.00 per pound
    RETURN cost;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `calculate_size` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `calculate_size`(weight INT) RETURNS varchar(10) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE size VARCHAR(10);
    
    -- Determine the size based on the weight
    IF weight > 25 THEN
        SET size = 'large';
    ELSE
        SET size = 'regular';
    END IF;
    
    RETURN size;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `calculate_total_earning` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `calculate_total_earning`() RETURNS decimal(8,2)
    DETERMINISTIC
BEGIN
    DECLARE total_earning DECIMAL(8,2);
    DECLARE total_cost DECIMAL(8,2);
    
    -- Initialize total earning
    SET total_earning = 0.0;
    
    -- Calculate total earning by summing up total cost of all tickets
    SELECT SUM(ticket.total_cost) into total_cost FROM laundromat.ticket;

    
    -- If total_cost is not NULL, add it to total earning
    IF total_cost IS NOT NULL THEN
        SET total_earning = total_cost;
    END IF;
    
    RETURN total_earning;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `calculate_use_cost` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `calculate_use_cost`(size VARCHAR(10)) RETURNS decimal(8,2)
    DETERMINISTIC
BEGIN
    DECLARE use_cost DECIMAL(8,2);
    
    -- Determine the use cost based on the size
    IF size = 'large' THEN
        SET use_cost = 3.00;
    ELSE
        SET use_cost = 2.50;
    END IF;
    
    RETURN use_cost;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `create_customer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `create_customer`(
    p_first_name VARCHAR(255),
	p_last_name VARCHAR(255),
    p_age INT,
    p_customer_level ENUM('old', 'new')
) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE new_customer_id INT;
    
    -- Insert a new record into the customer table
    INSERT INTO customer (first_name, last_name, age, customer_level)
    VALUES (p_first_name, p_last_name, p_age, p_customer_level);
    
    -- Retrieve the auto-generated customer ID
    SET new_customer_id = LAST_INSERT_ID();
    
    -- Return the newly created customer ID
    RETURN new_customer_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_laundry_bag` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_laundry_bag`(
    IN color VARCHAR(50),
    IN first_name VARCHAR(255),
    IN last_name VARCHAR(255),
	IN age INT,
    IN customer_level ENUM('old', 'new')
)
BEGIN
    DECLARE new_customer_id INT;
    
    -- Insert a new record into the customer table to get the auto-incremented customer_id
    INSERT INTO customer (first_name, last_name, age, customer_level)
    VALUES (first_name, last_name, age, customer_level);
    
    -- Retrieve the auto-generated customer ID
    SET new_customer_id = LAST_INSERT_ID();
    
    -- Insert a new record into the laundry_bag table with the generated customer_id
    INSERT INTO laundry_bag (color_bag, customer_id)
    VALUES (color, new_customer_id);
    
    -- Return a message indicating the successful creation of the laundry bag
    SELECT 'Laundry bag created successfully.' AS message;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_ticket` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_ticket`(
    IN phone_num VARCHAR(15),
    IN pick_up_date DATE,
    IN weight INT,
    IN washing_method ENUM('machine', 'hand'),
    IN drying_method ENUM('dryer', 'hang_dry')
)
BEGIN
    DECLARE total_cost DECIMAL(8,2);
    
    -- Calculate the total cost based on the weight
    SET total_cost = calculate_cost_per_pound(weight);
    
    -- Insert a new record into the ticket table
    INSERT INTO ticket (phone_number, pick_up, weight, washing_method, drying_method, total_cost)
    VALUES (phone_num, pick_up_date, weight, washing_method, drying_method, total_cost);
    
    -- Retrieve the auto-generated ticket number
    SELECT LAST_INSERT_ID() AS new_ticket_number, total_cost;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_ticket` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_ticket`(
    IN p_ticket_number INT
)
BEGIN
    -- Delete the ticket with the specified ticket number
    DELETE FROM ticket WHERE ticket_number = p_ticket_number;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_pick_up_date` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_pick_up_date`(
    IN p_ticket_number INT,
    IN p_new_pick_up_date DATE
)
BEGIN
    -- Update the pick-up date for the specified ticket
    UPDATE ticket
    SET pick_up = p_new_pick_up_date
    WHERE ticket_number = p_ticket_number;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-18  2:02:29
