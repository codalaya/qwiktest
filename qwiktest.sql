-- MySQL dump 10.13  Distrib 8.0.35, for Linux (x86_64)
--
-- Host: localhost    Database: quiktest
-- ------------------------------------------------------
-- Server version	8.0.35-0ubuntu0.22.04.1

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
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `image_path` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categories_code_unique` (`code`),
  UNIQUE KEY `categories_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Half Yearly Exams','cat_v7tS9K1lCNs','half-yearly-exams',NULL,NULL,NULL,1,'2024-02-06 04:37:51','2024-02-06 04:37:51',NULL);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comprehension_passages`
--

DROP TABLE IF EXISTS `comprehension_passages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comprehension_passages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `comprehension_passages_code_unique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comprehension_passages`
--

LOCK TABLES `comprehension_passages` WRITE;
/*!40000 ALTER TABLE `comprehension_passages` DISABLE KEYS */;
/*!40000 ALTER TABLE `comprehension_passages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `difficulty_levels`
--

DROP TABLE IF EXISTS `difficulty_levels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `difficulty_levels` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `difficulty_levels_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `difficulty_levels`
--

LOCK TABLES `difficulty_levels` WRITE;
/*!40000 ALTER TABLE `difficulty_levels` DISABLE KEYS */;
INSERT INTO `difficulty_levels` VALUES (1,'Very Easy','VERYEASY',1,NULL,NULL,NULL),(2,'Easy','EASY',1,NULL,NULL,NULL),(3,'Medium','MEDIUM',1,NULL,NULL,NULL),(4,'High','HIGH',1,NULL,NULL,NULL),(5,'Very High','VERYHIGH',1,NULL,NULL,NULL);
/*!40000 ALTER TABLE `difficulty_levels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_questions`
--

DROP TABLE IF EXISTS `exam_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_questions` (
  `exam_id` bigint unsigned NOT NULL,
  `question_id` bigint unsigned NOT NULL,
  `exam_section_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`exam_id`,`question_id`),
  KEY `exam_questions_question_id_foreign` (`question_id`),
  KEY `exam_questions_exam_section_id_index` (`exam_section_id`),
  CONSTRAINT `exam_questions_exam_id_foreign` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `exam_questions_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_questions`
--

LOCK TABLES `exam_questions` WRITE;
/*!40000 ALTER TABLE `exam_questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_schedules`
--

DROP TABLE IF EXISTS `exam_schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_schedules` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `exam_id` bigint unsigned NOT NULL,
  `schedule_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'fixed',
  `start_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_date` date DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `grace_period` int NOT NULL DEFAULT '5',
  `send_email` tinyint(1) NOT NULL DEFAULT '0',
  `settings` json DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `exam_schedules_code_unique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_schedules`
--

LOCK TABLES `exam_schedules` WRITE;
/*!40000 ALTER TABLE `exam_schedules` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam_schedules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_sections`
--

DROP TABLE IF EXISTS `exam_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_sections` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `exam_id` bigint unsigned NOT NULL,
  `section_id` bigint unsigned NOT NULL,
  `total_questions` int unsigned NOT NULL DEFAULT '0',
  `total_duration` int unsigned DEFAULT NULL,
  `correct_marks` double(10,2) DEFAULT NULL,
  `total_marks` double(10,2) DEFAULT NULL,
  `negative_marking_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'fixed',
  `negative_marks` double(10,2) DEFAULT NULL,
  `section_cutoff` int unsigned DEFAULT NULL,
  `section_order` int unsigned NOT NULL DEFAULT '1',
  `assign_examiner` int unsigned NOT NULL DEFAULT '0',
  `examiner_id` bigint unsigned DEFAULT NULL,
  `examined` tinyint(1) NOT NULL DEFAULT '0',
  `examined_at` datetime DEFAULT NULL,
  `approved` tinyint(1) NOT NULL DEFAULT '0',
  `approved_at` datetime DEFAULT NULL,
  `approved_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_sections`
--

LOCK TABLES `exam_sections` WRITE;
/*!40000 ALTER TABLE `exam_sections` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_session_questions`
--

DROP TABLE IF EXISTS `exam_session_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_session_questions` (
  `exam_session_id` bigint unsigned NOT NULL,
  `sno` bigint unsigned NOT NULL DEFAULT '1',
  `question_id` bigint unsigned NOT NULL,
  `exam_section_id` bigint unsigned NOT NULL,
  `original_question` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` text COLLATE utf8mb4_unicode_ci,
  `user_answer` text COLLATE utf8mb4_unicode_ci,
  `correct_answer` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unanswered',
  `is_correct` tinyint(1) DEFAULT NULL,
  `time_taken` int NOT NULL DEFAULT '0',
  `marks_earned` double(5,2) NOT NULL DEFAULT '0.00',
  `marks_deducted` double(5,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`exam_session_id`,`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_session_questions`
--

LOCK TABLES `exam_session_questions` WRITE;
/*!40000 ALTER TABLE `exam_session_questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam_session_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_session_sections`
--

DROP TABLE IF EXISTS `exam_session_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_session_sections` (
  `sno` bigint unsigned NOT NULL DEFAULT '1',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `exam_session_id` bigint unsigned NOT NULL,
  `exam_section_id` bigint unsigned NOT NULL,
  `section_id` bigint unsigned NOT NULL,
  `starts_at` datetime DEFAULT NULL,
  `ends_at` datetime DEFAULT NULL,
  `total_time_taken` int NOT NULL DEFAULT '0',
  `current_question` int NOT NULL DEFAULT '0',
  `results` json DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'not_visited',
  PRIMARY KEY (`exam_session_id`,`exam_section_id`),
  KEY `exam_session_sections_sno_index` (`sno`),
  KEY `exam_session_sections_status_index` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_session_sections`
--

LOCK TABLES `exam_session_sections` WRITE;
/*!40000 ALTER TABLE `exam_session_sections` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam_session_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_sessions`
--

DROP TABLE IF EXISTS `exam_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_sessions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `exam_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `exam_schedule_id` bigint unsigned DEFAULT NULL,
  `starts_at` datetime NOT NULL,
  `ends_at` datetime NOT NULL,
  `total_time_taken` int NOT NULL DEFAULT '0',
  `current_section` int NOT NULL DEFAULT '0',
  `current_question` int NOT NULL DEFAULT '0',
  `results` json DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'started',
  `completed_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `exam_sessions_code_unique` (`code`),
  KEY `exam_sessions_status_index` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_sessions`
--

LOCK TABLES `exam_sessions` WRITE;
/*!40000 ALTER TABLE `exam_sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_types`
--

DROP TABLE IF EXISTS `exam_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_types` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `image_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'http://placehold.it/100x100',
  `color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '444444',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `exam_types_code_unique` (`code`),
  UNIQUE KEY `exam_types_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_types`
--

LOCK TABLES `exam_types` WRITE;
/*!40000 ALTER TABLE `exam_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exams`
--

DROP TABLE IF EXISTS `exams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exams` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `exam_type_id` int NOT NULL,
  `exam_mode` enum('objective','subjective','mixed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'objective',
  `sub_category_id` bigint unsigned NOT NULL,
  `exam_template_id` bigint unsigned DEFAULT NULL,
  `total_marks` double(10,2) DEFAULT NULL,
  `total_duration` int unsigned NOT NULL DEFAULT '0',
  `total_questions` int unsigned NOT NULL DEFAULT '0',
  `is_paid` tinyint(1) NOT NULL DEFAULT '0',
  `price` bigint unsigned DEFAULT NULL,
  `can_redeem` tinyint(1) NOT NULL DEFAULT '0',
  `points_required` int unsigned DEFAULT NULL,
  `settings` json DEFAULT NULL,
  `is_private` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `exams_slug_unique` (`slug`),
  UNIQUE KEY `exams_code_unique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exams`
--

LOCK TABLES `exams` WRITE;
/*!40000 ALTER TABLE `exams` DISABLE KEYS */;
/*!40000 ALTER TABLE `exams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `features`
--

DROP TABLE IF EXISTS `features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `features` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` int NOT NULL DEFAULT '1',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `features_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `features`
--

LOCK TABLES `features` WRITE;
/*!40000 ALTER TABLE `features` DISABLE KEYS */;
INSERT INTO `features` VALUES (1,'Practice Sets','practice_sets',NULL,1,1,NULL,NULL),(2,'Quizzes','quizzes',NULL,2,1,NULL,NULL),(3,'Lessons','lessons',NULL,3,1,NULL,NULL),(4,'Videos','videos',NULL,4,1,NULL,NULL),(5,'Exams','exams',NULL,5,1,NULL,NULL);
/*!40000 ALTER TABLE `features` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lessons`
--

DROP TABLE IF EXISTS `lessons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lessons` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `duration` int NOT NULL DEFAULT '1',
  `skill_id` bigint unsigned NOT NULL,
  `topic_id` bigint unsigned DEFAULT NULL,
  `difficulty_level_id` bigint unsigned NOT NULL DEFAULT '1',
  `preferences` json DEFAULT NULL,
  `avg_read_time` int NOT NULL DEFAULT '0',
  `total_reads` bigint unsigned NOT NULL DEFAULT '0',
  `is_paid` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lessons_code_unique` (`code`),
  KEY `lessons_skill_id_foreign` (`skill_id`),
  KEY `lessons_topic_id_foreign` (`topic_id`),
  CONSTRAINT `lessons_skill_id_foreign` FOREIGN KEY (`skill_id`) REFERENCES `skills` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `lessons_topic_id_foreign` FOREIGN KEY (`topic_id`) REFERENCES `topics` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lessons`
--

LOCK TABLES `lessons` WRITE;
/*!40000 ALTER TABLE `lessons` DISABLE KEYS */;
/*!40000 ALTER TABLE `lessons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_resets_table',1),(3,'2014_10_12_200000_add_two_factor_columns_to_users_table',1),(4,'2018_11_06_222923_create_transactions_table',1),(5,'2018_11_07_192923_create_transfers_table',1),(6,'2018_11_07_202152_update_transfers_table',1),(7,'2018_11_15_124230_create_wallets_table',1),(8,'2018_11_19_164609_update_transactions_table',1),(9,'2018_11_20_133759_add_fee_transfers_table',1),(10,'2018_11_22_131953_add_status_transfers_table',1),(11,'2018_11_22_133438_drop_refund_transfers_table',1),(12,'2019_05_13_111553_update_status_transfers_table',1),(13,'2019_06_25_103755_add_exchange_status_transfers_table',1),(14,'2019_07_29_184926_decimal_places_wallets_table',1),(15,'2019_08_19_000000_create_failed_jobs_table',1),(16,'2019_10_02_193759_add_discount_transfers_table',1),(17,'2019_12_14_000001_create_personal_access_tokens_table',1),(18,'2020_10_30_193412_add_meta_wallets_table',1),(19,'2021_01_19_122742_create_sessions_table',1),(20,'2021_01_26_103623_create_permission_tables',1),(21,'2021_01_26_145101_create_user_groups_table',1),(22,'2021_02_01_111346_create_categories_table',1),(23,'2021_02_01_123941_create_sub_categories_table',1),(24,'2021_03_11_165355_create_sections_table',1),(25,'2021_03_11_165427_create_skills_table',1),(26,'2021_03_11_165437_create_topics_table',1),(27,'2021_03_11_170421_create_difficulty_levels_table',1),(28,'2021_03_11_170645_create_question_types_table',1),(29,'2021_03_11_171040_create_comprehension_passages_table',1),(30,'2021_03_11_171818_create_questions_table',1),(31,'2021_05_06_170328_create_sub_category_types_table',1),(32,'2021_05_13_105405_create_quiz_types_table',1),(33,'2021_05_13_133602_create_quizzes_table',1),(34,'2021_05_13_162316_create_quiz_questions_table',1),(35,'2021_05_13_174530_create_practice_sets_table',1),(36,'2021_05_13_174705_create_practice_set_questions_table',1),(37,'2021_05_17_165018_create_settings_table',1),(38,'2021_05_18_094439_create_general_settings',1),(39,'2021_05_20_120637_create_sub_category_sections_table',1),(40,'2021_05_24_115523_create_practice_sessions_table',1),(41,'2021_05_25_153658_create_practice_session_questions',1),(42,'2021_06_06_121703_create_quiz_sessions_table',1),(43,'2021_06_06_122342_create_quiz_session_questions_table',1),(44,'2021_06_16_130734_create_quiz_schedules_table',1),(45,'2021_06_18_120842_create_user_group_users_table',1),(46,'2021_06_18_121246_create_user_group_quiz_schedules_table',1),(47,'2021_09_18_121222_create_tags_table',1),(48,'2021_09_20_065115_create_taggables_table',1),(49,'2021_10_18_064312_create_top_bar_settings',1),(50,'2021_10_18_072244_create_stat_settings',1),(51,'2021_10_18_092059_create_cta_settings',1),(52,'2021_10_18_100722_create_feature_settings',1),(53,'2021_10_18_100740_create_testimonial_settings',1),(54,'2021_11_11_051939_modify_home_page_hero_settings',1),(55,'2021_11_11_082743_create_category_settings',1),(56,'2021_11_11_095920_footer_settings',1),(57,'2021_11_15_165120_create_theme_settings',1),(58,'2021_11_22_074935_create_videos_table',1),(59,'2021_11_22_075107_create_lessons_table',1),(60,'2021_11_25_083402_create_practice_lessons_table',1),(61,'2021_11_30_093225_create_license_settings',1),(62,'2021_12_11_085821_create_practice_videos_table',1),(63,'2021_12_14_124247_add_columns_to_quiz_types_table',1),(64,'2021_12_15_124247_add_preferences_column_to_users_table',1),(65,'2021_12_16_102442_add_sno_column_to_quiz_session_questions_table',1),(66,'2021_12_17_102442_add_paid_column_to_practice_sets_table',1),(67,'2022_01_26_085924_create_plans_table',1),(68,'2022_01_26_173546_create_features_table',1),(69,'2022_01_26_173624_create_plan_features_table',1),(70,'2022_01_28_064934_create_payments_table',1),(71,'2022_01_28_073453_create_subscriptions_table',1),(72,'2022_01_28_164017_create_billing_settings',1),(73,'2022_01_28_164025_create_payment_settings',1),(74,'2022_01_29_145619_create_tax_settings',1),(75,'2022_02_01_083750_create_bank_settings',1),(76,'2022_02_01_093000_create_razorpay_settings',1),(77,'2022_03_17_075120_create_exam_types_table',1),(78,'2022_03_17_083916_create_exams_table',1),(79,'2022_03_18_133511_create_exam_sections_table',1),(80,'2022_03_18_141450_create_exam_questions_table',1),(81,'2022_03_19_130734_create_exam_schedules_table',1),(82,'2022_03_19_151246_create_user_group_exam_schedules_table',1),(83,'2022_03_20_075827_create_exam_sessions_table',1),(84,'2022_03_20_082540_create_exam_session_sections_table',1),(85,'2022_03_20_102540_create_exam_session_questions_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_permissions`
--

DROP TABLE IF EXISTS `model_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_permissions`
--

LOCK TABLES `model_has_permissions` WRITE;
/*!40000 ALTER TABLE `model_has_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `model_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_roles`
--

DROP TABLE IF EXISTS `model_has_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_has_roles` (
  `role_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_roles`
--

LOCK TABLES `model_has_roles` WRITE;
/*!40000 ALTER TABLE `model_has_roles` DISABLE KEYS */;
INSERT INTO `model_has_roles` VALUES (1,'App\\Models\\User',1),(3,'App\\Models\\User',2),(3,'App\\Models\\User',3);
/*!40000 ALTER TABLE `model_has_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `payment_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `plan_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `total_amount` double(8,2) NOT NULL,
  `currency` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_date` datetime DEFAULT NULL,
  `invoice_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `refund_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_processor` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` json DEFAULT NULL,
  `status` enum('created','pending','success','failed','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'created',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `payments_payment_id_unique` (`payment_id`),
  KEY `invoice_id` (`invoice_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plan_features`
--

DROP TABLE IF EXISTS `plan_features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plan_features` (
  `plan_id` bigint unsigned NOT NULL,
  `feature_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`plan_id`,`feature_id`),
  KEY `plan_features_feature_id_foreign` (`feature_id`),
  CONSTRAINT `plan_features_feature_id_foreign` FOREIGN KEY (`feature_id`) REFERENCES `features` (`id`) ON DELETE CASCADE,
  CONSTRAINT `plan_features_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plan_features`
--

LOCK TABLES `plan_features` WRITE;
/*!40000 ALTER TABLE `plan_features` DISABLE KEYS */;
/*!40000 ALTER TABLE `plan_features` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plans`
--

DROP TABLE IF EXISTS `plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plans` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` bigint unsigned NOT NULL,
  `duration` int NOT NULL,
  `price` bigint unsigned NOT NULL DEFAULT '0',
  `currency` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `has_discount` tinyint(1) NOT NULL DEFAULT '0',
  `discount_percentage` int NOT NULL DEFAULT '0',
  `has_trial` tinyint(1) NOT NULL DEFAULT '0',
  `trial_days` int NOT NULL DEFAULT '0',
  `icon` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `feature_restrictions` tinyint(1) NOT NULL DEFAULT '0',
  `settings` json DEFAULT NULL,
  `sort_order` bigint unsigned NOT NULL DEFAULT '1',
  `is_popular` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `plans_code_unique` (`code`),
  KEY `plans_category_type_category_id_index` (`category_type`,`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plans`
--

LOCK TABLES `plans` WRITE;
/*!40000 ALTER TABLE `plans` DISABLE KEYS */;
/*!40000 ALTER TABLE `plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `practice_lessons`
--

DROP TABLE IF EXISTS `practice_lessons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `practice_lessons` (
  `lesson_id` bigint unsigned NOT NULL,
  `skill_id` bigint unsigned NOT NULL,
  `sub_category_id` bigint unsigned NOT NULL,
  `sort_order` int DEFAULT '1',
  PRIMARY KEY (`lesson_id`,`skill_id`,`sub_category_id`),
  KEY `practice_lessons_skill_id_foreign` (`skill_id`),
  KEY `practice_lessons_sub_category_id_foreign` (`sub_category_id`),
  CONSTRAINT `practice_lessons_lesson_id_foreign` FOREIGN KEY (`lesson_id`) REFERENCES `lessons` (`id`) ON DELETE CASCADE,
  CONSTRAINT `practice_lessons_skill_id_foreign` FOREIGN KEY (`skill_id`) REFERENCES `skills` (`id`) ON DELETE CASCADE,
  CONSTRAINT `practice_lessons_sub_category_id_foreign` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `practice_lessons`
--

LOCK TABLES `practice_lessons` WRITE;
/*!40000 ALTER TABLE `practice_lessons` DISABLE KEYS */;
/*!40000 ALTER TABLE `practice_lessons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `practice_session_questions`
--

DROP TABLE IF EXISTS `practice_session_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `practice_session_questions` (
  `practice_session_id` bigint unsigned NOT NULL,
  `question_id` bigint unsigned NOT NULL,
  `original_question` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` text COLLATE utf8mb4_unicode_ci,
  `user_answer` text COLLATE utf8mb4_unicode_ci,
  `correct_answer` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unanswered',
  `is_correct` tinyint(1) DEFAULT NULL,
  `time_taken` int NOT NULL DEFAULT '0',
  `points_earned` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`practice_session_id`,`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `practice_session_questions`
--

LOCK TABLES `practice_session_questions` WRITE;
/*!40000 ALTER TABLE `practice_session_questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `practice_session_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `practice_sessions`
--

DROP TABLE IF EXISTS `practice_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `practice_sessions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `practice_set_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `total_time_taken` int NOT NULL DEFAULT '0',
  `percentage_completed` decimal(5,2) NOT NULL DEFAULT '0.00',
  `total_points_earned` int unsigned NOT NULL DEFAULT '0',
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'started',
  `completed_at` datetime DEFAULT NULL,
  `results` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `practice_sessions_code_unique` (`code`),
  KEY `practice_sessions_status_index` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `practice_sessions`
--

LOCK TABLES `practice_sessions` WRITE;
/*!40000 ALTER TABLE `practice_sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `practice_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `practice_set_questions`
--

DROP TABLE IF EXISTS `practice_set_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `practice_set_questions` (
  `practice_set_id` bigint unsigned NOT NULL,
  `question_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`practice_set_id`,`question_id`),
  KEY `practice_set_questions_question_id_foreign` (`question_id`),
  CONSTRAINT `practice_set_questions_practice_set_id_foreign` FOREIGN KEY (`practice_set_id`) REFERENCES `practice_sets` (`id`) ON DELETE CASCADE,
  CONSTRAINT `practice_set_questions_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `practice_set_questions`
--

LOCK TABLES `practice_set_questions` WRITE;
/*!40000 ALTER TABLE `practice_set_questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `practice_set_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `practice_sets`
--

DROP TABLE IF EXISTS `practice_sets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `practice_sets` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_category_id` bigint unsigned NOT NULL,
  `skill_id` bigint unsigned NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `total_questions` int unsigned NOT NULL DEFAULT '0',
  `auto_grading` tinyint(1) NOT NULL DEFAULT '1',
  `correct_marks` int unsigned DEFAULT NULL,
  `allow_rewards` tinyint(1) NOT NULL DEFAULT '1',
  `settings` json DEFAULT NULL,
  `is_paid` tinyint(1) NOT NULL DEFAULT '0',
  `price` bigint unsigned DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `practice_sets_slug_unique` (`slug`),
  UNIQUE KEY `practice_sets_code_unique` (`code`),
  KEY `practice_sets_skill_id_foreign` (`skill_id`),
  KEY `practice_sets_sub_category_id_foreign` (`sub_category_id`),
  CONSTRAINT `practice_sets_skill_id_foreign` FOREIGN KEY (`skill_id`) REFERENCES `skills` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `practice_sets_sub_category_id_foreign` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_categories` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `practice_sets`
--

LOCK TABLES `practice_sets` WRITE;
/*!40000 ALTER TABLE `practice_sets` DISABLE KEYS */;
/*!40000 ALTER TABLE `practice_sets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `practice_videos`
--

DROP TABLE IF EXISTS `practice_videos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `practice_videos` (
  `video_id` bigint unsigned NOT NULL,
  `skill_id` bigint unsigned NOT NULL,
  `sub_category_id` bigint unsigned NOT NULL,
  `sort_order` int DEFAULT '1',
  PRIMARY KEY (`video_id`,`skill_id`,`sub_category_id`),
  KEY `practice_videos_skill_id_foreign` (`skill_id`),
  KEY `practice_videos_sub_category_id_foreign` (`sub_category_id`),
  CONSTRAINT `practice_videos_skill_id_foreign` FOREIGN KEY (`skill_id`) REFERENCES `skills` (`id`) ON DELETE CASCADE,
  CONSTRAINT `practice_videos_sub_category_id_foreign` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `practice_videos_video_id_foreign` FOREIGN KEY (`video_id`) REFERENCES `videos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `practice_videos`
--

LOCK TABLES `practice_videos` WRITE;
/*!40000 ALTER TABLE `practice_videos` DISABLE KEYS */;
/*!40000 ALTER TABLE `practice_videos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question_types`
--

DROP TABLE IF EXISTS `question_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question_types` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `short_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `question_types_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question_types`
--

LOCK TABLES `question_types` WRITE;
/*!40000 ALTER TABLE `question_types` DISABLE KEYS */;
INSERT INTO `question_types` VALUES (1,'Multiple Choice Single Answer','MSA','objective','msa.png','This question type is easy to set up and is the most frequent MCQ question in online exams. Users are allowed to pick just one answer from a list of given options.',1,NULL,NULL,NULL),(2,'Multiple Choice Multiple Answers','MMA','objective','mma.png','Multiple Choice Multiple Answers type question allows users to select one or several answers from a list of given options.',1,NULL,NULL,NULL),(3,'True or False','TOF','objective','tof.png','A true or false question consists of a statement that requires a true or false response. We can also format the options such as: Yes/No, Correct/Incorrect, and Agree/Disagree.',1,NULL,NULL,NULL),(4,'Short Answer','SAQ','objective','saq.png','Short answer questions allow users to provide text or numeric answers. These responses will be validated against the provided possible answers.',1,NULL,NULL,NULL),(5,'Match the Following','MTF','objective','mtf.png','A matching question is two adjacent lists of related words, phrases, pictures, or symbols. Each item in one list is paired with at least one item in the other list.',1,NULL,NULL,NULL),(6,'Ordering/Sequence','ORD','objective','ord.png','An ordering/sequence question consists of a scrambled list of related words, phrases, pictures, or symbols. The User needs to arrange them in a logical order/sequence.',1,NULL,NULL,NULL),(7,'Fill in the Blanks','FIB','objective','fib.png','A Fill in the Blank question consists of a phrase, sentence, or paragraph with a blank space where a student provides the missing word or words.',1,NULL,NULL,NULL),(8,'Long Answer/Paragraph','LAQ','subjective','laq.png','In Long answer or paragraph question type is equivalent to essay writing where a student provides a text box to write his response.',0,NULL,NULL,NULL);
/*!40000 ALTER TABLE `question_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `question_type_id` bigint unsigned NOT NULL,
  `question` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` json NOT NULL,
  `correct_answer` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `default_marks` int NOT NULL DEFAULT '1',
  `default_time` int NOT NULL DEFAULT '60',
  `skill_id` bigint unsigned NOT NULL,
  `topic_id` bigint unsigned DEFAULT NULL,
  `difficulty_level_id` bigint unsigned NOT NULL DEFAULT '1',
  `preferences` json DEFAULT NULL,
  `has_attachment` tinyint(1) NOT NULL DEFAULT '0',
  `attachment_type` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comprehension_passage_id` bigint unsigned DEFAULT NULL,
  `attachment_options` json DEFAULT NULL,
  `solution` text COLLATE utf8mb4_unicode_ci,
  `solution_video` json DEFAULT NULL,
  `hint` text COLLATE utf8mb4_unicode_ci,
  `avg_time_taken` int NOT NULL DEFAULT '0',
  `total_attempts` bigint unsigned NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `questions_code_unique` (`code`),
  KEY `questions_skill_id_foreign` (`skill_id`),
  KEY `questions_topic_id_foreign` (`topic_id`),
  KEY `questions_comprehension_passage_id_foreign` (`comprehension_passage_id`),
  CONSTRAINT `questions_comprehension_passage_id_foreign` FOREIGN KEY (`comprehension_passage_id`) REFERENCES `comprehension_passages` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `questions_skill_id_foreign` FOREIGN KEY (`skill_id`) REFERENCES `skills` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `questions_topic_id_foreign` FOREIGN KEY (`topic_id`) REFERENCES `topics` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` VALUES (1,'que_lIQ0cGURlPd',3,'<p>What is the charge of an electron?</p>','[{\"option\": \"<p>Positive</p>\", \"partial_weightage\": 0}, {\"option\": \"<p>Negative</p>\", \"partial_weightage\": 0}]','i:2;',300,30,3,NULL,1,'[]',0,NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,'2024-02-06 05:43:09','2024-02-13 06:44:23',NULL),(2,'que_xXlrnXu9Ahq',5,'<p>What is the order of fundamental forces in nature according to their strengths.</p>','[{\"pair\": \"<p>1</p>\", \"option\": \"<p>Nuclear Force</p>\", \"partial_weightage\": 0}, {\"pair\": \"<p>2</p>\", \"option\": \"<p>Electomagnetic Force</p>\", \"partial_weightage\": 0}, {\"pair\": \"<p>3</p>\", \"option\": \"<p>Weak Nuclear Force</p>\", \"partial_weightage\": 0}, {\"pair\": \"<p>4</p>\", \"option\": \"<p>Gravitational Force</p>\", \"partial_weightage\": 0}]','N;',300,30,3,NULL,1,'[]',0,NULL,NULL,NULL,'<p>The order according to current model of physics are as follows, the order goes in increasing order.</p>\n\n<p>1. Gravitational Force</p>\n\n<p>2. Weak Nuclear Force</p>\n\n<p>3. Electromagnetic Force</p>\n\n<p>4. Nuclear Force.</p>',NULL,NULL,0,0,1,'2024-02-06 06:24:35','2024-02-13 06:44:23',NULL),(3,'que_lclLuAhghFv',1,'<p>What is the weight of The Sun?</p>','[{\"option\": \"<p>5kg</p>\", \"partial_weightage\": 0}, {\"option\": \"<p>2kg</p>\", \"partial_weightage\": 0}, {\"option\": \"<p>9kg</p>\", \"partial_weightage\": 0}, {\"option\": \"<p>more than 9kg.</p>\", \"partial_weightage\": 0}]','i:4;',30,30,1,NULL,1,'[]',0,NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,'2024-02-13 05:25:36','2024-02-13 06:44:23',NULL),(4,'que_FHdFM9HBWOE',1,'<p>What is the amount of charge a proton holds?</p>','[{\"option\": \"<p>1e</p>\", \"partial_weightage\": 0}, {\"option\": \"<p>2e</p>\", \"partial_weightage\": 0}, {\"option\": \"<p>3e</p>\", \"partial_weightage\": 0}, {\"option\": \"<p>4e</p>\", \"partial_weightage\": 0}]','i:1;',30,30,3,NULL,1,'[]',0,NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,'2024-02-13 05:27:08','2024-02-13 06:44:23',NULL),(5,'que_ub6gt1p6QUq',1,'<p>Which of the following is not an electric appliances?</p>','[{\"option\": \"<p>electron projector</p>\", \"partial_weightage\": 0}, {\"option\": \"<p>Bulb</p>\", \"partial_weightage\": 0}, {\"option\": \"<p>Thermonuclear reactor</p>\", \"partial_weightage\": 0}, {\"option\": \"<p>Fan</p>\", \"partial_weightage\": 0}]','i:1;',30,30,3,NULL,1,'[]',0,NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,'2024-02-13 05:28:48','2024-02-13 06:44:23',NULL);
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz_questions`
--

DROP TABLE IF EXISTS `quiz_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quiz_questions` (
  `quiz_id` bigint unsigned NOT NULL,
  `question_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`quiz_id`,`question_id`),
  KEY `quiz_questions_question_id_foreign` (`question_id`),
  CONSTRAINT `quiz_questions_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `quiz_questions_quiz_id_foreign` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz_questions`
--

LOCK TABLES `quiz_questions` WRITE;
/*!40000 ALTER TABLE `quiz_questions` DISABLE KEYS */;
INSERT INTO `quiz_questions` VALUES (1,3),(1,4),(1,5);
/*!40000 ALTER TABLE `quiz_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz_schedules`
--

DROP TABLE IF EXISTS `quiz_schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quiz_schedules` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quiz_id` bigint unsigned NOT NULL,
  `schedule_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'fixed',
  `start_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_date` date DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `grace_period` int NOT NULL DEFAULT '5',
  `send_email` tinyint(1) NOT NULL DEFAULT '0',
  `settings` json DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `quiz_schedules_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz_schedules`
--

LOCK TABLES `quiz_schedules` WRITE;
/*!40000 ALTER TABLE `quiz_schedules` DISABLE KEYS */;
INSERT INTO `quiz_schedules` VALUES (1,'qsd_RnBEl8nXPDA',1,'flexible','2024-02-10','00:00:00','2024-02-29','00:00:00',5,0,NULL,'active','2024-02-10 02:24:50','2024-02-10 02:24:50',NULL);
/*!40000 ALTER TABLE `quiz_schedules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz_session_questions`
--

DROP TABLE IF EXISTS `quiz_session_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quiz_session_questions` (
  `quiz_session_id` bigint unsigned NOT NULL,
  `sno` bigint unsigned NOT NULL DEFAULT '1',
  `question_id` bigint unsigned NOT NULL,
  `original_question` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` text COLLATE utf8mb4_unicode_ci,
  `user_answer` text COLLATE utf8mb4_unicode_ci,
  `correct_answer` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unanswered',
  `is_correct` tinyint(1) DEFAULT NULL,
  `time_taken` int NOT NULL DEFAULT '0',
  `marks_earned` double(5,2) NOT NULL DEFAULT '0.00',
  `marks_deducted` double(5,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`quiz_session_id`,`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz_session_questions`
--

LOCK TABLES `quiz_session_questions` WRITE;
/*!40000 ALTER TABLE `quiz_session_questions` DISABLE KEYS */;
INSERT INTO `quiz_session_questions` VALUES (1,1,1,'<p>What is the charge of an electron?</p>','a:2:{i:0;s:15:\"<p>Positive</p>\";i:1;s:15:\"<p>Negative</p>\";}','N;','i:2;','not_answered',0,23,0.00,0.00),(1,2,2,'<p>What is the order of fundamental forces in nature according to their strengths.</p>','a:2:{s:7:\"matches\";a:4:{i:0;a:2:{s:2:\"id\";s:32:\"c215fc75951b35c5847a807240fab2ea\";s:5:\"value\";s:20:\"<p>Nuclear Force</p>\";}i:1;a:2:{s:2:\"id\";s:32:\"a9577d25b70d4788551133ae4f265347\";s:5:\"value\";s:27:\"<p>Electomagnetic Force</p>\";}i:2;a:2:{s:2:\"id\";s:32:\"2577539023dcd204eb78a3ad1cd6201c\";s:5:\"value\";s:25:\"<p>Weak Nuclear Force</p>\";}i:3;a:2:{s:2:\"id\";s:32:\"19be0e556de5c94f431c8d9ced56641f\";s:5:\"value\";s:26:\"<p>Gravitational Force</p>\";}}s:5:\"pairs\";a:4:{i:0;a:3:{s:2:\"id\";s:32:\"a22d6a95d33b5208f04eedb325282800\";s:5:\"value\";s:8:\"<p>1</p>\";s:4:\"code\";s:1:\"A\";}i:1;a:3:{s:2:\"id\";s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";s:5:\"value\";s:8:\"<p>2</p>\";s:4:\"code\";s:1:\"B\";}i:2;a:3:{s:2:\"id\";s:32:\"7667e2cd947e57f259549e120bbc619d\";s:5:\"value\";s:8:\"<p>4</p>\";s:4:\"code\";s:1:\"C\";}i:3;a:3:{s:2:\"id\";s:32:\"1d996b61ee20735a967752c065fd62b0\";s:5:\"value\";s:8:\"<p>3</p>\";s:4:\"code\";s:1:\"D\";}}}',NULL,'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}','not_visited',NULL,0,0.00,0.00),(2,1,1,'<p>What is the charge of an electron?</p>','a:2:{i:0;s:15:\"<p>Positive</p>\";i:1;s:15:\"<p>Negative</p>\";}','N;','i:2;','not_answered',0,272,0.00,0.00),(2,2,2,'<p>What is the order of fundamental forces in nature according to their strengths.</p>','a:2:{s:7:\"matches\";a:4:{i:0;a:2:{s:2:\"id\";s:32:\"c215fc75951b35c5847a807240fab2ea\";s:5:\"value\";s:20:\"<p>Nuclear Force</p>\";}i:1;a:2:{s:2:\"id\";s:32:\"a9577d25b70d4788551133ae4f265347\";s:5:\"value\";s:27:\"<p>Electomagnetic Force</p>\";}i:2;a:2:{s:2:\"id\";s:32:\"2577539023dcd204eb78a3ad1cd6201c\";s:5:\"value\";s:25:\"<p>Weak Nuclear Force</p>\";}i:3;a:2:{s:2:\"id\";s:32:\"19be0e556de5c94f431c8d9ced56641f\";s:5:\"value\";s:26:\"<p>Gravitational Force</p>\";}}s:5:\"pairs\";a:4:{i:0;a:3:{s:2:\"id\";s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";s:5:\"value\";s:8:\"<p>2</p>\";s:4:\"code\";s:1:\"A\";}i:1;a:3:{s:2:\"id\";s:32:\"7667e2cd947e57f259549e120bbc619d\";s:5:\"value\";s:8:\"<p>4</p>\";s:4:\"code\";s:1:\"B\";}i:2;a:3:{s:2:\"id\";s:32:\"1d996b61ee20735a967752c065fd62b0\";s:5:\"value\";s:8:\"<p>3</p>\";s:4:\"code\";s:1:\"C\";}i:3;a:3:{s:2:\"id\";s:32:\"a22d6a95d33b5208f04eedb325282800\";s:5:\"value\";s:8:\"<p>1</p>\";s:4:\"code\";s:1:\"D\";}}}','a:0:{}','a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}','not_answered',0,1,0.00,0.00),(3,2,1,'<p>What is the charge of an electron?</p>','a:2:{i:0;s:15:\"<p>Positive</p>\";i:1;s:15:\"<p>Negative</p>\";}',NULL,'i:2;','not_visited',NULL,0,0.00,0.00),(3,1,2,'<p>What is the order of fundamental forces in nature according to their strengths.</p>','a:2:{s:7:\"matches\";a:4:{i:0;a:2:{s:2:\"id\";s:32:\"c215fc75951b35c5847a807240fab2ea\";s:5:\"value\";s:20:\"<p>Nuclear Force</p>\";}i:1;a:2:{s:2:\"id\";s:32:\"a9577d25b70d4788551133ae4f265347\";s:5:\"value\";s:27:\"<p>Electomagnetic Force</p>\";}i:2;a:2:{s:2:\"id\";s:32:\"2577539023dcd204eb78a3ad1cd6201c\";s:5:\"value\";s:25:\"<p>Weak Nuclear Force</p>\";}i:3;a:2:{s:2:\"id\";s:32:\"19be0e556de5c94f431c8d9ced56641f\";s:5:\"value\";s:26:\"<p>Gravitational Force</p>\";}}s:5:\"pairs\";a:4:{i:0;a:3:{s:2:\"id\";s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";s:5:\"value\";s:8:\"<p>2</p>\";s:4:\"code\";s:1:\"A\";}i:1;a:3:{s:2:\"id\";s:32:\"a22d6a95d33b5208f04eedb325282800\";s:5:\"value\";s:8:\"<p>1</p>\";s:4:\"code\";s:1:\"B\";}i:2;a:3:{s:2:\"id\";s:32:\"1d996b61ee20735a967752c065fd62b0\";s:5:\"value\";s:8:\"<p>3</p>\";s:4:\"code\";s:1:\"C\";}i:3;a:3:{s:2:\"id\";s:32:\"7667e2cd947e57f259549e120bbc619d\";s:5:\"value\";s:8:\"<p>4</p>\";s:4:\"code\";s:1:\"D\";}}}','a:0:{}','a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}','not_answered',0,28,0.00,0.00),(4,1,1,'<p>What is the charge of an electron?</p>','a:2:{i:0;s:15:\"<p>Positive</p>\";i:1;s:15:\"<p>Negative</p>\";}',NULL,'i:2;','not_visited',NULL,0,0.00,0.00),(4,2,2,'<p>What is the order of fundamental forces in nature according to their strengths.</p>','a:2:{s:7:\"matches\";a:4:{i:0;a:2:{s:2:\"id\";s:32:\"c215fc75951b35c5847a807240fab2ea\";s:5:\"value\";s:20:\"<p>Nuclear Force</p>\";}i:1;a:2:{s:2:\"id\";s:32:\"a9577d25b70d4788551133ae4f265347\";s:5:\"value\";s:27:\"<p>Electomagnetic Force</p>\";}i:2;a:2:{s:2:\"id\";s:32:\"2577539023dcd204eb78a3ad1cd6201c\";s:5:\"value\";s:25:\"<p>Weak Nuclear Force</p>\";}i:3;a:2:{s:2:\"id\";s:32:\"19be0e556de5c94f431c8d9ced56641f\";s:5:\"value\";s:26:\"<p>Gravitational Force</p>\";}}s:5:\"pairs\";a:4:{i:0;a:3:{s:2:\"id\";s:32:\"7667e2cd947e57f259549e120bbc619d\";s:5:\"value\";s:8:\"<p>4</p>\";s:4:\"code\";s:1:\"A\";}i:1;a:3:{s:2:\"id\";s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";s:5:\"value\";s:8:\"<p>2</p>\";s:4:\"code\";s:1:\"B\";}i:2;a:3:{s:2:\"id\";s:32:\"a22d6a95d33b5208f04eedb325282800\";s:5:\"value\";s:8:\"<p>1</p>\";s:4:\"code\";s:1:\"C\";}i:3;a:3:{s:2:\"id\";s:32:\"1d996b61ee20735a967752c065fd62b0\";s:5:\"value\";s:8:\"<p>3</p>\";s:4:\"code\";s:1:\"D\";}}}',NULL,'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}','not_visited',NULL,0,0.00,0.00),(5,1,1,'<p>What is the charge of an electron?</p>','a:2:{i:0;s:15:\"<p>Positive</p>\";i:1;s:15:\"<p>Negative</p>\";}','N;','i:2;','not_answered',0,2,0.00,0.00),(5,2,2,'<p>What is the order of fundamental forces in nature according to their strengths.</p>','a:2:{s:7:\"matches\";a:4:{i:0;a:2:{s:2:\"id\";s:32:\"c215fc75951b35c5847a807240fab2ea\";s:5:\"value\";s:20:\"<p>Nuclear Force</p>\";}i:1;a:2:{s:2:\"id\";s:32:\"a9577d25b70d4788551133ae4f265347\";s:5:\"value\";s:27:\"<p>Electomagnetic Force</p>\";}i:2;a:2:{s:2:\"id\";s:32:\"2577539023dcd204eb78a3ad1cd6201c\";s:5:\"value\";s:25:\"<p>Weak Nuclear Force</p>\";}i:3;a:2:{s:2:\"id\";s:32:\"19be0e556de5c94f431c8d9ced56641f\";s:5:\"value\";s:26:\"<p>Gravitational Force</p>\";}}s:5:\"pairs\";a:4:{i:0;a:3:{s:2:\"id\";s:32:\"1d996b61ee20735a967752c065fd62b0\";s:5:\"value\";s:8:\"<p>3</p>\";s:4:\"code\";s:1:\"A\";}i:1;a:3:{s:2:\"id\";s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";s:5:\"value\";s:8:\"<p>2</p>\";s:4:\"code\";s:1:\"B\";}i:2;a:3:{s:2:\"id\";s:32:\"a22d6a95d33b5208f04eedb325282800\";s:5:\"value\";s:8:\"<p>1</p>\";s:4:\"code\";s:1:\"C\";}i:3;a:3:{s:2:\"id\";s:32:\"7667e2cd947e57f259549e120bbc619d\";s:5:\"value\";s:8:\"<p>4</p>\";s:4:\"code\";s:1:\"D\";}}}',NULL,'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}','not_visited',NULL,0,0.00,0.00),(6,1,1,'<p>What is the charge of an electron?</p>','a:2:{i:0;s:15:\"<p>Positive</p>\";i:1;s:15:\"<p>Negative</p>\";}',NULL,'i:2;','not_visited',NULL,0,0.00,0.00),(6,2,2,'<p>What is the order of fundamental forces in nature according to their strengths.</p>','a:2:{s:7:\"matches\";a:4:{i:0;a:2:{s:2:\"id\";s:32:\"c215fc75951b35c5847a807240fab2ea\";s:5:\"value\";s:20:\"<p>Nuclear Force</p>\";}i:1;a:2:{s:2:\"id\";s:32:\"a9577d25b70d4788551133ae4f265347\";s:5:\"value\";s:27:\"<p>Electomagnetic Force</p>\";}i:2;a:2:{s:2:\"id\";s:32:\"2577539023dcd204eb78a3ad1cd6201c\";s:5:\"value\";s:25:\"<p>Weak Nuclear Force</p>\";}i:3;a:2:{s:2:\"id\";s:32:\"19be0e556de5c94f431c8d9ced56641f\";s:5:\"value\";s:26:\"<p>Gravitational Force</p>\";}}s:5:\"pairs\";a:4:{i:0;a:3:{s:2:\"id\";s:32:\"7667e2cd947e57f259549e120bbc619d\";s:5:\"value\";s:8:\"<p>4</p>\";s:4:\"code\";s:1:\"A\";}i:1;a:3:{s:2:\"id\";s:32:\"a22d6a95d33b5208f04eedb325282800\";s:5:\"value\";s:8:\"<p>1</p>\";s:4:\"code\";s:1:\"B\";}i:2;a:3:{s:2:\"id\";s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";s:5:\"value\";s:8:\"<p>2</p>\";s:4:\"code\";s:1:\"C\";}i:3;a:3:{s:2:\"id\";s:32:\"1d996b61ee20735a967752c065fd62b0\";s:5:\"value\";s:8:\"<p>3</p>\";s:4:\"code\";s:1:\"D\";}}}',NULL,'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}','not_visited',NULL,0,0.00,0.00),(7,2,1,'<p>What is the charge of an electron?</p>','a:2:{i:0;s:15:\"<p>Positive</p>\";i:1;s:15:\"<p>Negative</p>\";}',NULL,'i:2;','not_visited',NULL,0,0.00,0.00),(7,1,2,'<p>What is the order of fundamental forces in nature according to their strengths.</p>','a:2:{s:7:\"matches\";a:4:{i:0;a:2:{s:2:\"id\";s:32:\"c215fc75951b35c5847a807240fab2ea\";s:5:\"value\";s:20:\"<p>Nuclear Force</p>\";}i:1;a:2:{s:2:\"id\";s:32:\"a9577d25b70d4788551133ae4f265347\";s:5:\"value\";s:27:\"<p>Electomagnetic Force</p>\";}i:2;a:2:{s:2:\"id\";s:32:\"2577539023dcd204eb78a3ad1cd6201c\";s:5:\"value\";s:25:\"<p>Weak Nuclear Force</p>\";}i:3;a:2:{s:2:\"id\";s:32:\"19be0e556de5c94f431c8d9ced56641f\";s:5:\"value\";s:26:\"<p>Gravitational Force</p>\";}}s:5:\"pairs\";a:4:{i:0;a:3:{s:2:\"id\";s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";s:5:\"value\";s:8:\"<p>2</p>\";s:4:\"code\";s:1:\"A\";}i:1;a:3:{s:2:\"id\";s:32:\"7667e2cd947e57f259549e120bbc619d\";s:5:\"value\";s:8:\"<p>4</p>\";s:4:\"code\";s:1:\"B\";}i:2;a:3:{s:2:\"id\";s:32:\"a22d6a95d33b5208f04eedb325282800\";s:5:\"value\";s:8:\"<p>1</p>\";s:4:\"code\";s:1:\"C\";}i:3;a:3:{s:2:\"id\";s:32:\"1d996b61ee20735a967752c065fd62b0\";s:5:\"value\";s:8:\"<p>3</p>\";s:4:\"code\";s:1:\"D\";}}}',NULL,'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}','not_visited',NULL,0,0.00,0.00),(8,1,1,'<p>What is the charge of an electron?</p>','a:2:{i:0;s:15:\"<p>Positive</p>\";i:1;s:15:\"<p>Negative</p>\";}',NULL,'i:2;','not_visited',NULL,0,0.00,0.00),(8,2,2,'<p>What is the order of fundamental forces in nature according to their strengths.</p>','a:2:{s:7:\"matches\";a:4:{i:0;a:2:{s:2:\"id\";s:32:\"c215fc75951b35c5847a807240fab2ea\";s:5:\"value\";s:20:\"<p>Nuclear Force</p>\";}i:1;a:2:{s:2:\"id\";s:32:\"a9577d25b70d4788551133ae4f265347\";s:5:\"value\";s:27:\"<p>Electomagnetic Force</p>\";}i:2;a:2:{s:2:\"id\";s:32:\"2577539023dcd204eb78a3ad1cd6201c\";s:5:\"value\";s:25:\"<p>Weak Nuclear Force</p>\";}i:3;a:2:{s:2:\"id\";s:32:\"19be0e556de5c94f431c8d9ced56641f\";s:5:\"value\";s:26:\"<p>Gravitational Force</p>\";}}s:5:\"pairs\";a:4:{i:0;a:3:{s:2:\"id\";s:32:\"7667e2cd947e57f259549e120bbc619d\";s:5:\"value\";s:8:\"<p>4</p>\";s:4:\"code\";s:1:\"A\";}i:1;a:3:{s:2:\"id\";s:32:\"1d996b61ee20735a967752c065fd62b0\";s:5:\"value\";s:8:\"<p>3</p>\";s:4:\"code\";s:1:\"B\";}i:2;a:3:{s:2:\"id\";s:32:\"a22d6a95d33b5208f04eedb325282800\";s:5:\"value\";s:8:\"<p>1</p>\";s:4:\"code\";s:1:\"C\";}i:3;a:3:{s:2:\"id\";s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";s:5:\"value\";s:8:\"<p>2</p>\";s:4:\"code\";s:1:\"D\";}}}',NULL,'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}','not_visited',NULL,0,0.00,0.00),(9,1,1,'<p>What is the charge of an electron?</p>','a:2:{i:0;s:15:\"<p>Positive</p>\";i:1;s:15:\"<p>Negative</p>\";}','N;','i:2;','not_answered',0,6,0.00,0.00),(9,2,2,'<p>What is the order of fundamental forces in nature according to their strengths.</p>','a:2:{s:7:\"matches\";a:4:{i:0;a:2:{s:2:\"id\";s:32:\"c215fc75951b35c5847a807240fab2ea\";s:5:\"value\";s:20:\"<p>Nuclear Force</p>\";}i:1;a:2:{s:2:\"id\";s:32:\"a9577d25b70d4788551133ae4f265347\";s:5:\"value\";s:27:\"<p>Electomagnetic Force</p>\";}i:2;a:2:{s:2:\"id\";s:32:\"2577539023dcd204eb78a3ad1cd6201c\";s:5:\"value\";s:25:\"<p>Weak Nuclear Force</p>\";}i:3;a:2:{s:2:\"id\";s:32:\"19be0e556de5c94f431c8d9ced56641f\";s:5:\"value\";s:26:\"<p>Gravitational Force</p>\";}}s:5:\"pairs\";a:4:{i:0;a:3:{s:2:\"id\";s:32:\"1d996b61ee20735a967752c065fd62b0\";s:5:\"value\";s:8:\"<p>3</p>\";s:4:\"code\";s:1:\"A\";}i:1;a:3:{s:2:\"id\";s:32:\"a22d6a95d33b5208f04eedb325282800\";s:5:\"value\";s:8:\"<p>1</p>\";s:4:\"code\";s:1:\"B\";}i:2;a:3:{s:2:\"id\";s:32:\"7667e2cd947e57f259549e120bbc619d\";s:5:\"value\";s:8:\"<p>4</p>\";s:4:\"code\";s:1:\"C\";}i:3;a:3:{s:2:\"id\";s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";s:5:\"value\";s:8:\"<p>2</p>\";s:4:\"code\";s:1:\"D\";}}}','a:0:{}','a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}','not_answered',0,8,0.00,0.00),(10,2,1,'<p>What is the charge of an electron?</p>','a:2:{i:0;s:15:\"<p>Positive</p>\";i:1;s:15:\"<p>Negative</p>\";}',NULL,'i:2;','not_visited',NULL,0,0.00,0.00),(10,1,2,'<p>What is the order of fundamental forces in nature according to their strengths.</p>','a:2:{s:7:\"matches\";a:4:{i:0;a:2:{s:2:\"id\";s:32:\"c215fc75951b35c5847a807240fab2ea\";s:5:\"value\";s:20:\"<p>Nuclear Force</p>\";}i:1;a:2:{s:2:\"id\";s:32:\"a9577d25b70d4788551133ae4f265347\";s:5:\"value\";s:27:\"<p>Electomagnetic Force</p>\";}i:2;a:2:{s:2:\"id\";s:32:\"2577539023dcd204eb78a3ad1cd6201c\";s:5:\"value\";s:25:\"<p>Weak Nuclear Force</p>\";}i:3;a:2:{s:2:\"id\";s:32:\"19be0e556de5c94f431c8d9ced56641f\";s:5:\"value\";s:26:\"<p>Gravitational Force</p>\";}}s:5:\"pairs\";a:4:{i:0;a:3:{s:2:\"id\";s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";s:5:\"value\";s:8:\"<p>2</p>\";s:4:\"code\";s:1:\"A\";}i:1;a:3:{s:2:\"id\";s:32:\"7667e2cd947e57f259549e120bbc619d\";s:5:\"value\";s:8:\"<p>4</p>\";s:4:\"code\";s:1:\"B\";}i:2;a:3:{s:2:\"id\";s:32:\"a22d6a95d33b5208f04eedb325282800\";s:5:\"value\";s:8:\"<p>1</p>\";s:4:\"code\";s:1:\"C\";}i:3;a:3:{s:2:\"id\";s:32:\"1d996b61ee20735a967752c065fd62b0\";s:5:\"value\";s:8:\"<p>3</p>\";s:4:\"code\";s:1:\"D\";}}}',NULL,'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}','not_visited',NULL,0,0.00,0.00),(11,2,1,'<p>What is the charge of an electron?</p>','a:2:{i:0;s:15:\"<p>Positive</p>\";i:1;s:15:\"<p>Negative</p>\";}',NULL,'i:2;','not_visited',NULL,0,0.00,0.00),(11,1,2,'<p>What is the order of fundamental forces in nature according to their strengths.</p>','a:2:{s:7:\"matches\";a:4:{i:0;a:2:{s:2:\"id\";s:32:\"c215fc75951b35c5847a807240fab2ea\";s:5:\"value\";s:20:\"<p>Nuclear Force</p>\";}i:1;a:2:{s:2:\"id\";s:32:\"a9577d25b70d4788551133ae4f265347\";s:5:\"value\";s:27:\"<p>Electomagnetic Force</p>\";}i:2;a:2:{s:2:\"id\";s:32:\"2577539023dcd204eb78a3ad1cd6201c\";s:5:\"value\";s:25:\"<p>Weak Nuclear Force</p>\";}i:3;a:2:{s:2:\"id\";s:32:\"19be0e556de5c94f431c8d9ced56641f\";s:5:\"value\";s:26:\"<p>Gravitational Force</p>\";}}s:5:\"pairs\";a:4:{i:0;a:3:{s:2:\"id\";s:32:\"7667e2cd947e57f259549e120bbc619d\";s:5:\"value\";s:8:\"<p>4</p>\";s:4:\"code\";s:1:\"A\";}i:1;a:3:{s:2:\"id\";s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";s:5:\"value\";s:8:\"<p>2</p>\";s:4:\"code\";s:1:\"B\";}i:2;a:3:{s:2:\"id\";s:32:\"1d996b61ee20735a967752c065fd62b0\";s:5:\"value\";s:8:\"<p>3</p>\";s:4:\"code\";s:1:\"C\";}i:3;a:3:{s:2:\"id\";s:32:\"a22d6a95d33b5208f04eedb325282800\";s:5:\"value\";s:8:\"<p>1</p>\";s:4:\"code\";s:1:\"D\";}}}',NULL,'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}','not_visited',NULL,0,0.00,0.00),(12,2,1,'<p>What is the charge of an electron?</p>','a:2:{i:0;s:15:\"<p>Positive</p>\";i:1;s:15:\"<p>Negative</p>\";}',NULL,'i:2;','not_visited',NULL,0,0.00,0.00),(12,1,2,'<p>What is the order of fundamental forces in nature according to their strengths.</p>','a:2:{s:7:\"matches\";a:4:{i:0;a:2:{s:2:\"id\";s:32:\"c215fc75951b35c5847a807240fab2ea\";s:5:\"value\";s:20:\"<p>Nuclear Force</p>\";}i:1;a:2:{s:2:\"id\";s:32:\"a9577d25b70d4788551133ae4f265347\";s:5:\"value\";s:27:\"<p>Electomagnetic Force</p>\";}i:2;a:2:{s:2:\"id\";s:32:\"2577539023dcd204eb78a3ad1cd6201c\";s:5:\"value\";s:25:\"<p>Weak Nuclear Force</p>\";}i:3;a:2:{s:2:\"id\";s:32:\"19be0e556de5c94f431c8d9ced56641f\";s:5:\"value\";s:26:\"<p>Gravitational Force</p>\";}}s:5:\"pairs\";a:4:{i:0;a:3:{s:2:\"id\";s:32:\"7667e2cd947e57f259549e120bbc619d\";s:5:\"value\";s:8:\"<p>4</p>\";s:4:\"code\";s:1:\"A\";}i:1;a:3:{s:2:\"id\";s:32:\"a22d6a95d33b5208f04eedb325282800\";s:5:\"value\";s:8:\"<p>1</p>\";s:4:\"code\";s:1:\"B\";}i:2;a:3:{s:2:\"id\";s:32:\"1d996b61ee20735a967752c065fd62b0\";s:5:\"value\";s:8:\"<p>3</p>\";s:4:\"code\";s:1:\"C\";}i:3;a:3:{s:2:\"id\";s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";s:5:\"value\";s:8:\"<p>2</p>\";s:4:\"code\";s:1:\"D\";}}}',NULL,'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}','not_visited',NULL,0,0.00,0.00),(13,1,1,'<p>What is the charge of an electron?</p>','a:2:{i:0;s:15:\"<p>Positive</p>\";i:1;s:15:\"<p>Negative</p>\";}',NULL,'i:2;','not_visited',NULL,0,0.00,0.00),(13,2,2,'<p>What is the order of fundamental forces in nature according to their strengths.</p>','a:2:{s:7:\"matches\";a:4:{i:0;a:2:{s:2:\"id\";s:32:\"c215fc75951b35c5847a807240fab2ea\";s:5:\"value\";s:20:\"<p>Nuclear Force</p>\";}i:1;a:2:{s:2:\"id\";s:32:\"a9577d25b70d4788551133ae4f265347\";s:5:\"value\";s:27:\"<p>Electomagnetic Force</p>\";}i:2;a:2:{s:2:\"id\";s:32:\"2577539023dcd204eb78a3ad1cd6201c\";s:5:\"value\";s:25:\"<p>Weak Nuclear Force</p>\";}i:3;a:2:{s:2:\"id\";s:32:\"19be0e556de5c94f431c8d9ced56641f\";s:5:\"value\";s:26:\"<p>Gravitational Force</p>\";}}s:5:\"pairs\";a:4:{i:0;a:3:{s:2:\"id\";s:32:\"a22d6a95d33b5208f04eedb325282800\";s:5:\"value\";s:8:\"<p>1</p>\";s:4:\"code\";s:1:\"A\";}i:1;a:3:{s:2:\"id\";s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";s:5:\"value\";s:8:\"<p>2</p>\";s:4:\"code\";s:1:\"B\";}i:2;a:3:{s:2:\"id\";s:32:\"1d996b61ee20735a967752c065fd62b0\";s:5:\"value\";s:8:\"<p>3</p>\";s:4:\"code\";s:1:\"C\";}i:3;a:3:{s:2:\"id\";s:32:\"7667e2cd947e57f259549e120bbc619d\";s:5:\"value\";s:8:\"<p>4</p>\";s:4:\"code\";s:1:\"D\";}}}',NULL,'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}','not_visited',NULL,0,0.00,0.00),(14,2,1,'<p>What is the charge of an electron?</p>','a:2:{i:0;s:15:\"<p>Positive</p>\";i:1;s:15:\"<p>Negative</p>\";}',NULL,'i:2;','not_visited',NULL,0,0.00,0.00),(14,1,2,'<p>What is the order of fundamental forces in nature according to their strengths.</p>','a:2:{s:7:\"matches\";a:4:{i:0;a:2:{s:2:\"id\";s:32:\"c215fc75951b35c5847a807240fab2ea\";s:5:\"value\";s:20:\"<p>Nuclear Force</p>\";}i:1;a:2:{s:2:\"id\";s:32:\"a9577d25b70d4788551133ae4f265347\";s:5:\"value\";s:27:\"<p>Electomagnetic Force</p>\";}i:2;a:2:{s:2:\"id\";s:32:\"2577539023dcd204eb78a3ad1cd6201c\";s:5:\"value\";s:25:\"<p>Weak Nuclear Force</p>\";}i:3;a:2:{s:2:\"id\";s:32:\"19be0e556de5c94f431c8d9ced56641f\";s:5:\"value\";s:26:\"<p>Gravitational Force</p>\";}}s:5:\"pairs\";a:4:{i:0;a:3:{s:2:\"id\";s:32:\"a22d6a95d33b5208f04eedb325282800\";s:5:\"value\";s:8:\"<p>1</p>\";s:4:\"code\";s:1:\"A\";}i:1;a:3:{s:2:\"id\";s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";s:5:\"value\";s:8:\"<p>2</p>\";s:4:\"code\";s:1:\"B\";}i:2;a:3:{s:2:\"id\";s:32:\"1d996b61ee20735a967752c065fd62b0\";s:5:\"value\";s:8:\"<p>3</p>\";s:4:\"code\";s:1:\"C\";}i:3;a:3:{s:2:\"id\";s:32:\"7667e2cd947e57f259549e120bbc619d\";s:5:\"value\";s:8:\"<p>4</p>\";s:4:\"code\";s:1:\"D\";}}}','a:0:{}','a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}','not_answered',0,228,0.00,0.00),(15,1,1,'<p>What is the charge of an electron?</p>','a:2:{i:0;s:15:\"<p>Positive</p>\";i:1;s:15:\"<p>Negative</p>\";}',NULL,'i:2;','not_visited',NULL,0,0.00,0.00),(15,2,2,'<p>What is the order of fundamental forces in nature according to their strengths.</p>','a:2:{s:7:\"matches\";a:4:{i:0;a:2:{s:2:\"id\";s:32:\"c215fc75951b35c5847a807240fab2ea\";s:5:\"value\";s:20:\"<p>Nuclear Force</p>\";}i:1;a:2:{s:2:\"id\";s:32:\"a9577d25b70d4788551133ae4f265347\";s:5:\"value\";s:27:\"<p>Electomagnetic Force</p>\";}i:2;a:2:{s:2:\"id\";s:32:\"2577539023dcd204eb78a3ad1cd6201c\";s:5:\"value\";s:25:\"<p>Weak Nuclear Force</p>\";}i:3;a:2:{s:2:\"id\";s:32:\"19be0e556de5c94f431c8d9ced56641f\";s:5:\"value\";s:26:\"<p>Gravitational Force</p>\";}}s:5:\"pairs\";a:4:{i:0;a:3:{s:2:\"id\";s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";s:5:\"value\";s:8:\"<p>2</p>\";s:4:\"code\";s:1:\"A\";}i:1;a:3:{s:2:\"id\";s:32:\"a22d6a95d33b5208f04eedb325282800\";s:5:\"value\";s:8:\"<p>1</p>\";s:4:\"code\";s:1:\"B\";}i:2;a:3:{s:2:\"id\";s:32:\"7667e2cd947e57f259549e120bbc619d\";s:5:\"value\";s:8:\"<p>4</p>\";s:4:\"code\";s:1:\"C\";}i:3;a:3:{s:2:\"id\";s:32:\"1d996b61ee20735a967752c065fd62b0\";s:5:\"value\";s:8:\"<p>3</p>\";s:4:\"code\";s:1:\"D\";}}}',NULL,'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}','not_visited',NULL,0,0.00,0.00),(16,2,1,'<p>What is the charge of an electron?</p>','a:2:{i:0;s:15:\"<p>Positive</p>\";i:1;s:15:\"<p>Negative</p>\";}',NULL,'i:2;','not_visited',NULL,0,0.00,0.00),(16,1,2,'<p>What is the order of fundamental forces in nature according to their strengths.</p>','a:2:{s:7:\"matches\";a:4:{i:0;a:2:{s:2:\"id\";s:32:\"c215fc75951b35c5847a807240fab2ea\";s:5:\"value\";s:20:\"<p>Nuclear Force</p>\";}i:1;a:2:{s:2:\"id\";s:32:\"a9577d25b70d4788551133ae4f265347\";s:5:\"value\";s:27:\"<p>Electomagnetic Force</p>\";}i:2;a:2:{s:2:\"id\";s:32:\"2577539023dcd204eb78a3ad1cd6201c\";s:5:\"value\";s:25:\"<p>Weak Nuclear Force</p>\";}i:3;a:2:{s:2:\"id\";s:32:\"19be0e556de5c94f431c8d9ced56641f\";s:5:\"value\";s:26:\"<p>Gravitational Force</p>\";}}s:5:\"pairs\";a:4:{i:0;a:3:{s:2:\"id\";s:32:\"7667e2cd947e57f259549e120bbc619d\";s:5:\"value\";s:8:\"<p>4</p>\";s:4:\"code\";s:1:\"A\";}i:1;a:3:{s:2:\"id\";s:32:\"1d996b61ee20735a967752c065fd62b0\";s:5:\"value\";s:8:\"<p>3</p>\";s:4:\"code\";s:1:\"B\";}i:2;a:3:{s:2:\"id\";s:32:\"a22d6a95d33b5208f04eedb325282800\";s:5:\"value\";s:8:\"<p>1</p>\";s:4:\"code\";s:1:\"C\";}i:3;a:3:{s:2:\"id\";s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";s:5:\"value\";s:8:\"<p>2</p>\";s:4:\"code\";s:1:\"D\";}}}',NULL,'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}','not_visited',NULL,0,0.00,0.00),(17,1,1,'<p>What is the charge of an electron?</p>','a:2:{i:0;s:15:\"<p>Positive</p>\";i:1;s:15:\"<p>Negative</p>\";}',NULL,'i:2;','not_visited',NULL,0,0.00,0.00),(17,2,2,'<p>What is the order of fundamental forces in nature according to their strengths.</p>','a:2:{s:7:\"matches\";a:4:{i:0;a:2:{s:2:\"id\";s:32:\"c215fc75951b35c5847a807240fab2ea\";s:5:\"value\";s:20:\"<p>Nuclear Force</p>\";}i:1;a:2:{s:2:\"id\";s:32:\"a9577d25b70d4788551133ae4f265347\";s:5:\"value\";s:27:\"<p>Electomagnetic Force</p>\";}i:2;a:2:{s:2:\"id\";s:32:\"2577539023dcd204eb78a3ad1cd6201c\";s:5:\"value\";s:25:\"<p>Weak Nuclear Force</p>\";}i:3;a:2:{s:2:\"id\";s:32:\"19be0e556de5c94f431c8d9ced56641f\";s:5:\"value\";s:26:\"<p>Gravitational Force</p>\";}}s:5:\"pairs\";a:4:{i:0;a:3:{s:2:\"id\";s:32:\"7667e2cd947e57f259549e120bbc619d\";s:5:\"value\";s:8:\"<p>4</p>\";s:4:\"code\";s:1:\"A\";}i:1;a:3:{s:2:\"id\";s:32:\"1d996b61ee20735a967752c065fd62b0\";s:5:\"value\";s:8:\"<p>3</p>\";s:4:\"code\";s:1:\"B\";}i:2;a:3:{s:2:\"id\";s:32:\"a22d6a95d33b5208f04eedb325282800\";s:5:\"value\";s:8:\"<p>1</p>\";s:4:\"code\";s:1:\"C\";}i:3;a:3:{s:2:\"id\";s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";s:5:\"value\";s:8:\"<p>2</p>\";s:4:\"code\";s:1:\"D\";}}}','a:0:{}','a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}','not_answered',0,151,0.00,0.00),(18,1,1,'<p>What is the charge of an electron?</p>','a:2:{i:0;s:15:\"<p>Positive</p>\";i:1;s:15:\"<p>Negative</p>\";}',NULL,'i:2;','not_visited',NULL,0,0.00,0.00),(18,2,2,'<p>What is the order of fundamental forces in nature according to their strengths.</p>','a:2:{s:7:\"matches\";a:4:{i:0;a:2:{s:2:\"id\";s:32:\"c215fc75951b35c5847a807240fab2ea\";s:5:\"value\";s:20:\"<p>Nuclear Force</p>\";}i:1;a:2:{s:2:\"id\";s:32:\"a9577d25b70d4788551133ae4f265347\";s:5:\"value\";s:27:\"<p>Electomagnetic Force</p>\";}i:2;a:2:{s:2:\"id\";s:32:\"2577539023dcd204eb78a3ad1cd6201c\";s:5:\"value\";s:25:\"<p>Weak Nuclear Force</p>\";}i:3;a:2:{s:2:\"id\";s:32:\"19be0e556de5c94f431c8d9ced56641f\";s:5:\"value\";s:26:\"<p>Gravitational Force</p>\";}}s:5:\"pairs\";a:4:{i:0;a:3:{s:2:\"id\";s:32:\"1d996b61ee20735a967752c065fd62b0\";s:5:\"value\";s:8:\"<p>3</p>\";s:4:\"code\";s:1:\"A\";}i:1;a:3:{s:2:\"id\";s:32:\"a22d6a95d33b5208f04eedb325282800\";s:5:\"value\";s:8:\"<p>1</p>\";s:4:\"code\";s:1:\"B\";}i:2;a:3:{s:2:\"id\";s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";s:5:\"value\";s:8:\"<p>2</p>\";s:4:\"code\";s:1:\"C\";}i:3;a:3:{s:2:\"id\";s:32:\"7667e2cd947e57f259549e120bbc619d\";s:5:\"value\";s:8:\"<p>4</p>\";s:4:\"code\";s:1:\"D\";}}}','a:0:{}','a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}','not_answered',0,347,0.00,0.00),(19,2,1,'<p>What is the charge of an electron?</p>','a:2:{i:0;s:15:\"<p>Positive</p>\";i:1;s:15:\"<p>Negative</p>\";}','N;','i:2;','not_answered',0,78,0.00,0.00),(19,1,2,'<p>What is the order of fundamental forces in nature according to their strengths.</p>','a:2:{s:7:\"matches\";a:4:{i:0;a:2:{s:2:\"id\";s:32:\"c215fc75951b35c5847a807240fab2ea\";s:5:\"value\";s:20:\"<p>Nuclear Force</p>\";}i:1;a:2:{s:2:\"id\";s:32:\"a9577d25b70d4788551133ae4f265347\";s:5:\"value\";s:27:\"<p>Electomagnetic Force</p>\";}i:2;a:2:{s:2:\"id\";s:32:\"2577539023dcd204eb78a3ad1cd6201c\";s:5:\"value\";s:25:\"<p>Weak Nuclear Force</p>\";}i:3;a:2:{s:2:\"id\";s:32:\"19be0e556de5c94f431c8d9ced56641f\";s:5:\"value\";s:26:\"<p>Gravitational Force</p>\";}}s:5:\"pairs\";a:4:{i:0;a:3:{s:2:\"id\";s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";s:5:\"value\";s:8:\"<p>2</p>\";s:4:\"code\";s:1:\"A\";}i:1;a:3:{s:2:\"id\";s:32:\"1d996b61ee20735a967752c065fd62b0\";s:5:\"value\";s:8:\"<p>3</p>\";s:4:\"code\";s:1:\"B\";}i:2;a:3:{s:2:\"id\";s:32:\"a22d6a95d33b5208f04eedb325282800\";s:5:\"value\";s:8:\"<p>1</p>\";s:4:\"code\";s:1:\"C\";}i:3;a:3:{s:2:\"id\";s:32:\"7667e2cd947e57f259549e120bbc619d\";s:5:\"value\";s:8:\"<p>4</p>\";s:4:\"code\";s:1:\"D\";}}}','a:0:{}','a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}','not_answered',0,31,0.00,0.00),(20,2,1,'<p>What is the charge of an electron?</p>','a:2:{i:0;s:15:\"<p>Positive</p>\";i:1;s:15:\"<p>Negative</p>\";}','i:1;','i:2;','answered',0,31,0.00,0.00),(20,1,2,'<p>What is the order of fundamental forces in nature according to their strengths.</p>','a:2:{s:7:\"matches\";a:4:{i:0;a:2:{s:2:\"id\";s:32:\"c215fc75951b35c5847a807240fab2ea\";s:5:\"value\";s:20:\"<p>Nuclear Force</p>\";}i:1;a:2:{s:2:\"id\";s:32:\"a9577d25b70d4788551133ae4f265347\";s:5:\"value\";s:27:\"<p>Electomagnetic Force</p>\";}i:2;a:2:{s:2:\"id\";s:32:\"2577539023dcd204eb78a3ad1cd6201c\";s:5:\"value\";s:25:\"<p>Weak Nuclear Force</p>\";}i:3;a:2:{s:2:\"id\";s:32:\"19be0e556de5c94f431c8d9ced56641f\";s:5:\"value\";s:26:\"<p>Gravitational Force</p>\";}}s:5:\"pairs\";a:4:{i:0;a:3:{s:2:\"id\";s:32:\"7667e2cd947e57f259549e120bbc619d\";s:5:\"value\";s:8:\"<p>4</p>\";s:4:\"code\";s:1:\"A\";}i:1;a:3:{s:2:\"id\";s:32:\"1d996b61ee20735a967752c065fd62b0\";s:5:\"value\";s:8:\"<p>3</p>\";s:4:\"code\";s:1:\"B\";}i:2;a:3:{s:2:\"id\";s:32:\"a22d6a95d33b5208f04eedb325282800\";s:5:\"value\";s:8:\"<p>1</p>\";s:4:\"code\";s:1:\"C\";}i:3;a:3:{s:2:\"id\";s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";s:5:\"value\";s:8:\"<p>2</p>\";s:4:\"code\";s:1:\"D\";}}}',NULL,'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}','not_visited',NULL,0,0.00,0.00),(21,1,1,'<p>What is the charge of an electron?</p>','a:2:{i:0;s:15:\"<p>Positive</p>\";i:1;s:15:\"<p>Negative</p>\";}','i:2;','i:2;','answered',1,4,300.00,0.00),(21,2,2,'<p>What is the order of fundamental forces in nature according to their strengths.</p>','a:2:{s:7:\"matches\";a:4:{i:0;a:2:{s:2:\"id\";s:32:\"c215fc75951b35c5847a807240fab2ea\";s:5:\"value\";s:20:\"<p>Nuclear Force</p>\";}i:1;a:2:{s:2:\"id\";s:32:\"a9577d25b70d4788551133ae4f265347\";s:5:\"value\";s:27:\"<p>Electomagnetic Force</p>\";}i:2;a:2:{s:2:\"id\";s:32:\"2577539023dcd204eb78a3ad1cd6201c\";s:5:\"value\";s:25:\"<p>Weak Nuclear Force</p>\";}i:3;a:2:{s:2:\"id\";s:32:\"19be0e556de5c94f431c8d9ced56641f\";s:5:\"value\";s:26:\"<p>Gravitational Force</p>\";}}s:5:\"pairs\";a:4:{i:0;a:3:{s:2:\"id\";s:32:\"a22d6a95d33b5208f04eedb325282800\";s:5:\"value\";s:8:\"<p>1</p>\";s:4:\"code\";s:1:\"A\";}i:1;a:3:{s:2:\"id\";s:32:\"7667e2cd947e57f259549e120bbc619d\";s:5:\"value\";s:8:\"<p>4</p>\";s:4:\"code\";s:1:\"B\";}i:2;a:3:{s:2:\"id\";s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";s:5:\"value\";s:8:\"<p>2</p>\";s:4:\"code\";s:1:\"C\";}i:3;a:3:{s:2:\"id\";s:32:\"1d996b61ee20735a967752c065fd62b0\";s:5:\"value\";s:8:\"<p>3</p>\";s:4:\"code\";s:1:\"D\";}}}','a:4:{i:0;a:3:{s:2:\"id\";s:32:\"a22d6a95d33b5208f04eedb325282800\";s:5:\"value\";s:8:\"<p>1</p>\";s:4:\"code\";s:1:\"A\";}i:1;a:3:{s:2:\"id\";s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";s:5:\"value\";s:8:\"<p>2</p>\";s:4:\"code\";s:1:\"C\";}i:2;a:3:{s:2:\"id\";s:32:\"1d996b61ee20735a967752c065fd62b0\";s:5:\"value\";s:8:\"<p>3</p>\";s:4:\"code\";s:1:\"D\";}i:3;a:3:{s:2:\"id\";s:32:\"7667e2cd947e57f259549e120bbc619d\";s:5:\"value\";s:8:\"<p>4</p>\";s:4:\"code\";s:1:\"B\";}}','a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}','answered',1,84,300.00,0.00),(22,1,1,'<p>What is the charge of an electron?</p>','a:2:{i:0;s:15:\"<p>Positive</p>\";i:1;s:15:\"<p>Negative</p>\";}','N;','i:2;','not_answered',0,13,0.00,0.00),(22,2,2,'<p>What is the order of fundamental forces in nature according to their strengths.</p>','a:2:{s:7:\"matches\";a:4:{i:0;a:2:{s:2:\"id\";s:32:\"c215fc75951b35c5847a807240fab2ea\";s:5:\"value\";s:20:\"<p>Nuclear Force</p>\";}i:1;a:2:{s:2:\"id\";s:32:\"a9577d25b70d4788551133ae4f265347\";s:5:\"value\";s:27:\"<p>Electomagnetic Force</p>\";}i:2;a:2:{s:2:\"id\";s:32:\"2577539023dcd204eb78a3ad1cd6201c\";s:5:\"value\";s:25:\"<p>Weak Nuclear Force</p>\";}i:3;a:2:{s:2:\"id\";s:32:\"19be0e556de5c94f431c8d9ced56641f\";s:5:\"value\";s:26:\"<p>Gravitational Force</p>\";}}s:5:\"pairs\";a:4:{i:0;a:3:{s:2:\"id\";s:32:\"a22d6a95d33b5208f04eedb325282800\";s:5:\"value\";s:8:\"<p>1</p>\";s:4:\"code\";s:1:\"A\";}i:1;a:3:{s:2:\"id\";s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";s:5:\"value\";s:8:\"<p>2</p>\";s:4:\"code\";s:1:\"B\";}i:2;a:3:{s:2:\"id\";s:32:\"7667e2cd947e57f259549e120bbc619d\";s:5:\"value\";s:8:\"<p>4</p>\";s:4:\"code\";s:1:\"C\";}i:3;a:3:{s:2:\"id\";s:32:\"1d996b61ee20735a967752c065fd62b0\";s:5:\"value\";s:8:\"<p>3</p>\";s:4:\"code\";s:1:\"D\";}}}',NULL,'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}','not_visited',NULL,0,0.00,0.00),(23,2,1,'<p>What is the charge of an electron?</p>','a:2:{i:0;s:15:\"<p>Positive</p>\";i:1;s:15:\"<p>Negative</p>\";}','N;','i:2;','not_answered',0,156,0.00,0.00),(23,1,2,'<p>What is the order of fundamental forces in nature according to their strengths.</p>','a:2:{s:7:\"matches\";a:4:{i:0;a:2:{s:2:\"id\";s:32:\"c215fc75951b35c5847a807240fab2ea\";s:5:\"value\";s:20:\"<p>Nuclear Force</p>\";}i:1;a:2:{s:2:\"id\";s:32:\"a9577d25b70d4788551133ae4f265347\";s:5:\"value\";s:27:\"<p>Electomagnetic Force</p>\";}i:2;a:2:{s:2:\"id\";s:32:\"2577539023dcd204eb78a3ad1cd6201c\";s:5:\"value\";s:25:\"<p>Weak Nuclear Force</p>\";}i:3;a:2:{s:2:\"id\";s:32:\"19be0e556de5c94f431c8d9ced56641f\";s:5:\"value\";s:26:\"<p>Gravitational Force</p>\";}}s:5:\"pairs\";a:4:{i:0;a:3:{s:2:\"id\";s:32:\"7667e2cd947e57f259549e120bbc619d\";s:5:\"value\";s:8:\"<p>4</p>\";s:4:\"code\";s:1:\"A\";}i:1;a:3:{s:2:\"id\";s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";s:5:\"value\";s:8:\"<p>2</p>\";s:4:\"code\";s:1:\"B\";}i:2;a:3:{s:2:\"id\";s:32:\"a22d6a95d33b5208f04eedb325282800\";s:5:\"value\";s:8:\"<p>1</p>\";s:4:\"code\";s:1:\"C\";}i:3;a:3:{s:2:\"id\";s:32:\"1d996b61ee20735a967752c065fd62b0\";s:5:\"value\";s:8:\"<p>3</p>\";s:4:\"code\";s:1:\"D\";}}}',NULL,'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}','not_visited',NULL,0,0.00,0.00),(24,2,1,'<p>What is the charge of an electron?</p>','a:2:{i:0;s:15:\"<p>Positive</p>\";i:1;s:15:\"<p>Negative</p>\";}','i:2;','i:2;','answered',1,25,300.00,0.00),(24,3,2,'<p>What is the order of fundamental forces in nature according to their strengths.</p>','a:2:{s:7:\"matches\";a:4:{i:0;a:2:{s:2:\"id\";s:32:\"c215fc75951b35c5847a807240fab2ea\";s:5:\"value\";s:20:\"<p>Nuclear Force</p>\";}i:1;a:2:{s:2:\"id\";s:32:\"a9577d25b70d4788551133ae4f265347\";s:5:\"value\";s:27:\"<p>Electomagnetic Force</p>\";}i:2;a:2:{s:2:\"id\";s:32:\"2577539023dcd204eb78a3ad1cd6201c\";s:5:\"value\";s:25:\"<p>Weak Nuclear Force</p>\";}i:3;a:2:{s:2:\"id\";s:32:\"19be0e556de5c94f431c8d9ced56641f\";s:5:\"value\";s:26:\"<p>Gravitational Force</p>\";}}s:5:\"pairs\";a:4:{i:0;a:3:{s:2:\"id\";s:32:\"1d996b61ee20735a967752c065fd62b0\";s:5:\"value\";s:8:\"<p>3</p>\";s:4:\"code\";s:1:\"A\";}i:1;a:3:{s:2:\"id\";s:32:\"7667e2cd947e57f259549e120bbc619d\";s:5:\"value\";s:8:\"<p>4</p>\";s:4:\"code\";s:1:\"B\";}i:2;a:3:{s:2:\"id\";s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";s:5:\"value\";s:8:\"<p>2</p>\";s:4:\"code\";s:1:\"C\";}i:3;a:3:{s:2:\"id\";s:32:\"a22d6a95d33b5208f04eedb325282800\";s:5:\"value\";s:8:\"<p>1</p>\";s:4:\"code\";s:1:\"D\";}}}',NULL,'a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}','not_visited',NULL,0,0.00,0.00),(24,4,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}',NULL,'i:4;','not_visited',NULL,0,0.00,0.00),(24,5,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(24,1,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}','i:1;','i:1;','answered',1,15,30.00,0.00),(25,5,1,'<p>What is the charge of an electron?</p>','a:2:{i:0;s:15:\"<p>Positive</p>\";i:1;s:15:\"<p>Negative</p>\";}','N;','i:2;','not_answered',0,56,0.00,0.00),(25,1,2,'<p>What is the order of fundamental forces in nature according to their strengths.</p>','a:2:{s:7:\"matches\";a:4:{i:0;a:2:{s:2:\"id\";s:32:\"c215fc75951b35c5847a807240fab2ea\";s:5:\"value\";s:20:\"<p>Nuclear Force</p>\";}i:1;a:2:{s:2:\"id\";s:32:\"a9577d25b70d4788551133ae4f265347\";s:5:\"value\";s:27:\"<p>Electomagnetic Force</p>\";}i:2;a:2:{s:2:\"id\";s:32:\"2577539023dcd204eb78a3ad1cd6201c\";s:5:\"value\";s:25:\"<p>Weak Nuclear Force</p>\";}i:3;a:2:{s:2:\"id\";s:32:\"19be0e556de5c94f431c8d9ced56641f\";s:5:\"value\";s:26:\"<p>Gravitational Force</p>\";}}s:5:\"pairs\";a:4:{i:0;a:3:{s:2:\"id\";s:32:\"7667e2cd947e57f259549e120bbc619d\";s:5:\"value\";s:8:\"<p>4</p>\";s:4:\"code\";s:1:\"A\";}i:1;a:3:{s:2:\"id\";s:32:\"1d996b61ee20735a967752c065fd62b0\";s:5:\"value\";s:8:\"<p>3</p>\";s:4:\"code\";s:1:\"B\";}i:2;a:3:{s:2:\"id\";s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";s:5:\"value\";s:8:\"<p>2</p>\";s:4:\"code\";s:1:\"C\";}i:3;a:3:{s:2:\"id\";s:32:\"a22d6a95d33b5208f04eedb325282800\";s:5:\"value\";s:8:\"<p>1</p>\";s:4:\"code\";s:1:\"D\";}}}','a:4:{i:0;a:3:{s:2:\"id\";s:32:\"a22d6a95d33b5208f04eedb325282800\";s:5:\"value\";s:8:\"<p>1</p>\";s:4:\"code\";s:1:\"D\";}i:1;a:3:{s:2:\"id\";s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";s:5:\"value\";s:8:\"<p>2</p>\";s:4:\"code\";s:1:\"C\";}i:2;a:3:{s:2:\"id\";s:32:\"1d996b61ee20735a967752c065fd62b0\";s:5:\"value\";s:8:\"<p>3</p>\";s:4:\"code\";s:1:\"B\";}i:3;a:3:{s:2:\"id\";s:32:\"7667e2cd947e57f259549e120bbc619d\";s:5:\"value\";s:8:\"<p>4</p>\";s:4:\"code\";s:1:\"A\";}}','a:4:{i:0;s:32:\"a22d6a95d33b5208f04eedb325282800\";i:1;s:32:\"d1a89b1335613b7b84b5426e0ef6452a\";i:2;s:32:\"1d996b61ee20735a967752c065fd62b0\";i:3;s:32:\"7667e2cd947e57f259549e120bbc619d\";}','answered',1,22,300.00,0.00),(25,4,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}','i:3;','i:4;','answered',0,8,0.00,0.00),(25,2,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}','i:1;','i:1;','answered',1,8,30.00,0.00),(25,3,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}','i:1;','i:1;','answered',1,14,30.00,0.00),(26,1,1,'<p>What is the charge of an electron?</p>','a:2:{i:0;s:15:\"<p>Positive</p>\";i:1;s:15:\"<p>Negative</p>\";}','i:2;','i:2;','answered',1,11,300.00,0.00),(26,2,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}',NULL,'i:4;','not_visited',NULL,0,0.00,0.00),(26,3,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}','i:1;','i:1;','answered',1,3,30.00,0.00),(26,4,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}','i:2;','i:1;','answered',0,48,0.00,0.00),(27,4,1,'<p>What is the charge of an electron?</p>','a:2:{i:0;s:15:\"<p>Positive</p>\";i:1;s:15:\"<p>Negative</p>\";}',NULL,'i:2;','not_visited',NULL,0,0.00,0.00),(27,3,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}','i:3;','i:4;','answered',0,4,0.00,0.00),(27,1,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}','i:3;','i:1;','answered',0,13,0.00,0.00),(27,2,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}','i:2;','i:1;','answered',0,12,0.00,0.00),(28,4,1,'<p>What is the charge of an electron?</p>','a:2:{i:0;s:15:\"<p>Positive</p>\";i:1;s:15:\"<p>Negative</p>\";}','i:1;','i:2;','answered',0,11,0.00,0.00),(28,1,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}','i:3;','i:4;','answered',0,5,0.00,0.00),(28,2,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}','i:1;','i:1;','answered',1,5,30.00,0.00),(28,3,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}','i:1;','i:1;','answered',1,4,30.00,0.00),(29,3,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}','i:4;','i:4;','answered',1,8,30.00,0.00),(29,1,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}','i:2;','i:1;','answered',0,4,0.00,0.00),(29,2,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}','i:1;','i:1;','answered',1,4,30.00,0.00),(30,1,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}','i:4;','i:4;','answered',1,3,30.00,0.00),(30,2,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}','i:1;','i:1;','answered',1,5,30.00,0.00),(30,3,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}','N;','i:1;','not_answered',0,3,0.00,0.00),(31,2,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}','i:2;','i:4;','answered',0,3,0.00,0.00),(31,3,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}','i:2;','i:1;','answered',0,8,0.00,0.00),(31,1,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}','i:1;','i:1;','answered',1,3,30.00,0.00),(32,3,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}',NULL,'i:4;','not_visited',NULL,0,0.00,0.00),(32,1,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}','i:1;','i:1;','answered',1,3,30.00,0.00),(32,2,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}','i:2;','i:1;','answered',0,3,0.00,0.00),(33,1,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}','i:4;','i:4;','answered',1,2,28.00,0.00),(33,2,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}','i:1;','i:1;','answered',1,3,28.00,0.00),(33,3,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}','i:2;','i:1;','answered',0,5,0.00,0.00),(34,3,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}','i:3;','i:4;','answered',0,4,0.00,0.00),(34,2,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}','i:1;','i:1;','answered',1,3,27.00,0.00),(34,1,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}','i:1;','i:1;','answered',1,5,25.00,0.00),(35,1,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}','N;','i:4;','not_answered',0,3,0.00,0.00),(35,3,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(35,2,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(36,1,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}','i:4;','i:4;','answered',1,14,20.00,0.00),(36,2,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}','N;','i:1;','not_answered',0,1,0.00,0.00),(36,3,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}','N;','i:1;','not_answered',0,3,0.00,0.00),(37,1,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}','i:4;','i:4;','answered',1,4,26.00,0.00),(37,3,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}','i:1;','i:1;','answered',1,7,24.00,0.00),(37,2,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(38,1,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}','N;','i:4;','not_answered',0,1,0.00,0.00),(38,2,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(38,3,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(39,1,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}','i:4;','i:4;','answered',1,3,27.00,0.00),(39,2,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}','i:1;','i:1;','answered',1,7,24.00,0.00),(39,3,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}','i:2;','i:1;','answered',0,4,0.00,0.00),(40,1,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}','i:4;','i:4;','answered',1,2,28.00,0.00),(40,2,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}','i:1;','i:1;','answered',1,6,25.00,0.00),(40,3,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(41,1,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}','i:4;','i:4;','answered',1,3,27.00,0.00),(41,3,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(41,2,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}','i:1;','i:1;','answered',1,10,20.00,0.00),(42,2,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}',NULL,'i:4;','not_visited',NULL,0,0.00,0.00),(42,1,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}','i:1;','i:1;','answered',1,10,29.00,0.00),(42,3,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(43,1,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}','i:4;','i:4;','answered',1,3,27.00,0.00),(43,3,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(43,2,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}','i:1;','i:1;','answered',1,6,25.00,0.00),(44,2,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}','i:4;','i:4;','answered',1,8,22.00,0.00),(44,1,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}','i:1;','i:1;','answered',1,3,28.00,0.00),(44,3,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}','i:1;','i:1;','answered',1,10,21.00,0.00),(45,1,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}','i:4;','i:4;','answered',1,6,24.00,0.00),(45,2,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(45,3,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}','N;','i:1;','not_answered',0,3,0.00,0.00),(46,3,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}',NULL,'i:4;','not_visited',NULL,0,0.00,0.00),(46,2,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(46,1,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}','i:1;','i:1;','answered',1,4,26.00,0.00),(47,3,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}',NULL,'i:4;','not_visited',NULL,0,0.00,0.00),(47,1,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(47,2,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(48,1,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}',NULL,'i:4;','not_visited',NULL,0,0.00,0.00),(48,3,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(48,2,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(49,1,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}',NULL,'i:4;','not_visited',NULL,0,0.00,0.00),(49,3,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(49,2,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(50,3,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}',NULL,'i:4;','not_visited',NULL,0,0.00,0.00),(50,1,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(50,2,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(51,1,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}',NULL,'i:4;','not_visited',NULL,0,0.00,0.00),(51,3,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(51,2,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(52,3,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}',NULL,'i:4;','not_visited',NULL,0,0.00,0.00),(52,2,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(52,1,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(53,2,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}',NULL,'i:4;','not_visited',NULL,0,0.00,0.00),(53,1,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(53,3,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(54,3,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}',NULL,'i:4;','not_visited',NULL,0,0.00,0.00),(54,2,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(54,1,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(55,3,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}',NULL,'i:4;','not_visited',NULL,0,0.00,0.00),(55,1,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(55,2,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(56,1,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}',NULL,'i:4;','not_visited',NULL,0,0.00,0.00),(56,2,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(56,3,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(57,2,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}',NULL,'i:4;','not_visited',NULL,0,0.00,0.00),(57,1,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(57,3,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(58,3,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}',NULL,'i:4;','not_visited',NULL,0,0.00,0.00),(58,2,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(58,1,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(59,1,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}','N;','i:4;','not_answered',0,2,0.00,0.00),(59,3,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}','i:4;','i:1;','answered',0,10,0.00,0.00),(59,2,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(60,3,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}','i:4;','i:4;','answered',1,7,23.00,0.00),(60,2,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}','N;','i:1;','not_answered',0,5,0.00,0.00),(60,1,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}','i:1;','i:1;','answered',1,5,25.00,0.00),(61,1,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}','i:1;','i:4;','answered',0,5,0.00,0.00),(61,3,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(61,2,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(62,2,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}','i:4;','i:4;','answered',1,4,26.00,0.00),(62,3,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}','i:2;','i:1;','answered',0,3,0.00,0.00),(62,1,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}','i:1;','i:1;','answered',1,6,27.00,0.00),(63,3,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}',NULL,'i:4;','not_visited',NULL,0,0.00,0.00),(63,2,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}','i:2;','i:1;','answered',0,4,0.00,0.00),(63,1,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}','N;','i:1;','not_answered',0,6,0.00,0.00),(64,3,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}',NULL,'i:4;','not_visited',NULL,0,0.00,0.00),(64,1,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}','i:3;','i:1;','answered',0,26,0.00,0.00),(64,2,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(65,1,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}',NULL,'i:4;','not_visited',NULL,0,0.00,0.00),(65,3,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(65,2,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(66,3,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}',NULL,'i:4;','not_visited',NULL,0,0.00,0.00),(66,1,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(66,2,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(67,1,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}',NULL,'i:4;','not_visited',NULL,0,0.00,0.00),(67,3,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(67,2,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(68,1,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}',NULL,'i:4;','not_visited',NULL,0,0.00,0.00),(68,3,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(68,2,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(69,2,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}',NULL,'i:4;','not_visited',NULL,0,0.00,0.00),(69,1,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(69,3,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(70,3,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}',NULL,'i:4;','not_visited',NULL,0,0.00,0.00),(70,2,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(70,1,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(71,1,3,'<p>What is the weight of The Sun?</p>','a:4:{i:0;s:10:\"<p>5kg</p>\";i:1;s:10:\"<p>2kg</p>\";i:2;s:10:\"<p>9kg</p>\";i:3;s:21:\"<p>more than 9kg.</p>\";}','i:4;','i:4;','answered',1,11,20.00,0.00),(71,3,4,'<p>What is the amount of charge a proton holds?</p>','a:4:{i:0;s:9:\"<p>1e</p>\";i:1;s:9:\"<p>2e</p>\";i:2;s:9:\"<p>3e</p>\";i:3;s:9:\"<p>4e</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00),(71,2,5,'<p>Which of the following is not an electric appliances?</p>','a:4:{i:0;s:25:\"<p>electron projector</p>\";i:1;s:11:\"<p>Bulb</p>\";i:2;s:28:\"<p>Thermonuclear reactor</p>\";i:3;s:10:\"<p>Fan</p>\";}',NULL,'i:1;','not_visited',NULL,0,0.00,0.00);
/*!40000 ALTER TABLE `quiz_session_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz_sessions`
--

DROP TABLE IF EXISTS `quiz_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quiz_sessions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quiz_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `quiz_schedule_id` bigint unsigned DEFAULT NULL,
  `starts_at` datetime NOT NULL,
  `ends_at` datetime NOT NULL,
  `total_time_taken` int NOT NULL DEFAULT '0',
  `current_question` int NOT NULL DEFAULT '0',
  `results` json DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'started',
  `completed_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `quiz_sessions_code_unique` (`code`),
  KEY `quiz_sessions_status_index` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz_sessions`
--

LOCK TABLES `quiz_sessions` WRITE;
/*!40000 ALTER TABLE `quiz_sessions` DISABLE KEYS */;
INSERT INTO `quiz_sessions` VALUES (1,'aa12f39a-bc89-4e62-998b-4949fe09e8f6',1,2,NULL,'2024-02-10 11:19:15','2024-02-10 11:29:15',23,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 600, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 10, \"total_questions\": 2, \"total_time_taken\": {\"seconds\": 23, \"short_readable\": \"0:0:23\", \"detailed_readable\": \"23 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 23, \"short_readable\": \"0:0:23\", \"detailed_readable\": \"23 Sec\"}, \"unanswered_questions\": 2, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-10 11:19:40','2024-02-10 05:49:15','2024-02-10 05:49:40',NULL),(2,'563f4d00-228a-48a9-be95-e33e694be8c0',1,2,NULL,'2024-02-10 11:48:48','2024-02-10 11:58:48',273,1,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 600, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 10, \"total_questions\": 2, \"total_time_taken\": {\"seconds\": 273, \"short_readable\": \"0:4:33\", \"detailed_readable\": \"4 Min 33 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 273, \"short_readable\": \"0:4:33\", \"detailed_readable\": \"4 Min 33 Sec\"}, \"unanswered_questions\": 2, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-10 12:01:45','2024-02-10 06:18:48','2024-02-10 06:31:45',NULL),(3,'29b10b8d-2d13-41ef-b50e-485f36780d2c',1,2,NULL,'2024-02-10 12:29:38','2024-02-10 12:39:38',28,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 600, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 10, \"total_questions\": 2, \"total_time_taken\": {\"seconds\": 28, \"short_readable\": \"0:0:28\", \"detailed_readable\": \"28 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 28, \"short_readable\": \"0:0:28\", \"detailed_readable\": \"28 Sec\"}, \"unanswered_questions\": 2, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-10 12:39:38','2024-02-10 06:59:38','2024-02-10 07:09:38',NULL),(4,'c3438e1f-f6d6-4a7a-84b2-aab2455173d4',1,2,NULL,'2024-02-10 12:41:03','2024-02-10 12:51:03',0,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 600, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 10, \"total_questions\": 2, \"total_time_taken\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 2, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-10 12:51:06','2024-02-10 07:11:03','2024-02-10 07:21:06',NULL),(5,'41ac27e5-0cac-4771-9433-beffd46116eb',1,2,NULL,'2024-02-10 14:42:30','2024-02-10 14:52:30',2,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 600, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 10, \"total_questions\": 2, \"total_time_taken\": {\"seconds\": 2, \"short_readable\": \"0:0:2\", \"detailed_readable\": \"2 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 2, \"short_readable\": \"0:0:2\", \"detailed_readable\": \"2 Sec\"}, \"unanswered_questions\": 2, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-10 14:50:47','2024-02-10 09:12:30','2024-02-10 09:20:47',NULL),(6,'0c46c69a-bae0-4883-bc24-112ccf4996ef',1,2,NULL,'2024-02-10 14:51:36','2024-02-10 15:01:36',0,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 600, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 10, \"total_questions\": 2, \"total_time_taken\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 2, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-10 15:02:37','2024-02-10 09:21:36','2024-02-10 09:32:37',NULL),(7,'bf3619f8-9967-4d27-8a7a-bf14c054133b',1,2,NULL,'2024-02-10 15:24:01','2024-02-10 15:34:01',0,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 600, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 10, \"total_questions\": 2, \"total_time_taken\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 2, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-10 16:00:05','2024-02-10 09:54:01','2024-02-10 10:30:05',NULL),(8,'04d1461c-e280-4651-a63d-c0fcde04f711',1,2,NULL,'2024-02-10 16:00:24','2024-02-10 16:10:24',0,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 600, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 10, \"total_questions\": 2, \"total_time_taken\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 2, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-10 16:10:26','2024-02-10 10:30:24','2024-02-10 10:40:26',NULL),(9,'a69b8729-90e5-4f9a-b454-14176f047e67',1,2,NULL,'2024-02-10 16:12:23','2024-02-10 16:22:23',14,1,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 600, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 10, \"total_questions\": 2, \"total_time_taken\": {\"seconds\": 14, \"short_readable\": \"0:0:14\", \"detailed_readable\": \"14 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 14, \"short_readable\": \"0:0:14\", \"detailed_readable\": \"14 Sec\"}, \"unanswered_questions\": 2, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-10 16:13:34','2024-02-10 10:42:23','2024-02-10 10:43:34',NULL),(10,'f8b52649-3da2-4ba7-af82-3eac8d390846',1,2,NULL,'2024-02-10 16:14:04','2024-02-10 16:24:04',0,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 600, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 10, \"total_questions\": 2, \"total_time_taken\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 2, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-10 16:14:04','2024-02-10 10:44:04','2024-02-10 10:44:04',NULL),(11,'882b5283-765a-49ef-ba69-6b91f0f0c72b',1,2,NULL,'2024-02-10 16:14:48','2024-02-10 16:24:48',0,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 600, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 10, \"total_questions\": 2, \"total_time_taken\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 2, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-10 16:37:24','2024-02-10 10:44:48','2024-02-10 11:07:24',NULL),(12,'84d3f108-0932-4b5c-8267-a40c4ec1fbc9',1,2,NULL,'2024-02-10 16:38:05','2024-02-10 16:48:05',0,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 600, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 10, \"total_questions\": 2, \"total_time_taken\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 2, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-10 16:48:54','2024-02-10 11:08:05','2024-02-10 11:18:54',NULL),(13,'7872f573-5eea-479a-beb2-b84c75c2af58',1,2,NULL,'2024-02-10 16:50:14','2024-02-10 17:00:14',0,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 600, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 10, \"total_questions\": 2, \"total_time_taken\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 2, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-10 17:00:09','2024-02-10 11:20:14','2024-02-10 11:30:09',NULL),(14,'e3b1d066-dcc1-415a-bf5a-1f7d287d3987',1,2,NULL,'2024-02-10 17:00:17','2024-02-10 17:10:17',228,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 600, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 10, \"total_questions\": 2, \"total_time_taken\": {\"seconds\": 228, \"short_readable\": \"0:3:48\", \"detailed_readable\": \"3 Min 48 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 228, \"short_readable\": \"0:3:48\", \"detailed_readable\": \"3 Min 48 Sec\"}, \"unanswered_questions\": 2, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-10 17:10:20','2024-02-10 11:30:17','2024-02-10 11:40:20',NULL),(15,'d3a99210-4e1d-4185-a87b-f720aafb8539',1,2,NULL,'2024-02-13 06:43:11','2024-02-13 06:53:11',0,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 600, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 10, \"total_questions\": 2, \"total_time_taken\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 2, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-13 07:00:10','2024-02-13 01:13:11','2024-02-13 01:30:10',NULL),(16,'76e9dbc2-e6c0-44a5-9c3b-c52084315ec4',1,2,NULL,'2024-02-13 07:47:01','2024-02-13 07:57:01',0,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 600, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 10, \"total_questions\": 2, \"total_time_taken\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 2, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-13 08:00:35','2024-02-13 02:17:01','2024-02-13 02:30:35',NULL),(17,'fa076178-c122-4cfc-94d1-f840b145af18',1,2,NULL,'2024-02-13 08:01:00','2024-02-13 08:11:00',182,1,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 600, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 10, \"total_questions\": 2, \"total_time_taken\": {\"seconds\": 182, \"short_readable\": \"0:3:2\", \"detailed_readable\": \"3 Min 2 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 182, \"short_readable\": \"0:3:2\", \"detailed_readable\": \"3 Min 2 Sec\"}, \"unanswered_questions\": 2, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-13 08:04:13','2024-02-13 02:31:00','2024-02-13 02:34:13',NULL),(18,'a863ba11-79b1-4e23-b494-c1eeefda6069',1,2,NULL,'2024-02-13 08:13:17','2024-02-13 08:23:17',377,1,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 600, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 10, \"total_questions\": 2, \"total_time_taken\": {\"seconds\": 377, \"short_readable\": \"0:6:17\", \"detailed_readable\": \"6 Min 17 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 377, \"short_readable\": \"0:6:17\", \"detailed_readable\": \"6 Min 17 Sec\"}, \"unanswered_questions\": 2, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-13 08:20:26','2024-02-13 02:43:17','2024-02-13 02:50:26',NULL),(19,'64df2e5e-fe7b-4a75-bc2d-0ea9c47bd38c',1,2,NULL,'2024-02-13 08:20:40','2024-02-13 08:30:40',109,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 600, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 10, \"total_questions\": 2, \"total_time_taken\": {\"seconds\": 109, \"short_readable\": \"0:1:49\", \"detailed_readable\": \"1 Min 49 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 109, \"short_readable\": \"0:1:49\", \"detailed_readable\": \"1 Min 49 Sec\"}, \"unanswered_questions\": 2, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-13 08:32:21','2024-02-13 02:50:40','2024-02-13 03:02:21',NULL),(20,'304c210b-9fa5-466c-ba87-bdd4ed355516',1,2,NULL,'2024-02-13 08:37:58','2024-02-13 08:47:58',108,1,'{\"score\": 0, \"speed\": 33, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 600, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 10, \"total_questions\": 2, \"total_time_taken\": {\"seconds\": 108, \"short_readable\": \"0:1:48\", \"detailed_readable\": \"1 Min 48 Sec\"}, \"answered_questions\": 1, \"time_taken_for_other\": {\"seconds\": 77, \"short_readable\": \"0:1:17\", \"detailed_readable\": \"1 Min 17 Sec\"}, \"unanswered_questions\": 1, \"time_taken_for_answered\": {\"seconds\": 31, \"short_readable\": \"0:0:31\", \"detailed_readable\": \"31 Sec\"}, \"wrong_answered_questions\": 1, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 31, \"short_readable\": \"0:0:31\", \"detailed_readable\": \"31 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-13 08:42:08','2024-02-13 03:07:58','2024-02-13 03:12:08',NULL),(21,'8292de1c-655e-4315-b8da-d63397a07056',1,2,NULL,'2024-02-13 08:42:15','2024-02-13 08:52:15',88,1,'{\"score\": 600, \"speed\": 82, \"cutoff\": 90, \"accuracy\": 100, \"ip_address\": \"127.0.0.1\", \"percentage\": 100, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 600, \"marks_earned\": 600, \"pass_or_fail\": \"Passed\", \"marks_deducted\": 0, \"total_duration\": 10, \"total_questions\": 2, \"total_time_taken\": {\"seconds\": 88, \"short_readable\": \"0:1:28\", \"detailed_readable\": \"1 Min 28 Sec\"}, \"answered_questions\": 2, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 0, \"time_taken_for_answered\": {\"seconds\": 88, \"short_readable\": \"0:1:28\", \"detailed_readable\": \"1 Min 28 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 2, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 88, \"short_readable\": \"0:1:28\", \"detailed_readable\": \"1 Min 28 Sec\"}}','completed','2024-02-13 08:43:46','2024-02-13 03:12:15','2024-02-13 03:13:46',NULL),(22,'db85fa22-5197-486f-bc19-abb2d21a4a37',1,2,NULL,'2024-02-13 08:43:55','2024-02-13 08:53:55',13,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 600, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 10, \"total_questions\": 2, \"total_time_taken\": {\"seconds\": 13, \"short_readable\": \"0:0:13\", \"detailed_readable\": \"13 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 13, \"short_readable\": \"0:0:13\", \"detailed_readable\": \"13 Sec\"}, \"unanswered_questions\": 2, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-13 08:55:25','2024-02-13 03:13:55','2024-02-13 03:25:25',NULL),(23,'9a54c2f2-6245-4536-84ee-ea60db821440',1,2,NULL,'2024-02-13 09:18:47','2024-02-13 09:28:47',271,1,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 600, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 10, \"total_questions\": 2, \"total_time_taken\": {\"seconds\": 271, \"short_readable\": \"0:4:31\", \"detailed_readable\": \"4 Min 31 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 271, \"short_readable\": \"0:4:31\", \"detailed_readable\": \"4 Min 31 Sec\"}, \"unanswered_questions\": 2, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-13 09:23:45','2024-02-13 03:48:47','2024-02-13 03:53:45',NULL),(24,'a9d7cee2-5464-4097-bba5-af91c81877b7',1,2,NULL,'2024-02-13 11:03:46','2024-02-13 11:06:16',40,1,'{\"score\": 330, \"speed\": 180, \"cutoff\": 90, \"accuracy\": 100, \"ip_address\": \"127.0.0.1\", \"percentage\": 47.83, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 690, \"marks_earned\": 330, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 2.5, \"total_questions\": 5, \"total_time_taken\": {\"seconds\": 40, \"short_readable\": \"0:0:40\", \"detailed_readable\": \"40 Sec\"}, \"answered_questions\": 2, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 3, \"time_taken_for_answered\": {\"seconds\": 40, \"short_readable\": \"0:0:40\", \"detailed_readable\": \"40 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 2, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 40, \"short_readable\": \"0:0:40\", \"detailed_readable\": \"40 Sec\"}}','completed','2024-02-13 11:06:17','2024-02-13 05:33:46','2024-02-13 05:36:17',NULL),(25,'1c5c07f9-262e-4e33-a60a-70fc7c9bfab0',1,2,NULL,'2024-02-13 11:09:45','2024-02-13 11:12:15',108,4,'{\"score\": 360, \"speed\": 133, \"cutoff\": 90, \"accuracy\": 75, \"ip_address\": \"127.0.0.1\", \"percentage\": 92.31, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 390, \"marks_earned\": 360, \"pass_or_fail\": \"Passed\", \"marks_deducted\": 0, \"total_duration\": 2, \"total_questions\": 4, \"total_time_taken\": {\"seconds\": 108, \"short_readable\": \"0:1:48\", \"detailed_readable\": \"1 Min 48 Sec\"}, \"answered_questions\": 4, \"time_taken_for_other\": {\"seconds\": 56, \"short_readable\": \"0:0:56\", \"detailed_readable\": \"56 Sec\"}, \"unanswered_questions\": 0, \"time_taken_for_answered\": {\"seconds\": 52, \"short_readable\": \"0:0:52\", \"detailed_readable\": \"52 Sec\"}, \"wrong_answered_questions\": 1, \"correct_answered_questions\": 3, \"time_taken_for_wrong_answered\": {\"seconds\": 8, \"short_readable\": \"0:0:8\", \"detailed_readable\": \"8 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 44, \"short_readable\": \"0:0:44\", \"detailed_readable\": \"44 Sec\"}}','completed','2024-02-13 11:12:24','2024-02-13 05:39:45','2024-02-13 05:42:24',NULL),(26,'ab345d6f-40ab-42c4-9f83-b6a2b8f59748',1,2,NULL,'2024-02-13 11:14:46','2024-02-13 11:16:46',93,3,'{\"score\": 330, \"speed\": 116, \"cutoff\": 90, \"accuracy\": 66.67, \"ip_address\": \"127.0.0.1\", \"percentage\": 84.62, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 390, \"marks_earned\": 330, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 2, \"total_questions\": 4, \"total_time_taken\": {\"seconds\": 93, \"short_readable\": \"0:1:33\", \"detailed_readable\": \"1 Min 33 Sec\"}, \"answered_questions\": 3, \"time_taken_for_other\": {\"seconds\": 31, \"short_readable\": \"0:0:31\", \"detailed_readable\": \"31 Sec\"}, \"unanswered_questions\": 1, \"time_taken_for_answered\": {\"seconds\": 62, \"short_readable\": \"0:1:2\", \"detailed_readable\": \"1 Min 2 Sec\"}, \"wrong_answered_questions\": 1, \"correct_answered_questions\": 2, \"time_taken_for_wrong_answered\": {\"seconds\": 48, \"short_readable\": \"0:0:48\", \"detailed_readable\": \"48 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 14, \"short_readable\": \"0:0:14\", \"detailed_readable\": \"14 Sec\"}}','completed','2024-02-13 11:16:22','2024-02-13 05:44:46','2024-02-13 05:46:22',NULL),(27,'c0591b87-275b-422d-b240-e86808de3555',1,2,NULL,'2024-02-13 11:18:01','2024-02-13 11:20:01',29,2,'{\"score\": 0, \"speed\": 372, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 390, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 2, \"total_questions\": 4, \"total_time_taken\": {\"seconds\": 29, \"short_readable\": \"0:0:29\", \"detailed_readable\": \"29 Sec\"}, \"answered_questions\": 3, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 1, \"time_taken_for_answered\": {\"seconds\": 29, \"short_readable\": \"0:0:29\", \"detailed_readable\": \"29 Sec\"}, \"wrong_answered_questions\": 3, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 29, \"short_readable\": \"0:0:29\", \"detailed_readable\": \"29 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-13 11:20:04','2024-02-13 05:48:01','2024-02-13 05:50:04',NULL),(28,'49945710-8da3-46dc-a8eb-631949a719b1',1,2,NULL,'2024-02-13 12:11:52','2024-02-13 12:13:52',25,3,'{\"score\": 60, \"speed\": 576, \"cutoff\": 90, \"accuracy\": 50, \"ip_address\": \"127.0.0.1\", \"percentage\": 15.38, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 390, \"marks_earned\": 60, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 2, \"total_questions\": 4, \"total_time_taken\": {\"seconds\": 25, \"short_readable\": \"0:0:25\", \"detailed_readable\": \"25 Sec\"}, \"answered_questions\": 4, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 0, \"time_taken_for_answered\": {\"seconds\": 25, \"short_readable\": \"0:0:25\", \"detailed_readable\": \"25 Sec\"}, \"wrong_answered_questions\": 2, \"correct_answered_questions\": 2, \"time_taken_for_wrong_answered\": {\"seconds\": 16, \"short_readable\": \"0:0:16\", \"detailed_readable\": \"16 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 9, \"short_readable\": \"0:0:9\", \"detailed_readable\": \"9 Sec\"}}','completed','2024-02-13 12:12:20','2024-02-13 06:41:52','2024-02-13 06:42:20',NULL),(29,'203dbc3d-28d9-44ba-8ca8-12cfda7d0cc4',1,2,NULL,'2024-02-13 12:13:15','2024-02-13 12:14:45',16,2,'{\"score\": 60, \"speed\": 675, \"cutoff\": 90, \"accuracy\": 66.67, \"ip_address\": \"127.0.0.1\", \"percentage\": 66.67, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 60, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 16, \"short_readable\": \"0:0:16\", \"detailed_readable\": \"16 Sec\"}, \"answered_questions\": 3, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 0, \"time_taken_for_answered\": {\"seconds\": 16, \"short_readable\": \"0:0:16\", \"detailed_readable\": \"16 Sec\"}, \"wrong_answered_questions\": 1, \"correct_answered_questions\": 2, \"time_taken_for_wrong_answered\": {\"seconds\": 4, \"short_readable\": \"0:0:4\", \"detailed_readable\": \"4 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 12, \"short_readable\": \"0:0:12\", \"detailed_readable\": \"12 Sec\"}}','completed','2024-02-13 12:13:34','2024-02-13 06:43:15','2024-02-13 06:43:34',NULL),(30,'327cf4cb-99c5-4759-b783-500938c66bd6',1,2,NULL,'2024-02-13 12:15:54','2024-02-13 12:17:24',11,2,'{\"score\": 60, \"speed\": 655, \"cutoff\": 90, \"accuracy\": 100, \"ip_address\": \"127.0.0.1\", \"percentage\": 66.67, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 60, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 11, \"short_readable\": \"0:0:11\", \"detailed_readable\": \"11 Sec\"}, \"answered_questions\": 2, \"time_taken_for_other\": {\"seconds\": 3, \"short_readable\": \"0:0:3\", \"detailed_readable\": \"3 Sec\"}, \"unanswered_questions\": 1, \"time_taken_for_answered\": {\"seconds\": 8, \"short_readable\": \"0:0:8\", \"detailed_readable\": \"8 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 2, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 8, \"short_readable\": \"0:0:8\", \"detailed_readable\": \"8 Sec\"}}','completed','2024-02-13 12:16:34','2024-02-13 06:45:54','2024-02-13 06:46:34',NULL),(31,'f62a4082-e4e7-4140-a12d-cc2fe750d339',1,2,NULL,'2024-02-13 12:27:33','2024-02-13 12:29:03',14,2,'{\"score\": 30, \"speed\": 771, \"cutoff\": 90, \"accuracy\": 33.33, \"ip_address\": \"127.0.0.1\", \"percentage\": 33.33, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 30, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 14, \"short_readable\": \"0:0:14\", \"detailed_readable\": \"14 Sec\"}, \"answered_questions\": 3, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 0, \"time_taken_for_answered\": {\"seconds\": 14, \"short_readable\": \"0:0:14\", \"detailed_readable\": \"14 Sec\"}, \"wrong_answered_questions\": 2, \"correct_answered_questions\": 1, \"time_taken_for_wrong_answered\": {\"seconds\": 11, \"short_readable\": \"0:0:11\", \"detailed_readable\": \"11 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 3, \"short_readable\": \"0:0:3\", \"detailed_readable\": \"3 Sec\"}}','completed','2024-02-13 12:27:56','2024-02-13 06:57:33','2024-02-13 06:57:56',NULL),(32,'ca799675-2e14-4bdb-a408-de3cacaad3c9',1,2,NULL,'2024-02-13 12:29:04','2024-02-13 12:30:34',6,1,'{\"score\": 30, \"speed\": 1200, \"cutoff\": 90, \"accuracy\": 50, \"ip_address\": \"127.0.0.1\", \"percentage\": 33.33, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 30, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 6, \"short_readable\": \"0:0:6\", \"detailed_readable\": \"6 Sec\"}, \"answered_questions\": 2, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 1, \"time_taken_for_answered\": {\"seconds\": 6, \"short_readable\": \"0:0:6\", \"detailed_readable\": \"6 Sec\"}, \"wrong_answered_questions\": 1, \"correct_answered_questions\": 1, \"time_taken_for_wrong_answered\": {\"seconds\": 3, \"short_readable\": \"0:0:3\", \"detailed_readable\": \"3 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 3, \"short_readable\": \"0:0:3\", \"detailed_readable\": \"3 Sec\"}}','completed','2024-02-13 12:29:42','2024-02-13 06:59:04','2024-02-13 06:59:42',NULL),(33,'600dccd4-035e-4572-b669-913518541661',1,2,NULL,'2024-02-13 12:31:59','2024-02-13 12:33:29',10,2,'{\"score\": 56, \"speed\": 1080, \"cutoff\": 90, \"accuracy\": 66.67, \"ip_address\": \"127.0.0.1\", \"percentage\": 62.22, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 56, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 10, \"short_readable\": \"0:0:10\", \"detailed_readable\": \"10 Sec\"}, \"answered_questions\": 3, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 0, \"time_taken_for_answered\": {\"seconds\": 10, \"short_readable\": \"0:0:10\", \"detailed_readable\": \"10 Sec\"}, \"wrong_answered_questions\": 1, \"correct_answered_questions\": 2, \"time_taken_for_wrong_answered\": {\"seconds\": 5, \"short_readable\": \"0:0:5\", \"detailed_readable\": \"5 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 5, \"short_readable\": \"0:0:5\", \"detailed_readable\": \"5 Sec\"}}','completed','2024-02-13 12:32:13','2024-02-13 07:01:59','2024-02-13 07:02:13',NULL),(34,'88175612-5bef-418f-a910-d2742bc61b8b',1,2,NULL,'2024-02-13 12:33:05','2024-02-13 12:34:35',12,2,'{\"score\": 52, \"speed\": 900, \"cutoff\": 90, \"accuracy\": 66.67, \"ip_address\": \"127.0.0.1\", \"percentage\": 57.78, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 52, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 12, \"short_readable\": \"0:0:12\", \"detailed_readable\": \"12 Sec\"}, \"answered_questions\": 3, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 0, \"time_taken_for_answered\": {\"seconds\": 12, \"short_readable\": \"0:0:12\", \"detailed_readable\": \"12 Sec\"}, \"wrong_answered_questions\": 1, \"correct_answered_questions\": 2, \"time_taken_for_wrong_answered\": {\"seconds\": 4, \"short_readable\": \"0:0:4\", \"detailed_readable\": \"4 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 8, \"short_readable\": \"0:0:8\", \"detailed_readable\": \"8 Sec\"}}','completed','2024-02-13 12:33:25','2024-02-13 07:03:05','2024-02-13 07:03:25',NULL),(35,'b8fc815f-da07-4a94-a601-4aa6f16b0325',1,2,NULL,'2024-02-13 12:35:19','2024-02-13 12:36:49',3,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 3, \"short_readable\": \"0:0:3\", \"detailed_readable\": \"3 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 3, \"short_readable\": \"0:0:3\", \"detailed_readable\": \"3 Sec\"}, \"unanswered_questions\": 3, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-13 12:35:25','2024-02-13 07:05:19','2024-02-13 07:05:25',NULL),(36,'5a1ff851-e825-43fb-815e-79dda8b41b79',1,2,NULL,'2024-02-13 16:46:18','2024-02-13 16:47:48',18,2,'{\"score\": 20, \"speed\": 200, \"cutoff\": 90, \"accuracy\": 100, \"ip_address\": \"127.0.0.1\", \"percentage\": 22.22, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 20, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 18, \"short_readable\": \"0:0:18\", \"detailed_readable\": \"18 Sec\"}, \"answered_questions\": 1, \"time_taken_for_other\": {\"seconds\": 4, \"short_readable\": \"0:0:4\", \"detailed_readable\": \"4 Sec\"}, \"unanswered_questions\": 2, \"time_taken_for_answered\": {\"seconds\": 14, \"short_readable\": \"0:0:14\", \"detailed_readable\": \"14 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 1, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 14, \"short_readable\": \"0:0:14\", \"detailed_readable\": \"14 Sec\"}}','completed','2024-02-13 16:47:39','2024-02-13 11:16:18','2024-02-13 11:17:39',NULL),(37,'e8fbbb1c-6d7d-4820-b3ab-9bb6690882a7',1,2,NULL,'2024-02-13 16:47:46','2024-02-13 16:49:16',56,2,'{\"score\": 50, \"speed\": 129, \"cutoff\": 90, \"accuracy\": 100, \"ip_address\": \"127.0.0.1\", \"percentage\": 55.56, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 50, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 56, \"short_readable\": \"0:0:56\", \"detailed_readable\": \"56 Sec\"}, \"answered_questions\": 2, \"time_taken_for_other\": {\"seconds\": 45, \"short_readable\": \"0:0:45\", \"detailed_readable\": \"45 Sec\"}, \"unanswered_questions\": 1, \"time_taken_for_answered\": {\"seconds\": 11, \"short_readable\": \"0:0:11\", \"detailed_readable\": \"11 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 2, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 11, \"short_readable\": \"0:0:11\", \"detailed_readable\": \"11 Sec\"}}','completed','2024-02-13 16:50:30','2024-02-13 11:17:46','2024-02-13 11:20:30',NULL),(38,'34ce91d9-29a7-4158-a9aa-f1589955c9e1',1,2,NULL,'2024-02-13 16:51:27','2024-02-13 16:52:57',1,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 1, \"short_readable\": \"0:0:1\", \"detailed_readable\": \"1 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 1, \"short_readable\": \"0:0:1\", \"detailed_readable\": \"1 Sec\"}, \"unanswered_questions\": 3, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-13 16:51:33','2024-02-13 11:21:27','2024-02-13 11:21:33',NULL),(39,'820eac3e-d6bd-4c33-9794-fd7ff89ac494',1,2,NULL,'2024-02-13 16:51:48','2024-02-13 16:53:18',14,2,'{\"score\": 51, \"speed\": 771, \"cutoff\": 90, \"accuracy\": 66.67, \"ip_address\": \"127.0.0.1\", \"percentage\": 56.67, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 51, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 14, \"short_readable\": \"0:0:14\", \"detailed_readable\": \"14 Sec\"}, \"answered_questions\": 3, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 0, \"time_taken_for_answered\": {\"seconds\": 14, \"short_readable\": \"0:0:14\", \"detailed_readable\": \"14 Sec\"}, \"wrong_answered_questions\": 1, \"correct_answered_questions\": 2, \"time_taken_for_wrong_answered\": {\"seconds\": 4, \"short_readable\": \"0:0:4\", \"detailed_readable\": \"4 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 10, \"short_readable\": \"0:0:10\", \"detailed_readable\": \"10 Sec\"}}','completed','2024-02-13 16:52:31','2024-02-13 11:21:48','2024-02-13 11:22:31',NULL),(40,'e65dbea8-23ac-423f-ba33-f6aa9ecb2ab6',1,2,NULL,'2024-02-13 16:52:40','2024-02-13 16:54:10',8,1,'{\"score\": 53, \"speed\": 900, \"cutoff\": 90, \"accuracy\": 100, \"ip_address\": \"127.0.0.1\", \"percentage\": 58.89, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 53, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 8, \"short_readable\": \"0:0:8\", \"detailed_readable\": \"8 Sec\"}, \"answered_questions\": 2, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 1, \"time_taken_for_answered\": {\"seconds\": 8, \"short_readable\": \"0:0:8\", \"detailed_readable\": \"8 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 2, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 8, \"short_readable\": \"0:0:8\", \"detailed_readable\": \"8 Sec\"}}','completed','2024-02-13 16:53:20','2024-02-13 11:22:40','2024-02-13 11:23:20',NULL),(41,'decdb093-1864-41e1-9225-62bc413f1a62',1,2,NULL,'2024-02-13 16:54:44','2024-02-13 16:56:14',13,1,'{\"score\": 47, \"speed\": 554, \"cutoff\": 90, \"accuracy\": 100, \"ip_address\": \"127.0.0.1\", \"percentage\": 52.22, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 47, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 13, \"short_readable\": \"0:0:13\", \"detailed_readable\": \"13 Sec\"}, \"answered_questions\": 2, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 1, \"time_taken_for_answered\": {\"seconds\": 13, \"short_readable\": \"0:0:13\", \"detailed_readable\": \"13 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 2, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 13, \"short_readable\": \"0:0:13\", \"detailed_readable\": \"13 Sec\"}}','completed','2024-02-13 16:55:29','2024-02-13 11:24:44','2024-02-13 11:25:29',NULL),(42,'a0ccf6fd-225a-4be4-ab65-dc8d121f18f2',1,2,NULL,'2024-02-13 16:56:51','2024-02-13 16:58:21',10,0,'{\"score\": 29, \"speed\": 360, \"cutoff\": 90, \"accuracy\": 100, \"ip_address\": \"127.0.0.1\", \"percentage\": 32.22, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 29, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 10, \"short_readable\": \"0:0:10\", \"detailed_readable\": \"10 Sec\"}, \"answered_questions\": 1, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 2, \"time_taken_for_answered\": {\"seconds\": 10, \"short_readable\": \"0:0:10\", \"detailed_readable\": \"10 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 1, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 10, \"short_readable\": \"0:0:10\", \"detailed_readable\": \"10 Sec\"}}','completed','2024-02-13 16:57:15','2024-02-13 11:26:51','2024-02-13 11:27:15',NULL),(43,'82dafce3-7745-4b7a-b3a5-1355ad32f4ad',1,2,NULL,'2024-02-13 16:57:29','2024-02-13 16:58:59',9,1,'{\"score\": 52, \"speed\": 800, \"cutoff\": 90, \"accuracy\": 100, \"ip_address\": \"127.0.0.1\", \"percentage\": 57.78, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 52, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 9, \"short_readable\": \"0:0:9\", \"detailed_readable\": \"9 Sec\"}, \"answered_questions\": 2, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 1, \"time_taken_for_answered\": {\"seconds\": 9, \"short_readable\": \"0:0:9\", \"detailed_readable\": \"9 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 2, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 9, \"short_readable\": \"0:0:9\", \"detailed_readable\": \"9 Sec\"}}','completed','2024-02-13 16:58:22','2024-02-13 11:27:29','2024-02-13 11:28:22',NULL),(44,'172ad65d-fe80-4c50-a8a1-11d59aaa3d21',1,2,NULL,'2024-02-13 16:58:41','2024-02-13 17:00:11',21,2,'{\"score\": 71, \"speed\": 514, \"cutoff\": 90, \"accuracy\": 100, \"ip_address\": \"127.0.0.1\", \"percentage\": 78.89, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 71, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 21, \"short_readable\": \"0:0:21\", \"detailed_readable\": \"21 Sec\"}, \"answered_questions\": 3, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 0, \"time_taken_for_answered\": {\"seconds\": 21, \"short_readable\": \"0:0:21\", \"detailed_readable\": \"21 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 3, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 21, \"short_readable\": \"0:0:21\", \"detailed_readable\": \"21 Sec\"}}','completed','2024-02-13 17:00:23','2024-02-13 11:28:41','2024-02-13 11:30:23',NULL),(45,'bc341d76-bfe8-4509-99b5-29b75eacf500',1,2,NULL,'2024-02-13 17:01:51','2024-02-13 17:03:21',53,2,'{\"score\": 24, \"speed\": 68, \"cutoff\": 90, \"accuracy\": 100, \"ip_address\": \"127.0.0.1\", \"percentage\": 26.67, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 24, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 53, \"short_readable\": \"0:0:53\", \"detailed_readable\": \"53 Sec\"}, \"answered_questions\": 1, \"time_taken_for_other\": {\"seconds\": 47, \"short_readable\": \"0:0:47\", \"detailed_readable\": \"47 Sec\"}, \"unanswered_questions\": 2, \"time_taken_for_answered\": {\"seconds\": 6, \"short_readable\": \"0:0:6\", \"detailed_readable\": \"6 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 1, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 6, \"short_readable\": \"0:0:6\", \"detailed_readable\": \"6 Sec\"}}','completed','2024-02-13 17:02:47','2024-02-13 11:31:51','2024-02-13 11:32:47',NULL),(46,'d3809980-1bed-4e25-b232-a0df43b6b2bb',1,2,NULL,'2024-02-13 17:03:08','2024-02-13 17:04:38',4,0,'{\"score\": 26, \"speed\": 900, \"cutoff\": 90, \"accuracy\": 100, \"ip_address\": \"127.0.0.1\", \"percentage\": 28.89, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 26, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 4, \"short_readable\": \"0:0:4\", \"detailed_readable\": \"4 Sec\"}, \"answered_questions\": 1, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 2, \"time_taken_for_answered\": {\"seconds\": 4, \"short_readable\": \"0:0:4\", \"detailed_readable\": \"4 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 1, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 4, \"short_readable\": \"0:0:4\", \"detailed_readable\": \"4 Sec\"}}','completed','2024-02-13 17:04:49','2024-02-13 11:33:08','2024-02-13 11:34:49',NULL),(47,'7af474b7-fe3d-4918-8860-2ce902d45d6c',1,2,NULL,'2024-02-13 19:49:25','2024-02-13 19:50:55',0,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 3, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-13 19:50:17','2024-02-13 14:19:25','2024-02-13 14:20:17',NULL),(48,'d684948b-5ff3-4b02-8b2a-18d623f7a693',1,2,NULL,'2024-02-13 19:50:55','2024-02-13 19:52:25',0,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 3, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-13 19:50:55','2024-02-13 14:20:55','2024-02-13 14:20:55',NULL),(49,'7d963f53-1c2b-4800-a734-6b78a4eda821',1,2,NULL,'2024-02-13 19:51:08','2024-02-13 19:52:38',0,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 3, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-13 19:51:09','2024-02-13 14:21:08','2024-02-13 14:21:09',NULL),(50,'d8bbfc28-07f2-4d48-b0a8-a64843fbd103',1,2,NULL,'2024-02-13 19:51:46','2024-02-13 19:53:16',0,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 3, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-13 19:51:46','2024-02-13 14:21:46','2024-02-13 14:21:46',NULL),(51,'4f59c14b-b2c6-4000-a111-47cc3c09619f',1,2,NULL,'2024-02-13 19:52:11','2024-02-13 19:53:41',0,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 3, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-13 19:52:11','2024-02-13 14:22:11','2024-02-13 14:22:11',NULL),(52,'39cfc539-671a-48f6-9c81-d90a4ed240d3',1,2,NULL,'2024-02-13 19:53:57','2024-02-13 19:55:27',0,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 3, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-13 19:53:57','2024-02-13 14:23:57','2024-02-13 14:23:57',NULL),(53,'4bf98591-29c2-434d-9b42-6eb9881de4e0',1,2,NULL,'2024-02-13 19:54:22','2024-02-13 19:55:52',0,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 3, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-13 19:54:22','2024-02-13 14:24:22','2024-02-13 14:24:22',NULL),(54,'fae7b3e7-f852-43b4-98a5-8d571e2eb1e2',1,2,NULL,'2024-02-13 19:57:21','2024-02-13 19:58:51',0,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 3, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-13 19:57:21','2024-02-13 14:27:21','2024-02-13 14:27:21',NULL),(55,'339976b9-e604-4e85-b714-84fd6d14a75f',1,2,NULL,'2024-02-13 19:58:58','2024-02-13 20:00:28',0,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 3, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-13 19:58:58','2024-02-13 14:28:58','2024-02-13 14:28:58',NULL),(56,'138f27ce-e410-4cfc-b7fd-a8bd96ea3d6f',1,2,NULL,'2024-02-13 20:00:54','2024-02-13 20:02:24',0,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 3, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-13 20:00:55','2024-02-13 14:30:54','2024-02-13 14:30:55',NULL),(57,'d8c16ae9-03fd-44c0-a0c6-6e7da8989101',1,2,NULL,'2024-02-13 20:02:55','2024-02-13 20:04:25',0,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 3, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-13 20:04:41','2024-02-13 14:32:55','2024-02-13 14:34:41',NULL),(58,'e10e4b06-ce2f-42fe-ad57-98d58f5d13dd',1,2,NULL,'2024-02-13 20:04:51','2024-02-13 20:06:21',0,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 3, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-13 20:06:54','2024-02-13 14:34:51','2024-02-13 14:36:54',NULL),(59,'982daf3a-9d70-4dcc-9ff0-8e7d9b4d8e50',1,2,NULL,'2024-02-13 20:07:02','2024-02-13 20:08:32',69,2,'{\"score\": 0, \"speed\": 52, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 69, \"short_readable\": \"0:1:9\", \"detailed_readable\": \"1 Min 9 Sec\"}, \"answered_questions\": 1, \"time_taken_for_other\": {\"seconds\": 59, \"short_readable\": \"0:0:59\", \"detailed_readable\": \"59 Sec\"}, \"unanswered_questions\": 2, \"time_taken_for_answered\": {\"seconds\": 10, \"short_readable\": \"0:0:10\", \"detailed_readable\": \"10 Sec\"}, \"wrong_answered_questions\": 1, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 10, \"short_readable\": \"0:0:10\", \"detailed_readable\": \"10 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-13 20:08:34','2024-02-13 14:37:02','2024-02-13 14:38:34',NULL),(60,'d0f0d623-981a-4a8e-b7da-6ebab40808ae',1,2,NULL,'2024-02-13 20:09:23','2024-02-13 20:10:53',17,2,'{\"score\": 48, \"speed\": 424, \"cutoff\": 90, \"accuracy\": 100, \"ip_address\": \"127.0.0.1\", \"percentage\": 53.33, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 48, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 17, \"short_readable\": \"0:0:17\", \"detailed_readable\": \"17 Sec\"}, \"answered_questions\": 2, \"time_taken_for_other\": {\"seconds\": 5, \"short_readable\": \"0:0:5\", \"detailed_readable\": \"5 Sec\"}, \"unanswered_questions\": 1, \"time_taken_for_answered\": {\"seconds\": 12, \"short_readable\": \"0:0:12\", \"detailed_readable\": \"12 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 2, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 12, \"short_readable\": \"0:0:12\", \"detailed_readable\": \"12 Sec\"}}','completed','2024-02-13 20:10:16','2024-02-13 14:39:23','2024-02-13 14:40:16',NULL),(61,'bcd3c382-631b-44ad-8b16-0d83d3e00abd',1,2,NULL,'2024-02-13 20:10:26','2024-02-13 20:11:56',5,0,'{\"score\": 0, \"speed\": 720, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 5, \"short_readable\": \"0:0:5\", \"detailed_readable\": \"5 Sec\"}, \"answered_questions\": 1, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 2, \"time_taken_for_answered\": {\"seconds\": 5, \"short_readable\": \"0:0:5\", \"detailed_readable\": \"5 Sec\"}, \"wrong_answered_questions\": 1, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 5, \"short_readable\": \"0:0:5\", \"detailed_readable\": \"5 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-13 20:11:43','2024-02-13 14:40:26','2024-02-13 14:41:43',NULL),(62,'7f088f25-f4a0-46be-9fbb-6ef8e8f9871a',1,2,NULL,'2024-02-13 20:11:52','2024-02-13 20:13:22',13,2,'{\"score\": 53, \"speed\": 831, \"cutoff\": 90, \"accuracy\": 66.67, \"ip_address\": \"127.0.0.1\", \"percentage\": 58.89, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 53, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 13, \"short_readable\": \"0:0:13\", \"detailed_readable\": \"13 Sec\"}, \"answered_questions\": 3, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 0, \"time_taken_for_answered\": {\"seconds\": 13, \"short_readable\": \"0:0:13\", \"detailed_readable\": \"13 Sec\"}, \"wrong_answered_questions\": 1, \"correct_answered_questions\": 2, \"time_taken_for_wrong_answered\": {\"seconds\": 3, \"short_readable\": \"0:0:3\", \"detailed_readable\": \"3 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 10, \"short_readable\": \"0:0:10\", \"detailed_readable\": \"10 Sec\"}}','completed','2024-02-13 20:13:21','2024-02-13 14:41:52','2024-02-13 14:43:21',NULL),(63,'faa6d851-8443-4f2b-a42e-5f16d943ac4d',1,2,NULL,'2024-02-13 20:14:49','2024-02-13 20:16:19',10,1,'{\"score\": 0, \"speed\": 360, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 10, \"short_readable\": \"0:0:10\", \"detailed_readable\": \"10 Sec\"}, \"answered_questions\": 1, \"time_taken_for_other\": {\"seconds\": 6, \"short_readable\": \"0:0:6\", \"detailed_readable\": \"6 Sec\"}, \"unanswered_questions\": 2, \"time_taken_for_answered\": {\"seconds\": 4, \"short_readable\": \"0:0:4\", \"detailed_readable\": \"4 Sec\"}, \"wrong_answered_questions\": 1, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 4, \"short_readable\": \"0:0:4\", \"detailed_readable\": \"4 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-13 20:15:30','2024-02-13 14:44:49','2024-02-13 14:45:30',NULL),(64,'04c3c88f-7903-4255-b439-64dff2a442c2',1,2,NULL,'2024-02-13 20:15:48','2024-02-13 20:17:18',26,0,'{\"score\": 0, \"speed\": 138, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 26, \"short_readable\": \"0:0:26\", \"detailed_readable\": \"26 Sec\"}, \"answered_questions\": 1, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 2, \"time_taken_for_answered\": {\"seconds\": 26, \"short_readable\": \"0:0:26\", \"detailed_readable\": \"26 Sec\"}, \"wrong_answered_questions\": 1, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 26, \"short_readable\": \"0:0:26\", \"detailed_readable\": \"26 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-13 20:17:04','2024-02-13 14:45:48','2024-02-13 14:47:04',NULL),(65,'6056dded-ff91-4640-9061-09ab16160cf4',1,2,NULL,'2024-02-13 20:17:12','2024-02-13 20:18:42',0,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 3, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-13 20:18:43','2024-02-13 14:47:12','2024-02-13 14:48:43',NULL),(66,'68e207fc-0ae0-4e88-af90-4f3088d41257',1,2,NULL,'2024-02-13 20:19:00','2024-02-13 20:20:30',0,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (Linux; Android 11; SAMSUNG SM-G973U) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/14.2 Chrome/87.0.4280.141 Mobile Safari/537.36\", \"total_marks\": 90, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 3, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-13 20:20:22','2024-02-13 14:49:00','2024-02-13 14:50:22',NULL),(67,'3621d126-e3c0-4c07-bee4-1ffe745475f6',1,2,NULL,'2024-02-13 20:20:34','2024-02-13 20:22:04',0,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 3, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-13 20:21:50','2024-02-13 14:50:34','2024-02-13 14:51:50',NULL),(68,'2f63c0ed-68f7-4a14-9f8f-e6492755ed5a',1,2,NULL,'2024-02-13 20:22:18','2024-02-13 20:23:48',0,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 3, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-13 20:23:34','2024-02-13 14:52:18','2024-02-13 14:53:34',NULL),(69,'8aa37314-8855-46f9-ac6e-8926479e2dea',1,2,NULL,'2024-02-13 20:23:44','2024-02-13 20:25:14',0,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 3, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-13 20:25:16','2024-02-13 14:53:44','2024-02-13 14:55:16',NULL),(70,'60bf7eb5-205c-430e-bef5-2a35b485e68c',1,2,NULL,'2024-02-13 20:25:41','2024-02-13 20:27:11',0,0,'{\"score\": 0, \"speed\": 0, \"cutoff\": 90, \"accuracy\": 0, \"ip_address\": \"127.0.0.1\", \"percentage\": 0, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 0, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"answered_questions\": 0, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 3, \"time_taken_for_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 0, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}}','completed','2024-02-13 20:27:20','2024-02-13 14:55:41','2024-02-13 14:57:20',NULL),(71,'2a805f84-0b8b-4136-bcdc-817f5e1e8cda',1,2,NULL,'2024-02-13 20:27:27','2024-02-13 20:28:57',11,0,'{\"score\": 20, \"speed\": 327, \"cutoff\": 90, \"accuracy\": 100, \"ip_address\": \"127.0.0.1\", \"percentage\": 22.22, \"user_agent\": \"Mozilla/5.0 (X11; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0\", \"total_marks\": 90, \"marks_earned\": 20, \"pass_or_fail\": \"Failed\", \"marks_deducted\": 0, \"total_duration\": 1.5, \"total_questions\": 3, \"total_time_taken\": {\"seconds\": 11, \"short_readable\": \"0:0:11\", \"detailed_readable\": \"11 Sec\"}, \"answered_questions\": 1, \"time_taken_for_other\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"unanswered_questions\": 2, \"time_taken_for_answered\": {\"seconds\": 11, \"short_readable\": \"0:0:11\", \"detailed_readable\": \"11 Sec\"}, \"wrong_answered_questions\": 0, \"correct_answered_questions\": 1, \"time_taken_for_wrong_answered\": {\"seconds\": 0, \"short_readable\": \"0:0:0\", \"detailed_readable\": \"0 Sec\"}, \"time_taken_for_correct_answered\": {\"seconds\": 11, \"short_readable\": \"0:0:11\", \"detailed_readable\": \"11 Sec\"}}','completed','2024-02-13 20:29:01','2024-02-13 14:57:27','2024-02-13 14:59:01',NULL);
/*!40000 ALTER TABLE `quiz_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz_types`
--

DROP TABLE IF EXISTS `quiz_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quiz_types` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '444444',
  `image_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'http://placehold.it/100x100',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `quiz_types_code_unique` (`code`),
  UNIQUE KEY `quiz_types_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz_types`
--

LOCK TABLES `quiz_types` WRITE;
/*!40000 ALTER TABLE `quiz_types` DISABLE KEYS */;
INSERT INTO `quiz_types` VALUES (1,'Quiz','qtp_lLvoMjFoKRf','quiz',NULL,'444444','http://placehold.it/100x100',1,NULL,NULL,NULL),(2,'Contest','qtp_uqQvsmXRube','contest',NULL,'444444','http://placehold.it/100x100',1,NULL,NULL,NULL),(3,'Daily Challenge','qtp_xJnjmbmgV5E','daily-challenge',NULL,'444444','http://placehold.it/100x100',1,NULL,NULL,NULL),(4,'Daily Task','qtp_dJ7t7b2onxc','daily-task',NULL,'444444','http://placehold.it/100x100',1,NULL,NULL,NULL),(5,'Hackathon','qtp_pALr8tBpML7','hackathon',NULL,'444444','http://placehold.it/100x100',1,NULL,NULL,NULL),(6,'Assignment','qtp_ok3cIEqIHg4','assignment',NULL,'444444','http://placehold.it/100x100',1,NULL,NULL,NULL);
/*!40000 ALTER TABLE `quiz_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quizzes`
--

DROP TABLE IF EXISTS `quizzes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quizzes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `sub_category_id` bigint unsigned NOT NULL,
  `quiz_type_id` bigint unsigned NOT NULL,
  `total_questions` int unsigned NOT NULL DEFAULT '0',
  `total_duration` int unsigned DEFAULT NULL,
  `total_marks` double(5,2) DEFAULT NULL,
  `is_paid` tinyint(1) NOT NULL DEFAULT '0',
  `price` bigint unsigned DEFAULT NULL,
  `can_redeem` tinyint(1) NOT NULL DEFAULT '0',
  `points_required` int unsigned DEFAULT NULL,
  `settings` json DEFAULT NULL,
  `is_private` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `quizzes_slug_unique` (`slug`),
  UNIQUE KEY `quizzes_code_unique` (`code`),
  KEY `quizzes_sub_category_id_foreign` (`sub_category_id`),
  CONSTRAINT `quizzes_sub_category_id_foreign` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_categories` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quizzes`
--

LOCK TABLES `quizzes` WRITE;
/*!40000 ALTER TABLE `quizzes` DISABLE KEYS */;
INSERT INTO `quizzes` VALUES (1,'Formattive Assignment Test - 1','formattive-assignment-test-1','quiz_HUYlNhn92RY',NULL,1,1,3,90,90.00,0,NULL,0,NULL,'{\"cutoff\": 90, \"auto_grading\": true, \"auto_duration\": true, \"correct_marks\": null, \"hide_solutions\": false, \"list_questions\": true, \"negative_marks\": null, \"no_of_attempts\": null, \"total_duration\": null, \"restrict_attempts\": false, \"shuffle_questions\": true, \"disable_finish_button\": false, \"negative_marking_type\": \"fixed\", \"enable_negative_marking\": false, \"disable_question_navigation\": false}',0,1,'2024-02-06 04:39:01','2024-02-13 06:43:00',NULL);
/*!40000 ALTER TABLE `quizzes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_has_permissions`
--

DROP TABLE IF EXISTS `role_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `role_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_has_permissions`
--

LOCK TABLES `role_has_permissions` WRITE;
/*!40000 ALTER TABLE `role_has_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin','web','2024-02-06 03:36:53','2024-02-06 03:36:53'),(2,'instructor','web','2024-02-06 03:36:53','2024-02-06 03:36:53'),(3,'student','web','2024-02-06 03:36:53','2024-02-06 03:36:53'),(4,'parent','web','2024-02-06 03:36:53','2024-02-06 03:36:53'),(5,'guest','web','2024-02-06 03:36:53','2024-02-06 03:36:53'),(6,'employee','web','2024-02-06 03:36:53','2024-02-06 03:36:53'),(7,'institute','web','2024-02-06 03:36:53','2024-02-06 03:36:53'),(8,'candidate','web','2024-02-06 03:36:53','2024-02-06 03:36:53');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sections` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_code_unique` (`code`),
  UNIQUE KEY `sections_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
INSERT INTO `sections` VALUES (1,'Mathematics','sec_NdRxw8GoY3u','mathematics',NULL,NULL,1,'2024-02-06 05:41:01','2024-02-06 05:41:01',NULL),(2,'Physics','sec_vRXGWFHUjkh','physics',NULL,NULL,1,'2024-02-06 05:41:10','2024-02-06 05:41:10',NULL);
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `group` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `locked` tinyint(1) NOT NULL,
  `payload` json NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `settings_group_index` (`group`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES (1,'site','app_name',0,'\"QwikTest\"','2024-02-06 03:36:18','2024-02-06 03:36:18'),(2,'site','tag_line',0,'\"Everything You Need For Your Exam Preparation.\"','2024-02-06 03:36:18','2024-02-06 03:36:18'),(3,'site','seo_description',0,'\"Qwiktest Pro is an online test examination software and assessment tool that assists educational institutions,corporate companies to create and conduct web and mobile based exams.\"','2024-02-06 03:36:18','2024-02-06 03:36:18'),(4,'site','logo_path',0,'\"site/logo.png\"','2024-02-06 03:36:18','2024-02-06 03:36:18'),(5,'site','can_register',0,'true','2024-02-06 03:36:18','2024-02-06 03:36:18'),(6,'site','favicon_path',0,'\"site/favicon.png\"','2024-02-06 03:36:18','2024-02-06 03:36:18'),(11,'localization','default_locale',0,'\"en\"','2024-02-06 03:36:18','2024-02-06 03:36:18'),(12,'localization','default_timezone',0,'\"UTC\"','2024-02-06 03:36:18','2024-02-06 03:36:18'),(13,'email','host',0,'\"smtp.mailtrap.io\"','2024-02-06 03:36:18','2024-02-06 03:36:18'),(14,'email','port',0,'2525','2024-02-06 03:36:18','2024-02-06 03:36:18'),(15,'email','username',0,'\"username\"','2024-02-06 03:36:18','2024-02-06 03:36:18'),(16,'email','password',0,'\"password\"','2024-02-06 03:36:18','2024-02-06 03:36:18'),(17,'email','encryption',0,'\"tls\"','2024-02-06 03:36:18','2024-02-06 03:36:18'),(18,'email','from_address',0,'\"admin@qwiktest.com\"','2024-02-06 03:36:18','2024-02-06 03:36:18'),(19,'email','from_name',0,'\"QwikTest\"','2024-02-06 03:36:18','2024-02-06 03:36:18'),(20,'top_bar','message',0,'\"Top bar message here\"','2024-02-06 03:36:19','2024-02-06 03:36:19'),(21,'top_bar','button_text',0,'\"Details\"','2024-02-06 03:36:19','2024-02-06 03:36:19'),(22,'top_bar','button_link',0,'\"#\"','2024-02-06 03:36:19','2024-02-06 03:36:19'),(23,'stats','title',0,'\"Students love using QwikTest\"','2024-02-06 03:36:19','2024-02-06 03:36:19'),(24,'stats','subtitle',0,'\"25,000+ Happy students\"','2024-02-06 03:36:19','2024-02-06 03:36:19'),(25,'stats','stat1',0,'[\"9,55,878+\", \"Questions Practiced\"]','2024-02-06 03:36:19','2024-02-06 03:36:19'),(26,'stats','stat2',0,'[\"1,13,540+\", \"Tests Taken\"]','2024-02-06 03:36:19','2024-02-06 03:36:19'),(27,'stats','stat3',0,'[\"1,78,658+\", \"Videos Viewed\"]','2024-02-06 03:36:19','2024-02-06 03:36:19'),(28,'cta','title',0,'\"Unlock all Online Test Series\"','2024-02-06 03:36:19','2024-02-06 03:36:19'),(29,'cta','subtitle',0,'\"Starts $49/Month\"','2024-02-06 03:36:19','2024-02-06 03:36:19'),(30,'cta','button_text',0,'\"Buy Now\"','2024-02-06 03:36:19','2024-02-06 03:36:19'),(31,'cta','button_link',0,'\"#\"','2024-02-06 03:36:19','2024-02-06 03:36:19'),(32,'features','title',0,'\"Better Learning. Better Results.\"','2024-02-06 03:36:19','2024-02-06 03:36:19'),(33,'features','subtitle',0,'\"One platform for all your learning needs\"','2024-02-06 03:36:19','2024-02-06 03:36:19'),(34,'features','feature1',0,'[\"Top Quality Questions\", \"All questions and solutions, designed by top exam experts, based on latest patterns and actual exam level\", \"https://via.placeholder.com/48x48\"]','2024-02-06 03:36:19','2024-02-06 03:36:19'),(35,'features','feature2',0,'[\"Detailed Analysis\", \"Know your weaknesses, strengths and everything else that you need to know to improve your score and rank.\", \"https://via.placeholder.com/48x48\"]','2024-02-06 03:36:19','2024-02-06 03:36:19'),(36,'features','feature3',0,'[\"Live Quizzes\", \"Get your All-India Rank and feel the thrill of a real-exam. Groom your pressure handling and time management skills.\", \"https://via.placeholder.com/48x48\"]','2024-02-06 03:36:19','2024-02-06 03:36:19'),(37,'features','feature4',0,'[\"Learning Videos\", \"Become lifelong learners with best teachers, engaging video lessons and personalised learning journeys\", \"https://via.placeholder.com/48x48\"]','2024-02-06 03:36:19','2024-02-06 03:36:19'),(38,'testimonials','title',0,'\"Our students and parents love us\"','2024-02-06 03:36:20','2024-02-06 03:36:20'),(39,'testimonials','subtitle',0,'\"Hear it directly from our students\"','2024-02-06 03:36:20','2024-02-06 03:36:20'),(40,'testimonials','testimonial1',0,'[\"Sarah Meyer\", \"GMAT Aspirant\", \"Mock tests on QwikTest helped me develop my exam strategy. I was able to focus on my shortcomings and improve them!\", \"https://ui-avatars.com/api/?name=Sarah+Meyer\"]','2024-02-06 03:36:20','2024-02-06 03:36:20'),(41,'testimonials','testimonial2',0,'[\"Vijay Shah\", \"Class 12 Student\", \"QwikTest helped me get AIR 1 in KCET and AIR 105 in NEET. Thank you QwikTest!\", \"https://ui-avatars.com/api/?name=Vijay+Shah\"]','2024-02-06 03:36:20','2024-02-06 03:36:20'),(42,'hero','title',0,'\"Learn & Upgrade Your Skills on Your Schedule\"','2024-02-06 03:36:20','2024-02-06 03:36:20'),(43,'hero','subtitle',0,'\"Anywhere, anytime. Everything You Need For Your Exam Preparation\"','2024-02-06 03:36:20','2024-02-06 03:36:20'),(44,'hero','cta_text',0,'\"Get Started\"','2024-02-06 03:36:20','2024-02-06 03:36:20'),(45,'hero','image_path',0,'\"site/hero_image_bg.png\"','2024-02-06 03:36:20','2024-02-06 03:36:20'),(46,'hero','cta_link',0,'\"#\"','2024-02-06 03:36:20','2024-02-06 03:36:20'),(47,'home_page','enable_top_bar',0,'true','2024-02-06 03:36:20','2024-02-06 03:36:20'),(48,'home_page','enable_hero',0,'true','2024-02-06 03:36:20','2024-02-06 03:36:20'),(49,'home_page','enable_features',0,'true','2024-02-06 03:36:20','2024-02-06 03:36:20'),(50,'home_page','enable_categories',0,'true','2024-02-06 03:36:20','2024-02-06 03:36:20'),(51,'home_page','enable_stats',0,'true','2024-02-06 03:36:20','2024-02-06 03:36:20'),(52,'home_page','enable_testimonials',0,'true','2024-02-06 03:36:20','2024-02-06 03:36:20'),(53,'home_page','enable_cta',0,'true','2024-02-06 03:36:20','2024-02-06 03:36:20'),(54,'home_page','enable_footer',0,'true','2024-02-06 03:36:20','2024-02-06 03:36:20'),(55,'home_page','enable_search',0,'true','2024-02-06 03:36:20','2024-02-06 03:36:20'),(56,'site','white_logo_path',0,'\"site/logo_white.png\"','2024-02-06 03:36:20','2024-02-06 03:36:20'),(57,'localization','default_direction',0,'\"ltr\"','2024-02-06 03:36:20','2024-02-06 03:36:20'),(58,'category','title',0,'\"Comprehensive learning programs for all students\"','2024-02-06 03:36:20','2024-02-06 03:36:20'),(59,'category','subtitle',0,'\"Become lifelong learners with the best teachers, engaging video lessons and personalised learning journeys\"','2024-02-06 03:36:20','2024-02-06 03:36:20'),(60,'category','limit',0,'8','2024-02-06 03:36:20','2024-02-06 03:36:20'),(61,'footer','copyright_text',0,'\"All rights reserved.\"','2024-02-06 03:36:20','2024-02-06 03:36:20'),(62,'footer','enable_links',0,'true','2024-02-06 03:36:20','2024-02-06 03:36:20'),(63,'footer','footer_links',0,'[[\"About\", \"#\", true], [\"Features\", \"#\", true], [\"Pricing\", \"#\", true], [\"Help\", \"#\", true], [\"Disclaimer\", \"#\", true], [\"Privacy Policy\", \"#\", true]]','2024-02-06 03:36:20','2024-02-06 03:36:20'),(64,'footer','enable_social_links',0,'true','2024-02-06 03:36:20','2024-02-06 03:36:20'),(65,'footer','social_links',0,'{\"github\": [\"GitHub\", true, \"#\"], \"twitter\": [\"Twitter\", true, \"#\"], \"youtube\": [\"Youtube\", true, \"#\"], \"facebook\": [\"Facebook\", true, \"#\"], \"linkedin\": [\"LinkedIn\", true, \"#\"], \"instagram\": [\"Instagram\", true, \"#\"]}','2024-02-06 03:36:20','2024-02-06 03:36:20'),(66,'theme','primary_color',0,'\"32064a\"','2024-02-06 03:36:20','2024-02-06 03:36:20'),(67,'theme','secondary_color',0,'\"e56b1f\"','2024-02-06 03:36:20','2024-02-06 03:36:20'),(68,'theme','default_font',0,'\"Inter\"','2024-02-06 03:36:20','2024-02-06 03:36:20'),(69,'theme','default_font_url',0,'\"https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap\"','2024-02-06 03:36:20','2024-02-06 03:36:20'),(70,'license','purchase_code',0,'\"NO_PURCHASE_CODE\"','2024-02-06 03:36:20','2024-02-06 03:36:20'),(71,'license','activation_key',0,'\"NO_ACTIVATION_KEY\"','2024-02-06 03:36:20','2024-02-06 03:36:20'),(72,'billing','vendor_name',0,'\"QwikTest\"','2024-02-06 03:36:21','2024-02-06 03:36:21'),(73,'billing','invoice_prefix',0,'\"INVOICE\"','2024-02-06 03:36:21','2024-02-06 03:36:21'),(74,'billing','address',0,'\"-\"','2024-02-06 03:36:21','2024-02-06 03:36:21'),(75,'billing','city',0,'\"-\"','2024-02-06 03:36:21','2024-02-06 03:36:21'),(76,'billing','state',0,'\"-\"','2024-02-06 03:36:21','2024-02-06 03:36:21'),(77,'billing','zip',0,'\"-\"','2024-02-06 03:36:21','2024-02-06 03:36:21'),(78,'billing','country',0,'\"-\"','2024-02-06 03:36:21','2024-02-06 03:36:21'),(79,'billing','phone_number',0,'\"-\"','2024-02-06 03:36:21','2024-02-06 03:36:21'),(80,'billing','vat_number',0,'\"-\"','2024-02-06 03:36:21','2024-02-06 03:36:21'),(81,'billing','enable_invoicing',0,'false','2024-02-06 03:36:21','2024-02-06 03:36:21'),(82,'payments','default_payment_processor',0,'\"bank\"','2024-02-06 03:36:21','2024-02-06 03:36:21'),(83,'payments','default_currency',0,'\"USD\"','2024-02-06 03:36:21','2024-02-06 03:36:21'),(84,'payments','currency_symbol',0,'\"$\"','2024-02-06 03:36:21','2024-02-06 03:36:21'),(85,'payments','currency_symbol_position',0,'\"left\"','2024-02-06 03:36:21','2024-02-06 03:36:21'),(86,'tax','enable_tax',0,'false','2024-02-06 03:36:21','2024-02-06 03:36:21'),(87,'tax','tax_name',0,'\"VAT\"','2024-02-06 03:36:21','2024-02-06 03:36:21'),(88,'tax','tax_type',0,'\"exclusive\"','2024-02-06 03:36:21','2024-02-06 03:36:21'),(89,'tax','tax_amount_type',0,'\"percentage\"','2024-02-06 03:36:21','2024-02-06 03:36:21'),(90,'tax','tax_amount',0,'5','2024-02-06 03:36:21','2024-02-06 03:36:21'),(91,'tax','enable_additional_tax',0,'false','2024-02-06 03:36:21','2024-02-06 03:36:21'),(92,'tax','additional_tax_name',0,'\"Platform Charges\"','2024-02-06 03:36:21','2024-02-06 03:36:21'),(93,'tax','additional_tax_type',0,'\"exclusive\"','2024-02-06 03:36:21','2024-02-06 03:36:21'),(94,'tax','additional_tax_amount_type',0,'\"fixed\"','2024-02-06 03:36:21','2024-02-06 03:36:21'),(95,'tax','additional_tax_amount',0,'2','2024-02-06 03:36:21','2024-02-06 03:36:21'),(96,'payments','enable_bank',0,'false','2024-02-06 03:36:21','2024-02-06 03:36:21'),(97,'bank','bank_name',0,'\"-\"','2024-02-06 03:36:21','2024-02-06 03:36:21'),(98,'bank','account_owner',0,'\"-\"','2024-02-06 03:36:21','2024-02-06 03:36:21'),(99,'bank','account_number',0,'\"-\"','2024-02-06 03:36:21','2024-02-06 03:36:21'),(100,'bank','iban',0,'\"-\"','2024-02-06 03:36:21','2024-02-06 03:36:21'),(101,'bank','routing_number',0,'\"-\"','2024-02-06 03:36:21','2024-02-06 03:36:21'),(102,'bank','bic_swift',0,'\"-\"','2024-02-06 03:36:21','2024-02-06 03:36:21'),(103,'bank','other_details',0,'\"-\"','2024-02-06 03:36:21','2024-02-06 03:36:21'),(104,'payments','enable_razorpay',0,'false','2024-02-06 03:36:21','2024-02-06 03:36:21'),(105,'razorpay','key_id',0,'\"RZP_KEY_ID_HERE\"','2024-02-06 03:36:21','2024-02-06 03:36:21'),(106,'razorpay','key_secret',0,'\"RZP_KEY_SECRET_HERE\"','2024-02-06 03:36:21','2024-02-06 03:36:21'),(107,'razorpay','webhook_url',0,'\"webhooks/razorpay\"','2024-02-06 03:36:21','2024-02-06 03:36:21'),(108,'razorpay','webhook_secret',0,'\"RZP_WEBHOOK_SECRET_HERE\"','2024-02-06 03:36:21','2024-02-06 03:36:21');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skills`
--

DROP TABLE IF EXISTS `skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skills` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `section_id` bigint unsigned NOT NULL,
  `short_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `skills_code_unique` (`code`),
  UNIQUE KEY `skills_slug_unique` (`slug`),
  KEY `skills_section_id_foreign` (`section_id`),
  CONSTRAINT `skills_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skills`
--

LOCK TABLES `skills` WRITE;
/*!40000 ALTER TABLE `skills` DISABLE KEYS */;
INSERT INTO `skills` VALUES (1,'Vectors','skl_gNGszd6u0hf','vectors',1,NULL,1,'2024-02-06 05:41:25','2024-02-06 05:41:25',NULL),(2,'Kinematics','skl_uhbx2dQnPWZ','kinematics',2,NULL,1,'2024-02-06 05:41:36','2024-02-06 05:41:36',NULL),(3,'Electrostatics','skl_z0DqN1IHJuu','electrostatics',2,NULL,1,'2024-02-06 05:41:49','2024-02-06 05:41:49',NULL);
/*!40000 ALTER TABLE `skills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_categories`
--

DROP TABLE IF EXISTS `sub_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sub_categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` bigint unsigned NOT NULL,
  `sub_category_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `short_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(5000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sub_categories_code_unique` (`code`),
  UNIQUE KEY `sub_categories_slug_unique` (`slug`),
  KEY `sub_categories_category_id_foreign` (`category_id`),
  CONSTRAINT `sub_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_categories`
--

LOCK TABLES `sub_categories` WRITE;
/*!40000 ALTER TABLE `sub_categories` DISABLE KEYS */;
INSERT INTO `sub_categories` VALUES (1,'5th Standard','sub_qmhAU0cNU6i','5th-standard',1,'4',NULL,NULL,NULL,1,'2024-02-06 04:38:28','2024-02-06 04:38:28',NULL);
/*!40000 ALTER TABLE `sub_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_category_sections`
--

DROP TABLE IF EXISTS `sub_category_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sub_category_sections` (
  `sub_category_id` bigint unsigned NOT NULL,
  `section_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`sub_category_id`,`section_id`),
  KEY `sub_category_sections_section_id_foreign` (`section_id`),
  CONSTRAINT `sub_category_sections_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sub_category_sections_sub_category_id_foreign` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_category_sections`
--

LOCK TABLES `sub_category_sections` WRITE;
/*!40000 ALTER TABLE `sub_category_sections` DISABLE KEYS */;
INSERT INTO `sub_category_sections` VALUES (1,1),(1,2);
/*!40000 ALTER TABLE `sub_category_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_category_types`
--

DROP TABLE IF EXISTS `sub_category_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sub_category_types` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sub_category_types_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_category_types`
--

LOCK TABLES `sub_category_types` WRITE;
/*!40000 ALTER TABLE `sub_category_types` DISABLE KEYS */;
INSERT INTO `sub_category_types` VALUES (1,'Course','course',1,NULL,NULL,NULL),(2,'Certification','certification',1,NULL,NULL,NULL),(3,'Class','class',1,NULL,NULL,NULL),(4,'Exam','exam',1,NULL,NULL,NULL),(5,'Grade','grade',1,NULL,NULL,NULL),(6,'Standard','standard',1,NULL,NULL,NULL),(7,'Stream','stream',1,NULL,NULL,NULL),(8,'Level','level',1,NULL,NULL,NULL),(9,'Skill','skill',1,NULL,NULL,NULL),(10,'Branch','branch',1,NULL,NULL,NULL);
/*!40000 ALTER TABLE `sub_category_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscriptions`
--

DROP TABLE IF EXISTS `subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscriptions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `plan_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `category_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` bigint unsigned NOT NULL,
  `payment_id` bigint unsigned DEFAULT NULL,
  `starts_at` datetime DEFAULT NULL,
  `ends_at` datetime DEFAULT NULL,
  `data` json DEFAULT NULL,
  `status` enum('created','pending','active','cancelled','expired','halted','paused') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'created',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `subscriptions_code_unique` (`code`),
  KEY `subscriptions_category_type_category_id_index` (`category_type`,`category_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriptions`
--

LOCK TABLES `subscriptions` WRITE;
/*!40000 ALTER TABLE `subscriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taggables`
--

DROP TABLE IF EXISTS `taggables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taggables` (
  `tag_id` int NOT NULL,
  `taggable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `taggable_id` bigint unsigned NOT NULL,
  KEY `taggables_taggable_type_taggable_id_index` (`taggable_type`,`taggable_id`),
  KEY `tag_id` (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taggables`
--

LOCK TABLES `taggables` WRITE;
/*!40000 ALTER TABLE `taggables` DISABLE KEYS */;
/*!40000 ALTER TABLE `taggables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tags_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topics`
--

DROP TABLE IF EXISTS `topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `topics` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `skill_id` bigint unsigned NOT NULL,
  `short_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `topics_code_unique` (`code`),
  UNIQUE KEY `topics_slug_unique` (`slug`),
  KEY `topics_skill_id_foreign` (`skill_id`),
  CONSTRAINT `topics_skill_id_foreign` FOREIGN KEY (`skill_id`) REFERENCES `skills` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topics`
--

LOCK TABLES `topics` WRITE;
/*!40000 ALTER TABLE `topics` DISABLE KEYS */;
/*!40000 ALTER TABLE `topics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `payable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payable_id` bigint unsigned NOT NULL,
  `wallet_id` bigint unsigned DEFAULT NULL,
  `type` enum('deposit','withdraw') COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(64,0) NOT NULL,
  `confirmed` tinyint(1) NOT NULL,
  `meta` json DEFAULT NULL,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transactions_uuid_unique` (`uuid`),
  KEY `transactions_payable_type_payable_id_index` (`payable_type`,`payable_id`),
  KEY `payable_type_ind` (`payable_type`,`payable_id`,`type`),
  KEY `payable_confirmed_ind` (`payable_type`,`payable_id`,`confirmed`),
  KEY `payable_type_confirmed_ind` (`payable_type`,`payable_id`,`type`,`confirmed`),
  KEY `transactions_type_index` (`type`),
  KEY `transactions_wallet_id_foreign` (`wallet_id`),
  CONSTRAINT `transactions_wallet_id_foreign` FOREIGN KEY (`wallet_id`) REFERENCES `wallets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transfers`
--

DROP TABLE IF EXISTS `transfers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transfers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `from_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `from_id` bigint unsigned NOT NULL,
  `to_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `to_id` bigint unsigned NOT NULL,
  `status` enum('exchange','transfer','paid','refund','gift') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'transfer',
  `status_last` enum('exchange','transfer','paid','refund','gift') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deposit_id` bigint unsigned NOT NULL,
  `withdraw_id` bigint unsigned NOT NULL,
  `discount` decimal(64,0) NOT NULL DEFAULT '0',
  `fee` decimal(64,0) NOT NULL DEFAULT '0',
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transfers_uuid_unique` (`uuid`),
  KEY `transfers_from_type_from_id_index` (`from_type`,`from_id`),
  KEY `transfers_to_type_to_id_index` (`to_type`,`to_id`),
  KEY `transfers_deposit_id_foreign` (`deposit_id`),
  KEY `transfers_withdraw_id_foreign` (`withdraw_id`),
  CONSTRAINT `transfers_deposit_id_foreign` FOREIGN KEY (`deposit_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transfers_withdraw_id_foreign` FOREIGN KEY (`withdraw_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transfers`
--

LOCK TABLES `transfers` WRITE;
/*!40000 ALTER TABLE `transfers` DISABLE KEYS */;
/*!40000 ALTER TABLE `transfers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_group_exam_schedules`
--

DROP TABLE IF EXISTS `user_group_exam_schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_group_exam_schedules` (
  `exam_schedule_id` bigint unsigned NOT NULL,
  `user_group_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`exam_schedule_id`,`user_group_id`),
  KEY `user_group_exam_schedules_user_group_id_foreign` (`user_group_id`),
  CONSTRAINT `user_group_exam_schedules_exam_schedule_id_foreign` FOREIGN KEY (`exam_schedule_id`) REFERENCES `exam_schedules` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_group_exam_schedules_user_group_id_foreign` FOREIGN KEY (`user_group_id`) REFERENCES `user_groups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_group_exam_schedules`
--

LOCK TABLES `user_group_exam_schedules` WRITE;
/*!40000 ALTER TABLE `user_group_exam_schedules` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_group_exam_schedules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_group_quiz_schedules`
--

DROP TABLE IF EXISTS `user_group_quiz_schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_group_quiz_schedules` (
  `quiz_schedule_id` bigint unsigned NOT NULL,
  `user_group_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`quiz_schedule_id`,`user_group_id`),
  KEY `user_group_quiz_schedules_user_group_id_foreign` (`user_group_id`),
  CONSTRAINT `user_group_quiz_schedules_quiz_schedule_id_foreign` FOREIGN KEY (`quiz_schedule_id`) REFERENCES `quiz_schedules` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_group_quiz_schedules_user_group_id_foreign` FOREIGN KEY (`user_group_id`) REFERENCES `user_groups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_group_quiz_schedules`
--

LOCK TABLES `user_group_quiz_schedules` WRITE;
/*!40000 ALTER TABLE `user_group_quiz_schedules` DISABLE KEYS */;
INSERT INTO `user_group_quiz_schedules` VALUES (1,1);
/*!40000 ALTER TABLE `user_group_quiz_schedules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_group_users`
--

DROP TABLE IF EXISTS `user_group_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_group_users` (
  `user_id` bigint unsigned NOT NULL,
  `user_group_id` bigint unsigned NOT NULL,
  `joined_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`,`user_group_id`),
  KEY `user_group_users_user_group_id_foreign` (`user_group_id`),
  CONSTRAINT `user_group_users_user_group_id_foreign` FOREIGN KEY (`user_group_id`) REFERENCES `user_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_group_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_group_users`
--

LOCK TABLES `user_group_users` WRITE;
/*!40000 ALTER TABLE `user_group_users` DISABLE KEYS */;
INSERT INTO `user_group_users` VALUES (2,1,NULL),(3,1,NULL);
/*!40000 ALTER TABLE `user_group_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_groups`
--

DROP TABLE IF EXISTS `user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_groups` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `is_private` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `settings` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_groups_code_unique` (`code`),
  UNIQUE KEY `user_groups_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_groups`
--

LOCK TABLES `user_groups` WRITE;
/*!40000 ALTER TABLE `user_groups` DISABLE KEYS */;
INSERT INTO `user_groups` VALUES (1,'Class 1','ugp_bHCSaZqsveN','class-1','<p>only for students having very great values.</p>',0,1,NULL,'2024-02-10 02:15:26','2024-02-10 02:15:26',NULL);
/*!40000 ALTER TABLE `user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `preferences` json DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile_verified_at` timestamp NULL DEFAULT NULL,
  `verification_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `verification_code_expires_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `two_factor_secret` text COLLATE utf8mb4_unicode_ci,
  `two_factor_recovery_codes` text COLLATE utf8mb4_unicode_ci,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_team_id` bigint unsigned DEFAULT NULL,
  `profile_photo_path` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_user_name_unique` (`user_name`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_mobile_unique` (`mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'QwikTest','Admin','admin','admin@qwiktest.com',NULL,'2024-02-10 03:27:00',NULL,NULL,NULL,NULL,'$2y$10$U96mEX44N4rOrKcmVMxAFeOMxaxBIIW7FAPD2hmKPzkdBeLnlaWtO',NULL,NULL,NULL,NULL,NULL,1,'2024-02-06 03:36:53','2024-02-10 03:27:00',NULL),(2,'Ritik','Raj','ritik@gmail.com','ritik@gmail.com',NULL,'2024-02-10 03:27:00',NULL,NULL,NULL,NULL,'$2y$10$gdpKZekqG28LeHFUgoIvuuc113ElH3nTEaJBNxM4YGirQLYHmONJ2',NULL,NULL,NULL,NULL,'profile-photos/dafoHaW0icNv6lFYmtUoxfZr91POi3fqfi1w0yNx.jpg',1,'2024-02-10 02:16:01','2024-02-10 03:27:00',NULL),(3,'Saumya','Chaurasiya','saumya@gmail.con','saumya@gmail.com',NULL,'2024-02-10 03:27:00',NULL,NULL,NULL,NULL,'$2y$10$W0QVmg22KxoDBH4bkIpVAOwljOn9WQAOcqljnam2DsOh/SlMIf1.a',NULL,NULL,NULL,NULL,NULL,1,'2024-02-10 02:17:05','2024-02-10 03:27:00',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `videos`
--

DROP TABLE IF EXISTS `videos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `videos` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `video_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'mp4',
  `video_link` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `thumbnail` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `duration` int unsigned NOT NULL DEFAULT '1',
  `skill_id` bigint unsigned NOT NULL,
  `topic_id` bigint unsigned DEFAULT NULL,
  `difficulty_level_id` bigint unsigned NOT NULL DEFAULT '1',
  `preferences` json DEFAULT NULL,
  `avg_watch_time` int NOT NULL DEFAULT '0',
  `total_views` bigint unsigned NOT NULL DEFAULT '0',
  `is_paid` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `videos_code_unique` (`code`),
  KEY `videos_skill_id_foreign` (`skill_id`),
  KEY `videos_topic_id_foreign` (`topic_id`),
  CONSTRAINT `videos_skill_id_foreign` FOREIGN KEY (`skill_id`) REFERENCES `skills` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `videos_topic_id_foreign` FOREIGN KEY (`topic_id`) REFERENCES `topics` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `videos`
--

LOCK TABLES `videos` WRITE;
/*!40000 ALTER TABLE `videos` DISABLE KEYS */;
/*!40000 ALTER TABLE `videos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallets`
--

DROP TABLE IF EXISTS `wallets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wallets` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `holder_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `holder_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta` json DEFAULT NULL,
  `balance` decimal(64,0) NOT NULL DEFAULT '0',
  `decimal_places` smallint NOT NULL DEFAULT '2',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `wallets_holder_type_holder_id_slug_unique` (`holder_type`,`holder_id`,`slug`),
  KEY `wallets_holder_type_holder_id_index` (`holder_type`,`holder_id`),
  KEY `wallets_slug_index` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallets`
--

LOCK TABLES `wallets` WRITE;
/*!40000 ALTER TABLE `wallets` DISABLE KEYS */;
INSERT INTO `wallets` VALUES (1,'App\\Models\\User',1,'Default Wallet','default',NULL,'[]',0,2,'2024-02-06 03:53:07','2024-02-06 03:53:07'),(2,'App\\Models\\User',2,'Default Wallet','default',NULL,'[]',0,2,'2024-02-10 02:17:08','2024-02-10 02:17:08'),(3,'App\\Models\\User',3,'Default Wallet','default',NULL,'[]',0,2,'2024-02-10 02:19:16','2024-02-10 02:19:16');
/*!40000 ALTER TABLE `wallets` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-14 11:58:09
