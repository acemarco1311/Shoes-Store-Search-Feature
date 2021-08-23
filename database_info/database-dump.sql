-- MySQL dump 10.13  Distrib 8.0.25, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: ShoesStore
-- ------------------------------------------------------
-- Server version	8.0.19-0ubuntu5

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `ShoesStore`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `ShoesStore` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `ShoesStore`;

--
-- Table structure for table `Addresses`
--

DROP TABLE IF EXISTS `Addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Addresses` (
  `addressID` int NOT NULL AUTO_INCREMENT,
  `number` int DEFAULT NULL,
  `streetName` varchar(50) DEFAULT NULL,
  `area` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `stateName` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`addressID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Addresses`
--

LOCK TABLES `Addresses` WRITE;
/*!40000 ALTER TABLE `Addresses` DISABLE KEYS */;
INSERT INTO `Addresses` VALUES (1,23,'Adelaide','Adelaide','Adelaide','South Australia','Australia');
/*!40000 ALTER TABLE `Addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Colors`
--

DROP TABLE IF EXISTS `Colors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Colors` (
  `colorID` int NOT NULL AUTO_INCREMENT,
  `colorName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`colorID`),
  UNIQUE KEY `uniqueColor` (`colorName`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Colors`
--

LOCK TABLES `Colors` WRITE;
/*!40000 ALTER TABLE `Colors` DISABLE KEYS */;
INSERT INTO `Colors` VALUES (4,'black'),(5,'pink'),(1,'red'),(2,'white'),(3,'yellow');
/*!40000 ALTER TABLE `Colors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ModelStock`
--

DROP TABLE IF EXISTS `ModelStock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ModelStock` (
  `recordID` int NOT NULL AUTO_INCREMENT,
  `itemID` int DEFAULT NULL,
  `size` decimal(3,1) DEFAULT NULL,
  `stockNumber` int DEFAULT NULL,
  PRIMARY KEY (`recordID`),
  KEY `modelFk` (`itemID`),
  CONSTRAINT `modelFk` FOREIGN KEY (`itemID`) REFERENCES `Shoes` (`itemID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `validStock` CHECK ((`stockNumber` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ModelStock`
--

LOCK TABLES `ModelStock` WRITE;
/*!40000 ALTER TABLE `ModelStock` DISABLE KEYS */;
INSERT INTO `ModelStock` VALUES (1,1,8.5,10),(2,1,7.0,2),(3,2,5.5,30),(4,3,9.0,3),(5,4,6.0,7),(6,4,6.5,0);
/*!40000 ALTER TABLE `ModelStock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Orders`
--

DROP TABLE IF EXISTS `Orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Orders` (
  `orderID` int NOT NULL AUTO_INCREMENT,
  `userID` int DEFAULT NULL,
  `itemID` int DEFAULT NULL,
  `dateCreated` datetime DEFAULT NULL,
  `orderStatus` tinyint(1) DEFAULT NULL,
  `itemSize` decimal(3,1) DEFAULT NULL,
  PRIMARY KEY (`orderID`),
  KEY `customerBuy` (`userID`),
  KEY `itemBought` (`itemID`),
  CONSTRAINT `customerBuy` FOREIGN KEY (`userID`) REFERENCES `Users` (`userID`) ON UPDATE CASCADE,
  CONSTRAINT `itemBought` FOREIGN KEY (`itemID`) REFERENCES `Shoes` (`itemID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Orders`
--

LOCK TABLES `Orders` WRITE;
/*!40000 ALTER TABLE `Orders` DISABLE KEYS */;
INSERT INTO `Orders` VALUES (1,1,1,'2021-06-30 00:00:00',1,8.5);
/*!40000 ALTER TABLE `Orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Shoes`
--

DROP TABLE IF EXISTS `Shoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Shoes` (
  `itemID` int NOT NULL AUTO_INCREMENT,
  `itemName` varchar(100) DEFAULT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `price` decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (`itemID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Shoes`
--

LOCK TABLES `Shoes` WRITE;
/*!40000 ALTER TABLE `Shoes` DISABLE KEYS */;
INSERT INTO `Shoes` VALUES (1,'Nike Air Force 1','Nike',200.00),(2,'Adidas Alpha Bouce','Adidas',150.00),(3,'Converse Chuck Taylor 1970s','Converse',60.00),(4,'Vans Old School','Vans',50.00);
/*!40000 ALTER TABLE `Shoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ShoesColor`
--

DROP TABLE IF EXISTS `ShoesColor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ShoesColor` (
  `shoesColorID` int NOT NULL AUTO_INCREMENT,
  `itemID` int DEFAULT NULL,
  `colorID` int DEFAULT NULL,
  PRIMARY KEY (`shoesColorID`),
  KEY `shoesColorFk` (`itemID`),
  KEY `colorFk` (`colorID`),
  CONSTRAINT `colorFk` FOREIGN KEY (`colorID`) REFERENCES `Colors` (`colorID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `shoesColorFk` FOREIGN KEY (`itemID`) REFERENCES `Shoes` (`itemID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ShoesColor`
--

LOCK TABLES `ShoesColor` WRITE;
/*!40000 ALTER TABLE `ShoesColor` DISABLE KEYS */;
INSERT INTO `ShoesColor` VALUES (1,1,1),(2,1,2),(3,2,1),(4,2,4),(5,3,3),(6,4,5);
/*!40000 ALTER TABLE `ShoesColor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ShoesStyle`
--

DROP TABLE IF EXISTS `ShoesStyle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ShoesStyle` (
  `shoesStyleID` int NOT NULL AUTO_INCREMENT,
  `itemID` int DEFAULT NULL,
  `styleID` int DEFAULT NULL,
  PRIMARY KEY (`shoesStyleID`),
  KEY `shoesStyleFk` (`itemID`),
  KEY `styleFk` (`styleID`),
  CONSTRAINT `shoesStyleFk` FOREIGN KEY (`itemID`) REFERENCES `Shoes` (`itemID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `styleFk` FOREIGN KEY (`styleID`) REFERENCES `Styles` (`styleID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ShoesStyle`
--

LOCK TABLES `ShoesStyle` WRITE;
/*!40000 ALTER TABLE `ShoesStyle` DISABLE KEYS */;
INSERT INTO `ShoesStyle` VALUES (1,1,1),(2,1,2),(3,2,3),(4,3,2),(5,4,4);
/*!40000 ALTER TABLE `ShoesStyle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Styles`
--

DROP TABLE IF EXISTS `Styles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Styles` (
  `styleID` int NOT NULL AUTO_INCREMENT,
  `styleName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`styleID`),
  UNIQUE KEY `uniqueStyle` (`styleName`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Styles`
--

LOCK TABLES `Styles` WRITE;
/*!40000 ALTER TABLE `Styles` DISABLE KEYS */;
INSERT INTO `Styles` VALUES (2,'casual'),(4,'chunky'),(1,'sneaker'),(3,'sporty');
/*!40000 ALTER TABLE `Styles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Users` (
  `userID` int NOT NULL AUTO_INCREMENT,
  `addressID` int DEFAULT NULL,
  `passwordHash` char(60) NOT NULL,
  `emailAddress` varchar(100) NOT NULL,
  `firstName` varchar(50) DEFAULT NULL,
  `lastName` varchar(50) DEFAULT NULL,
  `contactNumber` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE KEY `uniqueEmail` (`emailAddress`),
  KEY `userAddress` (`addressID`),
  CONSTRAINT `userAddress` FOREIGN KEY (`addressID`) REFERENCES `Addresses` (`addressID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (1,1,'exampleHash','acemarco9@gmail.com','Thanh Toan Nguyen','Le','123456756');
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-07-01  2:03:58


