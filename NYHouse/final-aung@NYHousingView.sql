-- MySQLShell dump 2.0.1  Distrib Ver 8.2.1 for macos13 on x86_64 - for MySQL 8.2.0 (MySQL Community Server (GPL)), for macos13 (x86_64)
--
-- Host: 34.75.9.212    Database: final-aung    Table: NYHousingView
-- ------------------------------------------------------
-- Server version	8.0.31

--
-- Final view structure for view `NYHousingView`
--

/*!50001 DROP VIEW IF EXISTS `NYHousingView`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `NYHousingView` AS select `NYHouse`.`BrokerTitle` AS `BrokerTitle`,`NYHouse`.`Type` AS `Type`,`NYHouse`.`Price` AS `Price`,`NYHouse`.`Beds` AS `Beds`,`NYHouse`.`Bath` AS `Bath`,`NYHouse`.`PropertySqft` AS `PropertySqft`,`NYHouse`.`Address` AS `Address`,`NYHouse`.`State` AS `State`,`NYHouse`.`MainAddress` AS `MainAddress`,`NYHouse`.`AdministrativeAreaLevel2` AS `AdministrativeAreaLevel2`,`NYHouse`.`Locality` AS `Locality`,`NYHouse`.`SubLocality` AS `SubLocality`,`NYHouse`.`StreetName` AS `StreetName`,`NYHouse`.`LongName` AS `LongName`,`NYHouse`.`FormattedAddress` AS `FormattedAddress`,`NYHouse`.`Latitude` AS `Latitude`,`NYHouse`.`Longitude` AS `Longitude` from `NYHouse` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
