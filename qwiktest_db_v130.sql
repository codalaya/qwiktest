-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 15, 2022 at 03:48 AM
-- Server version: 5.7.23-23
-- PHP Version: 7.3.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ivzbijmy_qwiktest`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `image_path` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comprehension_passages`
--

CREATE TABLE `comprehension_passages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `difficulty_levels`
--

CREATE TABLE `difficulty_levels` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `difficulty_levels`
--

INSERT INTO `difficulty_levels` (`id`, `name`, `code`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Very Easy', 'VERYEASY', 1, NULL, NULL, NULL),
(2, 'Easy', 'EASY', 1, NULL, NULL, NULL),
(3, 'Medium', 'MEDIUM', 1, NULL, NULL, NULL),
(4, 'High', 'HIGH', 1, NULL, NULL, NULL),
(5, 'Very High', 'VERYHIGH', 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `features`
--

CREATE TABLE `features` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '1',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `features`
--

INSERT INTO `features` (`id`, `name`, `code`, `description`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Practice Sets', 'practice_sets', NULL, 1, 1, NULL, NULL),
(2, 'Quizzes', 'quizzes', NULL, 2, 1, NULL, NULL),
(3, 'Lessons', 'lessons', NULL, 3, 1, NULL, NULL),
(4, 'Videos', 'videos', NULL, 4, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `lessons`
--

CREATE TABLE `lessons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `duration` int(11) NOT NULL DEFAULT '1',
  `skill_id` bigint(20) UNSIGNED NOT NULL,
  `topic_id` bigint(20) UNSIGNED DEFAULT NULL,
  `difficulty_level_id` bigint(20) UNSIGNED NOT NULL DEFAULT '1',
  `preferences` json DEFAULT NULL,
  `avg_read_time` int(11) NOT NULL DEFAULT '0',
  `total_reads` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `is_paid` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2014_10_12_200000_add_two_factor_columns_to_users_table', 1),
(4, '2018_11_06_222923_create_transactions_table', 1),
(5, '2018_11_07_192923_create_transfers_table', 1),
(6, '2018_11_07_202152_update_transfers_table', 1),
(7, '2018_11_15_124230_create_wallets_table', 1),
(8, '2018_11_19_164609_update_transactions_table', 1),
(9, '2018_11_20_133759_add_fee_transfers_table', 1),
(10, '2018_11_22_131953_add_status_transfers_table', 1),
(11, '2018_11_22_133438_drop_refund_transfers_table', 1),
(12, '2019_05_13_111553_update_status_transfers_table', 1),
(13, '2019_06_25_103755_add_exchange_status_transfers_table', 1),
(14, '2019_07_29_184926_decimal_places_wallets_table', 1),
(15, '2019_08_19_000000_create_failed_jobs_table', 1),
(16, '2019_10_02_193759_add_discount_transfers_table', 1),
(17, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(18, '2020_10_30_193412_add_meta_wallets_table', 1),
(19, '2021_01_19_122742_create_sessions_table', 1),
(20, '2021_01_26_103623_create_permission_tables', 1),
(21, '2021_01_26_145101_create_user_groups_table', 1),
(22, '2021_02_01_111346_create_categories_table', 1),
(23, '2021_02_01_123941_create_sub_categories_table', 1),
(24, '2021_03_11_165355_create_sections_table', 1),
(25, '2021_03_11_165427_create_skills_table', 1),
(26, '2021_03_11_165437_create_topics_table', 1),
(27, '2021_03_11_170421_create_difficulty_levels_table', 1),
(28, '2021_03_11_170645_create_question_types_table', 1),
(29, '2021_03_11_171040_create_comprehension_passages_table', 1),
(30, '2021_03_11_171818_create_questions_table', 1),
(31, '2021_05_06_170328_create_sub_category_types_table', 1),
(32, '2021_05_13_105405_create_quiz_types_table', 1),
(33, '2021_05_13_133602_create_quizzes_table', 1),
(34, '2021_05_13_162316_create_quiz_questions_table', 1),
(35, '2021_05_13_174530_create_practice_sets_table', 1),
(36, '2021_05_13_174705_create_practice_set_questions_table', 1),
(37, '2021_05_17_165018_create_settings_table', 1),
(38, '2021_05_18_094439_create_general_settings', 1),
(39, '2021_05_20_120637_create_sub_category_sections_table', 1),
(40, '2021_05_24_115523_create_practice_sessions_table', 1),
(41, '2021_05_25_153658_create_practice_session_questions', 1),
(42, '2021_06_06_121703_create_quiz_sessions_table', 1),
(43, '2021_06_06_122342_create_quiz_session_questions_table', 1),
(44, '2021_06_16_130734_create_quiz_schedules_table', 1),
(45, '2021_06_18_120842_create_user_group_users_table', 1),
(46, '2021_06_18_121246_create_user_group_quiz_schedules_table', 1),
(47, '2021_09_18_121222_create_tags_table', 1),
(48, '2021_09_20_065115_create_taggables_table', 1),
(49, '2021_10_18_064312_create_top_bar_settings', 1),
(50, '2021_10_18_072244_create_stat_settings', 1),
(51, '2021_10_18_092059_create_cta_settings', 1),
(52, '2021_10_18_100722_create_feature_settings', 1),
(53, '2021_10_18_100740_create_testimonial_settings', 1),
(54, '2021_11_11_051939_modify_home_page_hero_settings', 1),
(55, '2021_11_11_082743_create_category_settings', 1),
(56, '2021_11_11_095920_footer_settings', 1),
(57, '2021_11_15_165120_create_theme_settings', 1),
(58, '2021_11_22_074935_create_videos_table', 1),
(59, '2021_11_22_075107_create_lessons_table', 1),
(60, '2021_11_25_083402_create_practice_lessons_table', 1),
(61, '2021_11_30_093225_create_license_settings', 1),
(62, '2021_12_11_085821_create_practice_videos_table', 1),
(63, '2021_12_14_124247_add_columns_to_quiz_types_table', 1),
(64, '2021_12_15_124247_add_preferences_column_to_users_table', 1),
(65, '2021_12_16_102442_add_sno_column_to_quiz_session_questions_table', 1),
(66, '2021_12_17_102442_add_paid_column_to_practice_sets_table', 1),
(67, '2022_01_26_085924_create_plans_table', 1),
(68, '2022_01_26_173546_create_features_table', 1),
(69, '2022_01_26_173624_create_plan_features_table', 1),
(70, '2022_01_28_064934_create_payments_table', 1),
(71, '2022_01_28_073453_create_subscriptions_table', 1),
(72, '2022_01_28_164017_create_billing_settings', 1),
(73, '2022_01_28_164025_create_payment_settings', 1),
(74, '2022_01_29_145619_create_tax_settings', 1),
(75, '2022_02_01_083750_create_bank_settings', 1),
(76, '2022_02_01_093000_create_razorpay_settings', 1);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `payment_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `plan_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
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
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `plans`
--

CREATE TABLE `plans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `duration` int(11) NOT NULL,
  `price` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `currency` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `has_discount` tinyint(1) NOT NULL DEFAULT '0',
  `discount_percentage` int(11) NOT NULL DEFAULT '0',
  `has_trial` tinyint(1) NOT NULL DEFAULT '0',
  `trial_days` int(11) NOT NULL DEFAULT '0',
  `icon` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `feature_restrictions` tinyint(1) NOT NULL DEFAULT '0',
  `settings` json DEFAULT NULL,
  `sort_order` bigint(20) UNSIGNED NOT NULL DEFAULT '1',
  `is_popular` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `plan_features`
--

CREATE TABLE `plan_features` (
  `plan_id` bigint(20) UNSIGNED NOT NULL,
  `feature_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `practice_lessons`
--

CREATE TABLE `practice_lessons` (
  `lesson_id` bigint(20) UNSIGNED NOT NULL,
  `skill_id` bigint(20) UNSIGNED NOT NULL,
  `sub_category_id` bigint(20) UNSIGNED NOT NULL,
  `sort_order` int(11) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `practice_sessions`
--

CREATE TABLE `practice_sessions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `practice_set_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `total_time_taken` int(11) NOT NULL DEFAULT '0',
  `percentage_completed` decimal(5,2) NOT NULL DEFAULT '0.00',
  `total_points_earned` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'started',
  `completed_at` datetime DEFAULT NULL,
  `results` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `practice_session_questions`
--

CREATE TABLE `practice_session_questions` (
  `practice_session_id` bigint(20) UNSIGNED NOT NULL,
  `question_id` bigint(20) UNSIGNED NOT NULL,
  `original_question` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` text COLLATE utf8mb4_unicode_ci,
  `user_answer` text COLLATE utf8mb4_unicode_ci,
  `correct_answer` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unanswered',
  `is_correct` tinyint(1) DEFAULT NULL,
  `time_taken` int(11) NOT NULL DEFAULT '0',
  `points_earned` int(10) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `practice_sets`
--

CREATE TABLE `practice_sets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_category_id` bigint(20) UNSIGNED NOT NULL,
  `skill_id` bigint(20) UNSIGNED NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `total_questions` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `auto_grading` tinyint(1) NOT NULL DEFAULT '1',
  `correct_marks` int(10) UNSIGNED DEFAULT NULL,
  `allow_rewards` tinyint(1) NOT NULL DEFAULT '1',
  `settings` json DEFAULT NULL,
  `is_paid` tinyint(1) NOT NULL DEFAULT '0',
  `price` bigint(20) UNSIGNED DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `practice_set_questions`
--

CREATE TABLE `practice_set_questions` (
  `practice_set_id` bigint(20) UNSIGNED NOT NULL,
  `question_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `practice_videos`
--

CREATE TABLE `practice_videos` (
  `video_id` bigint(20) UNSIGNED NOT NULL,
  `skill_id` bigint(20) UNSIGNED NOT NULL,
  `sub_category_id` bigint(20) UNSIGNED NOT NULL,
  `sort_order` int(11) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `question_type_id` bigint(20) UNSIGNED NOT NULL,
  `question` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` json NOT NULL,
  `correct_answer` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `default_marks` int(11) NOT NULL DEFAULT '1',
  `default_time` int(11) NOT NULL DEFAULT '60',
  `skill_id` bigint(20) UNSIGNED NOT NULL,
  `topic_id` bigint(20) UNSIGNED DEFAULT NULL,
  `difficulty_level_id` bigint(20) UNSIGNED NOT NULL DEFAULT '1',
  `preferences` json DEFAULT NULL,
  `has_attachment` tinyint(1) NOT NULL DEFAULT '0',
  `attachment_type` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comprehension_passage_id` bigint(20) UNSIGNED DEFAULT NULL,
  `attachment_options` json DEFAULT NULL,
  `solution` text COLLATE utf8mb4_unicode_ci,
  `solution_video` json DEFAULT NULL,
  `hint` text COLLATE utf8mb4_unicode_ci,
  `avg_time_taken` int(11) NOT NULL DEFAULT '0',
  `total_attempts` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `question_types`
--

CREATE TABLE `question_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `short_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `question_types`
--

INSERT INTO `question_types` (`id`, `name`, `code`, `type`, `icon_path`, `short_description`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Multiple Choice Single Answer', 'MSA', 'objective', 'msa.png', 'This question type is easy to set up and is the most frequent MCQ question in online exams. Users are allowed to pick just one answer from a list of given options.', 1, NULL, NULL, NULL),
(2, 'Multiple Choice Multiple Answers', 'MMA', 'objective', 'mma.png', 'Multiple Choice Multiple Answers type question allows users to select one or several answers from a list of given options.', 1, NULL, NULL, NULL),
(3, 'True or False', 'TOF', 'objective', 'tof.png', 'A true or false question consists of a statement that requires a true or false response. We can also format the options such as: Yes/No, Correct/Incorrect, and Agree/Disagree.', 1, NULL, NULL, NULL),
(4, 'Short Answer', 'SAQ', 'objective', 'saq.png', 'Short answer questions allow users to provide text or numeric answers. These responses will be validated against the provided possible answers.', 1, NULL, NULL, NULL),
(5, 'Match the Following', 'MTF', 'objective', 'mtf.png', 'A matching question is two adjacent lists of related words, phrases, pictures, or symbols. Each item in one list is paired with at least one item in the other list.', 1, NULL, NULL, NULL),
(6, 'Ordering/Sequence', 'ORD', 'objective', 'ord.png', 'An ordering/sequence question consists of a scrambled list of related words, phrases, pictures, or symbols. The User needs to arrange them in a logical order/sequence.', 1, NULL, NULL, NULL),
(7, 'Fill in the Blanks', 'FIB', 'objective', 'fib.png', 'A Fill in the Blank question consists of a phrase, sentence, or paragraph with a blank space where a student provides the missing word or words.', 1, NULL, NULL, NULL),
(8, 'Long Answer/Paragraph', 'LAQ', 'subjective', 'laq.png', 'In Long answer or paragraph question type is equivalent to essay writing where a student provides a text box to write his response.', 0, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `quizzes`
--

CREATE TABLE `quizzes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `sub_category_id` bigint(20) UNSIGNED NOT NULL,
  `quiz_type_id` bigint(20) UNSIGNED NOT NULL,
  `total_questions` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `total_duration` int(10) UNSIGNED DEFAULT NULL,
  `total_marks` double(5,2) DEFAULT NULL,
  `is_paid` tinyint(1) NOT NULL DEFAULT '0',
  `price` bigint(20) UNSIGNED DEFAULT NULL,
  `can_redeem` tinyint(1) NOT NULL DEFAULT '0',
  `points_required` int(10) UNSIGNED DEFAULT NULL,
  `settings` json DEFAULT NULL,
  `is_private` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quiz_questions`
--

CREATE TABLE `quiz_questions` (
  `quiz_id` bigint(20) UNSIGNED NOT NULL,
  `question_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quiz_schedules`
--

CREATE TABLE `quiz_schedules` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quiz_id` bigint(20) UNSIGNED NOT NULL,
  `schedule_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'fixed',
  `start_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_date` date DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `grace_period` int(11) NOT NULL DEFAULT '5',
  `send_email` tinyint(1) NOT NULL DEFAULT '0',
  `settings` json DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quiz_sessions`
--

CREATE TABLE `quiz_sessions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quiz_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `quiz_schedule_id` bigint(20) UNSIGNED DEFAULT NULL,
  `starts_at` datetime NOT NULL,
  `ends_at` datetime NOT NULL,
  `total_time_taken` int(11) NOT NULL DEFAULT '0',
  `current_question` int(11) NOT NULL DEFAULT '0',
  `results` json DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'started',
  `completed_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quiz_session_questions`
--

CREATE TABLE `quiz_session_questions` (
  `quiz_session_id` bigint(20) UNSIGNED NOT NULL,
  `sno` bigint(20) UNSIGNED NOT NULL DEFAULT '1',
  `question_id` bigint(20) UNSIGNED NOT NULL,
  `original_question` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` text COLLATE utf8mb4_unicode_ci,
  `user_answer` text COLLATE utf8mb4_unicode_ci,
  `correct_answer` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unanswered',
  `is_correct` tinyint(1) DEFAULT NULL,
  `time_taken` int(11) NOT NULL DEFAULT '0',
  `marks_earned` double(5,2) NOT NULL DEFAULT '0.00',
  `marks_deducted` double(5,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quiz_types`
--

CREATE TABLE `quiz_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '444444',
  `image_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'http://placehold.it/100x100',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quiz_types`
--

INSERT INTO `quiz_types` (`id`, `name`, `code`, `slug`, `description`, `color`, `image_path`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Quiz', 'qtp_lLvoMjFoKRf', 'quiz', NULL, '444444', 'http://placehold.it/100x100', 1, NULL, NULL, NULL),
(2, 'Contest', 'qtp_uqQvsmXRube', 'contest', NULL, '444444', 'http://placehold.it/100x100', 1, NULL, NULL, NULL),
(3, 'Daily Challenge', 'qtp_xJnjmbmgV5E', 'daily-challenge', NULL, '444444', 'http://placehold.it/100x100', 1, NULL, NULL, NULL),
(4, 'Daily Task', 'qtp_dJ7t7b2onxc', 'daily-task', NULL, '444444', 'http://placehold.it/100x100', 1, NULL, NULL, NULL),
(5, 'Hackathon', 'qtp_pALr8tBpML7', 'hackathon', NULL, '444444', 'http://placehold.it/100x100', 1, NULL, NULL, NULL),
(6, 'Assignment', 'qtp_ok3cIEqIHg4', 'assignment', NULL, '444444', 'http://placehold.it/100x100', 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'web', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(2, 'instructor', 'web', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(3, 'student', 'web', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(4, 'parent', 'web', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(5, 'guest', 'web', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(6, 'employee', 'web', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(7, 'institute', 'web', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(8, 'candidate', 'web', '2022-02-15 02:10:51', '2022-02-15 02:10:51');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sections`
--

CREATE TABLE `sections` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('c0HPXVBysDoVBpsFDR2IAkzjYvRFiZlZqFSMrZ6K', NULL, '157.245.153.6', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN2RybWx4MWt0ZW9TWTBaTU9NUlR4dzFUR1ZRVnVWbzNxWDNETnZyUSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly9kZXYubmVhcmNoaXAuY29tIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1644904049),
('EBCoMT8PbLYvUu1OzevXaH7n5gY1EBsXIVDBqHNg', NULL, '27.6.61.64', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.82 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWTRBNE53c3E3TnVSVGNqTlNEVXVMeW1WODlGYjJZTE53aHVqWEpZRiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzE6Imh0dHA6Ly9kZXYubmVhcmNoaXAuY29tL3ByaWNpbmciO319', 1644920358);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `group` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `locked` tinyint(1) NOT NULL,
  `payload` json NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `group`, `name`, `locked`, `payload`, `created_at`, `updated_at`) VALUES
(1, 'site', 'app_name', 0, '\"QwikTest\"', '2022-02-15 02:10:47', '2022-02-15 02:10:47'),
(2, 'site', 'tag_line', 0, '\"Everything You Need For Your Exam Preparation.\"', '2022-02-15 02:10:47', '2022-02-15 02:10:47'),
(3, 'site', 'seo_description', 0, '\"Qwiktest Pro is an online test examination software and assessment tool that assists educational institutions,corporate companies to create and conduct web and mobile based exams.\"', '2022-02-15 02:10:47', '2022-02-15 02:10:47'),
(4, 'site', 'logo_path', 0, '\"site/logo.png\"', '2022-02-15 02:10:47', '2022-02-15 02:10:47'),
(5, 'site', 'can_register', 0, 'true', '2022-02-15 02:10:47', '2022-02-15 02:10:47'),
(6, 'site', 'favicon_path', 0, '\"site/favicon.png\"', '2022-02-15 02:10:47', '2022-02-15 02:10:47'),
(11, 'localization', 'default_locale', 0, '\"en\"', '2022-02-15 02:10:47', '2022-02-15 02:10:47'),
(12, 'localization', 'default_timezone', 0, '\"UTC\"', '2022-02-15 02:10:47', '2022-02-15 02:10:47'),
(13, 'email', 'host', 0, '\"smtp.mailtrap.io\"', '2022-02-15 02:10:47', '2022-02-15 02:10:47'),
(14, 'email', 'port', 0, '2525', '2022-02-15 02:10:47', '2022-02-15 02:10:47'),
(15, 'email', 'username', 0, '\"username\"', '2022-02-15 02:10:47', '2022-02-15 02:10:47'),
(16, 'email', 'password', 0, '\"password\"', '2022-02-15 02:10:47', '2022-02-15 02:10:47'),
(17, 'email', 'encryption', 0, '\"tls\"', '2022-02-15 02:10:47', '2022-02-15 02:10:47'),
(18, 'email', 'from_address', 0, '\"admin@qwiktest.com\"', '2022-02-15 02:10:47', '2022-02-15 02:10:47'),
(19, 'email', 'from_name', 0, '\"QwikTest\"', '2022-02-15 02:10:47', '2022-02-15 02:10:47'),
(20, 'top_bar', 'message', 0, '\"Top bar message here\"', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(21, 'top_bar', 'button_text', 0, '\"Details\"', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(22, 'top_bar', 'button_link', 0, '\"#\"', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(23, 'stats', 'title', 0, '\"Students love using QwikTest\"', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(24, 'stats', 'subtitle', 0, '\"25,000+ Happy students\"', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(25, 'stats', 'stat1', 0, '[\"9,55,878+\", \"Questions Practiced\"]', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(26, 'stats', 'stat2', 0, '[\"1,13,540+\", \"Tests Taken\"]', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(27, 'stats', 'stat3', 0, '[\"1,78,658+\", \"Videos Viewed\"]', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(28, 'cta', 'title', 0, '\"Unlock all Online Test Series\"', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(29, 'cta', 'subtitle', 0, '\"Starts $49/Month\"', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(30, 'cta', 'button_text', 0, '\"Buy Now\"', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(31, 'cta', 'button_link', 0, '\"#\"', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(32, 'features', 'title', 0, '\"Better Learning. Better Results.\"', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(33, 'features', 'subtitle', 0, '\"One platform for all your learning needs\"', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(34, 'features', 'feature1', 0, '[\"Top Quality Questions\", \"All questions and solutions, designed by top exam experts, based on latest patterns and actual exam level\", \"https://via.placeholder.com/48x48\"]', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(35, 'features', 'feature2', 0, '[\"Detailed Analysis\", \"Know your weaknesses, strengths and everything else that you need to know to improve your score and rank.\", \"https://via.placeholder.com/48x48\"]', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(36, 'features', 'feature3', 0, '[\"Live Quizzes\", \"Get your All-India Rank and feel the thrill of a real-exam. Groom your pressure handling and time management skills.\", \"https://via.placeholder.com/48x48\"]', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(37, 'features', 'feature4', 0, '[\"Learning Videos\", \"Become lifelong learners with best teachers, engaging video lessons and personalised learning journeys\", \"https://via.placeholder.com/48x48\"]', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(38, 'testimonials', 'title', 0, '\"Our students and parents love us\"', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(39, 'testimonials', 'subtitle', 0, '\"Hear it directly from our students\"', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(40, 'testimonials', 'testimonial1', 0, '[\"Sarah Meyer\", \"GMAT Aspirant\", \"Mock tests on QwikTest helped me develop my exam strategy. I was able to focus on my shortcomings and improve them!\", \"https://ui-avatars.com/api/?name=Sarah+Meyer\"]', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(41, 'testimonials', 'testimonial2', 0, '[\"Vijay Shah\", \"Class 12 Student\", \"QwikTest helped me get AIR 1 in KCET and AIR 105 in NEET. Thank you QwikTest!\", \"https://ui-avatars.com/api/?name=Vijay+Shah\"]', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(42, 'hero', 'title', 0, '\"Learn & Upgrade Your Skills on Your Schedule\"', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(43, 'hero', 'subtitle', 0, '\"Anywhere, anytime. Everything You Need For Your Exam Preparation\"', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(44, 'hero', 'cta_text', 0, '\"Get Started\"', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(45, 'hero', 'image_path', 0, '\"site/hero_image_bg.png\"', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(46, 'hero', 'cta_link', 0, '\"#\"', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(47, 'home_page', 'enable_top_bar', 0, 'true', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(48, 'home_page', 'enable_hero', 0, 'true', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(49, 'home_page', 'enable_features', 0, 'true', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(50, 'home_page', 'enable_categories', 0, 'true', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(51, 'home_page', 'enable_stats', 0, 'true', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(52, 'home_page', 'enable_testimonials', 0, 'true', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(53, 'home_page', 'enable_cta', 0, 'true', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(54, 'home_page', 'enable_footer', 0, 'true', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(55, 'home_page', 'enable_search', 0, 'true', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(56, 'site', 'white_logo_path', 0, '\"site/logo_white.png\"', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(57, 'localization', 'default_direction', 0, '\"ltr\"', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(58, 'category', 'title', 0, '\"Comprehensive learning programs for all students\"', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(59, 'category', 'subtitle', 0, '\"Become lifelong learners with the best teachers, engaging video lessons and personalised learning journeys\"', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(60, 'category', 'limit', 0, '8', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(61, 'footer', 'copyright_text', 0, '\"All rights reserved.\"', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(62, 'footer', 'enable_links', 0, 'true', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(63, 'footer', 'footer_links', 0, '[[\"About\", \"#\", true], [\"Features\", \"#\", true], [\"Pricing\", \"#\", true], [\"Help\", \"#\", true], [\"Disclaimer\", \"#\", true], [\"Privacy Policy\", \"#\", true]]', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(64, 'footer', 'enable_social_links', 0, 'true', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(65, 'footer', 'social_links', 0, '{\"github\": [\"GitHub\", true, \"#\"], \"twitter\": [\"Twitter\", true, \"#\"], \"youtube\": [\"Youtube\", true, \"#\"], \"facebook\": [\"Facebook\", true, \"#\"], \"linkedin\": [\"LinkedIn\", true, \"#\"], \"instagram\": [\"Instagram\", true, \"#\"]}', '2022-02-15 02:10:48', '2022-02-15 02:10:48'),
(66, 'theme', 'primary_color', 0, '\"32064a\"', '2022-02-15 02:10:48', '2022-02-15 02:14:14'),
(67, 'theme', 'secondary_color', 0, '\"e56b1f\"', '2022-02-15 02:10:48', '2022-02-15 02:14:14'),
(68, 'theme', 'default_font', 0, '\"Inter\"', '2022-02-15 02:10:48', '2022-02-15 02:14:14'),
(69, 'theme', 'default_font_url', 0, '\"https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap\"', '2022-02-15 02:10:48', '2022-02-15 02:14:14'),
(70, 'license', 'purchase_code', 0, '\"NO_PURCHASE_CODE\"', '2022-02-15 02:10:49', '2022-02-15 02:10:49'),
(71, 'license', 'activation_key', 0, '\"NO_ACTIVATION_KEY\"', '2022-02-15 02:10:49', '2022-02-15 02:10:49'),
(72, 'billing', 'vendor_name', 0, '\"QwikTest\"', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(73, 'billing', 'invoice_prefix', 0, '\"INVOICE\"', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(74, 'billing', 'address', 0, '\"-\"', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(75, 'billing', 'city', 0, '\"-\"', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(76, 'billing', 'state', 0, '\"-\"', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(77, 'billing', 'zip', 0, '\"-\"', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(78, 'billing', 'country', 0, '\"-\"', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(79, 'billing', 'phone_number', 0, '\"-\"', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(80, 'billing', 'vat_number', 0, '\"-\"', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(81, 'billing', 'enable_invoicing', 0, 'false', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(82, 'payments', 'default_payment_processor', 0, '\"bank\"', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(83, 'payments', 'default_currency', 0, '\"USD\"', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(84, 'payments', 'currency_symbol', 0, '\"$\"', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(85, 'payments', 'currency_symbol_position', 0, '\"left\"', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(86, 'tax', 'enable_tax', 0, 'false', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(87, 'tax', 'tax_name', 0, '\"VAT\"', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(88, 'tax', 'tax_type', 0, '\"exclusive\"', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(89, 'tax', 'tax_amount_type', 0, '\"percentage\"', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(90, 'tax', 'tax_amount', 0, '5', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(91, 'tax', 'enable_additional_tax', 0, 'false', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(92, 'tax', 'additional_tax_name', 0, '\"Platform Charges\"', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(93, 'tax', 'additional_tax_type', 0, '\"exclusive\"', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(94, 'tax', 'additional_tax_amount_type', 0, '\"fixed\"', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(95, 'tax', 'additional_tax_amount', 0, '2', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(96, 'payments', 'enable_bank', 0, 'false', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(97, 'bank', 'bank_name', 0, '\"-\"', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(98, 'bank', 'account_owner', 0, '\"-\"', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(99, 'bank', 'account_number', 0, '\"-\"', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(100, 'bank', 'iban', 0, '\"-\"', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(101, 'bank', 'routing_number', 0, '\"-\"', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(102, 'bank', 'bic_swift', 0, '\"-\"', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(103, 'bank', 'other_details', 0, '\"-\"', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(104, 'payments', 'enable_razorpay', 0, 'false', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(105, 'razorpay', 'key_id', 0, '\"RZP_KEY_ID_HERE\"', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(106, 'razorpay', 'key_secret', 0, '\"RZP_KEY_SECRET_HERE\"', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(107, 'razorpay', 'webhook_url', 0, '\"webhooks/razorpay\"', '2022-02-15 02:10:51', '2022-02-15 02:10:51'),
(108, 'razorpay', 'webhook_secret', 0, '\"RZP_WEBHOOK_SECRET_HERE\"', '2022-02-15 02:10:51', '2022-02-15 02:10:51');

-- --------------------------------------------------------

--
-- Table structure for table `skills`
--

CREATE TABLE `skills` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `section_id` bigint(20) UNSIGNED NOT NULL,
  `short_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `plan_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `category_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `payment_id` bigint(20) UNSIGNED DEFAULT NULL,
  `starts_at` datetime DEFAULT NULL,
  `ends_at` datetime DEFAULT NULL,
  `data` json DEFAULT NULL,
  `status` enum('created','pending','active','cancelled','expired','halted','paused') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'created',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sub_categories`
--

CREATE TABLE `sub_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `sub_category_type_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `short_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(5000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sub_category_sections`
--

CREATE TABLE `sub_category_sections` (
  `sub_category_id` bigint(20) UNSIGNED NOT NULL,
  `section_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sub_category_types`
--

CREATE TABLE `sub_category_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sub_category_types`
--

INSERT INTO `sub_category_types` (`id`, `name`, `code`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Course', 'course', 1, NULL, NULL, NULL),
(2, 'Certification', 'certification', 1, NULL, NULL, NULL),
(3, 'Class', 'class', 1, NULL, NULL, NULL),
(4, 'Exam', 'exam', 1, NULL, NULL, NULL),
(5, 'Grade', 'grade', 1, NULL, NULL, NULL),
(6, 'Standard', 'standard', 1, NULL, NULL, NULL),
(7, 'Stream', 'stream', 1, NULL, NULL, NULL),
(8, 'Level', 'level', 1, NULL, NULL, NULL),
(9, 'Skill', 'skill', 1, NULL, NULL, NULL),
(10, 'Branch', 'branch', 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `taggables`
--

CREATE TABLE `taggables` (
  `tag_id` int(11) NOT NULL,
  `taggable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `taggable_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `topics`
--

CREATE TABLE `topics` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `skill_id` bigint(20) UNSIGNED NOT NULL,
  `short_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `payable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payable_id` bigint(20) UNSIGNED NOT NULL,
  `wallet_id` bigint(20) UNSIGNED DEFAULT NULL,
  `type` enum('deposit','withdraw') COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(64,0) NOT NULL,
  `confirmed` tinyint(1) NOT NULL,
  `meta` json DEFAULT NULL,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transfers`
--

CREATE TABLE `transfers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `from_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `from_id` bigint(20) UNSIGNED NOT NULL,
  `to_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `to_id` bigint(20) UNSIGNED NOT NULL,
  `status` enum('exchange','transfer','paid','refund','gift') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'transfer',
  `status_last` enum('exchange','transfer','paid','refund','gift') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deposit_id` bigint(20) UNSIGNED NOT NULL,
  `withdraw_id` bigint(20) UNSIGNED NOT NULL,
  `discount` decimal(64,0) NOT NULL DEFAULT '0',
  `fee` decimal(64,0) NOT NULL DEFAULT '0',
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
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
  `current_team_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profile_photo_path` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `user_name`, `email`, `preferences`, `email_verified_at`, `mobile`, `mobile_verified_at`, `verification_code`, `verification_code_expires_at`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `remember_token`, `current_team_id`, `profile_photo_path`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'QwikTest', 'Admin', 'admin', 'admin@qwiktest.com', NULL, '2022-02-15 02:10:51', NULL, NULL, NULL, NULL, '$2y$10$LgANvS/XdDaVJivsy7QlveFMpKBSFhaY56pPaPDmjRKxfHFo/EEEy', NULL, NULL, NULL, NULL, NULL, 1, '2022-02-15 02:10:51', '2022-02-15 02:10:51', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_groups`
--

CREATE TABLE `user_groups` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `is_private` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `settings` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_group_quiz_schedules`
--

CREATE TABLE `user_group_quiz_schedules` (
  `quiz_schedule_id` bigint(20) UNSIGNED NOT NULL,
  `user_group_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_group_users`
--

CREATE TABLE `user_group_users` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `user_group_id` bigint(20) UNSIGNED NOT NULL,
  `joined_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `videos`
--

CREATE TABLE `videos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `video_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'mp4',
  `video_link` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `thumbnail` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `duration` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `skill_id` bigint(20) UNSIGNED NOT NULL,
  `topic_id` bigint(20) UNSIGNED DEFAULT NULL,
  `difficulty_level_id` bigint(20) UNSIGNED NOT NULL DEFAULT '1',
  `preferences` json DEFAULT NULL,
  `avg_watch_time` int(11) NOT NULL DEFAULT '0',
  `total_views` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `is_paid` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wallets`
--

CREATE TABLE `wallets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `holder_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `holder_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta` json DEFAULT NULL,
  `balance` decimal(64,0) NOT NULL DEFAULT '0',
  `decimal_places` smallint(6) NOT NULL DEFAULT '2',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `wallets`
--

INSERT INTO `wallets` (`id`, `holder_type`, `holder_id`, `name`, `slug`, `description`, `meta`, `balance`, `decimal_places`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'Default Wallet', 'default', NULL, '[]', 0, 2, '2022-02-15 02:11:28', '2022-02-15 02:11:28');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categories_code_unique` (`code`),
  ADD UNIQUE KEY `categories_slug_unique` (`slug`);

--
-- Indexes for table `comprehension_passages`
--
ALTER TABLE `comprehension_passages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `comprehension_passages_code_unique` (`code`);

--
-- Indexes for table `difficulty_levels`
--
ALTER TABLE `difficulty_levels`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `difficulty_levels_code_unique` (`code`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `features`
--
ALTER TABLE `features`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `features_code_unique` (`code`);

--
-- Indexes for table `lessons`
--
ALTER TABLE `lessons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `lessons_code_unique` (`code`),
  ADD KEY `lessons_skill_id_foreign` (`skill_id`),
  ADD KEY `lessons_topic_id_foreign` (`topic_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `payments_payment_id_unique` (`payment_id`),
  ADD KEY `invoice_id` (`invoice_id`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `plans`
--
ALTER TABLE `plans`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `plans_code_unique` (`code`),
  ADD KEY `plans_category_type_category_id_index` (`category_type`,`category_id`);

--
-- Indexes for table `plan_features`
--
ALTER TABLE `plan_features`
  ADD PRIMARY KEY (`plan_id`,`feature_id`),
  ADD KEY `plan_features_feature_id_foreign` (`feature_id`);

--
-- Indexes for table `practice_lessons`
--
ALTER TABLE `practice_lessons`
  ADD PRIMARY KEY (`lesson_id`,`skill_id`,`sub_category_id`),
  ADD KEY `practice_lessons_skill_id_foreign` (`skill_id`),
  ADD KEY `practice_lessons_sub_category_id_foreign` (`sub_category_id`);

--
-- Indexes for table `practice_sessions`
--
ALTER TABLE `practice_sessions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `practice_sessions_code_unique` (`code`),
  ADD KEY `practice_sessions_status_index` (`status`);

--
-- Indexes for table `practice_session_questions`
--
ALTER TABLE `practice_session_questions`
  ADD PRIMARY KEY (`practice_session_id`,`question_id`);

--
-- Indexes for table `practice_sets`
--
ALTER TABLE `practice_sets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `practice_sets_slug_unique` (`slug`),
  ADD UNIQUE KEY `practice_sets_code_unique` (`code`),
  ADD KEY `practice_sets_skill_id_foreign` (`skill_id`),
  ADD KEY `practice_sets_sub_category_id_foreign` (`sub_category_id`);

--
-- Indexes for table `practice_set_questions`
--
ALTER TABLE `practice_set_questions`
  ADD PRIMARY KEY (`practice_set_id`,`question_id`),
  ADD KEY `practice_set_questions_question_id_foreign` (`question_id`);

--
-- Indexes for table `practice_videos`
--
ALTER TABLE `practice_videos`
  ADD PRIMARY KEY (`video_id`,`skill_id`,`sub_category_id`),
  ADD KEY `practice_videos_skill_id_foreign` (`skill_id`),
  ADD KEY `practice_videos_sub_category_id_foreign` (`sub_category_id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `questions_code_unique` (`code`),
  ADD KEY `questions_skill_id_foreign` (`skill_id`),
  ADD KEY `questions_topic_id_foreign` (`topic_id`),
  ADD KEY `questions_comprehension_passage_id_foreign` (`comprehension_passage_id`);

--
-- Indexes for table `question_types`
--
ALTER TABLE `question_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `question_types_code_unique` (`code`);

--
-- Indexes for table `quizzes`
--
ALTER TABLE `quizzes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `quizzes_slug_unique` (`slug`),
  ADD UNIQUE KEY `quizzes_code_unique` (`code`),
  ADD KEY `quizzes_sub_category_id_foreign` (`sub_category_id`);

--
-- Indexes for table `quiz_questions`
--
ALTER TABLE `quiz_questions`
  ADD PRIMARY KEY (`quiz_id`,`question_id`),
  ADD KEY `quiz_questions_question_id_foreign` (`question_id`);

--
-- Indexes for table `quiz_schedules`
--
ALTER TABLE `quiz_schedules`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `quiz_schedules_code_unique` (`code`);

--
-- Indexes for table `quiz_sessions`
--
ALTER TABLE `quiz_sessions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `quiz_sessions_code_unique` (`code`),
  ADD KEY `quiz_sessions_status_index` (`status`);

--
-- Indexes for table `quiz_session_questions`
--
ALTER TABLE `quiz_session_questions`
  ADD PRIMARY KEY (`quiz_session_id`,`question_id`);

--
-- Indexes for table `quiz_types`
--
ALTER TABLE `quiz_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `quiz_types_code_unique` (`code`),
  ADD UNIQUE KEY `quiz_types_slug_unique` (`slug`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `sections`
--
ALTER TABLE `sections`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sections_code_unique` (`code`),
  ADD UNIQUE KEY `sections_slug_unique` (`slug`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `settings_group_index` (`group`);

--
-- Indexes for table `skills`
--
ALTER TABLE `skills`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `skills_code_unique` (`code`),
  ADD UNIQUE KEY `skills_slug_unique` (`slug`),
  ADD KEY `skills_section_id_foreign` (`section_id`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `subscriptions_code_unique` (`code`),
  ADD KEY `subscriptions_category_type_category_id_index` (`category_type`,`category_id`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `sub_categories`
--
ALTER TABLE `sub_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sub_categories_code_unique` (`code`),
  ADD UNIQUE KEY `sub_categories_slug_unique` (`slug`),
  ADD KEY `sub_categories_category_id_foreign` (`category_id`);

--
-- Indexes for table `sub_category_sections`
--
ALTER TABLE `sub_category_sections`
  ADD PRIMARY KEY (`sub_category_id`,`section_id`),
  ADD KEY `sub_category_sections_section_id_foreign` (`section_id`);

--
-- Indexes for table `sub_category_types`
--
ALTER TABLE `sub_category_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sub_category_types_code_unique` (`code`);

--
-- Indexes for table `taggables`
--
ALTER TABLE `taggables`
  ADD KEY `taggables_taggable_type_taggable_id_index` (`taggable_type`,`taggable_id`),
  ADD KEY `tag_id` (`tag_id`);

--
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tags_slug_unique` (`slug`);

--
-- Indexes for table `topics`
--
ALTER TABLE `topics`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `topics_code_unique` (`code`),
  ADD UNIQUE KEY `topics_slug_unique` (`slug`),
  ADD KEY `topics_skill_id_foreign` (`skill_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `transactions_uuid_unique` (`uuid`),
  ADD KEY `transactions_payable_type_payable_id_index` (`payable_type`,`payable_id`),
  ADD KEY `payable_type_ind` (`payable_type`,`payable_id`,`type`),
  ADD KEY `payable_confirmed_ind` (`payable_type`,`payable_id`,`confirmed`),
  ADD KEY `payable_type_confirmed_ind` (`payable_type`,`payable_id`,`type`,`confirmed`),
  ADD KEY `transactions_type_index` (`type`),
  ADD KEY `transactions_wallet_id_foreign` (`wallet_id`);

--
-- Indexes for table `transfers`
--
ALTER TABLE `transfers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `transfers_uuid_unique` (`uuid`),
  ADD KEY `transfers_from_type_from_id_index` (`from_type`,`from_id`),
  ADD KEY `transfers_to_type_to_id_index` (`to_type`,`to_id`),
  ADD KEY `transfers_deposit_id_foreign` (`deposit_id`),
  ADD KEY `transfers_withdraw_id_foreign` (`withdraw_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_user_name_unique` (`user_name`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_mobile_unique` (`mobile`);

--
-- Indexes for table `user_groups`
--
ALTER TABLE `user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_groups_code_unique` (`code`),
  ADD UNIQUE KEY `user_groups_slug_unique` (`slug`);

--
-- Indexes for table `user_group_quiz_schedules`
--
ALTER TABLE `user_group_quiz_schedules`
  ADD PRIMARY KEY (`quiz_schedule_id`,`user_group_id`),
  ADD KEY `user_group_quiz_schedules_user_group_id_foreign` (`user_group_id`);

--
-- Indexes for table `user_group_users`
--
ALTER TABLE `user_group_users`
  ADD PRIMARY KEY (`user_id`,`user_group_id`),
  ADD KEY `user_group_users_user_group_id_foreign` (`user_group_id`);

--
-- Indexes for table `videos`
--
ALTER TABLE `videos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `videos_code_unique` (`code`),
  ADD KEY `videos_skill_id_foreign` (`skill_id`),
  ADD KEY `videos_topic_id_foreign` (`topic_id`);

--
-- Indexes for table `wallets`
--
ALTER TABLE `wallets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `wallets_holder_type_holder_id_slug_unique` (`holder_type`,`holder_id`,`slug`),
  ADD KEY `wallets_holder_type_holder_id_index` (`holder_type`,`holder_id`),
  ADD KEY `wallets_slug_index` (`slug`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `comprehension_passages`
--
ALTER TABLE `comprehension_passages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `difficulty_levels`
--
ALTER TABLE `difficulty_levels`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `features`
--
ALTER TABLE `features`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `lessons`
--
ALTER TABLE `lessons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `plans`
--
ALTER TABLE `plans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `practice_sessions`
--
ALTER TABLE `practice_sessions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `practice_sets`
--
ALTER TABLE `practice_sets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `question_types`
--
ALTER TABLE `question_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `quizzes`
--
ALTER TABLE `quizzes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quiz_schedules`
--
ALTER TABLE `quiz_schedules`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quiz_sessions`
--
ALTER TABLE `quiz_sessions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quiz_types`
--
ALTER TABLE `quiz_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `sections`
--
ALTER TABLE `sections`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- AUTO_INCREMENT for table `skills`
--
ALTER TABLE `skills`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sub_categories`
--
ALTER TABLE `sub_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sub_category_types`
--
ALTER TABLE `sub_category_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `topics`
--
ALTER TABLE `topics`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transfers`
--
ALTER TABLE `transfers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_groups`
--
ALTER TABLE `user_groups`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `videos`
--
ALTER TABLE `videos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wallets`
--
ALTER TABLE `wallets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `lessons`
--
ALTER TABLE `lessons`
  ADD CONSTRAINT `lessons_skill_id_foreign` FOREIGN KEY (`skill_id`) REFERENCES `skills` (`id`),
  ADD CONSTRAINT `lessons_topic_id_foreign` FOREIGN KEY (`topic_id`) REFERENCES `topics` (`id`);

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `plan_features`
--
ALTER TABLE `plan_features`
  ADD CONSTRAINT `plan_features_feature_id_foreign` FOREIGN KEY (`feature_id`) REFERENCES `features` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `plan_features_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `practice_lessons`
--
ALTER TABLE `practice_lessons`
  ADD CONSTRAINT `practice_lessons_lesson_id_foreign` FOREIGN KEY (`lesson_id`) REFERENCES `lessons` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `practice_lessons_skill_id_foreign` FOREIGN KEY (`skill_id`) REFERENCES `skills` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `practice_lessons_sub_category_id_foreign` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `practice_sets`
--
ALTER TABLE `practice_sets`
  ADD CONSTRAINT `practice_sets_skill_id_foreign` FOREIGN KEY (`skill_id`) REFERENCES `skills` (`id`),
  ADD CONSTRAINT `practice_sets_sub_category_id_foreign` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_categories` (`id`);

--
-- Constraints for table `practice_set_questions`
--
ALTER TABLE `practice_set_questions`
  ADD CONSTRAINT `practice_set_questions_practice_set_id_foreign` FOREIGN KEY (`practice_set_id`) REFERENCES `practice_sets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `practice_set_questions_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `practice_videos`
--
ALTER TABLE `practice_videos`
  ADD CONSTRAINT `practice_videos_skill_id_foreign` FOREIGN KEY (`skill_id`) REFERENCES `skills` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `practice_videos_sub_category_id_foreign` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `practice_videos_video_id_foreign` FOREIGN KEY (`video_id`) REFERENCES `videos` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_comprehension_passage_id_foreign` FOREIGN KEY (`comprehension_passage_id`) REFERENCES `comprehension_passages` (`id`),
  ADD CONSTRAINT `questions_skill_id_foreign` FOREIGN KEY (`skill_id`) REFERENCES `skills` (`id`),
  ADD CONSTRAINT `questions_topic_id_foreign` FOREIGN KEY (`topic_id`) REFERENCES `topics` (`id`);

--
-- Constraints for table `quizzes`
--
ALTER TABLE `quizzes`
  ADD CONSTRAINT `quizzes_sub_category_id_foreign` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_categories` (`id`);

--
-- Constraints for table `quiz_questions`
--
ALTER TABLE `quiz_questions`
  ADD CONSTRAINT `quiz_questions_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `quiz_questions_quiz_id_foreign` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `skills`
--
ALTER TABLE `skills`
  ADD CONSTRAINT `skills_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`);

--
-- Constraints for table `sub_categories`
--
ALTER TABLE `sub_categories`
  ADD CONSTRAINT `sub_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

--
-- Constraints for table `sub_category_sections`
--
ALTER TABLE `sub_category_sections`
  ADD CONSTRAINT `sub_category_sections_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sub_category_sections_sub_category_id_foreign` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `topics`
--
ALTER TABLE `topics`
  ADD CONSTRAINT `topics_skill_id_foreign` FOREIGN KEY (`skill_id`) REFERENCES `skills` (`id`);

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_wallet_id_foreign` FOREIGN KEY (`wallet_id`) REFERENCES `wallets` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `transfers`
--
ALTER TABLE `transfers`
  ADD CONSTRAINT `transfers_deposit_id_foreign` FOREIGN KEY (`deposit_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transfers_withdraw_id_foreign` FOREIGN KEY (`withdraw_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_group_quiz_schedules`
--
ALTER TABLE `user_group_quiz_schedules`
  ADD CONSTRAINT `user_group_quiz_schedules_quiz_schedule_id_foreign` FOREIGN KEY (`quiz_schedule_id`) REFERENCES `quiz_schedules` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_group_quiz_schedules_user_group_id_foreign` FOREIGN KEY (`user_group_id`) REFERENCES `user_groups` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_group_users`
--
ALTER TABLE `user_group_users`
  ADD CONSTRAINT `user_group_users_user_group_id_foreign` FOREIGN KEY (`user_group_id`) REFERENCES `user_groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_group_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `videos`
--
ALTER TABLE `videos`
  ADD CONSTRAINT `videos_skill_id_foreign` FOREIGN KEY (`skill_id`) REFERENCES `skills` (`id`),
  ADD CONSTRAINT `videos_topic_id_foreign` FOREIGN KEY (`topic_id`) REFERENCES `topics` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
