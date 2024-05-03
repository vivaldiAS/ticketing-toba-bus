-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 26, 2023 at 03:00 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dantob_buss`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `schedules_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `age` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamatJemput` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `num_seats` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `user_id`, `schedules_id`, `name`, `age`, `alamatJemput`, `status`, `num_seats`, `created_at`, `updated_at`) VALUES
(1, 4, 1, 'Santo Lamsar Harianja', '33', 'not request', 'booked', 1, '2023-04-21 06:07:29', '2023-04-21 06:07:29'),
(2, 3, 1, 'Santo Lamsar Harianja', '90', 'not request', 'menunggu', 2, '2023-04-21 08:36:46', '2023-04-21 08:36:46'),
(3, 3, 1, 'Santo Lamsar Harianja', '39', 'not request', 'menunggu', 3, '2023-04-21 11:36:09', '2023-04-21 11:36:09'),
(4, 3, 1, 'Penumpang01', '1221', 'not request', 'menunggu', 4, '2023-04-21 11:37:34', '2023-04-21 11:37:34'),
(5, 3, 1, 'Penumpang01', '12', 'not request', 'menunggu', 5, '2023-04-21 20:48:02', '2023-04-21 20:48:02'),
(6, 3, 4, 'upi', '23', 'not request', 'menunggu', 2, '2023-04-23 06:59:19', '2023-04-23 06:59:19'),
(7, 3, 6, 'sans', '12', 'not request', 'menunggu', 10, '2023-04-23 07:11:45', '2023-04-23 07:11:45'),
(8, 3, 3, 'asianna', '23', 'Loket Medan', 'menunggu', 2, '2023-04-23 22:43:10', '2023-04-23 22:43:10'),
(9, 3, 4, 'saor', '34', 'Loket Balige', 'menunggu', 4, '2023-04-23 22:56:09', '2023-04-23 22:56:09'),
(10, 3, 7, 'jio', '45', 'Loket Terminal Tarutung', 'menunggu', 7, '2023-04-23 23:02:03', '2023-04-23 23:02:03'),
(11, 3, 8, 'putu', '23', 'Loket Porsea', 'menunggu', 10, '2023-04-24 19:48:15', '2023-04-24 19:48:15'),
(12, 4, 1, 'sasa hut', '32', 'not request', 'booked', 6, '2023-04-25 07:32:17', '2023-04-25 07:32:17'),
(13, 4, 1, 'gugu', '22', 'not request', 'booked', 7, '2023-04-25 07:34:06', '2023-04-25 07:34:06'),
(14, 4, 3, 'hasup', '67', 'Laguboti', 'booked', 1, '2023-04-25 07:50:20', '2023-04-25 07:50:20');

-- --------------------------------------------------------

--
-- Table structure for table `buses`
--

CREATE TABLE `buses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `supir_id` bigint(20) UNSIGNED NOT NULL,
  `police_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number_of_seats` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `merk` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nomor_pintu` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `buses`
--

INSERT INTO `buses` (`id`, `type`, `supir_id`, `police_number`, `number_of_seats`, `merk`, `nomor_pintu`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Economi', 5, 'BB 0938 KB', '12', 'KBT', 'KBT 001', 'Avaliable', '2023-04-17 06:54:32', '2023-04-17 06:54:32'),
(2, 'Economi', 6, 'BK 1232 KM', '12', 'KBT', 'KBT 002', 'Avaliable', '2023-04-17 06:56:26', '2023-04-17 06:56:26'),
(3, 'Executive', 7, 'BK 0978 MK', '12', 'KBT', 'EXC 001', 'Avaliable', '2023-04-17 20:50:48', '2023-04-17 20:50:48');

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
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lokets`
--

CREATE TABLE `lokets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_loket` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lokasi_loket` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `admin_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
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
(1, '2023_02_11_022824_create_roles_table', 1),
(2, '2014_10_12_000000_create_users_table', 2),
(3, '2014_10_12_100000_create_password_resets_table', 2),
(4, '2016_06_01_000001_create_oauth_auth_codes_table', 2),
(5, '2016_06_01_000002_create_oauth_access_tokens_table', 2),
(6, '2016_06_01_000003_create_oauth_refresh_tokens_table', 2),
(7, '2016_06_01_000004_create_oauth_clients_table', 2),
(8, '2016_06_01_000005_create_oauth_personal_access_clients_table', 2),
(9, '2019_08_19_000000_create_failed_jobs_table', 2),
(10, '2019_12_14_000001_create_personal_access_tokens_table', 2),
(11, '2023_02_14_134154_create_buses_table', 2),
(12, '2023_02_22_035653_create_routes_table', 2),
(13, '2023_03_09_071953_create_schedulues_table', 3),
(14, '2023_02_22_070729_create_bookings_table', 4),
(15, '2023_02_22_074123_create_trackings_table', 4),
(16, '2023_03_25_051709_add_nullable_to_column_name_in_bookings', 4),
(17, '2023_03_30_145229_create_pembayarans_table', 4),
(18, '2023_03_31_021316_add_status_to_schedules', 4),
(19, '2023_04_06_071612_create_lokets_table', 4),
(20, '2023_04_12_134347_add_harga_to_routes', 4),
(21, '2023_04_17_143143_add_type_to_routes', 5);

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('0082b2bd58c532b3d6addb79b415ecd42a75c49993470697d35e98bdc6c6e01c6a52b8b939881010', 2, 1, 'authToken', '[]', 0, '2023-04-22 11:14:38', '2023-04-22 11:14:39', '2024-04-22 18:14:38'),
('046d02666cfbc45a3d7fb95a30bccb20f1205fed10182e3d3f2256a79eb90645131def26754008f3', 7, 1, 'authToken', '[]', 0, '2023-04-24 02:54:20', '2023-04-24 02:54:20', '2024-04-24 09:54:20'),
('0b0851793a31aaefcc4bc86f9443631de5ec8e2c1260250dfeca4a88aa14747ee58be6b1f6a03028', 6, 1, 'authToken', '[]', 1, '2023-04-24 06:53:22', '2023-04-24 06:53:51', '2024-04-24 13:53:22'),
('0fbd0be993109d068f1a2e8c0f957e26dc23defe44e28f8d6d8ef4f282a737643c5641681fd6e44d', 6, 1, 'MyApp', '[]', 0, '2023-04-17 06:56:01', '2023-04-17 06:56:01', '2024-04-17 13:56:01'),
('1e1248460286eb8fbe5e9d448d695dcc8dae2e1be97844ed54be70b08742e49cde7316e0785a4ebf', 6, 1, 'authToken', '[]', 0, '2023-04-24 20:59:30', '2023-04-24 20:59:30', '2024-04-25 03:59:30'),
('1e764160e0dc647fd95008ced04f71f279fa8bd7ee9f9c5af900f297d2bef92aecbaacf0a8bb2ac1', 4, 1, 'MyApp', '[]', 0, '2023-04-17 06:51:46', '2023-04-17 06:51:46', '2024-04-17 13:51:46'),
('26362ef3bb63b0bac4d7f65f0646f3add53432a3f94be32df57e9405bf78aa779e565da4d1d6ea59', 6, 1, 'authToken', '[]', 0, '2023-04-24 07:10:48', '2023-04-24 07:10:48', '2024-04-24 14:10:48'),
('298562408096e3a3f6e118bd8bc87804e79f0fdc135742d9f7e53e5b46ab345d979905beed62a39f', 3, 1, 'authToken', '[]', 0, '2023-04-21 08:35:03', '2023-04-21 08:35:03', '2024-04-21 15:35:03'),
('3e2815aa9bb35895177c6894720c60ff45a601bd3995e2f2d1ad32d7c63e5ae7ecf23ad1388abf0b', 4, 1, 'authToken', '[]', 0, '2023-04-22 00:49:47', '2023-04-22 00:49:48', '2024-04-22 07:49:47'),
('41723ede8b04fdac96acb5e91796d57a9a5d69c84aa3812270e81fe1756c05390cf1b641044f8df5', 4, 1, 'authToken', '[]', 0, '2023-04-21 06:49:21', '2023-04-21 06:49:21', '2024-04-21 13:49:21'),
('43c06b5da2ddc9429cb9caf2682f7ac078d7f593ef0fd80e053ac57a4270438616e0c0956beb0600', 5, 1, 'authToken', '[]', 0, '2023-04-24 07:00:30', '2023-04-24 07:00:30', '2024-04-24 14:00:30'),
('44a455bb1e165d495cd528a875ac4e7a6359d418f8c3f60e83d4eee78e5da751861f58ed4a329c2e', 2, 1, 'authToken', '[]', 0, '2023-04-17 21:52:08', '2023-04-17 21:52:08', '2024-04-18 04:52:08'),
('4a7c059ca5f48946569ed32bb83fa7f5cec92af0f96c192923f79d8dde16787bfa305961a209375c', 2, 1, 'authToken', '[]', 0, '2023-04-17 09:26:39', '2023-04-17 09:26:39', '2024-04-17 16:26:39'),
('4c9599029c93fdab2b459fdb0ef41009a984dd06f279ea914a9907c7cae227898247616fe2918dda', 4, 1, 'authToken', '[]', 0, '2023-04-21 06:00:40', '2023-04-21 06:00:41', '2024-04-21 13:00:40'),
('4e41f9a12c5af0c1532669695dbc0a2c15959ab23948fb9256a9eecaf946602cd2bc9cdf9df3789d', 2, 1, 'authToken', '[]', 0, '2023-04-22 11:19:56', '2023-04-22 11:19:56', '2024-04-22 18:19:56'),
('50125131ab28d86597527020a81d47548c2ebd36b3c57dd40e9ad48b42cee878d76fc79ce2533b30', 3, 1, 'authToken', '[]', 0, '2023-04-23 22:44:52', '2023-04-23 22:44:52', '2024-04-24 05:44:52'),
('51fb7dcbcda6d5950e847a5491e9c4e63293f24ade7cddc653c51e5fb9d33086038c5e58f971ed30', 2, 1, 'authToken', '[]', 0, '2023-04-17 21:21:23', '2023-04-17 21:21:23', '2024-04-18 04:21:23'),
('53464ccc756dec2fb662b881b019198c37f0ae2e920317a81a45c701b7f7960db7cfc8f1eb828194', 3, 1, 'authToken', '[]', 1, '2023-04-22 00:32:25', '2023-04-22 06:38:19', '2024-04-22 07:32:25'),
('56b58e1a86a8f20eb7763643d1b0c9ec4024ffb03e873a6bdd73c8935e3a563b956edfcdc2765088', 3, 1, 'authToken', '[]', 0, '2023-04-23 19:15:23', '2023-04-23 19:15:24', '2024-04-24 02:15:23'),
('5886b9e1c22dbb362e8b16f8e1f9714d47d08eade6d67cfdc17bad7ba24ea2f29ec4536c600ad5c8', 4, 1, 'authToken', '[]', 0, '2023-04-25 00:47:56', '2023-04-25 00:47:56', '2024-04-25 07:47:56'),
('5fea14dc09cef8aee13ce8d6b80d59d30b7b7d33b93d78dda89f522d6641fc6eaca6f6fb0a6c7e9a', 4, 1, 'authToken', '[]', 1, '2023-04-21 07:40:04', '2023-04-21 08:34:31', '2024-04-21 14:40:04'),
('609edf5ab6c22be6914fdb7c217b382963596edc6115c548bad8bbd6f09274c7bcab744963b38c90', 2, 1, 'authToken', '[]', 0, '2023-04-17 09:29:08', '2023-04-17 09:29:08', '2024-04-17 16:29:08'),
('625b80369c7b015fb8487b4a7b98727f4d4115a00fe3805370d0170aadbb4c2104a482ab795b7897', 4, 1, 'authToken', '[]', 0, '2023-04-21 06:19:39', '2023-04-21 06:19:39', '2024-04-21 13:19:39'),
('651393a5ba2a30fc4893864043c095bcc1ebf28da530b49f3af5e123a826b8bc0425efd661d708f4', 3, 1, 'authToken', '[]', 1, '2023-04-24 00:53:13', '2023-04-24 02:53:10', '2024-04-24 07:53:13'),
('6a5e911bc9fe5d6658183d11634e30cb6ac7b7d3951126299573398ad78f13f1a73e4ece490bc0ce', 4, 1, 'authToken', '[]', 0, '2023-04-25 07:31:01', '2023-04-25 07:31:03', '2024-04-25 14:31:01'),
('6f92a03943be7b1c5c2dd68d1d8716dc1af4c5f9ac3bfde1c3423a4afebccb7f937800278a376b97', 2, 1, 'authToken', '[]', 0, '2023-04-23 23:00:28', '2023-04-23 23:00:28', '2024-04-24 06:00:28'),
('743be31ce99344b339aab5cd38f64a08b2fe4e79c2051c52d8b156924d0427dbb6408a365dc2d454', 4, 1, 'authToken', '[]', 1, '2023-04-21 07:29:46', '2023-04-21 07:39:51', '2024-04-21 14:29:46'),
('7b13c5a41543f9dee31a616636451531301e7fa39d13a561a5f67fc111e151187078a719548b1613', 7, 1, 'authToken', '[]', 1, '2023-04-24 06:54:15', '2023-04-24 06:54:28', '2024-04-24 13:54:15'),
('7ecdbdec16824892cd707c2ff3ae116b8ac1121e84455e420882cbb1fd64b38fbd32b6e6c03074dd', 3, 1, 'authToken', '[]', 0, '2023-04-24 19:47:31', '2023-04-24 19:47:31', '2024-04-25 02:47:31'),
('7fccfe42eb46db15944c1a124b676b0171919ec7e12d7fb31102b2480787e8da9200029888d9e407', 3, 1, 'authToken', '[]', 0, '2023-04-23 06:12:50', '2023-04-23 06:12:51', '2024-04-23 13:12:50'),
('803550d6060bd5153093ba5398aa362798279c356b95932fadbce84271eb9ad51fc373b73f867136', 2, 1, 'authToken', '[]', 0, '2023-04-17 06:52:24', '2023-04-17 06:52:24', '2024-04-17 13:52:24'),
('8077e88011f10e75985e01d48f2d2b7d8501d45fd28acfd20b5aa1ca30280cd12ca90375e3c67ebe', 5, 1, 'authToken', '[]', 1, '2023-04-24 02:53:23', '2023-04-24 02:54:11', '2024-04-24 09:53:23'),
('837e6d9363d4cbae120ea25fd361d78a21f2d86c5e417bcb15811d9562b779bacca9fa64126f62a7', 2, 1, 'authToken', '[]', 1, '2023-04-24 19:45:42', '2023-04-24 19:47:24', '2024-04-25 02:45:42'),
('88edee9d5a5313ec2b9510de330d99d30c3090be86930bee03a6a77d9300433b971a597d097f285d', 3, 1, 'authToken', '[]', 1, '2023-04-22 08:13:52', '2023-04-22 11:14:27', '2024-04-22 15:13:52'),
('8a7f096a12c9c4977b88cc1e21e868abb79990ce4ce5e8ad414b46b1f05a4b0068411d6d5546e8b1', 4, 1, 'authToken', '[]', 0, '2023-04-21 06:39:28', '2023-04-21 06:39:29', '2024-04-21 13:39:28'),
('8c2bf8bf1a7c7b92e6585bfab6085a37cd73d91f9d414c3aac6a587706ebf9a8ab69897df87ad84c', 2, 1, 'authToken', '[]', 0, '2023-04-24 08:30:26', '2023-04-24 08:30:26', '2024-04-24 15:30:26'),
('90926a1e28205bcfa9fd33c427c66333cd96ebc7c644499bddc4235e689e9987ab33604f88017a83', 6, 1, 'authToken', '[]', 1, '2023-04-24 07:06:36', '2023-04-24 08:13:32', '2024-04-24 14:06:36'),
('9517e829f3f8c55e933277363ee6d3bec7d51d78254038863ac7de2bf94a0528082465289120a61b', 4, 1, 'authToken', '[]', 1, '2023-04-22 00:31:53', '2023-04-22 00:32:18', '2024-04-22 07:31:53'),
('98740f27bd21447d2765cfe508d4a79d9e7c28fd434b98109e623260cfd0962f07ae2e928531bc69', 3, 1, 'authToken', '[]', 0, '2023-04-23 08:05:12', '2023-04-23 08:05:12', '2024-04-23 15:05:12'),
('9c052357730c2f20e5b59ecb135c74bbdc103ef00b9535426a00eef1482fc387106157d705372fbf', 2, 1, 'authToken', '[]', 0, '2023-04-23 07:07:51', '2023-04-23 07:07:52', '2024-04-23 14:07:51'),
('9cc2d407a26f828e6aa579c58ac1b5406d3049421018fc008f14bf33d85d9f5a85531ca500ffeab5', 2, 1, 'authToken', '[]', 1, '2023-04-17 06:47:52', '2023-04-17 06:49:45', '2024-04-17 13:47:52'),
('a94e342e11ffcd56e9a6ef4a2a51e35b49ea377d9c47539492c1d52e4b66e8b27c53554aafeae46d', 4, 1, 'authToken', '[]', 1, '2023-04-21 07:06:39', '2023-04-21 07:29:36', '2024-04-21 14:06:39'),
('ab789510756ac76ea351a55d45f033fac21f972d2174f38c11be3cd0c0ed85645e38c98f658c9fa6', 5, 1, 'authToken', '[]', 1, '2023-04-24 06:55:55', '2023-04-24 07:06:25', '2024-04-24 13:55:55'),
('bd94b84470ccb4a305e43ec21c27d87f6b012a51eb691fe9c29b7d8709a30f956adaad1443969101', 4, 1, 'authToken', '[]', 0, '2023-04-24 07:31:20', '2023-04-24 07:31:21', '2024-04-24 14:31:20'),
('bd9c8cfd545d620c4338117106113d05cfc46e4c356a61cd2f438539b6be3277e1d0f3eed474f9b9', 4, 1, 'authToken', '[]', 0, '2023-04-21 08:47:15', '2023-04-21 08:47:15', '2024-04-21 15:47:15'),
('be3189655df39fa3ab7333458f0191de55488733c371ec06bf2bc33837609f8ed2a6fb714f598833', 4, 1, 'authToken', '[]', 1, '2023-04-17 06:51:56', '2023-04-17 06:52:10', '2024-04-17 13:51:56'),
('c073a03c4fd0024e7aef049e05914b30d5870a706452cd8b86ac7500904c1437908266630cee9181', 2, 1, 'authToken', '[]', 1, '2023-04-17 20:28:12', '2023-04-17 21:21:12', '2024-04-18 03:28:12'),
('c3da3a4527bd324fccc5967cac45360186bb8ef47eb10ec3baab13fe90f118120bc9c1d6c7bcaaa1', 3, 1, 'authToken', '[]', 0, '2023-04-21 20:35:35', '2023-04-21 20:35:36', '2024-04-22 03:35:35'),
('c92848c5a0787df011e59bdc82334c3635e4c7c9da6e37f46970534d915f5a258fae68f59d905dc6', 2, 1, 'authToken', '[]', 1, '2023-04-17 06:45:11', '2023-04-17 06:47:42', '2024-04-17 13:45:11'),
('d4bdf5be5d51b3bfa4e2969133638042960132732c4661f3b2b3f0cc61b64d6cd42c7a75800963e9', 7, 1, 'MyApp', '[]', 0, '2023-04-17 20:50:00', '2023-04-17 20:50:00', '2024-04-18 03:50:00'),
('d5857def1281eec9965183d09c6702cc864b710a610ae908c59522162957264d081c37ed9c0edb87', 3, 1, 'authToken', '[]', 1, '2023-04-17 06:50:07', '2023-04-17 06:50:52', '2024-04-17 13:50:07'),
('d5bf8b7cd2d9ffa89f7d8671b292841f5dd9994ee8b3461ead03df8568eb395d1b8499230f7ed113', 5, 1, 'MyApp', '[]', 0, '2023-04-17 06:54:03', '2023-04-17 06:54:03', '2024-04-17 13:54:03'),
('eac5e3845ecc00ba9dca3c6dbbad2bab796d2a7a18756569204916e9df0a4546af23eb4474ae6a34', 6, 1, 'authToken', '[]', 0, '2023-04-24 19:27:10', '2023-04-24 19:27:10', '2024-04-25 02:27:10'),
('f1f2fae5ee9b11c3d629c9ecfdc3d1b5bb655ca9e7a72510745d470414b78dde4e946c1f2d2e152b', 2, 1, 'authToken', '[]', 0, '2023-04-17 09:10:16', '2023-04-17 09:10:17', '2024-04-17 16:10:16');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `provider`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Laravel Personal Access Client', 'TrzmHVJskA3gkhjVStD15Uusv0SOPk8kfpLpNEqb', NULL, 'http://localhost', 1, 0, 0, '2023-04-17 06:29:09', '2023-04-17 06:29:09'),
(2, NULL, 'Laravel Password Grant Client', 'w3cint76BxiovZamz5W2qss7a0HcW3PAAI6WPuPo', 'users', 'http://localhost', 0, 1, 0, '2023-04-17 06:29:09', '2023-04-17 06:29:09');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2023-04-17 06:29:09', '2023-04-17 06:29:09');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
-- Table structure for table `pembayarans`
--

CREATE TABLE `pembayarans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `schedules_id` bigint(20) UNSIGNED NOT NULL,
  `bookings_id` bigint(20) UNSIGNED NOT NULL,
  `method` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `original_request_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaksi_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `terminal_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `invoice_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` bigint(20) NOT NULL,
  `virtual_account_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `active` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pembayarans`
--

INSERT INTO `pembayarans` (`id`, `schedules_id`, `bookings_id`, `method`, `status`, `date`, `original_request_id`, `transaksi_id`, `terminal_id`, `invoice_number`, `amount`, `virtual_account_number`, `created_at`, `updated_at`, `active`) VALUES
(1, 1, 1, 'noncash', 'menunggu', '2023-04-21 13:07:29', '70923', '100001', '853', 'INV-EKBT-20230421130727', 100000, '0', '2023-04-21 06:07:29', '2023-04-21 06:07:29', 0),
(2, 1, 2, 'cash', 'berhasil', '2023-04-21 15:36:46', '9644', '100002', '585', 'INV-20230421', 10000, '0', '2023-04-21 08:36:46', '2023-04-21 08:36:46', 0),
(3, 1, 3, 'cash', 'berhasil', '2023-04-21 18:36:09', '5294', '100003', '535', 'INV-20230421', 10000, '0', '2023-04-21 11:36:09', '2023-04-21 11:36:09', 0),
(4, 1, 4, 'cash', 'berhasil', '2023-04-21 18:37:34', '4663', '100004', '558', 'INV-20230421', 10000, '0', '2023-04-21 11:37:34', '2023-04-21 11:37:34', 0),
(5, 1, 5, 'cash', 'berhasil', '2023-04-22 03:48:02', '2032', '100005', '874', 'INV-20230422', 10000, '0', '2023-04-21 20:48:02', '2023-04-21 20:48:02', 0),
(6, 4, 6, 'cash', 'berhasil', '2023-04-23 13:59:19', '2342', '100006', '300', 'INV-20230423', 10000, '0', '2023-04-23 06:59:19', '2023-04-23 06:59:19', 0),
(7, 6, 7, 'cash', 'berhasil', '2023-04-23 14:11:45', '2595', '100007', '152', 'INV-20230423', 10000, '0', '2023-04-23 07:11:45', '2023-04-23 07:11:45', 0),
(8, 3, 8, 'cash', 'berhasil', '2023-04-24 05:43:10', '294', '100008', '481', 'INV-20230424', 10000, '0', '2023-04-23 22:43:10', '2023-04-23 22:43:10', 0),
(9, 4, 9, 'cash', 'berhasil', '2023-04-24 05:56:09', '9127', '100009', '193', 'INV-20230424', 10000, '0', '2023-04-23 22:56:09', '2023-04-23 22:56:09', 0),
(10, 7, 10, 'cash', 'berhasil', '2023-04-24 06:02:03', '4410', '100010', '478', 'INV-20230424', 10000, '0', '2023-04-23 23:02:03', '2023-04-23 23:02:03', 0),
(11, 8, 11, 'cash', 'berhasil', '2023-04-25 02:48:15', '440', '100011', '688', 'INV-20230425', 10000, '0', '2023-04-24 19:48:15', '2023-04-24 19:48:15', 0),
(12, 1, 12, 'noncash', 'menunggu', '2023-04-25 14:32:17', '97868', '100012', '432', 'INV-EKBT-20230425143212', 100000, '0', '2023-04-25 07:32:17', '2023-04-25 07:32:17', 0),
(13, 1, 13, 'noncash', 'menunggu', '2023-04-25 14:34:06', '79324', '100013', '633', 'INV-EKBT-20230425143405', 100000, '0', '2023-04-25 07:34:06', '2023-04-25 07:34:06', 0),
(14, 3, 14, 'noncash', 'menunggu', '2023-04-25 14:50:20', '78952', '100014', '953', 'INV-EKBT-20230425145017', 100000, '0', '2023-04-25 07:50:20', '2023-04-25 07:50:20', 0);

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
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `role`, `created_at`, `updated_at`) VALUES
(1, 'admin_kantor', NULL, NULL),
(2, 'passenger', NULL, NULL),
(3, 'driver', NULL, NULL),
(4, 'admin_loket', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `routes`
--

CREATE TABLE `routes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `derpature` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `arrival` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `harga` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `routes`
--

INSERT INTO `routes` (`id`, `derpature`, `arrival`, `harga`, `type`, `created_at`, `updated_at`) VALUES
(1, 'Medan', 'Tarutung', '120000', 'Economi', '2023-04-17 08:52:33', '2023-04-17 08:52:33'),
(2, 'Siantar', 'Tarutung', '200000', 'Executive', '2023-04-17 20:51:14', '2023-04-17 20:51:14'),
(3, 'Medan', 'Balige', '100000', 'Economi', '2023-04-17 21:12:52', '2023-04-17 21:12:52');

-- --------------------------------------------------------

--
-- Table structure for table `schedules`
--

CREATE TABLE `schedules` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `bus_id` bigint(20) UNSIGNED NOT NULL,
  `route_id` bigint(20) UNSIGNED NOT NULL,
  `tanggal` datetime NOT NULL,
  `harga` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `schedules`
--

INSERT INTO `schedules` (`id`, `bus_id`, `route_id`, `tanggal`, `harga`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 3, '2023-04-19 00:00:00', '100000', 'complete', '2023-04-17 21:16:05', '2023-04-17 21:16:05'),
(3, 2, 3, '2023-04-24 00:00:00', '100000', 'in_progress', '2023-04-22 11:15:02', '2023-04-22 11:15:02'),
(4, 3, 2, '2023-04-24 00:00:00', '200000', 'not_started', '2023-04-22 11:15:25', '2023-04-22 11:15:25'),
(5, 2, 3, '2023-04-26 00:00:00', '100000', 'not_started', '2023-04-23 07:08:29', '2023-04-23 07:08:29'),
(6, 2, 1, '2023-04-05 03:12:00', '120000', 'complete', '2023-04-23 07:10:59', '2023-04-25 00:15:02'),
(7, 3, 2, '2023-04-24 12:00:00', '200000', 'not_started', '2023-04-23 23:01:02', '2023-04-23 23:01:02'),
(8, 2, 3, '2023-04-25 09:45:00', '100000', 'not_started', '2023-04-24 19:46:06', '2023-04-24 19:46:06');

-- --------------------------------------------------------

--
-- Table structure for table `trackings`
--

CREATE TABLE `trackings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `bus_id` bigint(20) UNSIGNED NOT NULL,
  `latitude` decimal(10,8) NOT NULL,
  `longitude` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `username`, `phone_number`, `address`, `gender`, `photo`, `password`, `role_id`, `email_verified_at`, `remember_token`, `created_at`, `updated_at`) VALUES
(2, 'admin', 'admin@gmail.com', 'admin01', '082323234354', 'Tarutung', 'Laki-laki', 'null', '$2a$12$0JNlEjMOtlPzgy09/zQJeuMk4AYZFZ2A/YLOSEp/G5ldMduoUOEO.', 1, NULL, NULL, NULL, NULL),
(3, 'admin loket', 'adminloket@gmail.com', 'admin loket 1', '082626348489', 'Medan', 'Perempuan', 'null', '$2a$12$0JNlEjMOtlPzgy09/zQJeuMk4AYZFZ2A/YLOSEp/G5ldMduoUOEO.', 4, NULL, NULL, NULL, NULL),
(4, 'Penumpang01', 'penumpang@gmail.com', 'penumpang pertama', '0836646464', 'Tarutung', 'Laki-laki', 'null', '$2y$10$5JIs1GEQiiKogiV0kTNHdevcig9o1yu/8MOqotLldXMiQRXkE1Sxe', 2, NULL, NULL, '2023-04-17 06:51:46', '2023-04-17 06:51:46'),
(5, 'supir exe 01', 'supir01@gmail.com', 'supir pertama', '0823243280', 'Tarutung', 'Laki-laki', 'null', '$2y$10$3a.gPx5p1FZu1k6EjTRZY.psq48fQR8dk18YjXAi2a19qR0L3808S', 3, NULL, NULL, '2023-04-17 06:54:03', '2023-04-17 06:54:03'),
(6, 'supir 02', 'supir02@gmail.com', 'supir kedua', '082473487343', 'silaen toba', 'Laki-laki', 'null', '$2y$10$uDkaA8tVRv1FxBdtojzJIe/9QE5/1HSDK4mrhcKeRFEhOUXPV10z2', 3, NULL, NULL, '2023-04-17 06:56:01', '2023-04-17 06:56:01'),
(7, 'supir 03', 'supir03@gmail.com', 'supir 03', '82473487344', 'silaen toba', 'Perempuan', 'null', '$2y$10$MvP1/U33/qRSQYxEaz5D/uqqTHBxgOPUQqSN3XJVa5SJFUcaxL5ii', 3, NULL, NULL, '2023-04-17 20:50:00', '2023-04-17 20:50:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bookings_user_id_foreign` (`user_id`),
  ADD KEY `bookings_schedules_id_foreign` (`schedules_id`);

--
-- Indexes for table `buses`
--
ALTER TABLE `buses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `buses_supir_id_foreign` (`supir_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `lokets`
--
ALTER TABLE `lokets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lokets_admin_id_foreign` (`admin_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_auth_codes_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `pembayarans`
--
ALTER TABLE `pembayarans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pembayarans_schedules_id_foreign` (`schedules_id`),
  ADD KEY `pembayarans_bookings_id_foreign` (`bookings_id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `routes`
--
ALTER TABLE `routes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `schedules`
--
ALTER TABLE `schedules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `schedules_bus_id_foreign` (`bus_id`),
  ADD KEY `schedules_route_id_foreign` (`route_id`);

--
-- Indexes for table `trackings`
--
ALTER TABLE `trackings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `trackings_bus_id_foreign` (`bus_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_role_id_foreign` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `buses`
--
ALTER TABLE `buses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lokets`
--
ALTER TABLE `lokets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pembayarans`
--
ALTER TABLE `pembayarans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `routes`
--
ALTER TABLE `routes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `schedules`
--
ALTER TABLE `schedules`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `trackings`
--
ALTER TABLE `trackings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_schedules_id_foreign` FOREIGN KEY (`schedules_id`) REFERENCES `schedules` (`id`),
  ADD CONSTRAINT `bookings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `buses`
--
ALTER TABLE `buses`
  ADD CONSTRAINT `buses_supir_id_foreign` FOREIGN KEY (`supir_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `lokets`
--
ALTER TABLE `lokets`
  ADD CONSTRAINT `lokets_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `pembayarans`
--
ALTER TABLE `pembayarans`
  ADD CONSTRAINT `pembayarans_bookings_id_foreign` FOREIGN KEY (`bookings_id`) REFERENCES `bookings` (`id`),
  ADD CONSTRAINT `pembayarans_schedules_id_foreign` FOREIGN KEY (`schedules_id`) REFERENCES `schedules` (`id`);

--
-- Constraints for table `schedules`
--
ALTER TABLE `schedules`
  ADD CONSTRAINT `schedules_bus_id_foreign` FOREIGN KEY (`bus_id`) REFERENCES `buses` (`id`),
  ADD CONSTRAINT `schedules_route_id_foreign` FOREIGN KEY (`route_id`) REFERENCES `routes` (`id`);

--
-- Constraints for table `trackings`
--
ALTER TABLE `trackings`
  ADD CONSTRAINT `trackings_bus_id_foreign` FOREIGN KEY (`bus_id`) REFERENCES `buses` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
