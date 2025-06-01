/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.5.2-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: my_database
-- ------------------------------------------------------
-- Server version	11.5.2-MariaDB-ubu2404

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctrine_migration_versions`
--

LOCK TABLES `doctrine_migration_versions` WRITE;
/*!40000 ALTER TABLE `doctrine_migration_versions` DISABLE KEYS */;
INSERT INTO `doctrine_migration_versions` VALUES
('DoctrineMigrations\\Version20220920190821','2022-09-20 21:08:27',135),
('DoctrineMigrations\\Version20220922121542','2022-09-22 14:15:53',74),
('DoctrineMigrations\\Version20220922184201','2022-09-22 20:42:12',44),
('DoctrineMigrations\\Version20220924163010','2022-10-08 12:15:08',237),
('DoctrineMigrations\\Version20220924172138','2022-10-08 12:15:08',164),
('DoctrineMigrations\\Version20220924221120','2022-10-08 12:15:08',181);
/*!40000 ALTER TABLE `doctrine_migration_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messenger_messages`
--

DROP TABLE IF EXISTS `messenger_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messenger_messages` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `body` longtext NOT NULL,
  `headers` longtext NOT NULL,
  `queue_name` varchar(190) NOT NULL,
  `created_at` datetime NOT NULL,
  `available_at` datetime NOT NULL,
  `delivered_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  KEY `IDX_75EA56E016BA31DB` (`delivered_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messenger_messages`
--

LOCK TABLES `messenger_messages` WRITE;
/*!40000 ALTER TABLE `messenger_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messenger_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `order_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_F5299398A76ED395` (`user_id`),
  CONSTRAINT `FK_F5299398A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_content`
--

DROP TABLE IF EXISTS `order_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `quantity` int(11) NOT NULL,
  `dispacth_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_content`
--

LOCK TABLES `order_content` WRITE;
/*!40000 ALTER TABLE `order_content` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_product`
--

DROP TABLE IF EXISTS `order_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_product` (
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (`order_id`,`product_id`),
  KEY `IDX_2530ADE68D9F6D38` (`order_id`),
  KEY `IDX_2530ADE64584665A` (`product_id`),
  CONSTRAINT `FK_2530ADE64584665A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_2530ADE68D9F6D38` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_product`
--

LOCK TABLES `order_product` WRITE;
/*!40000 ALTER TABLE `order_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` longtext NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `image` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES
(52,'Fender Bass','Odio dolorum reiciendis tempore ad laudantium omnis deserunt. Nisi ut hic in architecto dolorem ducimus ut. Et atque laudantium fugit aspernatur.',32.33,'bass-ic-640268c5aa6b2.png'),
(53,'Queen.','Sed in libero sequi et facere modi. Dolor est architecto quia quaerat quis eaque voluptate. Aliquid deleniti voluptate soluta et laudantium qui.',493.50,'bass-ic1-640247403c24d.png'),
(54,'And so.','Quisquam voluptatem ratione vel est accusantium. Magnam similique dolor architecto quo molestias. Repellat quae debitis et aperiam consequatur vel id.',300.50,'btr300-632e26d0ec812.png'),
(55,'Latitude.','Animi consectetur quis voluptatibus quo asperiores repellat. Magni quod reprehenderit rem pariatur.',24.25,'fg700s-632e271809675.png'),
(56,'Alice.','Consequatur laudantium ducimus est. Animi sint dicta voluptatem numquam recusandae aperiam. Amet nobis voluptas animi natus ut asperiores.',493.00,'hofner-632e272f28527.png'),
(57,'I!\' said.','Quo similique officiis repellat recusandae quae. Modi amet quisquam blanditiis tempore culpa nesciunt voluptas. Esse iste aut rem similique. Quasi consequatur enim dolores consequuntur fugit.',233.00,'ibanez-632e2743db7fe.png'),
(58,'Duchess.','Est culpa eum aut nesciunt expedita vero consectetur. Occaecati libero deserunt aut dolorem aliquam magni. Possimus non deleniti assumenda ex ad esse. Aut quia ut sed reiciendis dignissimos.',103.50,'precision-632e2766a1015.png'),
(59,'Gibson Les Paul','Quam at quisquam delectus repellat suscipit. Et officia ipsam molestiae.',174.20,'les-paul-632e254b1836e.png'),
(60,'Hatter.','Expedita unde earum explicabo officiis et dolor voluptas libero. Et ab et quis. Sit qui aut similique nihil et quia.',75.80,'ludwig-632e278d3570b.png'),
(61,'MUST be.','Sit quam sapiente velit blanditiis. Voluptas doloribus error et est ut corrupti. Praesentium incidunt magnam reiciendis excepturi aliquid. Non magni itaque exercitationem facere ut molestias.',423.00,'pearl-632e27a211763.png');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `surname` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `state` varchar(100) NOT NULL,
  `city` varchar(50) NOT NULL,
  `address` varchar(100) NOT NULL,
  `email` varchar(180) NOT NULL,
  `roles` longtext NOT NULL COMMENT '(DC2Type:json)',
  `password` varchar(255) NOT NULL,
  `registration_date` datetime NOT NULL,
  `secret` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES
(1,'admin','admin','admin','admin','admin','admin','admin@admin.com','[\"ROLE_ADMIN\"]','$2y$13$lsejG4lXEzd6hHSC6glx3Ojjg.C3qdZAturk5uFF0g4VKRW6kUbom','0000-00-00 00:00:00',NULL),
(3,'John','Doe','Smith','New York','New York','Park Avenue','pepe@pepe.com','[]','$2y$13$8oqRbcSBxgy.6o9bo40.9OVv4Iq20MzPfwpTcx1cd1tOdieZ7x9p2','0000-00-00 00:00:00',NULL),
(15,'Tyshawn Doyle','Alvina','Streich','Swaziland','Evafort','91272 Nyah Coves\nWest Pierreburgh, IL 54131','salma.brakus@fay.com','[]','.J8l1\\uN>w','0000-00-00 00:00:00',NULL),
(16,'Uriel Kertzmann','Pete','Baumbach','Philippines','Larkinburgh','89739 Isac Station\nOsbaldoville, GA 47602','geovanny27@hotmail.com','[]','gN_E~X{N\'a9rBe5hu:','0000-00-00 00:00:00',NULL),
(17,'Kiara Carroll','Myles','Ratke','Taiwan','East Hoseabury','413 Goyette Coves\nWest Bradyton, WY 22380-2188','lebsack.alyson@feeney.net','[]',',M3A[4{v?9f&\'I=.=0','0000-00-00 00:00:00',NULL),
(18,'Miss Marisa Gusikowski Jr.','Berenice','Predovic','Zimbabwe','Anastasialand','1760 King CanyonNorth Penelopeland, AZ 70384','tate.murphy@olson.info','[]','$2y$13$/lFnC2ZMicroB.UrfjQBAerfbsXL3DVfOG5u7yAtRWUjeMnXMdIba','0000-00-00 00:00:00',NULL),
(19,'Chloe Orn','Mariam','O\'Hara','Georgia','North Everardo','13586 Mallory Mountains\nLake Catherinemouth, MO 75556','stoltenberg.rosamond@gmail.com','[]','Q(f?\\DcHZR','0000-00-00 00:00:00',NULL),
(20,'Loraine Stracke','Aiyana','Frami','Samoa','Littelchester','8044 Grimes Ways\nEast Meredith, NJ 37837','marvin.isobel@gerlach.com','[]','v=L:78A?|/!~AZPo$449','0000-00-00 00:00:00',NULL),
(21,'Maye Hagenes','Jacklyn','Hauck','Monaco','Lake Noemihaven','83539 Schamberger Club\nWest Nola, NM 27474-7052','christophe12@erdman.org','[]','+ME_ZV^LMu#u~','0000-00-00 00:00:00',NULL),
(22,'Clementina McKenzie','Zelda','Armstrong','Bahrain','Carlostown','8160 Arnoldo Fork\nEast Joanfurt, VA 89541-2456','miller.emmett@yahoo.com','[]','s=KI1Iw%\'Y=','0000-00-00 00:00:00',NULL),
(23,'Leonie O\'Hara','Cameron','Funk','Tokelau','South Oliverport','753 Grady Harbors Apt. 513\nSkilestown, CO 04138','amber.jacobi@gmail.com','[]','5*AsjHe','0000-00-00 00:00:00',NULL),
(24,'Thora Pagac','Tevin','Wolf','Netherlands','Lake Georgianahaven','96956 Julie Forest\nAlanaside, WI 71613','quincy71@gmail.com','[]','I:Z3]QIh-MS','0000-00-00 00:00:00',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2025-06-01 16:29:07
