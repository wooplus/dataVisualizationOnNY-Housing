-- MySQLShell dump 2.0.1  Distrib Ver 8.2.1 for macos13 on x86_64 - for MySQL 8.2.0 (MySQL Community Server (GPL)), for macos13 (x86_64)
--
-- Host: 34.75.9.212    Database: final-aung    Table: NYDataStructureView
-- ------------------------------------------------------
-- Server version	8.0.31

--
-- Final view structure for view `NYDataStructureView`
--

/*!50001 DROP VIEW IF EXISTS `NYDataStructureView`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `NYDataStructureView` AS select `information_schema`.`columns`.`COLUMN_NAME` AS `column_name`,`information_schema`.`columns`.`DATA_TYPE` AS `data_type`,`information_schema`.`columns`.`CHARACTER_MAXIMUM_LENGTH` AS `character_maximum_length` from `information_schema`.`COLUMNS` `columns` where (`information_schema`.`columns`.`TABLE_NAME` = 'NYHouse') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
