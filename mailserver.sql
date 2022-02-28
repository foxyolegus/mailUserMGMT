-- MariaDB dump 10.19  Distrib 10.5.12-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: mailserver
-- ------------------------------------------------------
-- Server version	10.5.12-MariaDB-0+deb11u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `virtual_aliases`
--

DROP TABLE IF EXISTS `virtual_aliases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `virtual_aliases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `source` varchar(100) NOT NULL,
  `destination` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `domain_id` (`domain_id`),
  CONSTRAINT `virtual_aliases_ibfk_1` FOREIGN KEY (`domain_id`) REFERENCES `virtual_domains` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `virtual_aliases`
--

LOCK TABLES `virtual_aliases` WRITE;
/*!40000 ALTER TABLE `virtual_aliases` DISABLE KEYS */;
INSERT INTO `virtual_aliases` VALUES (1,1,'webmaster@tstb.gov.tm','oleg.barzasekov@tstb.gov.tm'),(2,1,'info@tstb.gov.tm','r.durdyyew@tstb.gov.tm'),(3,1,'admin@tstb.gov.tm','m.karliyev@tstb.gov.tm'),(4,1,'admin@tstb.gov.tm','s.tashliyev@tstb.gov.tm');
/*!40000 ALTER TABLE `virtual_aliases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `virtual_domains`
--

DROP TABLE IF EXISTS `virtual_domains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `virtual_domains` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `virtual_domains`
--

LOCK TABLES `virtual_domains` WRITE;
/*!40000 ALTER TABLE `virtual_domains` DISABLE KEYS */;
INSERT INTO `virtual_domains` VALUES (1,'tstb.gov.tm');
/*!40000 ALTER TABLE `virtual_domains` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `virtual_users`
--

DROP TABLE IF EXISTS `virtual_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `virtual_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `password` varchar(106) NOT NULL,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `domain_id` (`domain_id`),
  CONSTRAINT `virtual_users_ibfk_1` FOREIGN KEY (`domain_id`) REFERENCES `virtual_domains` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `virtual_users`
--

LOCK TABLES `virtual_users` WRITE;
/*!40000 ALTER TABLE `virtual_users` DISABLE KEYS */;
INSERT INTO `virtual_users` VALUES (1,1,'$6$gq4g/f6LEIXIh0PS$qtwV8ErdVl0yrYnm91lX6GQTZ.4wipTkkLIeajKYuUVLcjeKjNmZxegMEdjY0g.zMGoyM9h8br4RVzkQs0Ihm1','oleg.barzasekov@tstb.gov.tm'),(3,1,'$6$AllKtUBdZN/yGbUI$8TH55w1YhCMcLz0MRnxw4EuG0oQ9bM3QyN5bjmKE3LU29lK2xZn.eEIMP.AjDr6vkB0U5W1wjd7Na9ZsJMRwa.','m.karliyev@tstb.gov.tm'),(4,1,'$6$AllKtUBdZN/yGbUI$8TH55w1YhCMcLz0MRnxw4EuG0oQ9bM3QyN5bjmKE3LU29lK2xZn.eEIMP.AjDr6vkB0U5W1wjd7Na9ZsJMRwa.','s.tashliyev@tstb.gov.tm'),(6,1,'$6$AllKtUBdZN/yGbUI$8TH55w1YhCMcLz0MRnxw4EuG0oQ9bM3QyN5bjmKE3LU29lK2xZn.eEIMP.AjDr6vkB0U5W1wjd7Na9ZsJMRwa.','chairman@tstb.gov.tm'),(9,1,'$6$AllKtUBdZN/yGbUI$8TH55w1YhCMcLz0MRnxw4EuG0oQ9bM3QyN5bjmKE3LU29lK2xZn.eEIMP.AjDr6vkB0U5W1wjd7Na9ZsJMRwa.','r.durdyyew@tstb.gov.tm'),(10,1,'$6$TZ0Y0bdasRNa7dTd$UmjA0vbcH8ixQBA1LlXY9YYWapLg1Slsl37HbQP4fsmcJUGa.QENVzuaHgzK1vPJVVlLcIK51EL352V58ICfN/','o.barzasekov@tstb.gov.tm'),(11,1,'B2U3yq4w6lNNFqCFJq4SsHF4Q60JN4KVIm1DnxnjD/YtuyMqjPMBh/b0ol+cSUPWG/t6fWsI/Eny\n6wWS6rfLyg==','test@tstb.gov.tm'),(12,1,'b15ff5c29551905ca063144fe5f1dc9a','postmaster@tstb.gov.tm');
/*!40000 ALTER TABLE `virtual_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-11 19:01:23
