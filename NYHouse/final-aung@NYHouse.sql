-- MySQLShell dump 2.0.1  Distrib Ver 8.2.1 for macos13 on x86_64 - for MySQL 8.2.0 (MySQL Community Server (GPL)), for macos13 (x86_64)
--
-- Host: 34.75.9.212    Database: final-aung    Table: NYHouse
-- ------------------------------------------------------
-- Server version	8.0.31

--
-- Table structure for table `NYHouse`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE IF NOT EXISTS `NYHouse` (
  `BrokerTitle` varchar(255) DEFAULT NULL,
  `Type` varchar(255) DEFAULT NULL,
  `Price` int DEFAULT NULL,
  `Beds` tinyint DEFAULT NULL,
  `Bath` tinyint DEFAULT NULL,
  `PropertySqft` decimal(11,6) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `State` varchar(255) DEFAULT NULL,
  `MainAddress` varchar(255) DEFAULT NULL,
  `AdministrativeAreaLevel2` varchar(128) DEFAULT NULL,
  `Locality` varchar(128) DEFAULT NULL,
  `SubLocality` varchar(128) DEFAULT NULL,
  `StreetName` varchar(128) DEFAULT NULL,
  `LongName` varchar(128) DEFAULT NULL,
  `FormattedAddress` varchar(255) DEFAULT NULL,
  `Latitude` decimal(11,8) DEFAULT NULL,
  `Longitude` decimal(11,8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
