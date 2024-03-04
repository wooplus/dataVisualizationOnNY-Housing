-- MySQLShell dump 2.0.1  Distrib Ver 8.2.1 for macos13 on x86_64 - for MySQL 8.2.0 (MySQL Community Server (GPL)), for macos13 (x86_64)
--
-- Host: 34.75.9.212    Database: final-aung
-- ------------------------------------------------------
-- Server version	8.0.31

--
-- Current Database: final-aung
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `final-aung` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `final-aung`;

--
-- Dumping events for database 'final-aung'
--

--
-- Dumping routines for database 'final-aung'
--

-- begin procedure `final-aung`.`getAveragePriceOfPropertyType`
/*!50003 DROP PROCEDURE IF EXISTS `getAveragePriceOfPropertyType` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getAveragePriceOfPropertyType`(param VARCHAR(255))
BEGIN 
    SELECT Type, AVG(Price) FROM NYHouse
    WHERE Type LIKE param
    GROUP BY Type;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
-- end procedure `final-aung`.`getAveragePriceOfPropertyType`

-- begin procedure `final-aung`.`getHousingOnSubLocality`
/*!50003 DROP PROCEDURE IF EXISTS `getHousingOnSubLocality` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getHousingOnSubLocality`(param VARCHAR(128))
BEGIN 
    SELECT BrokerTitle, Type, Price, PropertySqft FROM NYHouse
    WHERE SubLocality LIKE param
    ORDER BY Price DESC
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
-- end procedure `final-aung`.`getHousingOnSubLocality`

-- begin procedure `final-aung`.`getHousingListAndAveragePrice`
/*!50003 DROP PROCEDURE IF EXISTS `getHousingListAndAveragePrice` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `getHousingListAndAveragePrice`()
BEGIN 
    SELECT * FROM NYHouse;
    SELECT AVG(Price) FROM NYHouse;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
-- end procedure `final-aung`.`getHousingListAndAveragePrice`

