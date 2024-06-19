-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 19 Jun 2024 pada 03.47
-- Versi server: 8.0.30
-- Versi PHP: 8.1.10

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

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `generate_weekly_schedule` (IN `start_day` TINYINT, IN `end_day` TINYINT, OUT `rows_inserted` INT, OUT `conflict_found` BOOLEAN)   BEGIN
    DECLARE current_day DATE;
    DECLARE dow TINYINT;
    DECLARE start_date DATE;
    DECLARE end_date DATE;
    DECLARE rows_added INT DEFAULT 0;

    -- Initialize conflict_found to FALSE
    SET conflict_found = FALSE;

    -- Calculate the start and end dates based on the start_day and end_day parameters
    SET start_date = CURDATE() + INTERVAL (start_day - DAYOFWEEK(CURDATE()) + 1) DAY;
    SET end_date = CURDATE() + INTERVAL (end_day - DAYOFWEEK(CURDATE()) + 1) DAY;
    
    -- Ensure start_date is less than end_date
    IF start_date > end_date THEN
        SET end_date = end_date + INTERVAL 7 DAY;
    END IF;

    SET current_day = start_date;

    -- Label the WHILE loop for the LEAVE statement
    the_loop: WHILE current_day <= end_date DO
        -- Get the day of the week (0=Sunday, 1=Monday, ..., 6=Saturday)
        SET dow = DAYOFWEEK(current_day) - 1;
        
        -- Check for conflicts before inserting
        IF EXISTS (
            SELECT 1 
            FROM schedules s 
            JOIN default_schedules ds ON s.bus_id = ds.bus_id AND s.tanggal = CONCAT(current_day, ' ', ds.TIME)
            WHERE ds.day_of_week = dow
        ) THEN
            -- Set conflict_found to TRUE and leave the loop
            SET conflict_found = TRUE;
            LEAVE the_loop;
        END IF;

        -- Insert schedules for the current day from default_schedules
        INSERT INTO schedules (bus_id, route_id, tanggal, harga, STATUS, is_default, created_at, updated_at)
        SELECT bus_id, route_id, CONCAT(current_day, ' ', TIME), harga, STATUS, 1, NOW(), NOW()
        FROM default_schedules
        WHERE day_of_week = dow;

        -- Update the count of rows added
        SET rows_added = rows_added + ROW_COUNT();

        -- Move to the next day
        SET current_day = current_day + INTERVAL 1 DAY;
    END WHILE the_loop;

    -- Set the output parameter
    SET rows_inserted = rows_added;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `adminloket_brand`
--

CREATE TABLE `adminloket_brand` (
  `id` bigint UNSIGNED NOT NULL,
  `id_adminloket` bigint UNSIGNED NOT NULL,
  `brand_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `adminloket_brand`
--

INSERT INTO `adminloket_brand` (`id`, `id_adminloket`, `brand_id`, `created_at`, `updated_at`) VALUES
(1, 3, 1, NULL, NULL),
(2, 8, 1, NULL, NULL),
(3, 9, 1, NULL, NULL),
(4, 10, 1, NULL, NULL),
(5, 11, 1, NULL, NULL),
(6, 12, 1, NULL, NULL),
(7, 20, 1, NULL, NULL),
(8, 31, 1, NULL, NULL),
(9, 22, 1, NULL, NULL),
(10, 28, 1, NULL, NULL),
(11, 34, 2, NULL, NULL),
(12, 37, 2, NULL, NULL),
(13, 40, 2, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `bookings`
--

CREATE TABLE `bookings` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `schedules_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamatJemput` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `num_seats` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number_phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `seats` int NOT NULL,
  `status` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `bookings`
--

INSERT INTO `bookings` (`id`, `user_id`, `schedules_id`, `name`, `alamatJemput`, `num_seats`, `number_phone`, `seats`, `status`, `created_at`, `updated_at`) VALUES
(284, 33, 1, '11422042 Vivaldi A. S.', 'Tarutung', '2', '085277922115', 0, 0, '2024-06-08 05:29:51', '2024-06-08 05:29:51'),
(285, 4, 1, 'Penumpang01', 'Tarutung', '3', '0836646464', 0, 0, '2024-06-08 05:34:58', '2024-06-08 05:34:58'),
(286, 33, 2, '11422042 Vivaldi A. S.', 'Tarutung', '2', '085277922115', 0, 0, '2024-06-10 02:59:46', '2024-06-10 02:59:46'),
(287, 4, 3, 'Penumpang01', 'Tarutung', '2', '0836646464', 0, 0, '2024-06-10 06:17:48', '2024-06-10 06:17:48'),
(288, 33, 4, '11422042 Vivaldi A. S.', 'Sidikalang', '2', '085277922115', 0, 0, '2024-06-11 07:07:12', '2024-06-11 07:07:12'),
(289, 4, 4, 'Penumpang01', 'Sidikalang', '4', '0836646464', 0, 0, '2024-06-11 07:16:29', '2024-06-11 07:16:29'),
(290, 37, 4, 'Justin Bieber', 'Sidikalang', '2', '8349032', 0, 0, '2024-06-11 07:17:27', '2024-06-11 07:17:27'),
(291, 37, 4, 'Johnny Depp', 'Sidikalang', '1', '8438329', 0, 0, '2024-06-11 07:21:50', '2024-06-11 07:21:50'),
(292, 37, 4, 'huron', 'Sidikalang', '1', '234324', 0, 0, '2024-06-11 07:22:58', '2024-06-11 07:22:58'),
(293, 37, 4, 'Benni', 'Sidikalang', '1', '011111111111', 0, 0, '2024-06-11 07:46:31', '2024-06-11 07:46:31'),
(294, 33, 7, '11422042 Vivaldi A. S.', 'Medan', '1', '085277922115', 0, 0, '2024-06-12 02:40:33', '2024-06-12 02:40:33'),
(295, 33, 7, '11422042 Vivaldi A. S.', 'Medan', '1', '085277922115', 0, 0, '2024-06-12 02:40:38', '2024-06-12 02:40:38'),
(296, 33, 7, '11422042 Vivaldi A. S.', 'Medan', '2', '085277922115', 0, 0, '2024-06-12 02:46:30', '2024-06-12 02:46:30'),
(297, 33, 7, '11422042 Vivaldi A. S.', 'Medan', '2', '085277922115', 0, 0, '2024-06-12 02:46:38', '2024-06-12 02:46:38'),
(298, 33, 7, '11422042 Vivaldi A. S.', 'Medan', '1', '085277922115', 0, 0, '2024-06-12 02:55:32', '2024-06-12 02:55:32'),
(299, 33, 7, '11422042 Vivaldi A. S.', 'Medan', '1', '085277922115', 0, 0, '2024-06-12 02:55:39', '2024-06-12 02:55:39'),
(300, 33, 7, '11422042 Vivaldi A. S.', 'Medan', '1', '085277922115', 0, 0, '2024-06-12 02:55:42', '2024-06-12 02:55:42'),
(301, 33, 7, 'Hans Agung', 'Medan', '1', '0892737848977', 0, 0, '2024-06-12 03:11:03', '2024-06-12 03:11:03'),
(302, 33, 7, '11422042 Vivaldi A. S.', 'Medan', '1', '085277922115', 0, 0, '2024-06-12 03:27:13', '2024-06-12 03:27:13'),
(303, 33, 7, '11422042 Vivaldi A. S.', 'Medan', '2', '085277922115', 0, 0, '2024-06-12 03:36:20', '2024-06-12 03:36:20'),
(304, 33, 7, '11422042 Vivaldi A. S.', 'Medan', '1', '085277922115', 0, 0, '2024-06-12 03:38:40', '2024-06-12 03:38:40'),
(305, 33, 7, '11422042 Vivaldi A. S.', 'Medan', '2', '085277922115', 0, 0, '2024-06-12 03:48:02', '2024-06-12 03:48:02'),
(306, 33, 6, '11422042 Vivaldi A. S.', 'Sidikalang', '2', '085277922115', 0, 0, '2024-06-12 03:56:09', '2024-06-12 03:56:09'),
(307, 33, 7, '11422042 Vivaldi A. S.', 'Medan', '1', '085277922115', 0, 0, '2024-06-12 04:29:44', '2024-06-12 04:29:44'),
(308, 33, 7, '11422042 Vivaldi A. S.', 'Medan', '2', '085277922115', 0, 0, '2024-06-12 04:33:31', '2024-06-12 04:33:31'),
(309, 33, 7, 'masrin sinaga', 'Medan', '2', '09876543', 0, 0, '2024-06-12 04:46:04', '2024-06-12 04:46:04'),
(310, 33, 6, 'arjoboy', 'Sidikalang', '1', '085277922115', 0, 0, '2024-06-12 05:10:33', '2024-06-12 05:10:33'),
(311, 33, 6, '11422042 Vivaldi A. S.', 'Sidikalang', '2', '085277922115', 0, 0, '2024-06-12 06:38:42', '2024-06-12 06:38:42'),
(312, 33, 6, '11422042 Vivaldi A. S.', 'Sidikalang', '2', '085277922115', 0, 0, '2024-06-12 06:38:50', '2024-06-12 06:38:50'),
(313, 33, 3, '11422042 Vivaldi A. S.', 'Tarutung', '1', '085277922115', 0, 0, '2024-06-14 06:18:34', '2024-06-14 06:18:34');

-- --------------------------------------------------------

--
-- Struktur dari tabel `booking_seats`
--

CREATE TABLE `booking_seats` (
  `id` bigint UNSIGNED NOT NULL,
  `booking_id` bigint UNSIGNED NOT NULL,
  `seat_number` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `booking_seats`
--

INSERT INTO `booking_seats` (`id`, `booking_id`, `seat_number`, `created_at`, `updated_at`) VALUES
(1, 284, 1, NULL, NULL),
(2, 284, 2, NULL, NULL),
(3, 285, 4, NULL, NULL),
(4, 285, 5, NULL, NULL),
(5, 285, 6, NULL, NULL),
(6, 286, 1, NULL, NULL),
(7, 286, 2, NULL, NULL),
(8, 287, 5, NULL, NULL),
(9, 287, 8, NULL, NULL),
(10, 288, 1, NULL, NULL),
(11, 288, 4, NULL, NULL),
(12, 289, 11, NULL, NULL),
(13, 289, 8, NULL, NULL),
(14, 289, 7, NULL, NULL),
(15, 289, 10, NULL, NULL),
(16, 290, 5, NULL, NULL),
(17, 290, 2, NULL, NULL),
(18, 291, 6, NULL, NULL),
(19, 292, 9, NULL, NULL),
(20, 293, 12, NULL, NULL),
(21, 294, 1, NULL, NULL),
(22, 295, 1, NULL, NULL),
(23, 296, 2, NULL, NULL),
(24, 296, 5, NULL, NULL),
(25, 297, 2, NULL, NULL),
(26, 297, 5, NULL, NULL),
(27, 298, 7, NULL, NULL),
(28, 299, 7, NULL, NULL),
(29, 300, 7, NULL, NULL),
(30, 301, 8, NULL, NULL),
(31, 302, 9, NULL, NULL),
(32, 303, 11, NULL, NULL),
(33, 303, 12, NULL, NULL),
(34, 304, 4, NULL, NULL),
(35, 305, 10, NULL, NULL),
(36, 305, 1, NULL, NULL),
(37, 306, 2, NULL, NULL),
(38, 306, 5, NULL, NULL),
(39, 307, 1, NULL, NULL),
(40, 308, 12, NULL, NULL),
(41, 308, 11, NULL, NULL),
(42, 309, 10, NULL, NULL),
(43, 309, 7, NULL, NULL),
(44, 310, 2, NULL, NULL),
(45, 311, 4, NULL, NULL),
(46, 311, 5, NULL, NULL),
(47, 312, 4, NULL, NULL),
(48, 312, 5, NULL, NULL),
(49, 313, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `brands`
--

CREATE TABLE `brands` (
  `id` bigint UNSIGNED NOT NULL,
  `merk` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `admin_id` bigint UNSIGNED NOT NULL,
  `status` int DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `brands`
--

INSERT INTO `brands` (`id`, `merk`, `admin_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 'KBT', 2, 1, '2024-04-29 01:59:12', '2024-04-29 01:59:12'),
(2, 'TTI', 32, 1, '2024-04-29 02:37:33', '2024-04-29 02:37:33'),
(3, 'Brand Jawa', 38, 1, '2024-05-28 21:36:37', '2024-05-28 21:36:37'),
(4, 'KPT', 39, 1, '2024-06-05 10:36:18', '2024-06-05 10:36:18'),
(6, 'parisma', 43, 1, '2024-06-05 23:24:05', '2024-06-05 23:24:05');

-- --------------------------------------------------------

--
-- Struktur dari tabel `buses`
--

CREATE TABLE `buses` (
  `id` bigint UNSIGNED NOT NULL,
  `supir_id` bigint UNSIGNED NOT NULL,
  `loket_id` bigint UNSIGNED NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `police_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number_of_seats` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `merk_id` bigint UNSIGNED NOT NULL,
  `nomor_pintu` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `buses`
--

INSERT INTO `buses` (`id`, `supir_id`, `loket_id`, `type`, `police_number`, `number_of_seats`, `merk_id`, `nomor_pintu`, `status`, `created_at`, `updated_at`) VALUES
(1, 6, 1, 'Ekonomi', 'BB 0938 KBS', '12', 1, 'KBT 001', 1, '2023-05-12 21:20:00', '2024-06-04 16:08:01'),
(2, 5, 1, 'Eksekutif', 'BB 1234 KM', '13', 1, 'KBT 002', 1, '2023-05-16 01:35:07', '2023-05-16 02:06:31'),
(3, 7, 1, 'Ekonomi', 'BK 0978 MK', '12', 1, 'KBT 003', 1, '2023-05-16 02:02:05', '2023-05-22 00:27:48'),
(4, 15, 2, 'Ekonomi', 'BK 1232 KM', '12', 1, 'KBT 004', 0, '2023-05-23 20:09:49', '2023-08-13 20:55:46'),
(5, 16, 2, 'Eksekutif', 'BB 1234 KF', '13', 1, 'KBT EKS 001', 1, '2023-05-23 22:05:48', '2023-05-23 22:05:48'),
(6, 18, 2, 'Ekonomi', 'BB 5555 FH', '12', 1, 'KBT 005', 1, '2023-07-12 19:40:43', '2023-07-12 19:40:43'),
(7, 22, 2, 'Ekonomi', 'BK 2340 KM', '12', 1, 'KBT 010', 1, '2023-07-18 00:38:51', '2023-07-18 00:38:51'),
(8, 28, 2, 'Ekonomi', 'BK 4321 KL', '12', 1, 'KBT 999', 1, '2023-08-07 19:14:16', '2023-08-07 19:14:16'),
(9, 14, 5, 'Ekonomi', 'BB 2351 LD', '18', 2, 'TTI 69', 1, '2024-05-09 09:29:30', '2024-06-13 07:00:46'),
(10, 26, 5, 'Ekonomi', 'ABC123', '12', 2, 'TTI 12', 1, '2024-05-09 11:30:11', '2024-06-05 18:47:59'),
(18, 35, 4, 'Ekonomi', 'bb 999 cc', '12', 2, 'TTI 00', 1, '2024-05-12 03:12:15', '2024-05-29 05:09:36'),
(19, 36, 4, 'Ekonomi', 'bb 000 cc', '12', 2, 'TTI 55', 1, '2024-05-12 03:13:36', '2024-05-12 03:13:36');

-- --------------------------------------------------------

--
-- Struktur dari tabel `default_schedules`
--

CREATE TABLE `default_schedules` (
  `id` bigint UNSIGNED NOT NULL,
  `bus_id` bigint UNSIGNED NOT NULL,
  `route_id` bigint UNSIGNED NOT NULL,
  `day_of_week` tinyint(1) NOT NULL COMMENT '0=Sunday, 1=Monday, ..., 6=Saturday',
  `time` time NOT NULL,
  `harga` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `brand_id` bigint NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `default_schedules`
--

INSERT INTO `default_schedules` (`id`, `bus_id`, `route_id`, `day_of_week`, `time`, `harga`, `status`, `brand_id`, `created_at`, `updated_at`) VALUES
(4, 3, 3, 2, '19:00:00', '160000', 'not_started', 1, '2024-05-26 19:33:23', '2024-05-26 19:33:23'),
(10, 2, 1, 2, '19:00:00', '1', 'not_started', 1, '2024-05-30 03:58:33', '2024-05-30 03:58:33'),
(11, 18, 32, 3, '11:30:00', '10000', 'not_started', 2, '2024-05-30 05:36:30', '2024-05-30 05:36:30'),
(12, 6, 4, 4, '19:00:00', '150000', 'not_started', 1, '2024-06-01 17:57:10', '2024-06-01 17:57:10'),
(13, 18, 33, 1, '11:30:00', '25000', 'not_started', 2, '2024-06-06 02:47:52', '2024-06-06 02:47:52'),
(14, 2, 2, 3, '00:00:02', '170000', 'not_started', 1, '2024-06-06 06:27:31', '2024-06-06 06:27:31');

-- --------------------------------------------------------

--
-- Struktur dari tabel `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `komisi`
--

CREATE TABLE `komisi` (
  `id` bigint NOT NULL,
  `persentase_komisi` int NOT NULL,
  `setoran_kantor` bigint NOT NULL,
  `administrasi` bigint NOT NULL,
  `brand_id` bigint NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `komisi`
--

INSERT INTO `komisi` (`id`, `persentase_komisi`, `setoran_kantor`, `administrasi`, `brand_id`, `created_at`, `updated_at`) VALUES
(1, 10, 53000, 5000, 1, '2024-06-10 02:37:20', '2024-06-10 02:37:20'),
(2, 21, 54000, 3000, 2, '2024-06-10 07:05:58', '2024-06-11 08:29:48');

-- --------------------------------------------------------

--
-- Struktur dari tabel `lokets`
--

CREATE TABLE `lokets` (
  `id` bigint UNSIGNED NOT NULL,
  `nama_loket` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lokasi_loket` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `admin_id` bigint UNSIGNED NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `brand_id` bigint NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `lokets`
--

INSERT INTO `lokets` (`id`, `nama_loket`, `lokasi_loket`, `admin_id`, `status`, `brand_id`, `created_at`, `updated_at`) VALUES
(1, 'Loket Medan KBT', 'Medan', 3, 1, 1, '2023-05-11 21:47:06', '2024-05-10 01:01:39'),
(2, 'Loket Tarutung KBT', 'Tarutung Jalan DI.Panjaitan no.27 lt.1', 8, 1, 1, '2023-05-11 23:45:31', '2023-07-16 18:56:25'),
(3, 'Loket Siborong-borong KBT', 'Jln.Gereja Siborong-borong', 9, 1, 1, '2023-07-18 00:18:51', '2023-07-18 00:18:51'),
(4, 'Loket Sidikalang TTI ', 'Sidikalang', 34, 1, 2, NULL, '2024-05-12 00:18:11'),
(5, 'Loket Balige TTI', 'Balige', 37, 1, 2, NULL, '2024-06-07 22:28:30'),
(6, 'Loket Tarutung TTI', 'Tarutung', 40, 0, 2, NULL, '2024-06-07 22:28:43');

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(63, '2024_04_29_172842_booking_seats_table', 1),
(64, '2024_05_12_041858_create_sopir_brand_table', 2),
(65, '2024_05_12_043531_create_adminloket_brand_table', 3),
(73, '2024_05_20_122205_add_foto_pengumuman_to_pengumumans_table', 2),
(89, '2014_10_12_000000_create_users_table', 3),
(90, '2014_10_12_100000_create_password_reset_tokens_table', 3),
(91, '2019_08_19_000000_create_failed_jobs_table', 3),
(92, '2019_12_14_000001_create_personal_access_tokens_table', 3),
(93, '2024_05_05_025402_create_profils_table', 3),
(94, '2024_05_05_025430_create_galeris_table', 3),
(95, '2024_05_05_025452_create_prestasis_table', 3),
(96, '2024_05_05_025501_create_prodis_table', 3),
(97, '2024_05_05_025511_create_semesters_table', 3),
(98, '2024_05_05_025526_create_dosens_table', 3),
(99, '2024_05_05_025541_create_tentangs_table', 3),
(100, '2024_05_09_133132_create_events_table', 3),
(101, '2024_05_11_222512_create_beritas_table', 3),
(102, '2024_05_11_222751_create_pengumumans_table', 3),
(103, '2024_05_11_225243_create_sliders_table', 3);

-- --------------------------------------------------------

--
-- Struktur dari tabel `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `client_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('002e2aa8592780797995fbb4f2db4846108799719d032d895ee3d5274c6321648b171b7e196bd3e6', 2, 3, 'authToken', '[]', 0, '2024-05-07 18:54:50', '2024-05-07 18:54:50', '2025-05-08 01:54:50'),
('0030b851f367567e1c449dc4a13758c7554075fb4fb635f63aba4abd6fcd6751fc16de1dfc9ae568', 3, 1, 'authToken', '[]', 0, '2023-06-12 22:11:30', '2023-06-12 22:11:30', '2024-06-13 05:11:30'),
('007be266c79ee887874a4b7d8877a2c78a544deaf42a2b47b834bd28c4e856dacf4d3da395edcdcd', 3, 3, 'authToken', '[]', 1, '2023-07-23 02:45:20', '2023-07-23 02:54:01', '2024-07-23 09:45:20'),
('0093dcf64075f5dbe6e2298d9e420bfd5aea08cd30c09abf4afe056b63ddb0211396272daaf806d3', 32, 3, 'authToken', '[]', 1, '2024-05-09 21:43:27', '2024-05-10 00:27:47', '2025-05-10 04:43:27'),
('00e3eb9a2215e684b275ec168c295080c6626072c8a918bb257e13c991bead691b0b895cf910173c', 2, 1, 'authToken', '[]', 0, '2023-05-15 02:45:14', '2023-05-15 02:45:14', '2024-05-15 09:45:14'),
('01465f0f328e06954a701aac8df3f1c7268ec2baade3b19ec913abde56642fb80b226c29f6a0fd90', 14, 3, 'authToken', '[]', 0, '2023-07-16 01:29:19', '2023-07-16 01:29:19', '2024-07-16 08:29:19'),
('01970503e0830a50aa916c91a5c8100e40df03fd53688d6763cd12a70db5e318e4fb9b85f6ff6793', 3, 1, 'authToken', '[]', 1, '2023-05-25 07:38:15', '2023-05-25 07:39:23', '2024-05-25 14:38:15'),
('020d199cee765ac9f9716e55a4b95ec46c538f4b7a38d2da2323054408bc928641fa32fc87e26e54', 14, 3, 'authToken', '[]', 0, '2023-07-16 00:08:42', '2023-07-16 00:08:42', '2024-07-16 07:08:42'),
('027415394c95e14a02d416a4ede5a0e6fe80a5ea0d7eb1a67073f81bb94ce0ad068c13762eb6db4f', 14, 3, 'authToken', '[]', 1, '2023-07-23 02:13:02', '2023-07-23 02:45:08', '2024-07-23 09:13:02'),
('02778ad9d824ab95152a6936a00b2f4e4f3c8518b48c6015fd3390aef2a9cceca6e8f314a99be2a4', 4, 1, 'authToken', '[]', 0, '2023-06-12 23:55:36', '2023-06-12 23:55:36', '2024-06-13 06:55:36'),
('0434e074cd33c5908dad2c688e669e6d07a01c2ae890bb2400d0896f521b8aed25cd37a020697e33', 14, 3, 'authToken', '[]', 1, '2023-07-09 19:04:25', '2023-07-09 19:04:37', '2024-07-10 02:04:25'),
('0460ad15c96f1f0c97bebdf8116a932a92bf0764463c325c1a4cc155c9d38b1ee8f3b216b0e19938', 3, 1, 'authToken', '[]', 0, '2023-06-20 01:27:32', '2023-06-20 01:27:32', '2024-06-20 08:27:32'),
('05fe5cbdb60df3b15ba99498e581333e42cce8fe5cf41616b4713e249ff6c639e75a3e4242e14cc4', 2, 3, 'authToken', '[]', 1, '2024-05-10 00:29:51', '2024-05-10 00:29:56', '2025-05-10 07:29:51'),
('0618ea9a21700d04fa1f2c47e639d251b775a773476bff8f6db6c90f84ee8566468162cbacafaf61', 4, 3, 'authToken', '[]', 0, '2024-01-15 13:38:42', '2024-01-15 13:38:42', '2025-01-15 20:38:42'),
('0631b3384f88c42b5d281706e76985cb7014b8f465064407d088c7e75c1cf0676a51ecf96d724afd', 33, 3, 'authToken', '[]', 0, '2024-05-13 18:27:42', '2024-05-13 18:27:42', '2025-05-14 01:27:42'),
('06db0dcd7c2fb963ed93b4369a66e61e5f7ff953e970d28d1d14e0c84cd2bd8bae04861e0a8c9efe', 14, 3, 'authToken', '[]', 0, '2023-07-11 22:15:48', '2023-07-11 22:15:48', '2024-07-12 05:15:48'),
('06e08ead6bd87f8a36b030965e40f4096960f8df59683e534eaa4ebd8868df6e58d874d9417c3854', 2, 3, 'authToken', '[]', 1, '2024-05-26 12:15:26', '2024-05-26 19:34:26', '2025-05-26 19:15:26'),
('071035f87dfc052e9e5e83591d37d8346ee8c93310c50db8758d3c21232ffc3d52e29d03995be8a3', 2, 3, 'authToken', '[]', 0, '2023-07-16 20:07:53', '2023-07-16 20:07:53', '2024-07-17 03:07:53'),
('099a13094ca4ba0bc30c2204e07119558071af8bb85c61ec2a5fd993aab81fec73963f5bc98f31b7', 33, 3, 'authToken', '[]', 0, '2024-05-22 22:05:18', '2024-05-22 22:05:18', '2025-05-23 05:05:18'),
('09e3dee7e78f54c513e59a87556125835aa39377ec2f4fdb57c111c1ccc529cde56e5a5df10a7577', 2, 1, 'authToken', '[]', 0, '2023-05-18 05:31:48', '2023-05-18 05:31:49', '2024-05-18 12:31:48'),
('0a0cc83eaf41de3a2e55e096fc94567ca85dfd262e1233b084280d955442adac6b754508689393f2', 3, 3, 'authToken', '[]', 1, '2024-05-24 06:48:04', '2024-05-24 06:48:34', '2025-05-24 13:48:04'),
('0a91b9432a030d05fad426373dca8ecb7f9b27a8984cdd5c82fba2df27006cf7cf9d42311cccc8d5', 8, 1, 'authToken', '[]', 0, '2023-05-30 00:33:34', '2023-05-30 00:33:34', '2024-05-30 07:33:34'),
('0aa953908579c35dfc4a13c85a2f4ba91966dab3533c51b7c91b2dfe572ed896c643f0e712d4e52a', 4, 1, 'authToken', '[]', 0, '2023-06-01 23:23:25', '2023-06-01 23:23:25', '2024-06-02 06:23:25'),
('0ad283acae7f4fc710f91ed156b1c0679c4ce2a60b32ded27070fb04e35c74c69118924b65007740', 14, 3, 'authToken', '[]', 1, '2024-01-12 01:51:43', '2024-01-12 01:58:00', '2025-01-12 08:51:43'),
('0af449deb77f24a345c0d26c5f12759cc313f077186fb29e51a2fc53549d397d2c5310725100f83c', 14, 3, 'authToken', '[]', 1, '2023-07-09 19:07:54', '2023-07-09 19:09:33', '2024-07-10 02:07:54'),
('0b1bcb80319b588562b0ca8aab4608ea73237b16db7f76b9b28395784e954e5db687939443cc3f90', 2, 1, 'authToken', '[]', 0, '2023-05-15 03:44:03', '2023-05-15 03:44:03', '2024-05-15 10:44:03'),
('0b4637555ea7c89cf61f64cb2cddae6067ada8c86e263aa33520b2cb27548062d3ac1e73d1ff9c02', 2, 1, 'authToken', '[]', 0, '2023-06-13 20:32:31', '2023-06-13 20:32:31', '2024-06-14 03:32:31'),
('0c1c502c4dc483d98d45767d726bc26567315be3301a91c6a77f811476cd1bf30115598afb04ad54', 4, 1, 'authToken', '[]', 0, '2023-06-13 00:49:32', '2023-06-13 00:49:32', '2024-06-13 07:49:32'),
('0c216506b4fa3450f7ae2e247df6d437d7da7322652b01d4b9717eebc6305df48996da8d7789b605', 32, 3, 'authToken', '[]', 1, '2024-05-22 00:40:56', '2024-05-22 00:51:28', '2025-05-22 07:40:56'),
('0c22e8da350dd2bc2005751c2c28765339f60fc1e144bbe3879ad7d9ab30e56256e4b0493e087d82', 4, 1, 'authToken', '[]', 0, '2023-06-20 02:33:14', '2023-06-20 02:33:14', '2024-06-20 09:33:14'),
('0d92db4f4eb5f2a79b4487ef81e4969686353ba9ae18395e1ab982d5e22a66565481f406bf4b1e21', 14, 1, 'authToken', '[]', 1, '2023-05-22 22:58:09', '2023-05-22 22:59:38', '2024-05-23 05:58:09'),
('0d92dcaa065180f99f23a491ec80430acfcf0e1c6c6b3603e9f81ae40c31969c6260b00eac42547a', 14, 3, 'authToken', '[]', 0, '2023-07-15 03:23:44', '2023-07-15 03:23:44', '2024-07-15 10:23:44'),
('0de4bf7dd0035bb53ab6fdbd9891a2ef36c4d93a8ecd3ddc7d6b64c431f6d2409724b0f6b8d38ffe', 3, 3, 'authToken', '[]', 1, '2023-07-17 06:03:16', '2023-07-17 06:03:28', '2024-07-17 13:03:16'),
('0e4449b400a84e1cf44fe005002e66c45320cd43e20a0b6dde4bf510b58f64638c928285c0aa8980', 32, 3, 'authToken', '[]', 0, '2024-05-09 11:28:55', '2024-05-09 11:28:55', '2025-05-09 18:28:55'),
('0ffb7839234a26b26b61b0a600aa7750dfa115f65ec1df32bfe87c78f54d37ab8427285268cea58d', 2, 3, 'authToken', '[]', 1, '2024-05-02 21:38:00', '2024-05-02 21:38:59', '2025-05-03 04:38:00'),
('1002c3d182cc0c44e2ccb1af765e0c93ebc6aafd70917cb963e5fcd79f1f6d4ac310cdaec3ba0624', 27, 3, 'MyApp', '[]', 0, '2023-07-17 23:35:22', '2023-07-17 23:35:22', '2024-07-18 06:35:22'),
('100795aa03c24966f6218af01ca0d181acf054f05138c3182b0691d614e76b3053f0ec7f6c978751', 33, 3, 'authToken', '[]', 0, '2024-05-22 21:12:23', '2024-05-22 21:12:23', '2025-05-23 04:12:23'),
('10a2650e20b89211efd93c8b7fb80e86d691874405d62b13d12bae18ef99c7ae184c81284323e46a', 7, 1, 'authToken', '[]', 0, '2023-06-29 22:29:18', '2023-06-29 22:29:18', '2024-06-30 05:29:18'),
('10a3fde7812304864496fccaee1e127f4d740507aa7c9d73aac0dafd8c504af6c5cf173e8ff62276', 5, 3, 'authToken', '[]', 1, '2024-05-09 11:27:05', '2024-05-09 11:27:40', '2025-05-09 18:27:05'),
('10bb33842423af68acd51b2ebf19a4d7c8fa59106fbb16093c25bcccad8f74cfdcf7d05925a53b53', 35, 3, 'MyApp', '[]', 0, '2024-05-11 22:58:00', '2024-05-11 22:58:00', '2025-05-12 05:58:00'),
('110b5a7b0263f56d5b03500b3f2222f1e89cf831aea743131bb21f3fc7fc816fb16c3b50dfd5744a', 33, 3, 'authToken', '[]', 0, '2024-05-02 21:40:53', '2024-05-02 21:40:53', '2025-05-03 04:40:53'),
('11ab1479d5a669a351b4da74786c72422ca5687686225c7b53b2789144a3a3496904f9a1bf2f6417', 32, 3, 'authToken', '[]', 0, '2024-05-26 11:28:26', '2024-05-26 11:28:26', '2025-05-26 18:28:26'),
('11d321e657a8fccf4659909a7060e8e8c4815c8bf739651e1670b6e8cce532eb40cb0e390622b28b', 3, 3, 'authToken', '[]', 1, '2024-05-23 18:56:16', '2024-05-23 20:39:33', '2025-05-24 01:56:16'),
('11da971bdd69f207b070e2cfcc688cc4eff6ef03ccab80d2a9df7625838bf411e3ca96fb3b92821a', 2, 3, 'authToken', '[]', 1, '2023-07-16 10:02:23', '2023-07-16 10:02:41', '2024-07-16 17:02:23'),
('11e285d0c815291903663f67c099b1d8f9f4e5a09751f19159af885de5ada4f0fdf0b803b2978191', 3, 1, 'authToken', '[]', 1, '2023-06-20 02:14:57', '2023-06-20 02:33:03', '2024-06-20 09:14:57'),
('120c243da7f53a090bc3029b817e923a626c9668e851f683dd268ab36c3fdec3cec7e8ea28034db6', 2, 1, 'authToken', '[]', 1, '2023-05-21 23:43:55', '2023-05-22 02:17:11', '2024-05-22 06:43:55'),
('1245d0a149faafb1a3b002f2ef633bbcf4984ebe859d22b55da25dd9217930e3c0c50458871aa3e2', 6, 1, 'authToken', '[]', 0, '2023-05-15 18:46:23', '2023-05-15 18:46:24', '2024-05-16 01:46:23'),
('135cee538869385685fc17a83969e804401165324d3159d9bbc8ccd3559e6f6190f1b04386492985', 33, 3, 'authToken', '[]', 1, '2024-05-01 20:12:46', '2024-05-01 20:30:22', '2025-05-02 03:12:46'),
('13c56532b75807857b1a9265d2a080974a0ae4df925a1cae626a285762270b1861f7adff13749f9f', 3, 1, 'authToken', '[]', 1, '2023-05-23 22:07:51', '2023-05-23 23:42:10', '2024-05-24 05:07:51'),
('1440bf307f657a64372925a05fa86fb71c469ea0b2c2ad1332345ca9c9075893cd5a864ed2edf6ed', 2, 1, 'authToken', '[]', 0, '2023-05-16 02:32:26', '2023-05-16 02:32:26', '2024-05-16 09:32:26'),
('1497cd7086ff3aa4edc8ded0597baeb783fbb3c806fd0f3fb08f1dffb4ba357cf7ff2e943ba0e42f', 2, 3, 'authToken', '[]', 1, '2023-08-09 23:44:36', '2023-08-10 00:35:16', '2024-08-10 06:44:36'),
('14a3192da48d96dedc86fdcb455587c3eddbb88aa2a453d6e7124b119e6642ae5df83ec56d59b062', 2, 3, 'authToken', '[]', 1, '2023-09-04 20:20:15', '2023-09-04 21:05:03', '2024-09-05 03:20:15'),
('15102fc39f1c9e59b7a9ee37b06e3c4d85e0f15e8046c4e1a77152ab314cc003cebc877aea3873df', 32, 3, 'authToken', '[]', 1, '2024-05-13 21:34:04', '2024-05-13 21:34:45', '2025-05-14 04:34:04'),
('151b5ee0ed6580f82aadf6b6cc804761dacf6950bff9d796b000804fb8d5c296c4828d4089060a53', 33, 3, 'authToken', '[]', 0, '2024-05-26 19:39:15', '2024-05-26 19:39:15', '2025-05-27 02:39:15'),
('15232db77fbde0e7e2d0be10c069c4e7013ddd141e5ea49820820cef29b12e7db5cee365083f772a', 3, 3, 'authToken', '[]', 0, '2024-05-23 20:13:54', '2024-05-23 20:13:55', '2025-05-24 03:13:54'),
('15fba731d8e31700733a6bec4a78a241d468c8d5f7d5b16d2a10c3594b366e8f7bbe214064a668b3', 4, 1, 'authToken', '[]', 1, '2023-06-12 18:24:57', '2023-06-12 20:24:42', '2024-06-13 01:24:57'),
('1635aa84a141a84148605945f6bb72da64fded70f11182777a202cc9c60101a2ce3d9ffa37913b0d', 5, 1, 'authToken', '[]', 0, '2023-05-22 23:35:08', '2023-05-22 23:35:08', '2024-05-23 06:35:08'),
('1681a29b3994b57f3664dc7a7534d02c07c60cad14459bf4be012c09ae6117d2f138b9528849d24f', 14, 3, 'authToken', '[]', 1, '2023-07-23 02:54:08', '2023-07-23 03:24:46', '2024-07-23 09:54:08'),
('16fe7ca6447d85e282e685f69b319461195aef5a8ed2427e8b80ebcaad8e086a1cbc802d03e66160', 14, 3, 'authToken', '[]', 0, '2023-07-16 00:01:22', '2023-07-16 00:01:22', '2024-07-16 07:01:22'),
('1702ac2bc516878c2b0feeab7a725ebaf2c4c5d9d37c8e7bf18623e31a2a327eca008cd511e0fa63', 8, 3, 'authToken', '[]', 1, '2023-07-16 20:40:08', '2023-07-16 20:40:48', '2024-07-17 03:40:08'),
('1732c18533c639f0f220a7157ae66282e14cd29511f3936c4a666fc3a9fbcec19f957d36bd8d8bd3', 4, 1, 'authToken', '[]', 0, '2023-06-22 18:52:40', '2023-06-22 18:52:42', '2024-06-23 01:52:40'),
('17485ba22f6c914d4fcc6091c451bfa0a91729c7579bdf4db9ef80a058f8d2befb60b901f118279b', 2, 1, 'authToken', '[]', 0, '2023-05-15 03:33:08', '2023-05-15 03:33:08', '2024-05-15 10:33:08'),
('1756911b43c30c34a471fc73610491564bd883f0ece9b4ee1b2c17d6b0aa64954211885e7e730935', 5, 1, 'authToken', '[]', 0, '2023-05-22 23:33:36', '2023-05-22 23:33:36', '2024-05-23 06:33:36'),
('1864255cb31c6d7c3e0cced70953bae42de8b2377689ad4f938b774a46ee5ff81d32007be10a5b5e', 2, 3, 'authToken', '[]', 1, '2024-05-26 00:55:38', '2024-05-26 10:12:56', '2025-05-26 07:55:38'),
('1877ed3463bba6714070acf83fa556fdb3f4eec1394dffef3227e56a4e7018ddfc1efda98b632390', 14, 1, 'authToken', '[]', 1, '2023-07-02 18:27:54', '2023-07-03 05:28:48', '2024-07-03 01:27:54'),
('18f2515e1695629a9919822330420d9b46c4e1303d5d2e854feaf686f236c609053f3027f4571896', 3, 1, 'authToken', '[]', 1, '2023-05-22 21:02:58', '2023-05-22 22:56:52', '2024-05-23 04:02:58'),
('1973ef27314e601143a230edbec94cbe1c009f157a1f18693212b1a4d02714584ca4d33fa3eb8007', 14, 3, 'authToken', '[]', 1, '2023-07-18 21:52:47', '2023-07-18 21:56:33', '2024-07-19 04:52:47'),
('19741dd29a72e4a63c736d37cfa149738c962471dd97ecec1bd7ce2ac8267ac6efd10a0476741a0f', 3, 3, 'authToken', '[]', 0, '2023-07-21 23:14:43', '2023-07-21 23:14:43', '2024-07-22 06:14:43'),
('19d3e25dd653ddf740af05e87c31132055c2928d1d4ce20e2f7f3d67dcc082717630596699fa50e1', 7, 1, 'authToken', '[]', 0, '2023-07-02 19:38:27', '2023-07-02 19:38:27', '2024-07-03 02:38:27'),
('1ab3cb09f5bf514384e62d6673aeff3de72c991c030f414da272ccfc53d69760d25ff821d37d0c3c', 9, 1, 'authToken', '[]', 1, '2023-05-24 00:23:03', '2023-05-24 00:31:13', '2024-05-24 07:23:03'),
('1b2e1c54e52f49c3cc91e3351a7b4996647dd9a247f2fc7c7b7e789780490941472c5ff68a0886ca', 2, 3, 'authToken', '[]', 1, '2023-07-16 18:16:57', '2023-07-16 18:19:44', '2024-07-17 01:16:57'),
('1bc2ab703278f7bfebb784574e29f9160362a55ca3dad951ea084e0b84c7171f0bce59e3e9aa9cc7', 2, 3, 'authToken', '[]', 0, '2023-08-07 18:43:00', '2023-08-07 18:43:01', '2024-08-08 01:43:00'),
('1bf6fc7a868c6dbb91b487744a2b568b6df7942be934babaceeec3b749b87f18989b0ce2d8314d10', 3, 1, 'authToken', '[]', 1, '2023-06-12 22:18:51', '2023-06-12 22:19:11', '2024-06-13 05:18:51'),
('1c3ce032a65645394fb61bd7391a6d73d4c8cd6108f9bf72859e81adb701bd049161fd24be60fcd3', 24, 3, 'MyApp', '[]', 0, '2023-07-17 23:33:42', '2023-07-17 23:33:42', '2024-07-18 06:33:42'),
('1ccab133fc872fb336ad14de8d0dfe1fba0498326156cfb681d2cd09bb9f227df8f8bc95bfde57d6', 33, 3, 'authToken', '[]', 1, '2024-05-02 21:36:28', '2024-05-02 21:37:25', '2025-05-03 04:36:28'),
('1cf0d662cce6e5f52b491a463c66aa2d96d4869d510fac1f5ae2693096f5f870048137f4fb95eb99', 33, 3, 'authToken', '[]', 1, '2024-05-23 00:29:25', '2024-05-23 05:53:36', '2025-05-23 07:29:25'),
('1cfdb747d34913585dbc55c9dbb31c8b5f306ab9b92d8aa32a36e386f6e6324e0acd5968075110de', 33, 3, 'authToken', '[]', 1, '2024-05-12 03:22:13', '2024-05-12 03:22:51', '2025-05-12 10:22:13'),
('1d26ca022fb8bf9b86d6b1a29fba97e1ac32f8648153679b2afb712699cd1274b79b9dcf821dedb3', 33, 3, 'authToken', '[]', 1, '2024-05-25 01:11:56', '2024-05-25 01:39:11', '2025-05-25 08:11:56'),
('1d49eb14cbe14728533fcf97755114627c73df03779c102b5c1962d9e48bcd17a225354b8f64d659', 32, 3, 'authToken', '[]', 1, '2024-05-22 08:14:38', '2024-05-22 08:15:17', '2025-05-22 15:14:38'),
('1dd1878d5f1c7b9e0a6f0ae73588d5ba88512a251ec93f7df2a13e3f019aa654e6f036116633bd26', 33, 3, 'authToken', '[]', 1, '2024-05-02 21:39:04', '2024-05-02 21:39:39', '2025-05-03 04:39:04'),
('1dde492f4affc6d80adfd4fe64c899b5b4863479ad63fbef28e32e1f860680eb9b6a2bcfd85e574e', 14, 1, 'authToken', '[]', 0, '2023-06-01 23:26:42', '2023-06-01 23:26:42', '2024-06-02 06:26:42'),
('1e0045c4383662724d7dded602937a43db97309cea6ac5841adc4a20891f87080b1216747abe7245', 2, 1, 'authToken', '[]', 0, '2023-05-23 00:31:15', '2023-05-23 00:31:16', '2024-05-23 07:31:15'),
('1e9e0da0882b53f35285b32ade4d78137c58e652fc90e0e4af744d34b1e64e5ef041c4e1aff5f142', 14, 3, 'authToken', '[]', 0, '2023-07-05 06:17:11', '2023-07-05 06:17:12', '2024-07-05 13:17:11'),
('1eb08b19b1dff6092fe75c28dd585f018a2c2a4d34327185303e2e612c108e50afa55e47f68e534d', 32, 3, 'authToken', '[]', 0, '2024-05-09 11:04:52', '2024-05-09 11:04:52', '2025-05-09 18:04:52'),
('2025d744e7e2a39e276671c8bcca30fa650e8fe60b97f12915dc9bae71df6cbee89941b08c36592f', 2, 3, 'authToken', '[]', 1, '2024-01-15 02:03:01', '2024-01-15 02:03:30', '2025-01-15 09:03:01'),
('20d4bf863e77ad7ccac0b833722d8169d3f760f6381901db05074b023e57ec2f68989df0f010d016', 3, 1, 'authToken', '[]', 1, '2023-06-20 01:50:36', '2023-06-20 02:12:50', '2024-06-20 08:50:36'),
('212bbe6e7af8d3922dfb719648e1a34695169abd9a5d3bb41a77487f4325ca5b3fb2678598addec4', 4, 1, 'authToken', '[]', 0, '2023-06-19 22:47:22', '2023-06-19 22:47:23', '2024-06-20 05:47:22'),
('212fe6eee4e0cf5be4f17298f384db55abcb13883cf672fa2fb311424cdd69f4978311dbdd0bd3a8', 32, 3, 'authToken', '[]', 1, '2024-05-24 05:37:38', '2024-05-24 05:38:28', '2025-05-24 12:37:38'),
('21b2423e3e132e61942fa67caba2e06d73c6012691b4eb4175fb0b3adcbed25570da2c7eda9392e4', 14, 3, 'authToken', '[]', 0, '2023-07-09 19:06:50', '2023-07-09 19:06:50', '2024-07-10 02:06:50'),
('22ae761205c0da1b2b759ce43d5a5855e77e8690115ecf07f67e1e3250688a7c3fb53e16ba2ba8b6', 2, 3, 'authToken', '[]', 1, '2024-05-04 21:44:24', '2024-05-04 21:44:49', '2025-05-05 04:44:24'),
('22f950674afc01ad72cb69e3fcef0ba4acb36a9d8c72faa9a661f5ea0e784fbbc46774f42ffa3feb', 2, 1, 'authToken', '[]', 0, '2023-05-15 03:57:41', '2023-05-15 03:57:41', '2024-05-15 10:57:41'),
('231bf2f7e5f66fe72ed4f0d2400c7a892fb30e46fce02571004d393c6c47ba67e9145b8ca8783a73', 14, 3, 'authToken', '[]', 0, '2023-07-15 03:23:25', '2023-07-15 03:23:25', '2024-07-15 10:23:25'),
('2325de7a9c8f4a7d99605d012f8ac3f2e122ed56c5f5ef29b98b7ee96cb5eb79af3697698a5e13c3', 3, 3, 'authToken', '[]', 1, '2023-08-13 19:11:07', '2023-08-13 20:38:55', '2024-08-14 02:11:07'),
('2370787d3ce6fc6532608c7e25eb90cd8c22d2d557863f9d7276c303e6fd1e253d3dee731f74fa6d', 14, 1, 'authToken', '[]', 0, '2023-06-21 17:56:08', '2023-06-21 17:56:09', '2024-06-22 00:56:08'),
('23b759ede1cdfc913131823dad45d83a56a945af937e632e9796ae7004bb2110f2b2794dfce1c1ba', 3, 3, 'authToken', '[]', 1, '2024-05-25 02:39:49', '2024-05-25 02:39:58', '2025-05-25 09:39:49'),
('243eb4a628c6012c5b26805a019227f8a712ac29fdccc4717c08617276c176ec2fa240a96f676bc1', 33, 3, 'authToken', '[]', 0, '2024-05-23 23:15:46', '2024-05-23 23:15:46', '2025-05-24 06:15:46'),
('2451f3ee5c5cef3cb2d3d282ab78640e1289f2c8f60c8b62e691540f4f5d1c433e087cfe80ea8965', 33, 3, 'authToken', '[]', 1, '2024-05-04 21:21:32', '2024-05-04 21:44:18', '2025-05-05 04:21:32'),
('249571b3b18561da937940c6c834ca4f3b26a923c7170d63015a1f1e6fb7f2799340ff61e409e08b', 32, 3, 'authToken', '[]', 1, '2024-04-29 02:01:31', '2024-04-29 02:01:46', '2025-04-29 09:01:31'),
('24a0f90d255f75c41d06d45119370da01b10e24aeb37b95111a31223e34a08e2ed13ffd6eaa8d9ad', 15, 1, 'MyApp', '[]', 0, '2023-05-23 19:49:55', '2023-05-23 19:49:55', '2024-05-24 02:49:55'),
('24a8e268b5d78490cd8f152f2df59abbe9fb900037b2e55d32d39d1066419d0aec47ba80a364cb01', 33, 3, 'authToken', '[]', 1, '2024-05-22 20:40:05', '2024-05-22 20:49:11', '2025-05-23 03:40:05'),
('2547c6e5a3d18efeacffccf56a3f716c0411ce79211fbd89054b2ccecaaaf329215b6e178b674854', 14, 3, 'authToken', '[]', 0, '2023-07-16 03:09:07', '2023-07-16 03:09:07', '2024-07-16 10:09:07'),
('25d6076a2c9d9d509d527178fcd55bacbb33ba43c3bfd534358748e13b09fa2c05a772ff51bbf911', 32, 3, 'authToken', '[]', 1, '2024-05-25 02:34:53', '2024-05-25 02:35:59', '2025-05-25 09:34:53'),
('25ddbb1a94784f07de3bd2de8a56077695624a594e86bd4d5ee98850c5d2076c1b0e65b9bedc04df', 32, 3, 'authToken', '[]', 1, '2024-05-10 00:29:35', '2024-05-10 00:29:46', '2025-05-10 07:29:35'),
('2602128e705e517d83bb9738edb64174f174ff51fa59c0e95a98035252ae5e9e2ee47aecb3501917', 2, 3, 'authToken', '[]', 1, '2024-05-24 05:36:28', '2024-05-24 05:36:49', '2025-05-24 12:36:28'),
('26e648c37ec9ee68019343c11d83d494673d92cdccb76604c1e28bcec15f3bf95dcf28060e788871', 5, 3, 'authToken', '[]', 1, '2024-05-23 05:53:44', '2024-05-23 05:56:06', '2025-05-23 12:53:44'),
('28676f81f99d043d3f1486f325e4dcbc9607a4b3f770eb3ba2ebb9000cebffb004d24d90a8faf411', 2, 3, 'authToken', '[]', 1, '2023-07-23 03:24:53', '2023-07-23 03:45:10', '2024-07-23 10:24:53'),
('29c9e209f66777e6eb99f80e25a3239e3188b8f9e69fe47f7fbd2f256deb10d2a694baf3ffe01f9c', 14, 3, 'authToken', '[]', 1, '2023-07-23 03:28:31', '2023-07-23 03:46:06', '2024-07-23 10:28:31'),
('2a7bf2e76ba1a1140a51b2fbe24b68383a052c77fd9b1205f891996ba51ee6f1afcae60e258563b3', 33, 3, 'authToken', '[]', 1, '2024-05-21 23:51:49', '2024-05-21 23:52:43', '2025-05-22 06:51:49'),
('2ab57afe2b717d2b0a002369c6fd390c5ce012e4e167ed9f60646a5e18dde85c970ab43e02d05664', 14, 3, 'authToken', '[]', 0, '2023-07-05 18:52:40', '2023-07-05 18:52:41', '2024-07-06 01:52:40'),
('2b0230b827c5e0d28e69952fd2846b754ff4f6c463bd665ad6496da6b56cb472355205862b33dd86', 14, 3, 'authToken', '[]', 1, '2023-07-06 00:38:12', '2023-07-06 02:14:40', '2024-07-06 07:38:12'),
('2c53b974430d54920051b11b466923d5989f4ca7ddf3df223a02347621203efe6db27f602d0f5369', 17, 3, 'authToken', '[]', 1, '2023-07-19 19:19:27', '2023-07-19 19:32:36', '2024-07-20 02:19:27'),
('2ceceab5de08b66be9ca3fd4e3a7b3957c5310cbc2add3d2cd7e949917bdc0a0940dfbb1462d64fc', 14, 3, 'authToken', '[]', 0, '2023-07-04 21:33:46', '2023-07-04 21:33:46', '2024-07-05 04:33:46'),
('2d625b969b9b8a9bcec567afaed838a5983d2e0d924cb9784bdab936713dce6ba8c5175829aaf2b7', 25, 3, 'MyApp', '[]', 0, '2023-07-17 23:34:37', '2023-07-17 23:34:37', '2024-07-18 06:34:37'),
('2daf9ee5e492d0a03e58de814e3c24203dc5cc953e09df876f71bfb18115307df7c5b0a4093e9ecc', 33, 3, 'authToken', '[]', 0, '2024-04-29 02:44:17', '2024-04-29 02:44:17', '2025-04-29 09:44:17'),
('2de705f476a9df8de44e40180d48e563b6536e048f90165f92a8e1ebae47513528b2051b8b2c531c', 4, 1, 'authToken', '[]', 1, '2023-06-01 23:36:52', '2023-06-06 00:28:58', '2024-06-02 06:36:52'),
('2e50e15aac532a243c7f81887a2e2df5d53ae14735a6281e7143ccc225fa73195a74ea689bdbdc5d', 3, 3, 'authToken', '[]', 1, '2023-07-17 06:02:40', '2023-07-17 06:03:07', '2024-07-17 13:02:40'),
('2e6f8f982a89a384808f2224c9d11179a9653b43590116b5f261aab0bd997c59c2fee96c763b0d90', 6, 3, 'authToken', '[]', 0, '2023-07-23 03:46:13', '2023-07-23 03:46:13', '2024-07-23 10:46:13'),
('2eadfb1af1c1abd984f476f5013ed6bc9c396182f53b738971da398108af4d22e0a47e5fb755bd5b', 4, 1, 'authToken', '[]', 0, '2023-06-20 18:26:49', '2023-06-20 18:26:50', '2024-06-21 01:26:49'),
('2eb39f1bb32ea7900c7995058a354f43c202e6587c413a3a582ee620a7bcf41a3f8d3e136f2ccd22', 33, 3, 'authToken', '[]', 1, '2024-04-30 04:56:51', '2024-04-30 05:47:34', '2025-04-30 11:56:51'),
('2ee8bacd8574576cc3d832bb32bf73170ec9426a6444c8d2a2165511cec5e04c9a53dd2e6b2cab63', 17, 3, 'authToken', '[]', 1, '2023-07-16 20:41:00', '2023-07-16 21:38:07', '2024-07-17 03:41:00'),
('2f9a582171006e487b981c44c130d4427afeea96a7e7b9a710e723243a3f1df4639de19a3f79d88c', 5, 3, 'authToken', '[]', 1, '2023-08-20 19:47:00', '2023-08-20 19:47:15', '2024-08-21 02:47:00'),
('308487d2f32454494f05c33a63fa1b15424b563c25be24b0092f211212aa34e47847547757f61bad', 2, 3, 'authToken', '[]', 0, '2024-05-09 19:01:54', '2024-05-09 19:01:54', '2025-05-10 02:01:54'),
('30c7b2489415e30153169649902820022b26d5d40afd062bcd732840505b34cf4f47d3698d96c5be', 14, 3, 'authToken', '[]', 0, '2023-07-15 01:37:34', '2023-07-15 01:37:34', '2024-07-15 08:37:34'),
('31345ed5df35fb2cbcecd0d7d1615a701e1f02ed2f4fcd14fadf86c3f9dc809e1b7d0e2f2ac3045c', 32, 3, 'authToken', '[]', 0, '2024-05-12 06:42:56', '2024-05-12 06:42:56', '2025-05-12 13:42:56'),
('31512f8b70159890f1c91d205f1912716e05963a6d667a2926ba20c803dc1460bc417bb56aebf92b', 4, 1, 'authToken', '[]', 0, '2023-06-12 23:53:06', '2023-06-12 23:53:06', '2024-06-13 06:53:06'),
('316e994f19f57fccf05cb698c3b823323b54015b52532b4f2b1051a59bea22da92e6af001946df52', 4, 3, 'authToken', '[]', 0, '2023-07-15 23:59:30', '2023-07-15 23:59:30', '2024-07-16 06:59:30'),
('31e2f2ae9d5889f699794e68f90dffec78879ce085cb6dc11fb9649acc474d04b5ae240ed4b91887', 14, 3, 'authToken', '[]', 0, '2023-07-19 06:28:40', '2023-07-19 06:28:40', '2024-07-19 13:28:40'),
('32ffdd99c43890e07ed300e7b5002abb1de8d3cdfb32d3473e30c0355bc933ee90143954fb6234f0', 3, 3, 'authToken', '[]', 1, '2024-05-22 20:49:17', '2024-05-22 20:52:26', '2025-05-23 03:49:17'),
('33722441b36144a475b34fb0744ad3612c2f4afee141c902da053c8296b3fb9cb3432bf11a6c93d0', 32, 3, 'authToken', '[]', 0, '2024-05-09 18:51:04', '2024-05-09 18:51:04', '2025-05-10 01:51:04'),
('33c204c6e93ea356d7c93d20b9903221745cfac322251c896d60e9338d26c4801b948dbff3c7a5f6', 2, 3, 'authToken', '[]', 1, '2023-07-20 01:56:29', '2023-07-21 20:17:47', '2024-07-20 08:56:29'),
('33de76ca2b5db5397ef130c8abc94405d62f979d519f4d5c32b31c16278e0e493c1d75be7d70954c', 7, 3, 'authToken', '[]', 1, '2024-05-25 02:06:04', '2024-05-25 02:34:46', '2025-05-25 09:06:04'),
('34208a7ffc1c93cb5213e4c98c7767a47fe108cbcd75613bc1ef82d8bc1be8a021ddc3375a9d5b3a', 4, 1, 'authToken', '[]', 0, '2023-06-01 23:27:51', '2023-06-01 23:27:51', '2024-06-02 06:27:51'),
('34b7c2c25e8e1b857074651ae908fceb999d04dcefb9b88596476bc7c2d1c19391b7eec2af1765fe', 14, 3, 'authToken', '[]', 0, '2023-07-16 03:20:11', '2023-07-16 03:20:11', '2024-07-16 10:20:11'),
('34c1e90e7331706dd9c2691f5cd8db277340570f1a3206723462a43fb1d2f4691432b230f6ec5e58', 14, 3, 'authToken', '[]', 0, '2023-07-16 03:16:14', '2023-07-16 03:16:14', '2024-07-16 10:16:14'),
('34cc8d2633e72ee9628f1f99d076a1adf47e0f16f9ef4ff9b2e053e35624511ec896506e70f4dc2e', 14, 3, 'authToken', '[]', 0, '2023-07-16 00:26:52', '2023-07-16 00:26:52', '2024-07-16 07:26:52'),
('3517e490a3cc5dcb0097b9523a9cbb2dbb7a143561c979e8cca002486eb39a56254aeae71fbe33f8', 2, 3, 'authToken', '[]', 1, '2023-07-16 19:20:43', '2023-07-16 19:22:17', '2024-07-17 02:20:43'),
('3648640b4a375a7c16ad1aba6c177d04b84f2498baceca405837655372d5019a3f3fe0a056a80eac', 2, 3, 'authToken', '[]', 1, '2024-05-23 21:34:34', '2024-05-23 23:09:44', '2025-05-24 04:34:34'),
('3661a52ab22d0618863f886d0796ca4c5f316becbd6475d9d7f8d584a3318d67429e4a951d01731b', 3, 1, 'authToken', '[]', 1, '2023-05-25 18:41:49', '2023-05-25 20:41:16', '2024-05-26 01:41:49'),
('36a1ed02bedb15276b70d21c9d9dfacf2fa6131380e6f6708c389a8c5f667deeb99540d60b3c4e1f', 8, 3, 'authToken', '[]', 1, '2023-07-17 06:03:34', '2023-07-17 06:03:46', '2024-07-17 13:03:34'),
('370a1ed8f2b5efb1e4e51be179bf1f3d550a93fd499460f3995daf64527846206bd4d28da707b9a1', 14, 3, 'authToken', '[]', 1, '2023-07-16 02:41:56', '2023-07-16 02:42:00', '2024-07-16 09:41:56'),
('3756bcad88fbdc788d6d7f06b4090d45420554619736d3ee398121a7386c70c7e61b60512aae8f54', 2, 3, 'authToken', '[]', 0, '2023-07-12 18:42:41', '2023-07-12 18:42:41', '2024-07-13 01:42:41'),
('378f70bdadec9eb4cd97224e5a97951cf0a958560f786af7b5b93def2060ca7f6e2ace3903a46cc0', 3, 3, 'authToken', '[]', 0, '2023-07-12 18:36:26', '2023-07-12 18:36:27', '2024-07-13 01:36:26'),
('3798040f97fce7ee5adb8fa471600222a49abe475af1a8f72a399d680e01e01ded8148952429629a', 32, 3, 'authToken', '[]', 0, '2024-05-10 12:05:58', '2024-05-10 12:05:58', '2025-05-10 19:05:58'),
('37a01156db8ec9d58783d106fa24017625f37b2f2956ad09896e7b5a9e0b161f6a2241d861df5262', 33, 3, 'authToken', '[]', 0, '2024-04-30 07:25:43', '2024-04-30 07:25:43', '2025-04-30 14:25:43'),
('3807cca32972e048ffb7a7fe3857c61f294b7b2ae7e8e956c43d9bed28082546ce7c6bf3c6429ee2', 32, 3, 'authToken', '[]', 0, '2024-05-09 19:02:27', '2024-05-09 19:02:27', '2025-05-10 02:02:27'),
('38742279883d6250e4583172523d7b2cd0155ee73b011c3adf0ac8041e64f1910ac7e4606b3c84af', 2, 1, 'authToken', '[]', 1, '2023-05-23 00:09:48', '2023-05-23 00:10:21', '2024-05-23 07:09:48'),
('38e4376c759ebb6afec1ecadfcc1a0be30c2349fd1d4c81a561a3cbd41cc1f9174ae6ca59a1bd39b', 33, 3, 'authToken', '[]', 1, '2024-05-05 19:45:16', '2024-05-05 19:45:57', '2025-05-06 02:45:16'),
('3a4202540270863891f51714610b67a61b8b08176a7c33f299e4109d635b1c4ec6ec0274fb36a933', 14, 3, 'authToken', '[]', 1, '2023-07-16 04:17:08', '2023-07-16 07:31:10', '2024-07-16 11:17:08'),
('3a98c6032c4d1ee504969cec346b8b8593182b184225f4d4166a1ac01aa8475ebc75c43f833cef64', 8, 1, 'authToken', '[]', 1, '2023-05-25 20:41:27', '2023-05-25 21:22:01', '2024-05-26 03:41:27'),
('3ae5df3b1a0f12f97558ce22a0f80177ae73053135b66211a319ea3a2c95a42d785e867f31bcd76e', 32, 3, 'authToken', '[]', 0, '2024-05-14 07:01:55', '2024-05-14 07:01:55', '2025-05-14 14:01:55'),
('3b06394c1128e640faa67babba33bec0f3571e70bbaf870722c23eb29576949347cf09bd93779179', 2, 3, 'authToken', '[]', 0, '2024-05-23 21:52:00', '2024-05-23 21:52:00', '2025-05-24 04:52:00'),
('3b694a1b49b478c6b7ef4a8acf87f45f37c3872accc75095bb2ea354935ed08dce3ffacf179aeb26', 2, 1, 'authToken', '[]', 0, '2023-05-22 18:21:54', '2023-05-22 18:21:54', '2024-05-23 01:21:54'),
('3bd13a4712358cf4e0a201bd899b92e67a200d0e3fe9c91639e0fbd60ecd166fa15d168dba700130', 17, 1, 'authToken', '[]', 1, '2023-05-25 20:35:32', '2023-05-25 21:22:19', '2024-05-26 03:35:32'),
('3c3711e0196bdc85334bb94e721c023cb0ad2878b104e74a0cdfed77acf898629f266251eaa242e3', 4, 1, 'authToken', '[]', 0, '2023-06-12 02:32:02', '2023-06-12 02:32:03', '2024-06-12 09:32:02'),
('3c73f0bd6026ddbb42cf6df931b40909119307fb8b031485066d9ff5c670b1eb1cad83098ad5efb1', 14, 3, 'authToken', '[]', 1, '2023-07-19 03:21:39', '2023-07-19 03:24:18', '2024-07-19 10:21:39'),
('3d246f4c94d679b2a6904d2d040bc6ec64f580ca9168ddad1f19c8f623a4208af2f5c673f4dca40b', 33, 3, 'authToken', '[]', 0, '2024-04-29 11:04:54', '2024-04-29 11:04:54', '2025-04-29 18:04:54'),
('3d53340da23f046127f0b134f52727682ee7f90d2390147345bb3c600b61da0ccfebf5d21eb6e901', 14, 3, 'authToken', '[]', 0, '2023-07-16 01:47:35', '2023-07-16 01:47:35', '2024-07-16 08:47:35'),
('3dc1b12e2051659210742ec04bea2beffc2e99c1d3fe698c972d82c0d725497281ab23b33d1e2bbd', 14, 3, 'authToken', '[]', 0, '2023-07-10 02:36:11', '2023-07-10 02:36:11', '2024-07-10 09:36:11'),
('3eb333bcb485a6969432131e5d4d1c87ba3003360aa3dc9d52b538fb4e8dba23972c504a283d5d19', 2, 3, 'authToken', '[]', 0, '2023-07-19 02:37:09', '2023-07-19 02:37:09', '2024-07-19 09:37:09'),
('3fb1a1a08c0edb6215504efb897308274bdce7f221d8c9d83607ebafd1a9ba82dc779ddee62fdf5e', 15, 1, 'authToken', '[]', 1, '2023-07-04 06:37:57', '2023-07-04 06:38:50', '2024-07-04 13:37:57'),
('401768360dd1f6bfcdbe8c6eb6a1a042ab6a2237e34c836dba5719875e91afa9ca791f202972f3da', 14, 3, 'authToken', '[]', 1, '2023-07-19 03:27:23', '2023-07-19 06:27:01', '2024-07-19 10:27:23'),
('406f5ba8fb9c1dc57ed282bbc633074c89a448b4d6ca5fb60cf5a798b5b8265e498b5f00d39ad3ec', 3, 3, 'authToken', '[]', 1, '2023-07-16 19:00:14', '2023-07-16 20:39:43', '2024-07-17 02:00:14'),
('409317b75fa90e77c870e5be11d54360fed657057edcee1cc271a546145a997890f3e49b744dba5b', 31, 3, 'MyApp', '[]', 0, '2023-07-18 00:07:02', '2023-07-18 00:07:02', '2024-07-18 07:07:02'),
('40ac7433f659958b28c827c64e96d90a4cd0e9517f94bb398a4123dd175ef9f1c66b29fc1a33a495', 7, 3, 'authToken', '[]', 0, '2023-07-16 07:31:20', '2023-07-16 07:31:20', '2024-07-16 14:31:20'),
('4140f5945480649d1896ee747238afd7ac9d48c102bfd3252439056edb09c9510a6ac3917b585770', 33, 3, 'authToken', '[]', 1, '2024-05-23 20:57:15', '2024-05-23 21:30:23', '2025-05-24 03:57:15'),
('41778e995fcf2f311951c6b693ea229655b2b8e7fcadf50073ea0c793157f139c80fd427045d9ab5', 33, 3, 'authToken', '[]', 1, '2024-05-25 01:51:11', '2024-05-25 02:00:35', '2025-05-25 08:51:11'),
('422942153885f87e8b02843ca9713a08d6071e873364ecb2cf4487481705c99b01d24a2dd5dffa75', 2, 1, 'authToken', '[]', 0, '2023-05-18 18:37:22', '2023-05-18 18:37:22', '2024-05-19 01:37:22'),
('424c3ec86571fe437fe33de44e18722cced6af79ab2b82c37fd318c47a876635d07ed9f1edf930bc', 33, 3, 'authToken', '[]', 1, '2024-05-24 06:13:56', '2024-05-24 06:20:53', '2025-05-24 13:13:56'),
('4267dd9666682c377cb5bb23556cecc5b95ec6cf39cfa54e611c3ccbb489723c14636d0f18658972', 33, 3, 'authToken', '[]', 1, '2024-05-26 00:41:19', '2024-05-26 00:45:04', '2025-05-26 07:41:19'),
('4314cb864536cd3a098fecc9714906760415dcd81a553708835751663b8a8eb77cb329f3a23f5e4b', 14, 3, 'authToken', '[]', 1, '2023-07-20 01:55:54', '2023-07-20 01:56:08', '2024-07-20 08:55:54'),
('439b26a03f2c7c2653e39c05210f135382125eaa98406b4d496c9c0d5c90a3e9fa1d1ab99fc165b3', 2, 3, 'authToken', '[]', 0, '2023-07-09 19:08:28', '2023-07-09 19:08:28', '2024-07-10 02:08:28'),
('43f742688e82b253eeae83264c67c0133c08ccf7dcff2f0d51059b8602f3513384547cecba0bd9fe', 14, 3, 'authToken', '[]', 0, '2023-08-10 00:35:22', '2023-08-10 00:35:22', '2024-08-10 07:35:22'),
('443c00f4ec06489958338c010dfee662de637352dad0a0e7d54da5e56902628f3b7c451bd4d47980', 2, 1, 'authToken', '[]', 0, '2023-05-15 03:35:15', '2023-05-15 03:35:15', '2024-05-15 10:35:15'),
('452c1a75d55f3f991c4d36f14030e96955fbd3d49b6a11c1789c68e6604786d063f1514498e945d7', 18, 1, 'MyApp', '[]', 0, '2023-06-13 20:29:49', '2023-06-13 20:29:49', '2024-06-14 03:29:49'),
('46110b6eb1dfc68caf82eca103086a556f2cfc3991810518c13d08e8fe6dce86ca4e978d720b2af1', 33, 3, 'authToken', '[]', 1, '2024-05-25 08:19:12', '2024-05-25 08:30:26', '2025-05-25 15:19:12'),
('467e735eb9a2d28a4929465a14eb2a7a313c50380e6e8d59f957237d52a13078fd1c105a782a98c2', 2, 1, 'authToken', '[]', 0, '2023-05-11 20:17:18', '2023-05-11 20:17:18', '2024-05-12 03:17:18'),
('4743340299bbe1ef02b7ad5360eddf9667758a972fac6ac5dfeb365e89b7a17827e28b9272b5b7ed', 2, 3, 'authToken', '[]', 0, '2023-07-26 21:40:58', '2023-07-26 21:40:58', '2024-07-27 04:40:58'),
('4771786937034dfa3ae64e166f7c488588f65ee5863a047bcb93a7b1a5e4de2155953099d9224c23', 33, 3, 'authToken', '[]', 0, '2024-05-05 21:25:46', '2024-05-05 21:25:46', '2025-05-06 04:25:46'),
('47d1e4635a3f2a870c8cf7b0ad455ac843bf652eaea7a299526f1cda7c0d0aef6beb8282f3ea1b4f', 33, 3, 'authToken', '[]', 1, '2024-05-23 21:25:47', '2024-05-23 21:25:53', '2025-05-24 04:25:47'),
('47e4e880031ac840fe680db7c3ee9ecf625befd59f9ae00d51867568d79d8247280da6145089e026', 13, 1, 'MyApp', '[]', 0, '2023-05-15 19:47:30', '2023-05-15 19:47:30', '2024-05-16 02:47:30'),
('4827dbb6465dc5a6839a866749ef7744c2e3366db93ce3ac3a925dd65f59cafc5839e8d4a185af27', 32, 3, 'authToken', '[]', 1, '2024-05-12 00:17:44', '2024-05-12 01:33:20', '2025-05-12 07:17:44'),
('488b40d889a9838f29ad6b14a82b64e6ebc59748aab7797e56f80234e8f4fda43d7172c7da496ed9', 2, 3, 'authToken', '[]', 0, '2023-07-19 02:50:37', '2023-07-19 02:50:37', '2024-07-19 09:50:37'),
('48db55c12c3f8b6dcb9937ea7d2398edc67d71882762faff19a02c8fc11d402adcd8f74d1d91c062', 33, 3, 'authToken', '[]', 0, '2024-05-05 03:06:07', '2024-05-05 03:06:07', '2025-05-05 10:06:07'),
('48f7668bcf409eefef0ca2f59dfabfb5d836775c979227024b602217d4714333b7876c671871a7e7', 4, 1, 'authToken', '[]', 0, '2023-06-01 23:02:58', '2023-06-01 23:02:59', '2024-06-02 06:02:58'),
('493d86dd91cc1787a1bde068827756d68154da66f65b68c9422f3c1901a1431922b09eeb8832dfe9', 14, 3, 'authToken', '[]', 0, '2023-07-05 23:58:05', '2023-07-05 23:58:05', '2024-07-06 06:58:05'),
('4a2b1466f8bc76ea323697b7f31f8bad4fd8939f9fdd9cd5f4bf0953a7ba6eec1d9f0d70bba5510c', 2, 3, 'authToken', '[]', 1, '2024-04-29 10:40:55', '2024-04-29 11:04:40', '2025-04-29 17:40:55'),
('4ac0e8cb3d9fb2bc389c58da679c1d96441df7230a0d7edc6be319f0dba7c95d3c82a0b9197e12fa', 14, 3, 'authToken', '[]', 1, '2023-07-15 02:57:50', '2023-07-15 03:23:17', '2024-07-15 09:57:50'),
('4ae66d2d175c3190d0b5aaad78b89125d03bcdaa4b068ecdc165891a9053081217795db9b5d188fd', 4, 1, 'authToken', '[]', 0, '2023-06-01 23:26:06', '2023-06-01 23:26:06', '2024-06-02 06:26:06'),
('4ae7c265e8c31c6675f042a096864e13d5ed0c985a71073fce3a9014e42563727dafe1109cd72e0a', 4, 1, 'authToken', '[]', 0, '2023-06-01 23:24:47', '2023-06-01 23:24:48', '2024-06-02 06:24:47'),
('4b247c14a11f2b95e5b1d4265908058194f9ed93e8f41950bb64a44fc25ecda84553c823e32dddc9', 2, 1, 'authToken', '[]', 0, '2023-05-18 06:46:28', '2023-05-18 06:46:29', '2024-05-18 13:46:28'),
('4cf3f646ddbd5551eb82dc5b4cc0e34ad5bccb24282b8555b2f21adaf0a5a9b333490efbf94995e9', 6, 1, 'authToken', '[]', 1, '2023-05-23 00:10:28', '2023-05-23 00:31:07', '2024-05-23 07:10:28'),
('4da823923d3b4afc103c3454da9650cde1e6f4c37d12c7782ad8ea877800b971e8e824520c71cb18', 2, 3, 'authToken', '[]', 1, '2023-07-16 18:38:20', '2023-07-16 18:39:16', '2024-07-17 01:38:20'),
('4eb2fe25ffcdf3c8b297a1966dc1acfb2c880ef26561cd5f1ce3f065396979900c5f35046a44c5ae', 2, 3, 'authToken', '[]', 0, '2023-07-16 19:44:32', '2023-07-16 19:44:32', '2024-07-17 02:44:32'),
('4ee8cb8dfccc5137f74d8d580af7f83e58434639e388d248c46d2e238234dcff1124c749bb69f833', 14, 3, 'authToken', '[]', 1, '2023-07-19 03:26:54', '2023-07-19 03:26:58', '2024-07-19 10:26:54'),
('4f6ba3f6be886e0e31e89bedd6accf8279e68b81c996a7501b18976bf0b5f5ff1fa9061c4d61df2a', 2, 1, 'authToken', '[]', 1, '2023-06-20 02:12:58', '2023-06-20 02:14:48', '2024-06-20 09:12:58'),
('4f97dda12cbf627b48cc65d47eb83164e646fc1aceb933aaa4d9398a532a45c1b1c7bd1b2727b373', 4, 1, 'authToken', '[]', 1, '2023-06-12 22:14:35', '2023-06-12 22:18:42', '2024-06-13 05:14:35'),
('501907ea073c296709b4c155f73056534ab2b9a57bf4a6aac2363b5da77c361f4f1821e371f72193', 14, 3, 'authToken', '[]', 1, '2023-07-16 02:42:10', '2023-07-16 02:42:49', '2024-07-16 09:42:10'),
('506560961c6e6f4a9171c18b06f40831073bb8e60014f4a743951140c3fd77bac4472c0c04f1b8da', 3, 3, 'authToken', '[]', 1, '2023-07-16 18:19:50', '2023-07-16 18:53:47', '2024-07-17 01:19:50'),
('508839b8d843b9e432758400833fad2ab280c663263063d6c51345b348f588eb5980f1ce464ed5a7', 2, 1, 'authToken', '[]', 0, '2023-05-15 21:36:53', '2023-05-15 21:36:53', '2024-05-16 04:36:53'),
('50ada5bee0e34583698985e47edfe7b1eb6851d441216b6582c285244b8e5d9e59b01c47067f2a1e', 3, 3, 'authToken', '[]', 1, '2023-07-12 18:15:47', '2023-07-12 19:38:04', '2024-07-13 01:15:47'),
('50dadc7729ff8f7f7911f94ea907bbdc7cee57e0c15e9118b415e00184d9b9c5a0b81103d29b57c0', 2, 3, 'authToken', '[]', 1, '2024-05-10 04:51:14', '2024-05-10 04:53:57', '2025-05-10 11:51:14'),
('5154ea1ff94226d1e4e353d79ddd78ce69d0bd97bb380fe966781c39d3e42a23f1158096f3b7fea0', 2, 3, 'authToken', '[]', 1, '2023-07-16 18:53:54', '2023-07-16 18:58:52', '2024-07-17 01:53:54'),
('5181c20ce0e46db738d2411b976dd45cd7f2d6db87e5a2049c969df9b51a6c5bb47cca64ccc0c0d6', 2, 1, 'authToken', '[]', 0, '2023-05-16 02:25:55', '2023-05-16 02:25:56', '2024-05-16 09:25:55'),
('51ae8de3b2226e329e3c2462135d543d170dcd7c36a345ae1302372c6e38d64e4461caf419e01763', 2, 1, 'authToken', '[]', 1, '2023-05-25 07:39:32', '2023-05-25 08:52:38', '2024-05-25 14:39:32'),
('51f8cde35442f66935d6a6fbd00b9413515da983bfed39a9e12cbede63bc9b33cfe0188daaf5f2e8', 2, 3, 'authToken', '[]', 0, '2023-07-14 06:33:55', '2023-07-14 06:33:55', '2024-07-14 13:33:55'),
('52d4b286f856aa3e848b565da0ed3aa586a597ffbd721217457c51cdc83529c90b6319c4251f1d69', 33, 3, 'authToken', '[]', 0, '2024-05-04 21:47:18', '2024-05-04 21:47:18', '2025-05-05 04:47:18'),
('52f6d13c1a1eed584b4215ac44d4bdfe18e768f45e02640bb95165de197b003c4455b1c84117db9f', 17, 1, 'authToken', '[]', 0, '2023-06-27 07:11:49', '2023-06-27 07:11:49', '2024-06-27 14:11:49'),
('5308635371925e92c203056253d00cf9b9653061540029f6b4fb2e887498b48b74aec10a0c3e72ed', 4, 1, 'authToken', '[]', 0, '2023-06-12 23:52:03', '2023-06-12 23:52:04', '2024-06-13 06:52:03'),
('535b0f452f071173862d1dfc06b33ee5f451d27346f00300eb89c75dd5e9fb67114da058d9fa0194', 33, 3, 'authToken', '[]', 0, '2024-05-23 00:19:38', '2024-05-23 00:19:38', '2025-05-23 07:19:38'),
('538fb97b105126af1ef8f7a6c464927315c5c52580368144744117a3316bfb85a6ebdb60d0a859a8', 37, 3, 'MyApp', '[]', 0, '2024-05-12 03:15:22', '2024-05-12 03:15:22', '2025-05-12 10:15:22'),
('53e9a4de9f8c608a6322807afc9f8af6a3b9e7df4cb920b2fc1458572427b9a87586cde7ae139084', 32, 3, 'authToken', '[]', 1, '2024-05-11 21:33:09', '2024-05-11 21:54:30', '2025-05-12 04:33:09'),
('5490eb9ae8adaa01c5f710a1399e47e1e5c8a27d3975b31aa0d0095e42a2200e1427292b42591125', 8, 1, 'authToken', '[]', 0, '2023-05-26 00:44:30', '2023-05-26 00:44:30', '2024-05-26 07:44:30'),
('54e49ae7fab49c9122af8fa344746f237c63cd1267994e2812ad5efb37eab539af7553c09707a38a', 14, 3, 'authToken', '[]', 0, '2023-07-19 03:18:48', '2023-07-19 03:18:48', '2024-07-19 10:18:48'),
('54f933b59010482428ba56d036a209f00b457f94504e9c9db00e760df9d93a72cf7fe790a6d142e1', 4, 1, 'authToken', '[]', 1, '2023-06-13 20:17:32', '2023-06-13 20:18:19', '2024-06-14 03:17:32'),
('55273128de8902008c8596a5de4978f449b565b8540063c92b0edc79a460453dcb851c03d624d1c5', 5, 3, 'authToken', '[]', 1, '2023-07-17 06:20:11', '2023-07-17 06:24:41', '2024-07-17 13:20:11'),
('55dc0a84be4f59698547d475839f323da9ac252625762296f44a85b6cf6605db85322ec0d24241f5', 14, 3, 'authToken', '[]', 0, '2023-07-16 01:44:39', '2023-07-16 01:44:39', '2024-07-16 08:44:39'),
('566106fb888e0d23f759241bc19e8abc50314ef6eae2ecae61a1b5720ac59fb6641b1464783541b7', 32, 3, 'authToken', '[]', 0, '2024-05-10 00:31:42', '2024-05-10 00:31:42', '2025-05-10 07:31:42'),
('56c0070fb9789d1d85a97a7a7fdba51a0c28c1c4a88c215a99b033b5d06a9f13e56bfd095a37ce32', 14, 3, 'authToken', '[]', 1, '2023-07-16 19:24:33', '2023-07-16 19:44:24', '2024-07-17 02:24:33'),
('56cd28591f773147612d3c41d6e898999dc76a9e48e54d35e87a2fe10e70f0939d17509287c780e2', 2, 3, 'authToken', '[]', 1, '2023-07-17 23:54:00', '2023-07-18 01:00:44', '2024-07-18 06:54:00'),
('576a55bf61080b07d64afc6518f2cb3fbb8fa04e3f362445b49dc629149d66692ee799641ac8fcf7', 2, 3, 'authToken', '[]', 1, '2024-05-09 11:17:15', '2024-05-09 11:26:38', '2025-05-09 18:17:15'),
('577353f2da52ff68b94fb94a8c76f2a8d547a60eec12a7af1e8e67306246e52c8de897ec2ce21612', 32, 3, 'MyApp', '[]', 0, '2024-04-29 02:37:33', '2024-04-29 02:37:33', '2025-04-29 09:37:33'),
('584418c10b0e8bba3a5052456ecdf5d0f0484cdb6eedb6d55488d0e347e2a0083a74a869e9a1c6ba', 14, 1, 'authToken', '[]', 1, '2023-06-13 00:21:35', '2023-06-13 00:22:41', '2024-06-13 07:21:35'),
('58573a901721e3bac5ae81e307b1aa3f20aa264a25432e760d750fc2e55fcbcf45b670a481e7dffa', 14, 3, 'authToken', '[]', 1, '2023-07-19 02:54:00', '2023-07-19 02:54:09', '2024-07-19 09:54:00'),
('592f3f81cba1b70db27d1c21ae83881aadcedac4bbec0716a59aaa565e14453195a31087edb096e8', 2, 3, 'authToken', '[]', 0, '2023-07-12 19:38:20', '2023-07-12 19:38:20', '2024-07-13 02:38:20'),
('5994618c63eec4d4650742c162f6eb61ffc946413a35c46bdca6a1771794221908c1acf335bd7889', 2, 1, 'authToken', '[]', 1, '2023-05-15 19:00:44', '2023-05-15 21:36:41', '2024-05-16 02:00:44'),
('59c7fa8b9e0b693c19490d83cc1d59981fb66a2d578a8ac209da1111fd83aae39d423dd001310899', 4, 3, 'authToken', '[]', 1, '2024-01-15 02:04:21', '2024-01-15 13:38:30', '2025-01-15 09:04:21'),
('59e33efa6dff018cddec140b24a7cde51de58c28ead9ba977fac24f5a495b27f05aa4c445fc4be73', 2, 1, 'authToken', '[]', 0, '2023-05-15 18:24:11', '2023-05-15 18:24:13', '2024-05-16 01:24:11'),
('5a06bb18ae414fb3491060f3dae327b6cf9a4b128048b7d1db6c6dc644547dabcec57b253ba4f3c3', 14, 3, 'authToken', '[]', 0, '2023-07-09 18:54:20', '2023-07-09 18:54:20', '2024-07-10 01:54:20'),
('5b73dab59dedf991abf8918338d77a2f179539ecd9f6f3880e6271e1770b33227ebb367545738036', 32, 3, 'authToken', '[]', 1, '2024-05-12 03:23:04', '2024-05-12 03:23:52', '2025-05-12 10:23:04'),
('5c8156b63f6a6dfbabf9e4c51ee2d155a435f29ec13dbed85c45ef78651f2bd11d5cbdee131863ca', 33, 3, 'MyApp', '[]', 0, '2024-04-29 02:44:10', '2024-04-29 02:44:10', '2025-04-29 09:44:10'),
('5ca4774bbd062f7cfed057f309507f838d5330f5ef5454d71ee15a84414d367c0229e51ef519960b', 14, 3, 'authToken', '[]', 0, '2023-07-16 00:26:26', '2023-07-16 00:26:26', '2024-07-16 07:26:26'),
('5e24614d46ccd0edbf2ae576e425692d2e3dc3cf1e671d9b1e288efb5f5fe7d34aa9baa9aaba476c', 2, 3, 'authToken', '[]', 0, '2023-08-13 20:39:15', '2023-08-13 20:39:15', '2024-08-14 03:39:15'),
('5e6d9909b672f16974dcc60613fa380bc387a05ef7d2d4c5d042199736584a3def603a0f63986001', 33, 3, 'authToken', '[]', 1, '2024-05-24 06:48:39', '2024-05-24 06:56:48', '2025-05-24 13:48:39'),
('5e7d45a2dc5b5667dba771b0831246cec06e2ce9818c77a18e6b27c030b08bbb44343858c7b1c75b', 4, 1, 'authToken', '[]', 1, '2023-06-13 19:05:41', '2023-06-13 20:17:15', '2024-06-14 02:05:41'),
('5f91f5314ae90da63963594c21fe8843f69f092615a4edd59c3f234c34198902947d13976f209f3c', 2, 3, 'authToken', '[]', 1, '2023-07-17 06:02:03', '2023-07-17 06:02:34', '2024-07-17 13:02:03'),
('6079b56865175149e4505b5391351649d491006fdfb17c7c956b4b029873d65d3ec9cf18c6ae6192', 17, 1, 'authToken', '[]', 1, '2023-05-25 21:39:03', '2023-05-26 00:44:09', '2024-05-26 04:39:03'),
('608819b6e78676ea0738f30c5365a9a81a44022225577803f07e6a42248d519687671cdecf7bd297', 2, 1, 'authToken', '[]', 0, '2023-05-23 20:27:53', '2023-05-23 20:27:54', '2024-05-24 03:27:53'),
('60bcbd60c67d29311664f0cdc5387788a93cd78edb4b0debd9b48cba285c35b9117ccaa03c6400db', 14, 3, 'authToken', '[]', 1, '2023-07-16 03:16:40', '2023-07-16 03:16:45', '2024-07-16 10:16:40'),
('60c75e2b98f950b1e81a27109342eb58331acb4661912660bf09b3377504a696014fb7d55bb24e34', 2, 1, 'authToken', '[]', 0, '2023-05-16 06:29:35', '2023-05-16 06:29:35', '2024-05-16 13:29:35'),
('6104b041556f3d0e20cd6d09bbfb28d0938da214c5d7a876dc1bae6416c438333f4b686256d5c91e', 2, 3, 'authToken', '[]', 0, '2023-07-21 23:19:38', '2023-07-21 23:19:38', '2024-07-22 06:19:38'),
('61eb236024c615f322d94fbf7159e4486dbefd9916a693c84684284f4ea13cb059d75d408802db1c', 33, 3, 'authToken', '[]', 1, '2024-04-29 11:38:09', '2024-04-29 15:24:54', '2025-04-29 18:38:09'),
('6224ea149ae4ee7b4c27c73fe3b111e742908cf005594dec7a36a00aa7f7fe041e5108a58a19b9ab', 14, 1, 'authToken', '[]', 0, '2023-06-20 20:34:04', '2023-06-20 20:34:04', '2024-06-21 03:34:04'),
('62c06ac4875853dab457319044a4a03992d58a7e255f9c99e466accb25b047525df8346844c991bf', 33, 3, 'authToken', '[]', 0, '2024-05-22 22:05:27', '2024-05-22 22:05:27', '2025-05-23 05:05:27'),
('62f2a88f077f64b8b5521b417a0a1550a077d792f44f577116e82d9ac11fc465a9b33661f852787d', 14, 3, 'authToken', '[]', 0, '2023-07-16 01:48:06', '2023-07-16 01:48:06', '2024-07-16 08:48:06'),
('6334ad8f67238cbcec2df5b0cc3e7e433d49f059d8cd1fc1eeff3a24964eecb732f20a25120b6ff3', 32, 3, 'authToken', '[]', 1, '2024-05-11 21:55:45', '2024-05-12 00:04:32', '2025-05-12 04:55:45'),
('638dda1d5b009525faf419573a79234548967ea7cc9d693077140e94b371b1cbed87debafdf3ff93', 14, 3, 'authToken', '[]', 0, '2023-07-16 00:09:49', '2023-07-16 00:09:49', '2024-07-16 07:09:49'),
('6422faf7c5beab7cc29c8c261dc4063a045920cdec2b6e2b3ebe15d80572e0e149d130523af1d0f5', 14, 3, 'authToken', '[]', 0, '2023-07-16 00:22:24', '2023-07-16 00:22:24', '2024-07-16 07:22:24'),
('644a408ea3337a16d0686b1079cd0884f824945df8094d9e2fb17524432aa4c79adfe207091ccdab', 14, 1, 'authToken', '[]', 0, '2023-07-04 00:49:42', '2023-07-04 00:49:42', '2024-07-04 07:49:42'),
('6452ffc1496f8420776d23af9b61baebcd17f1f9f11b657de4c92e7f045fd9f83389d3c2e2c9957d', 14, 3, 'authToken', '[]', 0, '2023-07-19 03:27:09', '2023-07-19 03:27:09', '2024-07-19 10:27:09'),
('658139d925e60a58c9ea5495e0fcfce3717a77864585102e1d933f820d795dc0f8ec6c59e90b8cd9', 33, 3, 'authToken', '[]', 1, '2024-05-05 20:09:04', '2024-05-05 20:10:13', '2025-05-06 03:09:04'),
('66248742dda0e85167b0761ccac5927da6b29f4d3350fdc08ce5882dedc5054638dedc8596b560a2', 3, 3, 'authToken', '[]', 0, '2023-08-13 07:33:13', '2023-08-13 07:33:14', '2024-08-13 14:33:13'),
('67103ab970b37f67db3ce3ff2a509c80f8c54c534426b564d8e502c966760419ba1270d593d5e2b1', 32, 3, 'authToken', '[]', 0, '2024-05-12 02:41:26', '2024-05-12 02:41:26', '2025-05-12 09:41:26'),
('6739a5b5259ae935d2386baf74195ba181b44d5a627a763676f3df105c88629edfb2624a64cd770b', 14, 3, 'authToken', '[]', 0, '2023-08-13 08:08:26', '2023-08-13 08:08:26', '2024-08-13 15:08:26'),
('679c97a76f3c319e654d3a2a507795d9fb148de5e97d86d8f2dbc4b23eb758726d2344a9aee286f7', 16, 1, 'authToken', '[]', 0, '2023-06-20 01:32:19', '2023-06-20 01:32:20', '2024-06-20 08:32:19'),
('67d9f9b78a046ed748fe1b29edce6998ddd0b7799297efe11c52394421bc7849875bfbde1bbdc04b', 32, 3, 'authToken', '[]', 1, '2024-05-10 00:41:21', '2024-05-10 04:50:59', '2025-05-10 07:41:21'),
('6804816aac0bfb5dc1715f65e979efca3c5b49305fa087c36e79d1204d857d0875c557d4753bc794', 2, 3, 'authToken', '[]', 1, '2024-05-23 21:26:19', '2024-05-23 21:34:27', '2025-05-24 04:26:19'),
('688507b02718167b62c7ddc03c661e370147f1e7c73753232719db024b0af0991cd0a805449a1d40', 4, 1, 'authToken', '[]', 1, '2023-06-12 22:19:29', '2023-06-12 22:24:29', '2024-06-13 05:19:29'),
('68ecad4ab2e6b164a72154a5efb82cad912698f30a3db1d09ac2e3d053a71950c9d02880a98fb125', 6, 1, 'authToken', '[]', 1, '2023-06-20 01:30:37', '2023-06-20 01:31:01', '2024-06-20 08:30:37'),
('69d16693fb6268fc55dcca35ea07b8700ea3e0a89a9b971aac8bccd49bdeea228a8774495a3a56ea', 4, 1, 'authToken', '[]', 0, '2023-06-22 19:35:26', '2023-06-22 19:35:27', '2024-06-23 02:35:26'),
('69f21a6a6858a80391e28db92975ceffd26560af9d4f31b6559baa7f464142c2b5d1164a524f2465', 4, 1, 'authToken', '[]', 0, '2023-05-30 19:49:29', '2023-05-30 19:49:29', '2024-05-31 02:49:29'),
('6a932aff18b4081d7a8d4c9f2af0d6e87367b7df1cac9bd74cb01a590963ecc62fe3dc6ecc87c893', 33, 3, 'authToken', '[]', 1, '2024-05-24 01:00:41', '2024-05-24 01:27:29', '2025-05-24 08:00:41'),
('6b39c121f5b957c6e111c65987670f8d6a59535a6cbfbaa074410542ae77772d5166adf1987bf02b', 4, 1, 'authToken', '[]', 0, '2023-06-07 07:05:34', '2023-06-07 07:05:34', '2024-06-07 14:05:34'),
('6bbeea101f25c6aaf2493bf6cde1d22295693712fe73246d0249bb4ac3d698eb2704adcd1a207386', 3, 3, 'authToken', '[]', 0, '2023-08-09 23:41:16', '2023-08-09 23:41:16', '2024-08-10 06:41:16'),
('6bdb5fc2b9b2293599e5224386d47cc61420c53d05e5fc6bddc15b80c018295568d1057a0b6da8a8', 28, 3, 'MyApp', '[]', 0, '2023-07-17 23:38:08', '2023-07-17 23:38:09', '2024-07-18 06:38:08'),
('6c49997ab703096673783a458b4040ac7aa95f33c0586714c955b6d661e33ca469247b7068dd1503', 17, 3, 'authToken', '[]', 0, '2023-07-16 18:06:23', '2023-07-16 18:06:23', '2024-07-17 01:06:23'),
('6c57f3257037e2a7e900ec00b440da7f9d400a63388f2c16f69b694f4c19cbb328a835f1b7d013d9', 14, 1, 'authToken', '[]', 0, '2023-06-20 19:47:11', '2023-06-20 19:47:12', '2024-06-21 02:47:11'),
('6c99e966b244c4eea95981a4a45f9c551e9eeeff9e8edb4a29bc907c19cd635c5c59c801017e617c', 7, 3, 'authToken', '[]', 0, '2024-05-26 00:16:26', '2024-05-26 00:16:26', '2025-05-26 07:16:26'),
('6d25e8fa7dc3280177446493e3dba2c93cc9514b67f90b65edd8fdc433dd20b826db71b572f1f65b', 14, 3, 'authToken', '[]', 0, '2023-07-16 03:09:42', '2023-07-16 03:09:42', '2024-07-16 10:09:42'),
('6e0b4d19665b7c592077d58707d064aa309b6eea45078ec9d2640a0e87ff38ff1fa0ef9807bfbc1a', 33, 3, 'authToken', '[]', 0, '2024-05-24 07:13:15', '2024-05-24 07:13:15', '2025-05-24 14:13:15'),
('6e2e7c7c52ddda63e07db4cb3687dc8c3adfdbfd96f3489d02be0f87852d8454ea81b8de682fe6ba', 2, 3, 'authToken', '[]', 0, '2024-05-26 10:13:01', '2024-05-26 10:13:01', '2025-05-26 17:13:01'),
('6e5e417bfc7da6babeedf49fb0d466333f11bc21de707c70aa21b27a8f5a007f7b84f94fff0c78b4', 30, 3, 'MyApp', '[]', 0, '2023-07-17 23:41:34', '2023-07-17 23:41:34', '2024-07-18 06:41:34'),
('6e7efeba4340d5ea881cb22e36804ce047c1cce01afb9ec5469818e410837c6179d24f1e13a198f0', 33, 3, 'authToken', '[]', 1, '2024-05-22 20:52:33', '2024-05-22 21:09:08', '2025-05-23 03:52:33'),
('6e8f8143544fcec12d54fe788c031b324e5577e6f9fc72f09f2dc46054890c64a6644b23d9724d86', 2, 3, 'authToken', '[]', 0, '2023-07-09 19:16:41', '2023-07-09 19:16:41', '2024-07-10 02:16:41'),
('6ecc6ed7a5b6bee4b7ae1753e98b895180beda522d0f46213978fbe354996113aceb9494b9c66742', 2, 3, 'authToken', '[]', 1, '2024-04-30 05:47:43', '2024-04-30 05:49:18', '2025-04-30 12:47:43');
INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('6f5dfe78e9ec2a9c83d15b405adf174a6163b8faf3a7e07b24898bf77cb49585c812e58ff1075950', 33, 3, 'authToken', '[]', 0, '2024-05-22 19:09:16', '2024-05-22 19:09:16', '2025-05-23 02:09:16'),
('7031bf5adc4c6c040214988ca1860cb01a2bb4cad9541b8088de1b67dcf59143e0faf54f352626ca', 33, 3, 'authToken', '[]', 0, '2024-04-29 11:04:51', '2024-04-29 11:04:51', '2025-04-29 18:04:51'),
('705f519c6604de041e226d201352c13580cacb7a9a3859ae88e9e635e9f8f2c67c498fcd7317fd71', 14, 3, 'authToken', '[]', 0, '2023-07-09 18:55:06', '2023-07-09 18:55:06', '2024-07-10 01:55:06'),
('7089e6751a1c295d935e3a900ab435e5aa3dc0bc2c3538dc8129cd673ea42c23e20266d9876cc272', 32, 3, 'authToken', '[]', 0, '2024-05-10 09:32:46', '2024-05-10 09:32:46', '2025-05-10 16:32:46'),
('711e2214e785af62742ac92d383dd4772ef6c197c22b44784cfeefefe8e429a502e42719241bacd6', 3, 1, 'authToken', '[]', 0, '2023-05-26 00:29:38', '2023-05-26 00:29:38', '2024-05-26 07:29:38'),
('717a857820d4a67fdd7077c361ff96190f68d069e6f4cee4fd947f0fbd1a1df145d4925b3f978a06', 14, 1, 'authToken', '[]', 0, '2023-07-03 21:00:29', '2023-07-03 21:00:29', '2024-07-04 04:00:29'),
('71d9af8135c261391c0798513d0b0f4ccb22874ea474f46d9ee04d151ba8cfdd6deccfd68ee099cd', 14, 3, 'authToken', '[]', 1, '2023-07-19 19:37:50', '2023-07-19 20:12:57', '2024-07-20 02:37:50'),
('72218832369dac66f243ace30887bbbf50f9920599c223a59d86a520587b6d294f959f25ebc38e8f', 2, 3, 'authToken', '[]', 0, '2024-05-23 21:28:36', '2024-05-23 21:28:36', '2025-05-24 04:28:36'),
('727a18ca724b1743107618d080bb54841dbe46e7433cfaf68e08a1861e62d225ac5eec986065a895', 2, 1, 'authToken', '[]', 0, '2023-05-22 18:21:53', '2023-05-22 18:21:53', '2024-05-23 01:21:53'),
('73493a6b72f43ca64308d84e655cd6b7b7a4c7dc36aa058d7f2016435b47b9bfc481a67b15e3bba5', 2, 1, 'authToken', '[]', 0, '2023-06-27 20:20:42', '2023-06-27 20:20:42', '2024-06-28 03:20:42'),
('751d364b06cd2d4c0c969aac700fcf5549e3d53b24ba03e206101e81834ce2cb359156adf670fc7b', 32, 3, 'authToken', '[]', 1, '2024-05-12 06:29:00', '2024-05-12 06:33:21', '2025-05-12 13:29:00'),
('75286a9f80d0533434c3e773b581f510d50d5e17369dcfb688aca39ea8e54828cb62694571501e2b', 2, 3, 'authToken', '[]', 1, '2024-05-12 01:33:23', '2024-05-12 01:33:32', '2025-05-12 08:33:23'),
('755e2200d3b89581b352ec6e020205028b0e785a6157495ab097748a825c8218936ce23beeb91d89', 14, 3, 'authToken', '[]', 0, '2023-07-10 05:52:43', '2023-07-10 05:52:43', '2024-07-10 12:52:43'),
('759562aa934461447902d5491ccaa303075a314f5dc833f56429f9346938cf85e3550bade3221cc7', 7, 3, 'authToken', '[]', 1, '2024-05-25 01:10:53', '2024-05-25 01:11:52', '2025-05-25 08:10:53'),
('75e2efe18f346cad07e0cb7130d9f5202363cc18cbb8b0c10ce425ea333aab9838d613e5e096a308', 5, 3, 'authToken', '[]', 1, '2024-05-22 00:51:36', '2024-05-22 00:55:27', '2025-05-22 07:51:36'),
('760c0b6c1e794b4de409bd21af447baee28d98a7fe914c8f13f61a72efa9430d9e15cfebe96cca9a', 33, 3, 'authToken', '[]', 1, '2024-05-09 19:22:37', '2024-05-09 21:43:20', '2025-05-10 02:22:37'),
('76244fb35b2036ec761ef30c2d8e9bd1bc977bfaf98aaaaf7e938a0f379b764b3f8454cb4f098e83', 37, 3, 'authToken', '[]', 1, '2024-05-25 07:37:13', '2024-05-25 08:08:24', '2025-05-25 14:37:13'),
('762b8f63c29a5f41b5e9e85dd642ab8056d31f05bd42a760ab576963bc72c4652675e36e40d8bb61', 6, 3, 'authToken', '[]', 1, '2024-01-15 02:09:05', '2024-01-15 02:24:33', '2025-01-15 09:09:05'),
('764eca8b52033326cf8fc5f47ac96ae088a105d4b3a729444c594db1d87365a055f36455d03d4baf', 2, 3, 'authToken', '[]', 0, '2024-05-12 00:16:46', '2024-05-12 00:16:46', '2025-05-12 07:16:46'),
('7660b43eb8bd7f13c4159fe3253bd934d8ed3dd4cb534aa110d8a29679a8dca4c031a5a07814070e', 3, 1, 'authToken', '[]', 0, '2023-05-23 23:22:47', '2023-05-23 23:22:47', '2024-05-24 06:22:47'),
('76a38b758dcad8d0952f90a8058bc1f1c9e80ca6f35d756cbd43889e72267a3ace8322ccda88f6e7', 2, 3, 'authToken', '[]', 1, '2024-05-22 21:09:13', '2024-05-22 21:12:19', '2025-05-23 04:09:13'),
('76d8de0e84f9035128bc2ba2151c2a407cbec9b15b46059912e105745a3398c98ebd45e893a1e8db', 7, 1, 'authToken', '[]', 0, '2023-07-02 19:40:23', '2023-07-02 19:40:23', '2024-07-03 02:40:23'),
('76f2791e91b2e82cac8f0e2253305ae63756631f60e6096f7af8c682adbbc0c908acd6a3f91e11bd', 4, 1, 'authToken', '[]', 0, '2023-06-06 00:29:33', '2023-06-06 00:29:33', '2024-06-06 07:29:33'),
('7715b19649de81c66d8708d4929f3ab3d60d1f6cfe8b712f25d682f37aa3ca77df91a50f015f416a', 2, 3, 'authToken', '[]', 0, '2024-05-11 23:01:38', '2024-05-11 23:01:38', '2025-05-12 06:01:38'),
('771e26279009267dae6a6637d3548a3408b033f8cddae5eea6bf8528fa6a8f9f0f5381be4a44089a', 14, 3, 'authToken', '[]', 1, '2023-07-07 21:56:22', '2023-07-09 18:52:01', '2024-07-08 04:56:22'),
('77319d0ebfd02a052f5183e291a6bb33bc6405b0c884f51b8fe03638b7e0fe58314d9d5ecf606860', 2, 1, 'authToken', '[]', 0, '2023-05-18 18:21:48', '2023-05-18 18:21:49', '2024-05-19 01:21:48'),
('77611ee3c2cf1728e667297293448ee8b806d9ae3147f944285db8c10eee43df1a887becfe518e73', 16, 3, 'authToken', '[]', 0, '2023-07-10 18:22:26', '2023-07-10 18:22:26', '2024-07-11 01:22:26'),
('783c6da6ac69e35986af117e5e65f9d46257fe6550384968bbb04171351fd0679908e67a99de91c6', 29, 3, 'MyApp', '[]', 0, '2023-07-17 23:39:58', '2023-07-17 23:39:58', '2024-07-18 06:39:58'),
('789f286556dade0fca7c6bca61b4f20eb016d52312648f78c6962dbdeb848c33b87ec487c6f9e5c4', 37, 3, 'authToken', '[]', 1, '2024-05-25 02:48:16', '2024-05-25 07:36:09', '2025-05-25 09:48:16'),
('78bbc2250384c5a64946fe3dbf0a761db755573f48a71f4256f1741410dbd543b3501523f4c9de1d', 32, 3, 'authToken', '[]', 1, '2024-05-12 01:33:39', '2024-05-12 03:21:14', '2025-05-12 08:33:39'),
('78ffe60ec5914b3d16f23ce42056fe44cb774ecfda2a5bed838829f7970f20326a0d0d58ddacf8c4', 33, 3, 'authToken', '[]', 0, '2024-05-04 04:05:41', '2024-05-04 04:05:41', '2025-05-04 11:05:41'),
('7943c24ea403e72ffca76055244818290523d7af7db540ffea14ce8ac9b997f9010b47e536aa4348', 2, 3, 'authToken', '[]', 0, '2023-07-16 03:13:33', '2023-07-16 03:13:33', '2024-07-16 10:13:33'),
('79e5c71acb8d02a069c85f7148571fc189b8484a69f601df8f49754f0c1908b3deb71a8b12892e55', 2, 1, 'authToken', '[]', 0, '2023-05-23 23:56:22', '2023-05-23 23:56:22', '2024-05-24 06:56:22'),
('79ecc98e6c1cb89319d7102c55f49bc235223eaf42cab3e8441c31d08b660e07b7ac9af157497988', 33, 3, 'authToken', '[]', 1, '2024-05-24 07:20:33', '2024-05-24 07:47:27', '2025-05-24 14:20:33'),
('7a0c8c1553caf92ff3131e9fe2f71b477d21dcfbb060de91fc09354f97b726c51925f141b7987b4a', 33, 3, 'authToken', '[]', 1, '2024-05-09 06:59:27', '2024-05-09 07:08:45', '2025-05-09 13:59:27'),
('7aeb5d858d3ed7cc1dd1118aab355f7fc033fbea22c2d078e8916fc3f28fc640153ea06bc84c94b3', 8, 1, 'authToken', '[]', 0, '2023-05-29 23:38:56', '2023-05-29 23:38:56', '2024-05-30 06:38:56'),
('7b818c8c0d903158ae9b5dbb8d2f725fb69964cb36d5311b18893c0ebf3e92225f7a35d5a6a1758f', 2, 3, 'authToken', '[]', 1, '2024-01-15 02:24:43', '2024-01-15 19:39:42', '2025-01-15 09:24:43'),
('7bca3de0174c95191e1f3ff5fccc50d2024f0e72c5d8084d625c6b77094611c5ff604c36c4196520', 2, 1, 'authToken', '[]', 0, '2023-05-22 06:46:36', '2023-05-22 06:46:37', '2024-05-22 13:46:36'),
('7ca346bfd8962ff18a83fd1a6d6273def86267608bfaa0663ff7a2532ebf9121daf08dae30f75305', 14, 3, 'authToken', '[]', 0, '2023-07-16 02:43:11', '2023-07-16 02:43:11', '2024-07-16 09:43:11'),
('7ced58722a7d821cf0932476fe1af93eea0083fab837c8565c6921d748695a5934f68ae2b9319f8e', 14, 3, 'authToken', '[]', 1, '2023-07-15 21:58:19', '2023-07-15 23:59:16', '2024-07-16 04:58:19'),
('7d1a9a5b883f21282f112df664b85910600b0a9e322fc8a907cfcf8b97c92c50fe61e6d7458b4d62', 8, 1, 'MyApp', '[]', 0, '2023-05-11 20:59:23', '2023-05-11 20:59:23', '2024-05-12 03:59:23'),
('7db51f2f4d05d79b2bd6e7fbdb2eeb0be4dca5607eaf77b36d26dea7943ae31e2438851a3a5156e2', 2, 3, 'authToken', '[]', 0, '2024-05-26 09:36:19', '2024-05-26 09:36:19', '2025-05-26 16:36:19'),
('7e00750e5c3c57823917e149971de712f5449f220948150349f3da48294cbf068b2f86bbf443d3ca', 14, 3, 'authToken', '[]', 1, '2023-07-18 02:22:10', '2023-07-18 02:41:44', '2024-07-18 09:22:10'),
('7e0f60b5a0bc6aa8daba20b8258a3451250126efdb9258cbdee8da330ccca6d06bd0e0c70ac4d30c', 14, 3, 'authToken', '[]', 1, '2023-07-16 01:52:27', '2023-07-16 02:23:06', '2024-07-16 08:52:27'),
('7e64fc8324d419291e3b810b3f99e4622b626bf9d329011c1156d6edae087a51181afdea07571a45', 9, 1, 'MyApp', '[]', 0, '2023-05-11 21:02:03', '2023-05-11 21:02:03', '2024-05-12 04:02:03'),
('7f5b6fabb66a5efe3ad658bc69a469614c90ada72af5b14117f8cbcd6eb916667ba1a1d62b0f40df', 7, 3, 'authToken', '[]', 0, '2024-05-25 02:15:55', '2024-05-25 02:15:55', '2025-05-25 09:15:55'),
('7fde6c2ed7d3a5555a80246e17450ce420ce74178173e5441a36abbdc40fe19991897325bd96974d', 3, 3, 'authToken', '[]', 1, '2023-07-17 06:04:07', '2023-07-17 06:15:12', '2024-07-17 13:04:07'),
('807e3a45aa2b908ab7a2525cae0de80b9fc8bee4fe655b37626a561f7cf6b2ad13d7ef765bc2acaf', 14, 3, 'authToken', '[]', 0, '2023-07-23 02:03:12', '2023-07-23 02:03:12', '2024-07-23 09:03:12'),
('80b8ca73dc606f8026311a3df1cf16330cbb48587889ed3862c7f18c53cd3f899992c2606530efb3', 33, 3, 'authToken', '[]', 0, '2024-05-13 21:34:51', '2024-05-13 21:34:51', '2025-05-14 04:34:51'),
('810cfaa25211eee617400bc97d81c39a5dc18e9f5fa247f31c635e18e63523d6ad0e58ebe359e380', 4, 1, 'authToken', '[]', 0, '2023-05-30 19:49:26', '2023-05-30 19:49:28', '2024-05-31 02:49:26'),
('81a0760849667347148f0b1be4f0628755b4e5b1ff31fee62312f6d2df8de6d359759a7bcb6166c8', 14, 3, 'authToken', '[]', 0, '2023-07-16 03:08:27', '2023-07-16 03:08:27', '2024-07-16 10:08:27'),
('81c4b65c4f77a7d0119eb1e97fe078c85581866ce8bcf66feea63cde91867eeb334fe9071f92753e', 3, 3, 'authToken', '[]', 1, '2024-05-24 01:27:35', '2024-05-24 01:28:33', '2025-05-24 08:27:35'),
('822d1970d5fc6e3a416607e847f31c0c3d9d31caefd8f19c6e5d6424ba95cab74017a5a05c0c00d6', 14, 1, 'authToken', '[]', 1, '2023-07-04 21:21:19', '2023-07-04 21:23:21', '2024-07-05 04:21:19'),
('82968cbf1483aa98b72fb6381c25badd66894f806dbbb4ce8e8d096668f40cffba5690368524e473', 33, 3, 'authToken', '[]', 0, '2024-05-24 06:58:56', '2024-05-24 06:58:56', '2025-05-24 13:58:56'),
('834c7b241cf671a31a8d5a8fbe0d716a5f4041d15be52234718d92ac8c6842298d4b88b357d6534a', 33, 3, 'authToken', '[]', 1, '2024-05-12 09:29:13', '2024-05-12 09:29:17', '2025-05-12 16:29:13'),
('83a9b8b2597d9d5c5ca111c285a8de7576f85dcd522af2c631b62d1fb8eb1193ccb20cf7b04bbe7e', 36, 3, 'MyApp', '[]', 0, '2024-05-12 00:19:58', '2024-05-12 00:19:58', '2025-05-12 07:19:58'),
('843abc1fdfe106691c42601a4373137d50e1e7e6f9a8db060be3992e0a05a89e14d35263b9765152', 2, 1, 'authToken', '[]', 0, '2023-05-12 20:34:54', '2023-05-12 20:34:55', '2024-05-13 03:34:54'),
('847be09869df2aaad4454fa246fdc8d891066eee05e3f796d6c4234100fa77c1b425778bda0d5346', 4, 3, 'authToken', '[]', 0, '2023-09-04 21:05:20', '2023-09-04 21:05:20', '2024-09-05 04:05:20'),
('8484856ff32c1f2307d162b3b00c769b932dbcba3fb579320cd4d14a5afa92dd09c779bf1cbc0572', 14, 3, 'authToken', '[]', 0, '2023-07-16 02:45:45', '2023-07-16 02:45:45', '2024-07-16 09:45:45'),
('858293a8dd2a11e9720a3fdb36fc018866289ddb8f01c39252469580be850ff22e0de1a9a7426d17', 33, 3, 'authToken', '[]', 1, '2024-05-25 02:01:13', '2024-05-25 02:01:55', '2025-05-25 09:01:13'),
('85a31df97b0d1498183a0a70a8d0db89c74f0b1b35f298a0a4d430c5a3d8883f9e19eb10b8c89620', 33, 3, 'authToken', '[]', 0, '2024-05-22 22:04:23', '2024-05-22 22:04:23', '2025-05-23 05:04:23'),
('85d97f027eb267e56ba6fd0c63a31309f9e99ed8dbf0b8c5b18083a32a27ba52b3b780df9839df58', 14, 3, 'authToken', '[]', 0, '2023-07-16 02:39:48', '2023-07-16 02:39:48', '2024-07-16 09:39:48'),
('85e6eda431a70a33f328d2cb58108600025cbe227c41a6f2522e589cb31eedce2fee02b8839675bd', 32, 3, 'authToken', '[]', 0, '2024-05-09 18:37:47', '2024-05-09 18:37:47', '2025-05-10 01:37:47'),
('85e77eb01239112326d3291996334b470d5b43950564690bb4904f6ef020df98cfddfd7dd0e974aa', 2, 3, 'authToken', '[]', 0, '2023-07-19 02:29:26', '2023-07-19 02:29:26', '2024-07-19 09:29:26'),
('86688abdcb489b82370fa1b827f1d63884d29423de65566df882422cb57a0e6971291a3409764956', 14, 3, 'authToken', '[]', 0, '2023-07-16 00:24:34', '2023-07-16 00:24:34', '2024-07-16 07:24:34'),
('867d1ecb10827514a69cdcb60527a153d629675605ae13fbfbad2eb6c8c3a9a60866af4a85dc1265', 14, 3, 'authToken', '[]', 1, '2023-07-16 02:45:22', '2023-07-16 02:45:40', '2024-07-16 09:45:22'),
('86e9cddef32d253a01bbbc215cb44108fafb15e4c6ec5eddf2f8465b8bdf80448b46afd61a2eb462', 33, 3, 'authToken', '[]', 0, '2024-05-06 00:54:25', '2024-05-06 00:54:25', '2025-05-06 07:54:25'),
('8705da9ea2c588104abf4388468600999997ba4c8297ca8b1dda7bbd783dd68355e342d4a169a784', 4, 1, 'authToken', '[]', 0, '2023-06-12 01:11:40', '2023-06-12 01:11:41', '2024-06-12 08:11:40'),
('8723878eb1d24b453cf479ef94f11e1dc64ed2227c91d0d19659a8d5d8f13a5637d6146c9eae01c3', 2, 3, 'authToken', '[]', 1, '2024-05-04 21:45:29', '2024-05-04 21:47:14', '2025-05-05 04:45:29'),
('885f247a5e1228d9f269c5d97fc035a3dd5093509d7be7bff85b64b01f174e3db8a3ac772871fdb7', 3, 3, 'authToken', '[]', 1, '2024-05-24 05:38:34', '2024-05-24 06:13:50', '2025-05-24 12:38:34'),
('888d2c750e07d24ae881695c3f5167f84aec63c2422646e983e91ca82c7041e040ef146cde1790e9', 33, 3, 'authToken', '[]', 1, '2024-05-09 19:21:32', '2024-05-09 19:21:40', '2025-05-10 02:21:32'),
('8924d1ef14dcd101fa6357916250e56db02f68059998464a1c1aa80bf8591d870057f8d4541fa40a', 33, 3, 'authToken', '[]', 0, '2024-05-03 08:20:51', '2024-05-03 08:20:51', '2025-05-03 15:20:51'),
('8a25119d1dab42c5a7997bed2c85cc30e30649262b4ec5eb6d84dd43fbb58dc640be35f03f92570f', 3, 1, 'authToken', '[]', 1, '2023-06-12 21:42:03', '2023-06-12 21:42:29', '2024-06-13 04:42:03'),
('8a9268ecc437f78b9aff3da04c163629c118c241fc4ac074af128e417b5d699469de0da0721a043e', 33, 3, 'authToken', '[]', 0, '2024-04-29 15:28:10', '2024-04-29 15:28:10', '2025-04-29 22:28:10'),
('8ad5137d9ae1b6049c582c784cca7404a3186efb4151649771a957eae3794bf058407770cf0456d1', 14, 3, 'authToken', '[]', 0, '2023-11-09 00:27:58', '2023-11-09 00:27:58', '2024-11-09 07:27:58'),
('8b1bc2bc8ffdbed6f5ace7847e40afcff9870cffde98cbea3bf27fbfb271e512dcb3c6356b4ecd09', 14, 3, 'authToken', '[]', 1, '2023-07-19 03:27:09', '2023-07-19 03:27:14', '2024-07-19 10:27:09'),
('8b3b95788cecc785a907662f21aa6bea6eb704399b43543b1aa1794abeeed97c7c76fb48343368e5', 2, 3, 'authToken', '[]', 1, '2024-05-09 19:21:50', '2024-05-09 19:22:26', '2025-05-10 02:21:50'),
('8b8779b5e5e91dea5c00f44659b727764d2d203c15278c6ea054ab008dd0061967bd332b207ac0b1', 2, 3, 'authToken', '[]', 0, '2024-05-01 20:30:48', '2024-05-01 20:30:48', '2025-05-02 03:30:48'),
('8bd0c8d26f8034a51e08e985923c2bfb1e57615f55098cdf0272ed3efa6e8660c8baf5c04228766a', 33, 3, 'authToken', '[]', 0, '2024-05-25 07:58:12', '2024-05-25 07:58:12', '2025-05-25 14:58:12'),
('8c54acec5e9b9b3bac3ac604dd902732a19645febc43aa4d5686dbbe9818695ad04b3a49b45fa9da', 4, 1, 'authToken', '[]', 0, '2023-06-13 00:22:51', '2023-06-13 00:22:51', '2024-06-13 07:22:51'),
('8c74294c82fc79645a241d5b1e5fa4ddd343ad68633d0c7bff6ac72b60ba37c9328540d1a6cd643e', 32, 3, 'authToken', '[]', 0, '2024-05-14 17:54:07', '2024-05-14 17:54:07', '2025-05-15 00:54:07'),
('8cc6b2c47e0cdad247f69a8aa1c289817081562c04bb4ad036068c3ade6b2f7cee7cea7c5611d4a7', 17, 3, 'authToken', '[]', 1, '2023-07-17 06:15:22', '2023-07-17 06:19:27', '2024-07-17 13:15:22'),
('8db71918b6b78f719247b1a44a98ac50c80929e3b7640552cea2436f95e9b30daee9aaf71d6855fe', 33, 3, 'authToken', '[]', 0, '2024-05-12 21:36:01', '2024-05-12 21:36:01', '2025-05-13 04:36:01'),
('8de3d8c3f2c12778111fdcfe7a6d8b792a4680e4a696b17a71846051668129dc81b8542cca3bc126', 3, 1, 'authToken', '[]', 0, '2023-05-24 00:31:22', '2023-05-24 00:31:22', '2024-05-24 07:31:22'),
('8e6f12924c4059b336021ab7b59a3865118db0221a328fb097e6c9e64bdd0a478a70cdce151ff0c7', 3, 1, 'authToken', '[]', 0, '2023-05-29 21:34:49', '2023-05-29 21:34:49', '2024-05-30 04:34:49'),
('8edb1f823529da703acac9e0f15b949a452d558e3ec1971876f8a353eadc9f8ebcbdd62f44eb4e33', 33, 3, 'authToken', '[]', 1, '2024-05-05 20:45:36', '2024-05-05 21:14:58', '2025-05-06 03:45:36'),
('8f0a0ebb0549e387029be3075bc295208708a8e570816c08a44197959a63bef0adeb5a95c6a33b53', 17, 3, 'authToken', '[]', 1, '2023-07-10 02:13:37', '2023-07-10 02:35:37', '2024-07-10 09:13:37'),
('8fb16073783a2bccddcb18d6ba056cf522a97f8484116db8928221ab33ffe67d9637462a012d636d', 2, 3, 'authToken', '[]', 1, '2024-05-10 00:39:56', '2024-05-10 00:41:15', '2025-05-10 07:39:56'),
('90a3f4bb5e8dd578d9356a4ff010a940dd54501074ffcf2082d30f366969b3d30e8a63c56aaca51a', 14, 3, 'authToken', '[]', 1, '2023-07-18 21:48:01', '2023-07-18 21:49:27', '2024-07-19 04:48:01'),
('91f333cb65adcce91ac4ec472bd317ab9ddc28c6f1a241505e228d4e545c032689f9f0041b497ad3', 3, 3, 'authToken', '[]', 1, '2024-05-25 02:00:40', '2024-05-25 02:01:07', '2025-05-25 09:00:40'),
('9276d6f67cbdaa8d838a0928f0b2996e3d97174d90eb96d7e5d9fc414ad394b25120d0693da45113', 2, 3, 'authToken', '[]', 0, '2023-08-20 19:45:08', '2023-08-20 19:45:09', '2024-08-21 02:45:08'),
('929571878a0709366ef91fbdb39b0f130530d653aa393619812fdd24da7944d3a44e71159bd37334', 19, 1, 'MyApp', '[]', 0, '2023-07-03 05:46:30', '2023-07-03 05:46:31', '2024-07-03 12:46:30'),
('92b7c66a90a5fefbc2c579cf08c6bd20e41ec5084eca51b9ea1eef60f5abef3d6b5584cc7d1cf3db', 2, 3, 'authToken', '[]', 1, '2024-05-02 21:39:45', '2024-05-02 21:40:44', '2025-05-03 04:39:45'),
('93bfde04d4793804838cecb910b5108f63d3428ad6a7df6b7987cbae4f82a7260d67ca0035eebb00', 33, 3, 'authToken', '[]', 1, '2024-05-07 18:45:22', '2024-05-07 18:54:34', '2025-05-08 01:45:22'),
('968bfcb28e4e2c6b4b165fdd8014290affcfb39608f01e936e5f293b887a4b5e88c8e80252774e19', 14, 3, 'authToken', '[]', 0, '2023-07-16 00:34:21', '2023-07-16 00:34:21', '2024-07-16 07:34:21'),
('96ad2e2a8499c8b67d577a273ebb6c24bb65f9fda3e62d94ef06e5fedd678d63e4e91da90c84cf3c', 32, 3, 'authToken', '[]', 1, '2024-05-22 01:37:30', '2024-05-22 01:52:32', '2025-05-22 08:37:30'),
('96bb5987698078fbeeafc6fd3daa2a70a7c6cb318a5b1738cacb2d18fcf224fa99b03368a930e27a', 4, 3, 'authToken', '[]', 1, '2023-07-16 18:39:22', '2023-07-16 19:20:36', '2024-07-17 01:39:22'),
('96ce40b4c617c9390414e4f7fa7d38c432a1126683bebb4ab02ea3eb06e7169fef59499466797f1f', 4, 3, 'authToken', '[]', 1, '2024-01-15 02:02:33', '2024-01-15 02:02:55', '2025-01-15 09:02:33'),
('971e6df3fd2f6422d94786b0f96cc0e0999674be623a56ea4c16f729aa8b893a88a173b5de617c1b', 4, 1, 'authToken', '[]', 0, '2023-06-13 00:47:18', '2023-06-13 00:47:18', '2024-06-13 07:47:18'),
('97407ca227b788bacf2699e23af87255865c0a7563c7b362a6b436e0d4914b44ce8d59f693ebd230', 33, 3, 'authToken', '[]', 1, '2024-05-13 01:30:26', '2024-05-13 01:30:37', '2025-05-13 08:30:26'),
('9844837f434baf921f7d941ab1a8212c7f1195062e6d2d8a130d761b1254f18de6aea5f84c274ae2', 33, 3, 'authToken', '[]', 1, '2024-05-22 00:33:43', '2024-05-22 00:37:21', '2025-05-22 07:33:43'),
('98cc7b2cbf3a2581de2134bb963ba294095de93745f492c86a7beb588e6a37e8f800de9100bf6ec4', 3, 3, 'authToken', '[]', 1, '2024-05-25 00:18:53', '2024-05-25 00:19:45', '2025-05-25 07:18:53'),
('98e39a7edde80acab9894f301fa41dce7887d753e9ead4f0c7526517ffcdf51a2856586f12aba043', 2, 3, 'authToken', '[]', 1, '2023-07-16 20:08:22', '2023-07-16 20:12:00', '2024-07-17 03:08:22'),
('998130c11313e4c5b6446b4b4fe29e87a3d69a9dda6d6e2982eab76e986ef4da8e48b639a4ec5739', 2, 3, 'authToken', '[]', 0, '2023-07-17 21:05:37', '2023-07-17 21:05:37', '2024-07-18 04:05:37'),
('99e4cdc543f13225f39b708f62f51c901568729ed1c39250077f979436d86baa5da279bd2c32ab09', 33, 3, 'authToken', '[]', 0, '2024-04-30 05:51:06', '2024-04-30 05:51:06', '2025-04-30 12:51:06'),
('9af58868f8ffd8c27ea15ea5a18e0f08705ecae06ca8a36631cd62e5a36cd9d31d5757a24f567913', 2, 3, 'authToken', '[]', 1, '2024-05-10 00:27:53', '2024-05-10 00:28:12', '2025-05-10 07:27:53'),
('9b11e406c22f2043118cfc2e95aa0a634f2e9f309e1937a65b7d04ac243ddcb767235e75b59ae646', 2, 3, 'MyApp', '[]', 0, '2024-04-29 01:59:12', '2024-04-29 01:59:12', '2025-04-29 08:59:12'),
('9b4534391d08e10162e92fdaa0bdd8c3cb631c606e67565d5a733d977d721902e1332066b8e87f7e', 2, 1, 'authToken', '[]', 0, '2023-05-21 23:55:10', '2023-05-21 23:55:10', '2024-05-22 06:55:10'),
('9bf9394af8f35a3fe3643bf52ffc93ac612f4f3a7ddd703a14d60e5cc0414c96e7fc4f2b09eefef7', 2, 1, 'authToken', '[]', 0, '2023-05-11 20:57:21', '2023-05-11 20:57:21', '2024-05-12 03:57:21'),
('9c229d9fb8e5a6dbbaf2f2a39fd70bd99b27c4126d817966853bdd19e961c1168a35ce015ab2ba71', 14, 3, 'authToken', '[]', 0, '2023-07-19 06:52:39', '2023-07-19 06:52:39', '2024-07-19 13:52:39'),
('9c506d558a3cf6d414f9e0eab1dfd3391a5889058fa7889a5ef5564c860a52fbcb38a06a02220572', 2, 3, 'authToken', '[]', 0, '2023-07-19 02:43:19', '2023-07-19 02:43:19', '2024-07-19 09:43:19'),
('9d75ef226ef0b212a9d78dab35b003e26f70f08e17f6ea1d36b332fd1ac36b316d437dbbf0125205', 33, 3, 'authToken', '[]', 1, '2024-05-05 21:40:01', '2024-05-06 00:52:19', '2025-05-06 04:40:01'),
('9db4349001f73b9af2fba870f0ccf599734401489c3841f95c2c058b6fdf0365891911de219c9239', 5, 1, 'authToken', '[]', 0, '2023-05-23 00:14:18', '2023-05-23 00:14:18', '2024-05-23 07:14:18'),
('9dde5ee59da57ae15e923b8b3e02f869e037f39447b59aee868b2d3c9166f5503bbeeb716ba60a9d', 33, 3, 'authToken', '[]', 1, '2024-05-24 06:57:20', '2024-05-24 06:58:36', '2025-05-24 13:57:20'),
('9e53f7208776f9ada81e74edbeb8496ece3f728785b7939e41adf945b90d76209d4fa51f030f5ada', 7, 3, 'authToken', '[]', 0, '2023-07-05 18:54:14', '2023-07-05 18:54:14', '2024-07-06 01:54:14'),
('9ebdf2cd2804f152f7fe38bcced13225ccb73e451cc1166a2379dc85f592fd322fa4e105d623fb9c', 17, 3, 'authToken', '[]', 1, '2023-08-20 19:47:20', '2023-08-20 19:52:01', '2024-08-21 02:47:20'),
('9f059eaa659322f0cb2bb1e592cf78be5096532b46904da73c92a95df6ed86d8b66f1cbbe0be33e3', 32, 3, 'authToken', '[]', 1, '2024-05-21 23:54:06', '2024-05-22 00:31:15', '2025-05-22 06:54:06'),
('9f254ccdf6cf005cbadf7d15cf8b1cdfc23d6009963d8163407216fa18ec5192c5f07def8ac331b9', 14, 3, 'authToken', '[]', 1, '2023-07-04 21:44:29', '2023-07-04 21:48:39', '2024-07-05 04:44:29'),
('9fc395da0f7c7f3c9976f8ac99c521193f2739d7b8e19e156e147e43a844bd6a35a7d8f947abad2a', 2, 3, 'authToken', '[]', 1, '2023-07-16 20:12:05', '2023-07-16 21:37:46', '2024-07-17 03:12:05'),
('9fee8a36d92cf668cc7f7dd511716b972599f92bd9f9d714ee6266e0a8a5922fc1cc1c2e41b364d5', 32, 3, 'authToken', '[]', 1, '2024-05-10 09:14:28', '2024-05-10 12:04:41', '2025-05-10 16:14:28'),
('a005acb76df1bf7c550dd33cc0ea46019c331583513577a7eefd4dfa312f39d3eb18b6c730f1404b', 33, 3, 'authToken', '[]', 1, '2024-04-29 10:40:18', '2024-04-29 10:40:23', '2025-04-29 17:40:18'),
('a041e312f9312dbde630538575dd27d4c8057fa62146fb39aaed0ad7ba8d2ea8cd4d98cb6323089d', 3, 1, 'authToken', '[]', 1, '2023-05-23 23:48:39', '2023-05-24 00:22:41', '2024-05-24 06:48:39'),
('a0556bdf2a51d5109ee77eb86e0e246e78979a05254b8ef02ec9b1f15b58f26c093e6204d157d8b5', 3, 1, 'authToken', '[]', 1, '2023-05-23 19:47:53', '2023-05-23 19:48:18', '2024-05-24 02:47:53'),
('a0a12d5f94265f257d685afa8566990d911d9141181aa584d714f2f1e86f58927c83b41c5d207b13', 33, 3, 'authToken', '[]', 1, '2024-05-24 06:34:21', '2024-05-24 06:34:45', '2025-05-24 13:34:21'),
('a0b1c303d4a3242440b85055b05e5d423ed996571f6576718d51a27b07f1eebf8d52047876eee6d9', 4, 3, 'authToken', '[]', 0, '2023-07-15 23:59:56', '2023-07-15 23:59:56', '2024-07-16 06:59:56'),
('a0be049bc47f53a26392d6640e4a487d49edfba7a7c7513c9c790d27e7a4bc965de5584f3c90fbeb', 33, 3, 'authToken', '[]', 0, '2024-05-24 00:30:55', '2024-05-24 00:30:55', '2025-05-24 07:30:55'),
('a120049f8d938963dc2ddd01ae8dc645b3a9cc5e341288a85ceb814df6ef725cac6a15fac749be43', 4, 1, 'authToken', '[]', 0, '2023-06-07 06:35:27', '2023-06-07 06:35:27', '2024-06-07 13:35:27'),
('a1331ed037388ad2a600c720d30f6e3c63b05f7b67c23f61da0a7527d457b951cb58d51f7209f621', 33, 3, 'authToken', '[]', 1, '2024-05-22 22:05:28', '2024-05-23 00:03:53', '2025-05-23 05:05:28'),
('a1f692491ba9c3cf91461627cb63f0589ec7913204b40ae9832ad835f317d78e4c4e6d6d4f848f5d', 2, 1, 'authToken', '[]', 1, '2023-06-13 20:18:57', '2023-06-13 20:25:19', '2024-06-14 03:18:57'),
('a26119058a342a9573d9a0c19b50a31bc491f860c9108dc64e6b0337a3cf1f55c666a3b3cd3329df', 3, 3, 'authToken', '[]', 0, '2024-05-23 20:39:37', '2024-05-23 20:39:37', '2025-05-24 03:39:37'),
('a3171726e5da08ff17a918b9338047f6b3ecb2f3fbc589ea1f68fa07f19c959446fd369fc101ae9c', 14, 3, 'authToken', '[]', 0, '2023-07-16 03:09:59', '2023-07-16 03:09:59', '2024-07-16 10:09:59'),
('a31e457e2e7cbb8011cfbc46d1b7710f5200c342b5696f3f875b5542304196e9ac092ca5af8ec83c', 3, 3, 'authToken', '[]', 1, '2024-05-23 21:11:44', '2024-05-23 21:23:49', '2025-05-24 04:11:44'),
('a326c926151548c111d18a7cfcbb78617e4dac5a9c5cc97f99fba22a7c36bd0fc5e2e9366e612514', 32, 3, 'authToken', '[]', 1, '2024-05-23 21:25:18', '2024-05-23 21:25:41', '2025-05-24 04:25:18'),
('a36d748026deae4c470e0d48567c7176f22cbc6f226d672f6db4e94098d1647609c3efd7868fe4c4', 33, 3, 'authToken', '[]', 0, '2024-04-30 06:09:41', '2024-04-30 06:09:41', '2025-04-30 13:09:41'),
('a5033810ffea5fe7c52da2f9de47d59e918dc0a8115b7a1328ecb333e38882b928e5092aa3245e05', 33, 3, 'authToken', '[]', 1, '2024-05-24 00:16:01', '2024-05-24 01:00:35', '2025-05-24 07:16:01'),
('a5045ddcf4c74fffa38ce6764a02237ccd3ff08c238ae5775fb5c65e7eba55911aed79069d82ec5c', 6, 3, 'authToken', '[]', 1, '2023-07-23 02:55:00', '2023-07-23 03:28:25', '2024-07-23 09:55:00'),
('a50801c79c7bb4770aeb19c73a75efbcbac7c0494d6477fc3f45260c3b9bb6ba0ac16400569dca4f', 14, 3, 'authToken', '[]', 1, '2023-07-16 02:44:09', '2023-07-16 02:45:00', '2024-07-16 09:44:09'),
('a562c4e6ccc0efa55395cfc41f732f1625a8dd0adc324445affce59ade45de05a3be2dc77f11865e', 33, 3, 'authToken', '[]', 0, '2024-05-23 05:56:22', '2024-05-23 05:56:22', '2025-05-23 12:56:22'),
('a5cbf67f5f95085d06980dae789335785d88a4c16092209dee5b75b05babcb92deb7ff364a914b0d', 33, 3, 'authToken', '[]', 1, '2024-05-24 07:48:36', '2024-05-25 00:18:44', '2025-05-24 14:48:36'),
('a65a19f0ed2494c8137fe455a4979ca749e896548bd87659f479f22feec9b69981edd9790877d8ee', 32, 3, 'authToken', '[]', 1, '2024-05-13 06:25:01', '2024-05-13 06:25:35', '2025-05-13 13:25:01'),
('a66e2d2e76a25b2981938cac3853a6834491b3b1fd88f840c0a1859b92e0b23578f700d9b701d74c', 4, 3, 'authToken', '[]', 0, '2024-01-17 12:35:30', '2024-01-17 12:35:30', '2025-01-17 19:35:30'),
('a6907469683407affc18b02021e2cb1bd421ef8956c023538efcfece3d26ad55b1e9c4e8dea67190', 33, 3, 'authToken', '[]', 1, '2024-05-23 07:45:20', '2024-05-23 18:33:11', '2025-05-23 14:45:20'),
('a6dda56b16d512e4f9ee797999680a69ed15363caa832c5fa41be33c9e39d14aa51c41095fd2b150', 14, 3, 'authToken', '[]', 0, '2023-07-09 21:11:04', '2023-07-09 21:11:04', '2024-07-10 04:11:04'),
('a6ea33205555f2d7ec0f6af5af1c3827ace415bc2b24ba90e095141f05b6080e54d64a7a47228ff8', 14, 3, 'authToken', '[]', 0, '2023-07-06 05:40:58', '2023-07-06 05:40:59', '2024-07-06 12:40:58'),
('a7c62dbbe947e53e4278bf0174a4f0d37709273a2debee82c013099ba6713392e643d69b436c5119', 5, 1, 'authToken', '[]', 0, '2023-05-22 00:19:46', '2023-05-22 00:19:46', '2024-05-22 07:19:46'),
('a8c874248ac57ed607b3e1f57d97fc001c63bbf7e5087d8ac8c4ffa31ac06372ad2a48b604f95465', 33, 3, 'authToken', '[]', 0, '2024-05-04 06:09:21', '2024-05-04 06:09:21', '2025-05-04 13:09:21'),
('a94bbe908625d4407f1652936f69c5329d33bfb3ca899809132c1e6da6c5285e193152d21a9f4af3', 14, 3, 'authToken', '[]', 1, '2023-07-19 03:26:37', '2023-07-19 03:26:45', '2024-07-19 10:26:37'),
('a9755a8dd471cf610ecaa845d67299669f151186ffcd13d2392821b4c4e221082ffd40b79189db77', 2, 3, 'authToken', '[]', 1, '2024-05-11 21:30:32', '2024-05-11 21:33:03', '2025-05-12 04:30:32'),
('a9eb16719ae61f8704fbed04d9edca429ef7c4e792f2c90f0e64c9e44cd58d09fb4cd3bf5e6d22b5', 34, 3, 'authToken', '[]', 1, '2024-05-25 02:37:35', '2024-05-25 02:39:42', '2025-05-25 09:37:35'),
('aac8e57c3686c576b3ad006b9ec9eaf4497e5815985da1943dd701f83b6e487c57d6746c1b427068', 21, 3, 'MyApp', '[]', 0, '2023-07-17 20:41:11', '2023-07-17 20:41:11', '2024-07-18 03:41:11'),
('aaef89eecbb436ca8fd83f8e40f1ae511cca4c495252db7386b90fe4bb0399c10f319b2e6dafb700', 4, 1, 'authToken', '[]', 1, '2023-06-06 18:45:06', '2023-06-07 06:34:54', '2024-06-07 01:45:06'),
('ab129d8904a3169b6b281ceaca91ce72fc7477ce2364b337a83d4027616f202db78482403e1556d4', 32, 3, 'authToken', '[]', 0, '2024-05-14 05:56:41', '2024-05-14 05:56:41', '2025-05-14 12:56:41'),
('abb943051d2d3209fb8135a532255c40372433d29559663620dd1d6d921f7d98c4fad7f909077809', 3, 3, 'authToken', '[]', 1, '2024-05-22 00:39:19', '2024-05-22 00:40:51', '2025-05-22 07:39:19'),
('ac4a4a40fee5bf3e26517cf7b63e15db2979d747a3b3161e8a7b7264a2ab4611d7b662945dc8fff9', 4, 1, 'authToken', '[]', 1, '2023-06-20 01:43:37', '2023-06-20 01:47:47', '2024-06-20 08:43:37'),
('ac87fdbd77bfb70ca4d20a48dc504f06678d46693707f30b78c6b35fc2755735641e5ac20042a8a2', 14, 3, 'authToken', '[]', 0, '2023-07-12 19:49:14', '2023-07-12 19:49:14', '2024-07-13 02:49:14'),
('acb31dfb15b7ae28d7cba83067a960e9d5b5b676a7afcba15c2256e79928bc20dcc8d82ceba23ee6', 3, 1, 'authToken', '[]', 0, '2023-05-23 00:18:49', '2023-05-23 00:18:49', '2024-05-23 07:18:49'),
('acbdf86e73d0fbc2b27cd6e24422d79273a1ce1294092047959e02f4aaf88595e0da7e5964ebac1b', 2, 1, 'authToken', '[]', 0, '2023-05-18 18:13:07', '2023-05-18 18:13:07', '2024-05-19 01:13:07'),
('ad27911376564c1ef5ab4525f2c8b47d99ba4b1cabe3fe0dd950d7e8d7335bcaf84b17cc4d14716c', 14, 3, 'authToken', '[]', 0, '2023-07-15 01:38:15', '2023-07-15 01:38:15', '2024-07-15 08:38:15'),
('adb0c4980e8503ce75cc965b4eb125b07949468be653095835f5d116cc133f15156ee6837a18c3c9', 15, 1, 'authToken', '[]', 1, '2023-06-20 01:30:00', '2023-06-20 01:30:15', '2024-06-20 08:30:00'),
('ade38ce8ede804f041959ef7a907a9a70eb0423c4d7b3ce2f99170368ceb12ce5bd0a4987ecc2323', 4, 1, 'authToken', '[]', 0, '2023-06-13 00:00:43', '2023-06-13 00:00:43', '2024-06-13 07:00:43'),
('aee6ca6a2acfe2a5d83eda0acaed74260762eb22b146836649ab4b92f862417650b64847a579ce97', 3, 3, 'authToken', '[]', 1, '2023-07-16 18:07:46', '2023-07-16 18:16:50', '2024-07-17 01:07:46'),
('af7a8d913ed0ca5a16144ff71a09e35d2215cd7cdafe8ed93073ee4670bc2d8d4b981f23012f333e', 33, 3, 'authToken', '[]', 1, '2024-05-21 23:53:48', '2024-05-21 23:53:55', '2025-05-22 06:53:48'),
('b05613498e36155bced351274603080e72877e0873e72c05623b49bed7131eef0e3c2ff15a7dc2e5', 33, 3, 'authToken', '[]', 1, '2024-05-25 02:05:21', '2024-05-25 02:05:45', '2025-05-25 09:05:21'),
('b1dcb465f7be71f7feea859e1152390f0296c9df331c8d081ddc27427e5380d463a02af11128eb3c', 33, 3, 'authToken', '[]', 1, '2024-05-25 07:36:32', '2024-05-25 07:37:07', '2025-05-25 14:36:32'),
('b1ddf019132f166669da204df5650dee9d9afc87133db3bbdd99d85777606828ad3bb967d67b368a', 3, 1, 'authToken', '[]', 1, '2023-05-25 21:23:30', '2023-05-25 21:37:03', '2024-05-26 04:23:30'),
('b3190eb075b1f0421e8c8b2746f21bbef30849b939769e289c8c5d016220830c0475f93fb7145d1e', 33, 3, 'authToken', '[]', 0, '2024-05-05 21:15:08', '2024-05-05 21:15:08', '2025-05-06 04:15:08'),
('b43578bacb4c0b5492b8ddda46385956e7ad9b1891796990bd5ac372092f914d68b07020e559f53a', 2, 1, 'authToken', '[]', 1, '2023-06-13 20:28:56', '2023-06-13 20:32:16', '2024-06-14 03:28:56'),
('b4358a297d560591ed6422060dbda57213eb639029dc172fc44cd737fe3addbec10b6c624ca27177', 2, 3, 'authToken', '[]', 1, '2024-05-05 20:10:22', '2024-05-05 20:12:14', '2025-05-06 03:10:22'),
('b48c0356317d1182b789575cadad3d363e833687133f5d48a7550742f5f764836d0536ab16d16c1e', 2, 3, 'authToken', '[]', 1, '2023-07-17 06:41:50', '2023-07-17 06:53:11', '2024-07-17 13:41:50'),
('b53b80ae25618eee6a816f72c2c4b7d93aab39ecb3e8c8a1e41992dd5d84afa6fe9f81cd4efea0a6', 14, 1, 'authToken', '[]', 0, '2023-07-03 06:45:20', '2023-07-03 06:45:20', '2024-07-03 13:45:20'),
('b5ab76b705a94c79640356ff1096a908fd14c2e968ec0a2e706dca4276287b99008ae1045aee6301', 17, 1, 'authToken', '[]', 0, '2023-05-29 23:21:42', '2023-05-29 23:21:43', '2024-05-30 06:21:42'),
('b610d382f24e647da94a67f341da1f9cd09e11504ee18ccdf8300835c501c774934386f7b102cc1b', 23, 3, 'MyApp', '[]', 0, '2023-07-17 23:32:31', '2023-07-17 23:32:31', '2024-07-18 06:32:31'),
('b63148f13c268ff92f5fbb99d10682797b58039fbc3fae8d175b6e2f2022ed3e63e66a6e0b2ee484', 2, 3, 'authToken', '[]', 0, '2023-07-17 21:23:50', '2023-07-17 21:23:50', '2024-07-18 04:23:50'),
('b660ced1f4120b4e112a904759f3ecb5e9da92dc3753ec0f78a698434efd68d60706ce9ed5a4d50b', 33, 3, 'authToken', '[]', 0, '2024-05-23 00:37:49', '2024-05-23 00:37:49', '2025-05-23 07:37:49'),
('b6ff0483b7bcb4108960db74726fae6c98664a1a4ce53b84728402f1a7a320afeb277ab535113d83', 6, 3, 'authToken', '[]', 1, '2023-07-20 01:50:39', '2023-07-20 01:55:37', '2024-07-20 08:50:39'),
('b7bc74ec5edd197bf5a4b53a5ec9c4993772491afd8995ab8b1a8803456014a0b439bb73c76e1af0', 3, 3, 'authToken', '[]', 1, '2024-05-24 06:56:54', '2024-05-24 06:57:13', '2025-05-24 13:56:54'),
('b80d97846ed39a471459dcf0e67fc87067a260f2a5800eac7ad4e9c8802a0cae109ed129a3062944', 11, 1, 'MyApp', '[]', 0, '2023-05-12 21:52:11', '2023-05-12 21:52:11', '2024-05-13 04:52:11'),
('b95c04aca8fa56d15cd5fc9c5a73e3f1496fd737f94244fc5ea8491818720577e48595aa9b143cb6', 33, 3, 'authToken', '[]', 0, '2024-05-22 01:52:37', '2024-05-22 01:52:37', '2025-05-22 08:52:37'),
('b993183b4efe6519262990af1d0497732e9f837ea564d4891fbf08214a43a7f7a2004a7328738a14', 33, 3, 'authToken', '[]', 0, '2024-05-22 08:17:03', '2024-05-22 08:17:03', '2025-05-22 15:17:03'),
('ba647a1f24028460120b3f90fc5527cb649e2662f92fd7716bc14d4c2eafc74a6296c7b7c76c9abc', 14, 3, 'authToken', '[]', 1, '2023-07-09 19:02:28', '2023-07-09 19:02:40', '2024-07-10 02:02:28'),
('ba84c27cc8022c217e2dfdbb4bdf627fb029362d6a6b61f65adeb4d256e25371e7de43dfed29c66f', 3, 3, 'authToken', '[]', 0, '2024-05-23 19:13:13', '2024-05-23 19:13:13', '2025-05-24 02:13:13'),
('baa2063e683be65c656003ac11ddd948242e012e757e24f6a981e62ea11665c85f30e932cfd76c21', 6, 1, 'authToken', '[]', 0, '2023-05-22 22:59:52', '2023-05-22 22:59:52', '2024-05-23 05:59:52'),
('bad3bd7e171e87ff1d8fff5d43eccc7a5bd412981b1277aacdddd3e4a1d0f0380979c71c3178bd27', 32, 3, 'authToken', '[]', 1, '2024-04-29 02:43:08', '2024-04-29 02:43:26', '2025-04-29 09:43:08'),
('bb24fc744bdcd5301eef6021baebfd5e02b4e80474179c7b0f764ee6924e1c90a06f494138f1c0db', 3, 3, 'authToken', '[]', 1, '2024-05-23 23:09:53', '2024-05-23 23:15:40', '2025-05-24 06:09:53'),
('bb710264cde5af177514957c541a8331ea48a9f218da1c9dde7c6df913deebfbf3f5ee99a3250723', 16, 1, 'MyApp', '[]', 0, '2023-05-23 20:31:23', '2023-05-23 20:31:23', '2024-05-24 03:31:23'),
('bb739b07e9b9ce33203cd1968713af290d3fc4b41bdb3b800b2d0db0b3581bb9d82dfd7b7f4c6f0d', 2, 1, 'authToken', '[]', 0, '2023-05-16 21:14:38', '2023-05-16 21:14:39', '2024-05-17 04:14:38'),
('bbb1b242e80ed3509d2287a876b11dc83b96a696ee4054b46970f966e23b661427fe81141903f84f', 32, 3, 'authToken', '[]', 1, '2024-05-11 21:13:52', '2024-05-11 21:30:23', '2025-05-12 04:13:52'),
('bc72daf6542a3fefad56ef8b5bc8f22b3d0338d552f6ea030c1031f85ded1bbf9ace504d8092330b', 14, 1, 'authToken', '[]', 1, '2023-06-27 19:41:59', '2023-06-27 20:20:29', '2024-06-28 02:41:59'),
('bc8ecc2034c04319654697f55159756a8f60e2b22472c47daf67600fd064baa3ee404dabca13d982', 8, 3, 'authToken', '[]', 0, '2023-07-12 19:22:45', '2023-07-12 19:22:45', '2024-07-13 02:22:45'),
('bccc49b631a0a1671c85f9fdf1ee3d4cbc785f7498a24d8e5359a308a71785f070f2dee461e23f2d', 7, 3, 'authToken', '[]', 1, '2023-07-17 06:19:45', '2023-07-17 06:19:58', '2024-07-17 13:19:45'),
('bd889b4d47f76a0791134ca27c36909abc8ec9cd0606283f277d1eecf3936e37e382568b1f23988b', 5, 3, 'authToken', '[]', 0, '2023-08-14 02:29:58', '2023-08-14 02:29:59', '2024-08-14 09:29:58'),
('bd93c32ed25e4b4b36dc4dc56cc2eada882b908da87db29dfc4a8b21505ca2b35a40a6c5aeb577e7', 35, 3, 'authToken', '[]', 1, '2024-05-12 03:21:42', '2024-05-12 03:22:04', '2025-05-12 10:21:42'),
('bdc1aebb5c335f43380c28b8459f30256dd9b03e4d6c77693825455ef2a2f3532780eebf2a0157ba', 2, 1, 'authToken', '[]', 1, '2023-05-23 19:48:25', '2023-05-23 22:07:44', '2024-05-24 02:48:25'),
('be3cd4cda2a1e2be85df0ae8ff3ae251e5ea8f5784e49fdb5e4d0e0e27d705e275226fa66bb6b3f6', 14, 1, 'authToken', '[]', 0, '2023-07-04 21:19:57', '2023-07-04 21:19:57', '2024-07-05 04:19:57'),
('bec2aac2efae926e20d68ddaad0f1117fe59429e49ef4e6dc91a047565008df5b5d8901549313eb7', 3, 1, 'authToken', '[]', 1, '2023-05-29 20:09:11', '2023-05-29 23:21:24', '2024-05-30 03:09:11'),
('bee0f6dfe45cfd3a1508606453259fc3dba5f049252735fa4e0a478d02e697b3aafc0d7950c85533', 3, 3, 'authToken', '[]', 1, '2023-07-16 09:32:41', '2023-07-16 10:02:13', '2024-07-16 16:32:41'),
('bf223fc36c2d69e90018c4897c22c0aaa1a9359649eb9902885252ffce79ddd45fa06b4abcedd760', 33, 3, 'authToken', '[]', 0, '2024-05-05 03:01:46', '2024-05-05 03:01:46', '2025-05-05 10:01:46'),
('bfc6b1ad1e866969d5628b3d5246f2dc5050d4af83355826ee6eefa0cd4ea293da851a91992e8fea', 2, 3, 'authToken', '[]', 1, '2024-04-29 11:07:26', '2024-04-29 11:37:58', '2025-04-29 18:07:26'),
('c061ca676688da45206f278b56c88a21334226f4ab956bfc7031c16f30f6fc57d7984fa1bd02a844', 2, 3, 'authToken', '[]', 0, '2024-04-29 10:55:33', '2024-04-29 10:55:33', '2025-04-29 17:55:33'),
('c0db8143a3cfebd8f7d85ee2d9879647544667d5794345d6e6cf92daa7318b6f446d86bf5976e591', 3, 3, 'authToken', '[]', 1, '2024-05-24 06:20:59', '2024-05-24 06:34:10', '2025-05-24 13:20:59'),
('c21ea9bf911502fee2f3ff3de6793eaef739f92b33330e4060c1fe5a5ddee8a0dd50f77f8d1c5dcc', 7, 3, 'authToken', '[]', 1, '2023-07-16 04:48:18', '2023-07-16 06:11:50', '2024-07-16 11:48:18'),
('c222ac5f392b046677e0581ef70d325776536b6634accbf290343eda9eac5e18359840400cc2a549', 2, 3, 'authToken', '[]', 1, '2023-07-16 02:38:54', '2023-07-16 02:39:43', '2024-07-16 09:38:54'),
('c299dd68843af714eee7f0b5bbe45b961c9ac4de2d68659916f6b4cef83017237117e276b1eee06b', 14, 3, 'authToken', '[]', 0, '2023-07-16 18:05:22', '2023-07-16 18:05:22', '2024-07-17 01:05:22'),
('c41483999a73ba576ee2a28bbd058f850e5c65ef386c8950f67980635c33f531781a3a928c9a2d39', 14, 3, 'authToken', '[]', 0, '2023-07-07 02:23:21', '2023-07-07 02:23:21', '2024-07-07 09:23:21'),
('c4452299605f385586f4a649713a88832c0430e1b776cff709eb746b087f91dde47ba04623b1694d', 14, 3, 'authToken', '[]', 0, '2023-07-16 02:45:07', '2023-07-16 02:45:07', '2024-07-16 09:45:07'),
('c499f1c1cad2b8023092c1b27f2447f28303bfa9df2153712b5ceb5174783c9c7e7a704838b7786b', 2, 3, 'authToken', '[]', 1, '2024-05-23 21:23:53', '2024-05-23 21:25:12', '2025-05-24 04:23:53'),
('c4a1daf5cfd9c71376cdec1cd4ecf2f3c117b2e1b3cbaa32370fa5155907536a6fbca7697be3280c', 32, 3, 'authToken', '[]', 0, '2024-05-09 18:39:21', '2024-05-09 18:39:21', '2025-05-10 01:39:21'),
('c5fbb23d91ae48a7bd783eed9b6170016342fad2e6edd2ca87bb9981b07b0878e68942aa92c9fc17', 14, 1, 'authToken', '[]', 0, '2023-06-20 18:44:08', '2023-06-20 18:44:08', '2024-06-21 01:44:08'),
('c609217cb777d309c5f0015443be726314c6a7e93fbf8c886a8d6cc154a95051b67b7a69e70f6f6e', 14, 1, 'MyApp', '[]', 0, '2023-05-22 22:58:02', '2023-05-22 22:58:02', '2024-05-23 05:58:02'),
('c73d7e9e8fd23a9ef7a8a92645bb280b09c2ec77d9d3ac8043c1ff7fac90d3ad40199899194f8556', 34, 3, 'authToken', '[]', 0, '2024-05-25 02:41:57', '2024-05-25 02:41:57', '2025-05-25 09:41:57'),
('c88d1744f9812eb807afb3cafce95732d6e8ee0dadcb75a4760904eccf7191ec736cb9da839c85b1', 32, 3, 'authToken', '[]', 0, '2024-05-22 01:29:56', '2024-05-22 01:29:56', '2025-05-22 08:29:56'),
('c88d213d980a6a373d8be28fae6d939ff2e4adff7563b8925300abd33e37b6a070378ac6f9b041ca', 3, 3, 'authToken', '[]', 0, '2024-05-23 18:54:51', '2024-05-23 18:54:51', '2025-05-24 01:54:51'),
('c918a56d8b3788e9156c3bf760bb3a1b2b21b3b6505d5b986002fe13b0b2b422bcad9830c19e7453', 3, 3, 'authToken', '[]', 0, '2024-05-23 18:35:06', '2024-05-23 18:35:07', '2025-05-24 01:35:06'),
('c91c928fcca14291d1fd5e7e4d11ff6bdc5966e5825fe763b223e3a1d95792b7ae12cd4b4045d5ae', 14, 3, 'authToken', '[]', 1, '2023-07-16 03:16:27', '2023-07-16 03:16:34', '2024-07-16 10:16:27'),
('c9a9dacd4527e73b39ab0ae93ba67c447efcf2cd9637fcbe7f3a008a0ce3cc05c15d5ea22a50efb8', 33, 3, 'authToken', '[]', 0, '2024-05-13 02:32:24', '2024-05-13 02:32:24', '2025-05-13 09:32:24'),
('cb3077ce3972831468b3e3e7eb96f73790ea380f49e71fde2c93da2d0cc8a644399a842f6b35a920', 33, 3, 'authToken', '[]', 1, '2024-05-12 09:28:22', '2024-05-12 09:28:26', '2025-05-12 16:28:22'),
('cb5179280de71815dd98ee79e401745e2516edd4a4285ed4ac4fee611b109a18256f0c080e5c0d22', 3, 3, 'authToken', '[]', 0, '2023-07-09 19:09:49', '2023-07-09 19:09:49', '2024-07-10 02:09:49'),
('cb81fdbdace591c5db1548f923f0ddad4367ba4fb6959259afb88679a2a6d384ed2ca8a4925cf435', 14, 3, 'authToken', '[]', 0, '2023-07-10 18:20:45', '2023-07-10 18:20:47', '2024-07-11 01:20:45'),
('cbe5ffc1f2b648e0ee6e4b1d3895d02e816fb6a68c12e2c4c7248517f6b20cf49984685d62de1f7e', 4, 3, 'authToken', '[]', 0, '2023-07-04 21:23:33', '2023-07-04 21:23:33', '2024-07-05 04:23:33'),
('cc1aea76c8b7e0cbc9b6055570c50df593b51ee5238f18c553ea385cff096c9252fdd58877fc34e5', 14, 3, 'authToken', '[]', 0, '2023-07-12 19:49:26', '2023-07-12 19:49:26', '2024-07-13 02:49:26'),
('cca6abba9af1554a0ea5042f15fc58fb4acbffc0fd64d97e997d7feee1b008ebe959c1a2c769b9fd', 2, 1, 'authToken', '[]', 0, '2023-05-13 06:51:46', '2023-05-13 06:51:47', '2024-05-13 13:51:46'),
('ccb194ce2df484dde078f3d852a6203e57064b03f0eee4050169cea8872952d453800d0901d69232', 33, 3, 'authToken', '[]', 0, '2024-05-22 22:04:39', '2024-05-22 22:04:39', '2025-05-23 05:04:39'),
('ccb7dbc6632dc169eb642a4ac652bfe2ed1f48b0db90e7ba38c57daf32c67420992dde30839f1bb8', 14, 3, 'authToken', '[]', 0, '2023-07-11 21:00:41', '2023-07-11 21:00:42', '2024-07-12 04:00:41'),
('ccdb53daaf8a188c1d83e34dab3eb6d5bd47e8de9a0354c4e6236f1de8666b4bda724ac80b46ce59', 22, 3, 'MyApp', '[]', 0, '2023-07-17 23:30:03', '2023-07-17 23:30:03', '2024-07-18 06:30:03'),
('cd14b5e2c33dbb938671c0f4ad25201c9ae1b7b5f119ee902b5a23e347342f1f860c03f1b1b98775', 14, 3, 'authToken', '[]', 1, '2023-07-16 02:48:33', '2023-07-16 02:50:52', '2024-07-16 09:48:33'),
('ce15f4f483daa427d7209a49b3821b69e57936be22ee02db19aca33c0c3e9bf07e968ed7412102e1', 14, 3, 'authToken', '[]', 0, '2023-07-04 21:28:43', '2023-07-04 21:28:43', '2024-07-05 04:28:43'),
('ce28ffe5c48079ecc177e2603841426025f8349c6b1ab2307a97990f10f45ee3f1da1e174106414b', 4, 1, 'authToken', '[]', 0, '2023-05-22 02:18:32', '2023-05-22 02:18:32', '2024-05-22 09:18:32'),
('ce618a482017e77b7145232bdb319d17378119ca54c291f3bee17d0c149c594d1d7a990c1f27629e', 14, 3, 'authToken', '[]', 0, '2023-07-06 02:19:26', '2023-07-06 02:19:26', '2024-07-06 09:19:26'),
('ce708db7f7a6ff8313e590a82c57463207a298b81d5ae76d318fa7358f06647a3b492ee643872fee', 14, 3, 'authToken', '[]', 0, '2023-07-16 00:20:57', '2023-07-16 00:20:57', '2024-07-16 07:20:57'),
('cec46079627559cf053d313f75c05156f914bfe5481d755b112a3e5f15d64d441b703806e98915ff', 14, 1, 'authToken', '[]', 0, '2023-07-02 19:25:56', '2023-07-02 19:25:56', '2024-07-03 02:25:56'),
('cf02541a4f710d1de2b6795274bb116f0de55bf68f2af2512450e66ac4984b6078c3d7d502256522', 32, 3, 'authToken', '[]', 0, '2024-05-13 21:56:54', '2024-05-13 21:56:54', '2025-05-14 04:56:54'),
('cf0bcc2331491d1b46e084e5a9722ed3c07f7e45a13628be841f8315aca53fa7d9c33b35af26be46', 3, 3, 'authToken', '[]', 1, '2024-05-24 06:34:54', '2024-05-24 06:47:20', '2025-05-24 13:34:54'),
('cf25ffded11db01123a36055a62ce9ab24e98264decb83fc2a0ba4497c0ae9a565ec8d73a7ba28e2', 14, 3, 'authToken', '[]', 1, '2023-07-10 01:28:25', '2023-07-10 02:13:00', '2024-07-10 08:28:25'),
('cf37cd1586c9e88083ceca4fb2c6f89a81b4d246e97371ea0f5b3b59caf1355e19bdc4b62c7f15fd', 3, 3, 'authToken', '[]', 0, '2023-07-10 02:35:46', '2023-07-10 02:35:46', '2024-07-10 09:35:46'),
('cf62852a832a1b3dd6a0a0498217cab55624e9b7749565452e01c44666aa3506c34b559cbde7f57a', 14, 1, 'authToken', '[]', 0, '2023-06-13 00:45:40', '2023-06-13 00:45:40', '2024-06-13 07:45:40'),
('d0deb17bc9ae84ddbf5561460488411998521a9906309b5ff41dad8cfc16439e9eff656919ad0828', 4, 3, 'authToken', '[]', 0, '2024-01-15 19:40:24', '2024-01-15 19:40:24', '2025-01-16 02:40:24'),
('d1ad41316a086ca57f91b80e4f28baacd6697ca470a1abc25341a544e2f902d12a2b13ba602dcf79', 7, 3, 'authToken', '[]', 0, '2023-07-06 05:45:56', '2023-07-06 05:45:57', '2024-07-06 12:45:56'),
('d1ba09d17a76a97056bc0b2cbf9353d776213dbeb244470cd7d630c581a4472477360389975f123e', 14, 3, 'authToken', '[]', 1, '2023-07-16 03:23:04', '2023-07-16 03:39:13', '2024-07-16 10:23:04'),
('d1e20434af0880183cfbb731eced0b19d0abc51cf090b87ff0d9620a6301f45e15655cdea77c7447', 4, 1, 'authToken', '[]', 0, '2023-06-13 00:51:46', '2023-06-13 00:51:46', '2024-06-13 07:51:46'),
('d1f2a6a5379989632f3484924c9c7f6205e39a0036dd05c387885dc35de5df956a8916bba7637d15', 7, 3, 'authToken', '[]', 1, '2023-07-16 03:39:44', '2023-07-16 04:48:05', '2024-07-16 10:39:44'),
('d1fbf03ef1e551d59b1d13b4187354a93f3b2cb4dcef5ac31dab43e13d2794d73bc4ed280edea002', 14, 3, 'authToken', '[]', 1, '2023-07-16 02:50:59', '2023-07-16 03:05:06', '2024-07-16 09:50:59'),
('d21829b80f931bf24759570e7456faeb67a9551e1210688906fcde7c6c7cc77850f1c53c88bc0354', 32, 3, 'authToken', '[]', 0, '2024-05-13 01:31:49', '2024-05-13 01:31:49', '2025-05-13 08:31:49'),
('d30ba0b791bb6f052259301450ec734f1e6cd274f7376f8f409b00c6b0963d1d6ae2fdf8d3a7aac5', 14, 3, 'authToken', '[]', 0, '2023-07-23 03:45:17', '2023-07-23 03:45:17', '2024-07-23 10:45:17'),
('d38d48cd6138157127e2c94b55334d73a537908fb10243a06f6ec0224082071df6b8ea2e140b1798', 2, 1, 'authToken', '[]', 0, '2023-05-13 06:51:48', '2023-05-13 06:51:48', '2024-05-13 13:51:48'),
('d39efb8937511d2b5e0cc107f8bcc236faec1f25a6bcef966aa3f02ecf717f39cfbbb7f6e425b486', 33, 3, 'authToken', '[]', 1, '2024-05-06 18:27:50', '2024-05-06 21:20:54', '2025-05-07 01:27:50'),
('d43f51750c53524f40fab28a800268c83578411dbdefa9b60a46cf75b1453a3b5f1e67e121b58de8', 14, 3, 'authToken', '[]', 1, '2023-07-20 00:33:15', '2023-07-20 01:49:35', '2024-07-20 07:33:15'),
('d4efad6d98a455dc2fe2e2f3b51e77dc6ac1d82e0ffb8c2549e5a0cd2abee9a6212f61cba58f09ac', 33, 3, 'authToken', '[]', 1, '2024-05-23 00:19:20', '2024-05-23 00:19:29', '2025-05-23 07:19:20'),
('d5751b3176ff9326e90156c67f97c24bb9d306ec020987e70924fe4a3d14fd92715570d0f314255f', 2, 1, 'authToken', '[]', 1, '2023-06-12 21:38:40', '2023-06-12 21:41:56', '2024-06-13 04:38:40'),
('d5d2e52365a6bb2b655c4f43f0c9766f51482204015f7eef7b84ef8bcc6a11524ca7e8db9af256c7', 2, 1, 'authToken', '[]', 0, '2023-05-15 18:47:41', '2023-05-15 18:47:41', '2024-05-16 01:47:41'),
('d6234684eaea625488fcd796755c49efa31fcca7734f6a04a6b810a0df7937bfcda63b7f861070bb', 14, 1, 'authToken', '[]', 1, '2023-06-28 04:12:16', '2023-06-28 04:14:35', '2024-06-28 11:12:16'),
('d6273ef09c4f200acb5211ff36218994c9674b07eead391d5c382bcd0fe8ec0ed07e7588ee8bea4c', 32, 3, 'authToken', '[]', 0, '2024-05-10 05:02:48', '2024-05-10 05:02:48', '2025-05-10 12:02:48'),
('d6df841a6f92577527833153c5dce3d54a9c04f544d6f6f816d4deb60d7db4d0e5a3665a344f43b8', 3, 1, 'authToken', '[]', 0, '2023-06-27 07:13:38', '2023-06-27 07:13:38', '2024-06-27 14:13:38'),
('d76084cbfb2b13cf3ecefd9a97f936173bab349b65efea47400d43c4b3bea211e7605ff805425bee', 14, 3, 'authToken', '[]', 1, '2023-07-16 02:43:59', '2023-07-16 02:44:04', '2024-07-16 09:43:59'),
('d770a2346a09564bd69ebbd70d89ac5e5446d6d8b45bd81e9c709c0daf89ab2720f31e1c22476144', 2, 1, 'authToken', '[]', 0, '2023-05-15 02:47:02', '2023-05-15 02:47:02', '2024-05-15 09:47:02'),
('d7847e7bfb1c9236991491d1fcd6aa462e047cceeb7a9042c5d0a3e2a93bbd01fd1c2c4cc702b145', 2, 3, 'authToken', '[]', 1, '2023-07-16 02:23:19', '2023-07-16 02:25:51', '2024-07-16 09:23:19'),
('d87cf4c12b8d9611b11b3ab3f5c46ad69a01c4a12efb9536bdba3a5b2aed0a0a38cc594be9153c2e', 33, 3, 'authToken', '[]', 0, '2024-05-06 06:10:22', '2024-05-06 06:10:22', '2025-05-06 13:10:22'),
('d8e863ff9378f0b0b7c75260ca744f5dc879e0d9a30a7f2adc93912d9d6a69883064f0dbe453cfa5', 2, 3, 'authToken', '[]', 1, '2024-05-11 21:54:33', '2024-05-11 21:55:40', '2025-05-12 04:54:33'),
('d916bee089819b275498bdbfe584f1aa5e7232a5ffe15f4b19ad51fe26d2635b0a7f1ea72dcfa05e', 3, 3, 'authToken', '[]', 1, '2023-07-09 19:10:02', '2023-07-09 21:09:50', '2024-07-10 02:10:02'),
('d921a73ac7ee4a5e21141bcf99e1861314b6097de6838d4425aaa5e5fd9d6f94c5b160a49c15b4f3', 3, 3, 'authToken', '[]', 0, '2024-05-25 02:40:37', '2024-05-25 02:40:37', '2025-05-25 09:40:37'),
('d95528f072ede5219f379dc084c707e932b30bb6b3e5be3245414b2e7e65264548d7dbcf7ec1ee6f', 14, 3, 'authToken', '[]', 1, '2023-07-16 02:30:25', '2023-07-16 02:38:36', '2024-07-16 09:30:25'),
('d99103619e9e5b5fe9648a86d20edb1af0904c53fc378e0d6f8b698c9dd1a94d8ec9b5761587f6d6', 33, 3, 'authToken', '[]', 1, '2024-05-25 09:09:01', '2024-05-26 00:12:15', '2025-05-25 16:09:01'),
('da30a0e0f47edaa1eb12adf68c2989c7def4ce0f3e70838d3a07e64010abf6a975ceddb7ed2d6cb7', 2, 3, 'authToken', '[]', 0, '2023-07-09 21:10:16', '2023-07-09 21:10:16', '2024-07-10 04:10:16'),
('da8db93547bfbcf03a81c0d00aaa586f481d07c470b66ba513ec150bca0f82855cb884098c3e25bd', 4, 3, 'authToken', '[]', 0, '2023-07-16 00:02:09', '2023-07-16 00:02:09', '2024-07-16 07:02:09'),
('dc5333310cdb87b8569b5abacfe5f3c379db06a70936db9f9f52b57ac2aad2a4e927f4a9433655dc', 33, 3, 'authToken', '[]', 1, '2024-05-25 00:44:45', '2024-05-25 01:10:47', '2025-05-25 07:44:45'),
('dd451358ee0ba2bd7ba7e090e53158ab51196d6777e1e7620f5eb4df81d669898e42debb975dd26e', 33, 3, 'authToken', '[]', 1, '2024-05-09 11:51:41', '2024-05-09 19:01:32', '2025-05-09 18:51:41'),
('de557b724cc339dde3b8b6714348ec68cf68e9ed1a5a836a74f07bed1f89546a29a3bcba04fa7897', 10, 1, 'MyApp', '[]', 0, '2023-05-12 21:50:57', '2023-05-12 21:50:57', '2024-05-13 04:50:57'),
('df6a2231f1edc15706eadf0f3658ec905cbf39fb68aef9dc33da2e20a251bcd16f85bdd13df74916', 2, 3, 'authToken', '[]', 0, '2024-04-29 11:05:14', '2024-04-29 11:05:14', '2025-04-29 18:05:14'),
('e04f6d52a5a03e465c6507b357a46b6f9b1d5a03e1b44a6d35f01eb70d6fb92ac89fad8ca3f3dc88', 32, 3, 'authToken', '[]', 1, '2024-05-25 02:02:00', '2024-05-25 02:02:24', '2025-05-25 09:02:00'),
('e0a5f97981238519c88c080d99c9ef468c64da6beeeb838e28a13853b6c18c1dda368a919a241bbd', 2, 1, 'authToken', '[]', 1, '2023-05-22 18:26:21', '2023-05-22 21:02:33', '2024-05-23 01:26:21'),
('e11d5bb80495becb6cc90dc5f267bef881980efea5dbf2eb3b04fc5ca1bc00a5d5201dd3d5f17046', 4, 3, 'authToken', '[]', 0, '2023-07-16 00:21:54', '2023-07-16 00:21:54', '2024-07-16 07:21:54'),
('e12c6319d38b3cfca1227352d0285097b60c05c864f5d140e74012892af545777264d55d9c5f76eb', 14, 1, 'authToken', '[]', 0, '2023-07-03 06:10:26', '2023-07-03 06:10:26', '2024-07-03 13:10:26'),
('e1ac3f1c01069d5be890b404b582e6fe0015a95e038169fae0ccc87a75d5e53bcb3811d0233d2c5a', 2, 1, 'authToken', '[]', 0, '2023-05-16 18:05:52', '2023-05-16 18:05:53', '2024-05-17 01:05:52'),
('e212d18335251e23269ec51fb31a559bec1afc3fab2f763d2f5fa583b71f6fea808f42c58f7afa06', 33, 3, 'authToken', '[]', 0, '2024-05-13 02:29:56', '2024-05-13 02:29:56', '2025-05-13 09:29:56'),
('e24f7accc05e023fdfac379d689eadffe99d94426f33784d5355d8e8cda59b60c37cccb465c869a0', 32, 3, 'authToken', '[]', 0, '2024-05-22 00:55:38', '2024-05-22 00:55:38', '2025-05-22 07:55:38');
INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('e295302c87b87d3c74975083dc02e1d852cc1bfe0f512cfbcb27b51024d41359062efbaf104dac4d', 3, 3, 'authToken', '[]', 1, '2023-08-20 19:45:57', '2023-08-20 19:46:19', '2024-08-21 02:45:57'),
('e2de85b093fe29006e8b668adcc1cfa191b520ee236a23a110da0948479d1d40de9c41cce9e1228a', 7, 3, 'authToken', '[]', 1, '2024-05-26 00:12:35', '2024-05-26 00:41:12', '2025-05-26 07:12:35'),
('e2fd988d4dbbf8b6118c9c8dafd8e24587a3665526496bb117dfec67395487b8ef0ee636a867ac25', 5, 3, 'authToken', '[]', 0, '2023-07-18 02:31:48', '2023-07-18 02:31:48', '2024-07-18 09:31:48'),
('e31cd829bed7136d324f97c5191c8d697d05b48fa08443de99532e7f7b41e1abcd17d4eebec53846', 32, 3, 'MyApp', '[]', 0, '2024-04-29 01:59:52', '2024-04-29 01:59:52', '2025-04-29 08:59:52'),
('e35640e693c2fde5658a29a6c75d3fba27722380920da18efed814be7a305db7687dfaf2f416d196', 2, 3, 'authToken', '[]', 1, '2024-04-29 15:25:05', '2024-04-29 15:28:05', '2025-04-29 22:25:05'),
('e36cdffa6e961eacdd3ee54536762a070728f9b4416d6ed36cdc91f0bceddeb48eddd7c841a1adf3', 2, 1, 'authToken', '[]', 0, '2023-05-15 01:57:46', '2023-05-15 01:57:47', '2024-05-15 08:57:46'),
('e3b20a4a4d5400c3124be37ac8a61d319e5fe4703fff863c055b3dc028445ac77a0a5fa95f245938', 17, 3, 'authToken', '[]', 0, '2023-07-16 10:03:08', '2023-07-16 10:03:08', '2024-07-16 17:03:08'),
('e3e1cfad02f9b458aeab5854debed87b71dac207241cde8fee1a4a9079adb0cbe2a18bba4a1ea338', 4, 1, 'authToken', '[]', 0, '2023-06-22 00:43:58', '2023-06-22 00:43:59', '2024-06-22 07:43:58'),
('e405eca07bde5b44d6003b2f1b06f4c2de5921d3fa9305df4587a60218e8576356bf8c984d4f5721', 33, 3, 'authToken', '[]', 1, '2024-05-25 02:36:04', '2024-05-25 02:36:53', '2025-05-25 09:36:04'),
('e4635193a37cc958a629e3d9120ba86aaedb9232d2c2ec15dd75111ad0ab9f0d7ae8e5abe3969adb', 7, 3, 'authToken', '[]', 1, '2024-05-26 00:45:09', '2024-05-26 00:45:35', '2025-05-26 07:45:09'),
('e4ea8f5a4e8467614a890a2c696a60a423e64a1f195a56e0b486568c6ebb85997c0980162366cb16', 33, 3, 'authToken', '[]', 0, '2024-05-25 08:30:37', '2024-05-25 08:30:37', '2025-05-25 15:30:37'),
('e4ffc5d7d07ac06fc6123664f7091970ac6985152235b4f99fa50b2c6f5814c963ccc62ee8026215', 26, 3, 'MyApp', '[]', 0, '2023-07-17 23:34:49', '2023-07-17 23:34:49', '2024-07-18 06:34:49'),
('e53b16c88911fec597bcc8cf358f862424048871ed710eeed1abec9e0206f10c43dd361fceb587b7', 2, 1, 'authToken', '[]', 0, '2023-05-15 02:44:29', '2023-05-15 02:44:29', '2024-05-15 09:44:29'),
('e5a5f11a6e202d37019d48695149253708d583f089ab5bdb06538e01c3c2f0d698fc2d11202ae8e1', 33, 3, 'authToken', '[]', 1, '2024-05-04 21:44:57', '2024-05-04 21:45:20', '2025-05-05 04:44:57'),
('e5c27b2326708b9af96a3317de2579fb8ff389a4a48df5ecae5f89b70b71ed59455f3bd6e2a2cf3d', 2, 1, 'authToken', '[]', 1, '2023-05-29 23:37:47', '2023-05-29 23:38:41', '2024-05-30 06:37:47'),
('e5cc9ef6d921e7ec082113e0066b6d57bac6f7da398e4375d24b6df5d1cf56d5c59e4cc3f6e2bbc1', 33, 3, 'authToken', '[]', 1, '2024-05-24 01:34:19', '2024-05-24 05:36:22', '2025-05-24 08:34:19'),
('e75d2abb9cce8bca5f5562b505d493a69c9113c1d50534fbe30e9e7897ffcfe266ef996586d668b1', 2, 3, 'authToken', '[]', 1, '2024-05-12 00:04:37', '2024-05-12 00:17:39', '2025-05-12 07:04:37'),
('e7bbf48b01e68372f041d12abe21f8f34f313698bcd0f036eaf7f80d7974de7c5be145b247ebe526', 33, 3, 'authToken', '[]', 0, '2024-05-22 19:49:14', '2024-05-22 19:49:15', '2025-05-23 02:49:14'),
('e88a0ef9beb929e4d50609d93286fbc2ae94521514f48033c6f2ca7fd1a430a0babfbbe4af4c693b', 2, 1, 'authToken', '[]', 0, '2023-06-12 21:42:37', '2023-06-12 21:42:37', '2024-06-13 04:42:37'),
('e8d7f85ef3bfd9d4dc07cfaba862ec9087a07fa33aed769cc474a94905d386fdda0a185ed0979e61', 14, 1, 'authToken', '[]', 0, '2023-06-29 22:08:15', '2023-06-29 22:08:15', '2024-06-30 05:08:15'),
('e933ea58c52922a1fae6fc64883e3d7ecdff9da9d6ea066937160a6dcc3ac44153f796f65455fc7f', 32, 3, 'authToken', '[]', 1, '2024-05-12 09:26:07', '2024-05-12 09:26:17', '2025-05-12 16:26:07'),
('e9c1d3749e65fdb41dab23b1f0bb2a66550f720520ad26a7508b972c43f3f4d63b7142f3562f2be5', 14, 1, 'authToken', '[]', 0, '2023-06-28 04:14:48', '2023-06-28 04:14:48', '2024-06-28 11:14:48'),
('ea856a366c08719561c2547134bf5ee883a96b7fa13ea25ed64a01eea3121a0a2408d570ee4a8b23', 17, 1, 'authToken', '[]', 1, '2023-05-25 21:24:05', '2023-05-25 21:37:35', '2024-05-26 04:24:05'),
('eb0b64b668c3bdad4f60da41d9c03125742466c8820cf0441d395bd7d4e96f0f2467bb6772a8375a', 32, 3, 'authToken', '[]', 0, '2024-05-11 21:44:56', '2024-05-11 21:44:56', '2025-05-12 04:44:56'),
('ebce9bf698d7ef291cc79e7be585539e74cff3b042379677aef50c74036e44387ab5be72350448f1', 4, 1, 'authToken', '[]', 0, '2023-06-12 23:47:42', '2023-06-12 23:47:43', '2024-06-13 06:47:42'),
('ec0d16c71fa447fa3d9b99b78a84e53152ddc74205b29a85e86cbb6777c3cc41b4f99adc5cbda5f2', 4, 1, 'authToken', '[]', 0, '2023-06-12 02:38:45', '2023-06-12 02:38:45', '2024-06-12 09:38:45'),
('ec888c3626d3242b8040d659dee68a57aa1e0e5b6d7228c9afea900a46f65e020a66ea9074298fa2', 12, 1, 'MyApp', '[]', 0, '2023-05-12 21:54:59', '2023-05-12 21:54:59', '2024-05-13 04:54:59'),
('ecb5557b133b748eb5b3c5342c7a86e3ba84b3130ee88159274a235f047e18dc3052244335cfbdd8', 33, 3, 'authToken', '[]', 1, '2024-05-05 19:19:23', '2024-05-05 19:44:00', '2025-05-06 02:19:23'),
('ed29d623899467d3b12e9e30f3fb02d987636dd4ce3d252f172043ed5eceb37c32c75cf06b7e412e', 34, 3, 'MyApp', '[]', 0, '2024-05-11 22:17:00', '2024-05-11 22:17:00', '2025-05-12 05:17:00'),
('ed5234fcefbc9f92301f888d94e7fc3f853b993925747a7279bcfc7d3b1e50ab769420cf5b1d19f1', 2, 3, 'authToken', '[]', 1, '2023-07-19 06:27:36', '2023-07-19 06:28:31', '2024-07-19 13:27:36'),
('ed8714f308f02a37f6328417369b3913edd08afcf465a299ceb419c60edbbb2f1f83ca6ebb702b21', 2, 3, 'authToken', '[]', 1, '2023-07-06 02:14:50', '2023-07-06 02:15:07', '2024-07-06 09:14:50'),
('edb29829a83bedb21eea6d8e75450bd66e23f7b5835c762209ace8dbfdcfa62812d8e9aad738c428', 33, 3, 'authToken', '[]', 1, '2024-05-13 21:33:51', '2024-05-13 21:33:58', '2025-05-14 04:33:51'),
('ee69a3bcd1a31b604de8a0e5209fdc3f04ea9193fbe3a90bab5b8ee399430cf06f9b79aed9f80ee3', 33, 3, 'authToken', '[]', 0, '2024-05-04 06:22:10', '2024-05-04 06:22:10', '2025-05-04 13:22:10'),
('ee73808fa1191c9d94ecbd77a3df603ef3f58c9af32b447d055f93782d9ea858f43766c32d129e2f', 33, 3, 'authToken', '[]', 0, '2024-05-12 09:27:19', '2024-05-12 09:27:19', '2025-05-12 16:27:19'),
('ef0b13e26c7b5add1f0d3c327b38e04b8a8b6afc6c20617e94d033d7330b24699110053b1b507cd9', 2, 3, 'authToken', '[]', 1, '2023-07-17 06:24:50', '2023-07-17 06:41:36', '2024-07-17 13:24:50'),
('ef237875b46891d608e731288afeda3c7395489f479f8577a2694ffa2577b601461bc400526b9ba7', 8, 1, 'authToken', '[]', 1, '2023-05-29 21:40:04', '2023-05-29 23:37:29', '2024-05-30 04:40:04'),
('ef4744d37d8c101dfb6a42ac06cb1bc53ef9d5108b9ec85d2f19a1ae6432cb157403e3522941549c', 2, 1, 'authToken', '[]', 0, '2023-06-12 21:36:34', '2023-06-12 21:36:34', '2024-06-13 04:36:34'),
('efc0056cfd93a90c3f92cd55572d614f5c983069cd25ab11543cb2da89cc6a5dbc9bceaec114cbed', 2, 3, 'authToken', '[]', 1, '2023-07-12 19:38:41', '2023-07-12 19:49:04', '2024-07-13 02:38:41'),
('f0a2434e5e78705d62be2a72dadc9da510b1cfdd760990960e3942f714c9031a2c86366516e6030b', 14, 1, 'authToken', '[]', 0, '2023-07-04 06:35:09', '2023-07-04 06:35:10', '2024-07-04 13:35:09'),
('f0ffda3aba3bbc21df1500633d532e1803ee4c143c15fd3231a788ed9fa61bee96b1e4050ae74037', 14, 3, 'authToken', '[]', 1, '2023-07-16 03:05:18', '2023-07-16 03:06:38', '2024-07-16 10:05:18'),
('f106aa56a1da842ddcb264c05a308936eaeb8381af6d8d4be3e958e3743e9c1bf0c7e8cfa0814fe2', 3, 3, 'authToken', '[]', 0, '2024-05-22 20:50:58', '2024-05-22 20:50:58', '2025-05-23 03:50:58'),
('f13625c0467955348878528db55edb29b0f4a5adac5dcf83364ef37bed5d49a134bef7ffda515d1e', 14, 3, 'authToken', '[]', 0, '2023-07-07 21:46:36', '2023-07-07 21:46:37', '2024-07-08 04:46:36'),
('f1c0088dfaec5beb45b702bc74bdb4a7f9109eeca1fa6ab4fbf7ccaeb94fc76d889e21429b1c4b47', 14, 3, 'authToken', '[]', 0, '2023-07-04 21:49:08', '2023-07-04 21:49:08', '2024-07-05 04:49:08'),
('f274a7d897b8d4a8cf4b5ffffe058a8b0522e4e638e5a2f4d89c2edc9d54d6cfe5e877a00ba166e3', 3, 3, 'authToken', '[]', 1, '2023-07-06 02:15:16', '2023-07-06 02:19:05', '2024-07-06 09:15:16'),
('f2928f1ef33c02afbe150f73afc0c94a6cb62021d1024c660b22246006101e97df89e7b461ea7e57', 3, 3, 'authToken', '[]', 1, '2024-05-24 07:47:35', '2024-05-24 07:48:21', '2025-05-24 14:47:35'),
('f2aa7ec2f3cf9f276ca26959bf45291ae86e0f914c19d4a2c2f18f7620ca62c92827aa7c11a2b5b0', 14, 3, 'authToken', '[]', 1, '2023-07-16 03:16:54', '2023-07-16 03:19:56', '2024-07-16 10:16:54'),
('f2da7b2b5d15ae5e7fb5358dc202a181ad8633920e1293adc95d0a3d014ce3f9cd92af5a6442420f', 14, 3, 'authToken', '[]', 0, '2023-07-15 00:43:46', '2023-07-15 00:43:47', '2024-07-15 07:43:46'),
('f2df8731c9a99a997da5ea8fb28a645d53aa55970efc9aafca177512fb9c677db0c05c265b8da0f5', 14, 1, 'authToken', '[]', 1, '2023-07-04 21:16:43', '2023-07-04 21:19:40', '2024-07-05 04:16:43'),
('f44f64d1d6174154443ad09981863947f370ddacc6cc21ca509cfbcc65e5637df31aae964e1877e5', 33, 3, 'authToken', '[]', 1, '2024-05-04 03:06:45', '2024-05-04 04:05:24', '2025-05-04 10:06:45'),
('f49e9d1400ef1fd7ccdd7871aba20eb6f84cd7ea7881f6ca77fa84d78607888a3eb6afb0c69d6062', 14, 3, 'authToken', '[]', 1, '2023-07-16 03:06:48', '2023-07-16 03:08:20', '2024-07-16 10:06:48'),
('f4b0cd7e86cd200f1d3f701e050fce8b2b41411348654bbdb3a3556eb2c035a216580fa074021b14', 33, 3, 'authToken', '[]', 0, '2024-05-04 06:10:20', '2024-05-04 06:10:20', '2025-05-04 13:10:20'),
('f4b14a6db2d0137beef5189dab5ff324cf95e60ab83ef396e89159266a72325f0692c461addbc8d4', 2, 3, 'authToken', '[]', 1, '2023-07-17 06:03:52', '2023-07-17 06:04:00', '2024-07-17 13:03:52'),
('f561cf6bfa3d6a4e5945a9fffbd4bc896fcffa21309d4ab8bf45e208194ef2a6601072437e8b22ec', 14, 3, 'authToken', '[]', 1, '2023-07-16 00:35:28', '2023-07-16 01:29:05', '2024-07-16 07:35:28'),
('f5684112721bcd91869b0b4dbe0e94b3452a0add548800860cc50b39ec61a5d97c4eb8c70ced4fa3', 2, 3, 'authToken', '[]', 0, '2023-07-16 02:25:59', '2023-07-16 02:25:59', '2024-07-16 09:25:59'),
('f5daf49f241723522010025bdc64390a03640eef4dbb6d87e04d9c704e0b6068f30374cbb4987231', 4, 1, 'authToken', '[]', 1, '2023-06-13 20:25:30', '2023-06-13 20:28:44', '2024-06-14 03:25:30'),
('f60ba552b4a1c5f8dbcd8fffad2a62dfe9c5197d73286ff12ab4273a01fc2303d38988830b02e864', 33, 3, 'authToken', '[]', 0, '2024-05-22 21:41:02', '2024-05-22 21:41:02', '2025-05-23 04:41:02'),
('f6501d2c9d7df947c25b7b12a14e9e2c5f76aff83f113d80144704905eed3812ce11b251c1451a80', 3, 3, 'authToken', '[]', 1, '2024-05-24 06:58:43', '2024-05-24 06:58:51', '2025-05-24 13:58:43'),
('f66d5413ce1a64759b4affa3bea68952046e1348d4a4aa6cdee0cd10b6c267bbcaf7150ba0d26144', 33, 3, 'authToken', '[]', 0, '2024-05-05 21:25:26', '2024-05-05 21:25:26', '2025-05-06 04:25:26'),
('f6b23f99ed0202e373b44694132ff3588e2616b634b4af37c3cbe18c8c0e8185c77f94e193882a8a', 2, 1, 'authToken', '[]', 0, '2023-05-11 21:57:53', '2023-05-11 21:57:53', '2024-05-12 04:57:53'),
('f734a0f3a4ff35b249ccb39c6ea09348ce76937904ea5bc9dd40d22ac68c3d2a1c2d2e5ed5947623', 33, 3, 'authToken', '[]', 0, '2024-04-30 07:25:04', '2024-04-30 07:25:04', '2025-04-30 14:25:04'),
('f7aa9532515ac2be75e3846a9b75c24479f2e06297bb83039ac8af02d963926298b54dc6c2057278', 4, 3, 'authToken', '[]', 1, '2023-08-20 19:46:24', '2023-08-20 19:46:48', '2024-08-21 02:46:24'),
('f7b47cf329397ad0ce396f0f4783bb1aff4023f365cf3ee16b6d51a6bd819c0b5a412504d6c3bd8a', 3, 3, 'authToken', '[]', 0, '2023-07-17 21:23:32', '2023-07-17 21:23:32', '2024-07-18 04:23:32'),
('f80e6aaded3d3f267a6bfb921af7eae055c3bcebc6b3dc1b94829fd5c0e8439944ab9367bf8d2050', 37, 3, 'authToken', '[]', 0, '2024-05-25 07:58:25', '2024-05-25 07:58:25', '2025-05-25 14:58:25'),
('f836e8d0c8f53cc2e845d6b52c0aca5a9e68ebbe89824dcfb5fe6a9364a1fb18648d875989f91e90', 14, 3, 'authToken', '[]', 1, '2023-07-16 01:29:32', '2023-07-16 01:47:27', '2024-07-16 08:29:32'),
('f8443171d41f04473864655f71f77bb21d69c30a81ef1835c0035e0bea118aab5e309e0fda5f5ecf', 2, 3, 'authToken', '[]', 1, '2024-05-10 12:04:50', '2024-05-10 12:05:48', '2025-05-10 19:04:50'),
('f9035532bf03ee2074425d95d8d3f9d484ffdda3a8333e82a36a89fd92ae187f6d2097bb2829e1e9', 33, 3, 'authToken', '[]', 0, '2024-05-03 01:32:52', '2024-05-03 01:32:52', '2025-05-03 08:32:52'),
('f985843cc0407198a959a36aab7201d88b381b4142df182bbace164dfc246d3fca4118aece7157fa', 33, 3, 'authToken', '[]', 1, '2024-05-24 06:47:26', '2024-05-24 06:47:46', '2025-05-24 13:47:26'),
('fa1483c4e9a4889c9a0560f43c5c9add4e9c7602b5276e41b24174b5aa50740158efe1eea2ebfc59', 14, 3, 'authToken', '[]', 0, '2023-07-06 20:01:41', '2023-07-06 20:01:41', '2024-07-07 03:01:41'),
('fa4be2eb3b1e23351af0816e8f63f415b23a5d45693b737b76419dbbd9d62d121e5bc8f2d11c7995', 33, 3, 'authToken', '[]', 1, '2024-05-05 20:00:04', '2024-05-05 20:08:18', '2025-05-06 03:00:04'),
('fa760a095763706b7db6e4f62aa67d1b026cc66ca6db34e5d164b33931b28980eb936e78d55c49ae', 17, 3, 'authToken', '[]', 0, '2023-07-10 02:13:16', '2023-07-10 02:13:16', '2024-07-10 09:13:16'),
('faef318d9c1b9a5c713e4f48bbb930d3d0c9a352d28939a744e7d61cf29a8dbc6a8f737dc7171bdf', 2, 3, 'authToken', '[]', 1, '2024-05-05 19:46:10', '2024-05-05 19:47:22', '2025-05-06 02:46:10'),
('fbf7a574e209e9972ad523ee967e05e813b8e8a66c35423feb49dbc38dae77a3312edf638d8c2df8', 3, 3, 'authToken', '[]', 1, '2024-05-25 01:39:17', '2024-05-25 01:41:28', '2025-05-25 08:39:17'),
('fc0d638b4fdcb24569a5bf4b2b65439aa1f604e3cef6ccf3f8155c358c696d064b49c67df7493599', 2, 3, 'authToken', '[]', 1, '2023-08-20 19:45:10', '2023-08-20 19:45:49', '2024-08-21 02:45:10'),
('fc14d31bcbb5678db22d7bbda13e75cf8251b2750e72a7b86289374fcbc714575bc37bfab59fa48a', 16, 1, 'authToken', '[]', 0, '2023-07-04 06:39:03', '2023-07-04 06:39:03', '2024-07-04 13:39:03'),
('fc31756da0aec3718361d15c17e834544a7de62a4abcc52dfd2d57105f2b266631625bb2330f449a', 14, 3, 'authToken', '[]', 1, '2023-07-17 02:37:15', '2023-07-17 02:41:40', '2024-07-17 09:37:15'),
('fcbdd0c250af2dd577ecf4dbe3f140da330e916a6a80f5473e5b50b627748557854917eea4342814', 2, 1, 'authToken', '[]', 0, '2023-06-12 21:35:54', '2023-06-12 21:35:55', '2024-06-13 04:35:54'),
('fd4402391c3a97652141100851b332ba9bdb2ea669c9758a3eca6a97ab6da7f388f43260c4910ff2', 33, 3, 'authToken', '[]', 1, '2024-05-09 07:16:48', '2024-05-09 07:24:39', '2025-05-09 14:16:48'),
('fd78c721c7a2a5c2fe3609439ba8629bc65369c8ff04c3a4d3231c8a49a53eb2b3f0314312fa9461', 2, 3, 'authToken', '[]', 1, '2024-05-24 06:47:51', '2024-05-24 06:47:57', '2025-05-24 13:47:51'),
('fd8fb11d6531b3ca83c1c7e9ad13cdb5486eb028669444a80a2341ca89b1b4d91cc145a084a48e08', 20, 3, 'MyApp', '[]', 0, '2023-07-14 06:34:14', '2023-07-14 06:34:14', '2024-07-14 13:34:14'),
('fde85616131a50edf6e07d83ac8ead86983e93a6ee613986e806abc4feadf9ce6d0a6f91d57ac1cd', 2, 1, 'authToken', '[]', 0, '2023-07-03 05:47:08', '2023-07-03 05:47:08', '2024-07-03 12:47:08'),
('fe2c30f5920acd6125ddd80424b13025f92e066406ec3a0ab1366ba511114b3fab48ee7c386aa4e3', 14, 3, 'authToken', '[]', 0, '2023-08-13 19:35:33', '2023-08-13 19:35:34', '2024-08-14 02:35:33'),
('fea0467a371bbfc108959f437bf167c4e5e195235262120abe14febc7058b1a566067006bb656620', 14, 1, 'authToken', '[]', 1, '2023-07-04 21:14:21', '2023-07-04 21:16:32', '2024-07-05 04:14:21'),
('fea53ea3a2ecce49670dd6e5f3ab2db90bf3dcf10243dfc2557b5093474cf497cdc61230ed649efe', 4, 3, 'authToken', '[]', 0, '2023-07-16 00:00:31', '2023-07-16 00:00:31', '2024-07-16 07:00:31'),
('ff68dde0ce6f30c2ee54b4d5c562af99f84d9af76cb67ba8c45000d40caab61024a2ada18d8efd23', 6, 3, 'authToken', '[]', 1, '2024-01-15 02:03:50', '2024-01-15 02:04:07', '2025-01-15 09:03:50'),
('ffcfc4c833e82cea322db6934cb29b984eb1f9e2f9dfd6a30a1cc4624f4bb5d608716f587d31faad', 33, 3, 'authToken', '[]', 0, '2024-05-04 06:20:14', '2024-05-04 06:20:14', '2025-05-04 13:20:14'),
('78e601bddaa63f2cff4b87dbb6d4a29b15163dce1289e3156bf08486745bdf81c2add03c4d98f678', 33, 3, 'authToken', '[]', 1, '2024-05-27 19:22:32', '2024-05-27 19:22:48', '2025-05-28 02:22:32'),
('2d26466865ff6cff95ecb0453db672b86b6a291523fdff64b786250088a78afcff62b4910f8ab1b2', 33, 3, 'authToken', '[]', 1, '2024-05-27 19:27:30', '2024-05-27 19:38:14', '2025-05-28 02:27:30'),
('c45129ad099ec82de11418d99e3ec7f29313db443fb15d76fc4f981b97dc67f1b0633f77327d639e', 2, 3, 'authToken', '[]', 1, '2024-05-27 19:40:26', '2024-05-27 19:53:23', '2025-05-28 02:40:26'),
('0a02b920ad3d4583f6ca9e94a9b76e65edefc88abf1fea3d070c58cd38465983c2a847b3ec417ac6', 2, 3, 'authToken', '[]', 1, '2024-05-27 19:53:39', '2024-05-27 20:14:10', '2025-05-28 02:53:39'),
('88735abcbecbabefd92a104f42813df2f5d0a200486cfef684983f5e8da9e0cad0730c87f6aa572f', 2, 3, 'authToken', '[]', 0, '2024-05-27 20:00:59', '2024-05-27 20:00:59', '2025-05-28 03:00:59'),
('fde40ccbdf8077174bbe7e3708a1176baab1c4bf7518ec678b87b7e5ece290db9958d36d6fb27d85', 33, 3, 'authToken', '[]', 1, '2024-05-27 20:14:23', '2024-05-27 20:45:00', '2025-05-28 03:14:23'),
('5a2712277cd8519b73a45ef92e6073a3c1df6c8e0d3fd717037f40a773336d62d2adeb0b718ec536', 3, 3, 'authToken', '[]', 0, '2024-05-27 20:45:06', '2024-05-27 20:45:06', '2025-05-28 03:45:06'),
('f4bf2515541317d3564c91839e71a6c37456d52cc41a5ea801726addefc506fb5885a8ddfff75604', 8, 3, 'authToken', '[]', 1, '2024-05-27 20:47:00', '2024-05-27 20:47:09', '2025-05-28 03:47:00'),
('74062c7713ef962caa5358a7316e8242c913668e94d66606f3dbd8490993f8c3240d89e48bbabf1f', 33, 3, 'authToken', '[]', 0, '2024-05-27 20:47:14', '2024-05-27 20:47:14', '2025-05-28 03:47:14'),
('89fbfa63fb747954967bde8a4f61f993dcf2133c2f8e90d24d3fa7b751026aea9a7bba8bb6f2f0fa', 33, 3, 'authToken', '[]', 1, '2024-05-27 21:05:35', '2024-05-27 21:33:12', '2025-05-28 04:05:35'),
('c3da2a80905849f75e73179a33360e8807a1efde3fd8f9198b60639881d0b2a7490227369ee212b7', 33, 3, 'authToken', '[]', 0, '2024-05-27 21:08:48', '2024-05-27 21:08:48', '2025-05-28 04:08:48'),
('821ebc6662e3a5df6335cf7bd3cf95ee15ce1f6a6ccaba96fcb4dfb335e1b88ad21a5ffdb8387e7f', 33, 3, 'authToken', '[]', 1, '2024-05-27 23:45:46', '2024-05-27 23:48:51', '2025-05-28 06:45:46'),
('61a7e645406614790e3b7ea99828ef4fd5a3fb148b7a94ed06096b962660696432edd4e7dcab4f05', 17, 3, 'authToken', '[]', 1, '2024-05-27 23:48:56', '2024-05-28 00:04:25', '2025-05-28 06:48:56'),
('f5939a5503cbe6841cc8415a196d12b893b6aca7b71cf6dbdba2c42d7c1fbc86d964bd2e97dfe6da', 17, 3, 'authToken', '[]', 0, '2024-05-27 23:59:45', '2024-05-27 23:59:45', '2025-05-28 06:59:45'),
('dd4b1c43cef78d44d9573ae380c58deb37cd3e2bfe62016e049be716f5569f08548b79636ad14140', 2, 3, 'authToken', '[]', 1, '2024-05-28 00:05:01', '2024-05-28 00:19:20', '2025-05-28 07:05:01'),
('ee54c02c832e614253519ca5ebae530db99fcb3d4e7ebcaf00164388c30bc60d448d7d5f5a174240', 33, 3, 'authToken', '[]', 1, '2024-05-28 00:19:26', '2024-05-28 00:33:42', '2025-05-28 07:19:26'),
('bb3ae11eff1358b47c7b96753ee362bafc011aeb5b3201bafe25050965d4e1faf566f1dbd7c3edff', 2, 3, 'authToken', '[]', 1, '2024-05-28 00:33:48', '2024-05-28 00:34:08', '2025-05-28 07:33:48'),
('9167d536fe112215478fbea35ef44d24e835d9419c786d34ed8fd5c7a138129275416b4155a9b084', 3, 3, 'authToken', '[]', 1, '2024-05-28 00:34:37', '2024-05-28 00:34:54', '2025-05-28 07:34:37'),
('a11208c3b15c9e8818e404b81c280427d3774339380ab71326b46d147ee41898645e6242b1727f70', 8, 3, 'authToken', '[]', 1, '2024-05-28 00:35:08', '2024-05-28 00:39:42', '2025-05-28 07:35:08'),
('93088e63bd9ed7d87dd3e622f76006db09acd766b3a5067bb375f74989ae1957159871ce5c5c728b', 33, 3, 'authToken', '[]', 1, '2024-05-28 00:40:56', '2024-05-28 00:41:02', '2025-05-28 07:40:56'),
('5172993951d06d9b5fb7391f30e3a31a55aecd3ddb0dfd933307b5676c01c479befe1a6f2af1d78c', 17, 3, 'authToken', '[]', 1, '2024-05-28 00:41:37', '2024-05-28 00:42:01', '2025-05-28 07:41:37'),
('f6d2bd440141033e40753b87e9fa8adb129b985c277f4e865927dc2f3d75c79239a1cfab9cc27d7d', 2, 3, 'authToken', '[]', 1, '2024-05-28 00:42:30', '2024-05-28 00:49:25', '2025-05-28 07:42:30'),
('079b9a83236d2c424c067e158a3328d920f3c1ae57b574f0d7859eaa70afcd90ce1e3a20061b080c', 17, 3, 'authToken', '[]', 1, '2024-05-28 00:49:30', '2024-05-28 00:51:08', '2025-05-28 07:49:30'),
('f80ad9392a847032743cc2dd9e479553d76e3b2c2adda58cc62faa93329ad3c8e1edb33c95928079', 33, 3, 'authToken', '[]', 1, '2024-05-28 00:51:13', '2024-05-28 01:00:36', '2025-05-28 07:51:13'),
('196f5f788fad8211916bb1b16356f617991aecb443c94bf9edc2960f66c1c85e76456ecef7a4e403', 17, 3, 'authToken', '[]', 1, '2024-05-28 01:00:44', '2024-05-28 01:14:08', '2025-05-28 08:00:44'),
('0e989a466f2e49c70dcf1a659fad15e027274257a17475efdae9c5f56dfab4888cc82370f571e925', 2, 3, 'authToken', '[]', 1, '2024-05-28 01:14:12', '2024-05-28 01:17:06', '2025-05-28 08:14:12'),
('1ae4964139e0a11ccf7f57a707806947d7558126bb3733d1d4307da8388c9dcfd203ac4e32daa29c', 2, 3, 'authToken', '[]', 0, '2024-05-28 01:16:03', '2024-05-28 01:16:03', '2025-05-28 08:16:03'),
('f47da436e07356fc0b4597dd891589019dbc33c3408ec07d9170f926c65590432ad0ab8099c2e9a2', 17, 3, 'authToken', '[]', 1, '2024-05-28 01:17:11', '2024-05-28 03:08:31', '2025-05-28 08:17:11'),
('be0f190c28f0917802da69ca8397ab37ff903534d0cd85c8d108740d846a625e42267ec92f62eeaf', 38, 3, 'MyApp', '[]', 0, '2024-05-28 01:28:43', '2024-05-28 01:28:43', '2025-05-28 08:28:43'),
('f4efedaa524ac9a780b29e574b475ba1ab2c59207232d7615921e1c2ccdd7908120c33a2df6da025', 3, 3, 'authToken', '[]', 0, '2024-05-28 01:59:53', '2024-05-28 01:59:53', '2025-05-28 08:59:53'),
('0932893fe7e8a3ccf3f6ab501db67639f508eb7f29e3e898f647e61b13e4fe60b5a1ae97e26564dc', 2, 3, 'authToken', '[]', 0, '2024-05-28 02:00:29', '2024-05-28 02:00:29', '2025-05-28 09:00:29'),
('daef8e93fbaf0a5ae2a4f8433efe51e0d07e99174c18c88bc784a19955ef04e8dd45f49077cc7d1b', 2, 3, 'authToken', '[]', 1, '2024-05-28 03:08:40', '2024-05-28 03:11:09', '2025-05-28 10:08:40'),
('e4f45f9163fa2054b9a6ae4942d29eccc0b624628594273a210a9554f6be4c171a68afdd96dc5d24', 17, 3, 'authToken', '[]', 0, '2024-05-28 03:11:13', '2024-05-28 03:11:13', '2025-05-28 10:11:13'),
('f4cd7a7517953362b398caaa1ef047aba0dce5ca1532e65b90fcaea69c4305a8c1e07d1a4eb29ed3', 33, 3, 'authToken', '[]', 1, '2024-05-28 20:59:29', '2024-05-28 21:00:09', '2025-05-29 03:59:29'),
('90bfd2230004c7316f981799096b07a9ce0fae774a5c9d0de63d0489ac00ace2ca03f5c8c600e508', 17, 3, 'authToken', '[]', 0, '2024-05-28 21:00:35', '2024-05-28 21:00:35', '2025-05-29 04:00:35'),
('2f104242dc764c89218136fb61b6df463b00b99243187a2e9e38c2009d9832e23145e508a8a04913', 38, 3, 'MyApp', '[]', 0, '2024-05-28 21:36:37', '2024-05-28 21:36:37', '2025-05-29 04:36:37'),
('563d793477ee328c6fa260a45d613d772651aa2cd9c8bfa3930ca442a3cfe738c7c336fe0d1201c1', 39, 3, 'MyApp', '[]', 0, '2024-05-28 21:54:22', '2024-05-28 21:54:22', '2025-05-29 04:54:22'),
('f470e0e2fb97e5119b66219d6dfa0333d6ffbb04035ae2320251cac40a641706f72b8d5b34bb7b84', 33, 3, 'authToken', '[]', 1, '2024-05-28 22:18:32', '2024-05-28 22:36:17', '2025-05-29 05:18:32'),
('b6ca2dd4abfc2683eb1f6ac3e6a2a4c534979963de1e7ce2a4e6e3b2911584ae78facaa9ba1806c4', 2, 3, 'authToken', '[]', 0, '2024-05-28 22:24:54', '2024-05-28 22:24:54', '2025-05-29 05:24:54'),
('b9857a932a2cc10e81380c96ab30acd7eed7e829614075f047d9519fc6b078081c5b221297a89ac3', 2, 3, 'authToken', '[]', 1, '2024-05-28 22:36:22', '2024-05-28 23:50:56', '2025-05-29 05:36:22'),
('c237c9ebc0d5ab9f0c63edbd4bee076660e95eb0a42e9b045216337f4e555720a3457617b4d348e2', 33, 3, 'authToken', '[]', 1, '2024-05-28 23:51:02', '2024-05-29 01:19:45', '2025-05-29 06:51:02'),
('d59c6e3837eb59228f0f01c7e7763cc60e6f5099a14a09ffb6628321c9b6384898c4d3da2183ebab', 2, 3, 'authToken', '[]', 1, '2024-05-29 01:19:50', '2024-05-29 01:20:14', '2025-05-29 08:19:50'),
('daab59685a2d6ad7008a11e1d8d070ebf01d3ce540f684c099fbf63159e46daf278a56d08171e0f3', 33, 3, 'authToken', '[]', 1, '2024-05-29 01:20:25', '2024-05-29 01:57:47', '2025-05-29 08:20:25'),
('027ecb9d4b9534e4952ca73abe93b2959636aed3b4d4372b3378c5512c205cb9dd04ec183a3f86d6', 17, 3, 'authToken', '[]', 1, '2024-05-29 01:57:56', '2024-05-29 02:12:11', '2025-05-29 08:57:56'),
('9be2093df3b8a400bd91d258abb8747716ba95df8056fa42a42fcca0aaf00aeb15e0f387a8f389ed', 38, 3, 'authToken', '[]', 0, '2024-05-29 02:13:05', '2024-05-29 02:13:05', '2025-05-29 09:13:05'),
('976b727e04ca73d03326b3b53406d568528a6a5bc6c3eb86c61c5ff42cbaddc98b78885b62c5aa9b', 2, 3, 'authToken', '[]', 0, '2024-05-29 02:25:04', '2024-05-29 02:25:04', '2025-05-29 09:25:04'),
('d0232119eaa8c21ef3576b4ec28aff578755db8f20fa5b35e9efbb946acc3b4ecce67c1cc7ea9831', 33, 3, 'authToken', '[]', 1, '2024-05-29 05:03:28', '2024-05-29 05:04:15', '2025-05-29 12:03:28'),
('2e581ebf51074d871ea878fd45b7ba15ffa100e6568db06c05880e61d9efe587aa92ecf5997019a9', 2, 3, 'authToken', '[]', 1, '2024-05-29 05:04:19', '2024-05-29 05:04:33', '2025-05-29 12:04:19'),
('cb98932655487d340b0ac1311598b738933c122636f55b9d0cb1349647ccc8adf31881dd13ba728d', 32, 3, 'authToken', '[]', 1, '2024-05-29 05:04:38', '2024-05-29 05:09:51', '2025-05-29 12:04:38'),
('d31100efb0b6976e3ab30c831cedfba60877db22ddf45447cf849c65c665c8de53ddc3c2b299feac', 17, 3, 'authToken', '[]', 1, '2024-05-29 05:10:01', '2024-05-29 05:11:59', '2025-05-29 12:10:01'),
('b34bedb1a4394a935ca64f0bfd81d5c7a1d9a55f2109e6765069064c856ac3d61a401290c2dfaac0', 4, 3, 'authToken', '[]', 1, '2024-05-29 05:20:13', '2024-05-29 05:22:01', '2025-05-29 12:20:13'),
('82b4de5ac9e3caba9ee094a6ec2b9abb9f9e6a6cba66ad654c1905b53bd075faeeb96a3d57d28a0f', 4, 3, 'authToken', '[]', 1, '2024-05-29 05:22:07', '2024-05-29 05:22:22', '2025-05-29 12:22:07'),
('2db51a8b7d22eaddbbe05f7f9ae4157b67bcfbfc3fcce9459aeeadc30b80deeac91ea4e208cfd5c3', 3, 3, 'authToken', '[]', 1, '2024-05-29 05:22:28', '2024-05-29 05:23:09', '2025-05-29 12:22:28'),
('70088bdcf7a30dd3350ab482b6c049b48c4ba697068a2387c243af0de56ffd8f6c9afb5946ec506c', 33, 3, 'authToken', '[]', 1, '2024-05-29 05:23:24', '2024-05-29 05:23:33', '2025-05-29 12:23:24'),
('c96345a2ba3eca3632f821875d09f0c7a400c251565dd887af2854c4105018ab17a8316a6d4b504a', 3, 3, 'authToken', '[]', 1, '2024-05-29 05:23:39', '2024-05-29 05:23:51', '2025-05-29 12:23:39'),
('cb69a1009187871a0406dfd5d6b617af7239a83dc44cc7afecab841bd7697f9ef3edea735457cdb4', 4, 3, 'authToken', '[]', 1, '2024-05-29 05:23:56', '2024-05-29 05:24:39', '2025-05-29 12:23:56'),
('9034b6116d2c3d02662e1506aa435c8ff3efbfd954e5530ab36b59360fdc0467fbd2c15a154cdc5d', 2, 3, 'authToken', '[]', 1, '2024-05-29 05:24:52', '2024-05-29 05:26:02', '2025-05-29 12:24:52'),
('b1daee2cdca5a1062df6ec1f3570cb6a9c7b48aee8d1494deecab9aa06302313586701be41b8d550', 17, 3, 'authToken', '[]', 1, '2024-05-29 05:48:08', '2024-05-29 05:48:15', '2025-05-29 12:48:08'),
('68995f755d5f5dcac1ac59ca38a03dcff4f9d6896945fd51e75f8cd6481cdfb89b916c81fb32cc1e', 33, 3, 'authToken', '[]', 1, '2024-05-29 05:48:23', '2024-05-29 16:28:51', '2025-05-29 12:48:23'),
('73188c815e4feebb11a49e1eed399fb0f79ffdfdcf1182703d87dfc250d15d4759cfd253581fb74d', 2, 3, 'authToken', '[]', 1, '2024-05-29 16:29:01', '2024-05-29 16:32:53', '2025-05-29 23:29:01'),
('b8af8d46660646901538f79dcfb9d7544ad83bdf1552533ea0b39a46022eb6002c3af38612cf9184', 5, 3, 'authToken', '[]', 1, '2024-05-29 16:32:59', '2024-05-29 16:33:43', '2025-05-29 23:32:59'),
('46f6fdabe161e603164147cfca8510b72dc967dc97f629a9900e628adf799b9cf3f2b3c9440785ac', 2, 3, 'authToken', '[]', 1, '2024-05-29 16:34:28', '2024-05-29 16:34:45', '2025-05-29 23:34:28'),
('7e343aa16a908294083e0725480a2f6787928978255b3eb104319c1f85f659ad044ea5875769f4ae', 16, 3, 'authToken', '[]', 1, '2024-05-29 16:35:06', '2024-05-29 16:36:04', '2025-05-29 23:35:06'),
('c0665f73ad350037eb998ca13d2400b73d9e9649090fe113da0bb6960ce3e05970897b02dfa7f40c', 2, 3, 'authToken', '[]', 1, '2024-05-29 16:36:13', '2024-05-29 21:11:01', '2025-05-29 23:36:13'),
('d731f5505e37a0ba2a23632a603d5b963aeedc47aba4a91cdc7fc340719d6a6bc64b90b853bd1d18', 33, 3, 'authToken', '[]', 1, '2024-05-29 21:11:12', '2024-05-29 21:12:44', '2025-05-30 04:11:12'),
('3507b93ac34d16f8d7850a6daeeccabc5068e152a7784418cc10e4b6ec7f444ad871c287570a21f9', 2, 3, 'authToken', '[]', 1, '2024-05-29 21:13:02', '2024-05-29 21:14:11', '2025-05-30 04:13:02'),
('424edbce9a4df20b9ce3c0b1623197d85efb9a479d93253d8de35a7fc344986047dc0753a544f511', 33, 3, 'authToken', '[]', 1, '2024-05-29 21:14:45', '2024-05-29 21:22:00', '2025-05-30 04:14:45'),
('a856b519a1d9754457a7dceef753dc98ed2743a30f0c0337d18915331cff0cbf574dcb7da2fe2e19', 3, 3, 'authToken', '[]', 1, '2024-05-29 21:22:13', '2024-05-29 21:25:31', '2025-05-30 04:22:13'),
('5ddbd97d2a751dd5c130ae12c0521858bc0f5023d0592f02041778fcf67895c57a7d46642a8b3072', 8, 3, 'authToken', '[]', 1, '2024-05-29 21:25:43', '2024-05-29 21:44:23', '2025-05-30 04:25:43'),
('cd6e55ddf5422693084d9a8a3135444d22c7d1d7a61f471dcea5c941a4dd323ac0e6952d4c0cd1ba', 33, 3, 'authToken', '[]', 1, '2024-05-29 21:44:31', '2024-05-29 22:32:50', '2025-05-30 04:44:31'),
('395a7681b21e37a9b838a540d5f656386448430f05f9cfb44f55d64c4907e650b6766f0c0e45306d', 33, 3, 'authToken', '[]', 1, '2024-05-29 22:33:08', '2024-05-29 22:34:51', '2025-05-30 05:33:08'),
('f5a1657e90dd20c48599db8ad1ee93ad7ea71c0b8ff3ef63d6ddeb925605774081d1407d3a7bd119', 32, 3, 'authToken', '[]', 0, '2024-05-29 22:35:05', '2024-05-29 22:35:05', '2025-05-30 05:35:05'),
('6f87f3e21a9d3289fcc7776ed2368e4712b1673cf3a892a2d027f9be834ee17015bd193d00042f5b', 2, 3, 'authToken', '[]', 0, '2024-05-31 20:42:57', '2024-05-31 20:42:57', '2025-06-01 03:42:57'),
('058bedc3408eea4e8142b4065577c27ccb63d0eda012a91932acb7b5a88227b7c9cb0c6ff088b817', 2, 3, 'authToken', '[]', 1, '2024-05-31 21:13:44', '2024-05-31 21:35:36', '2025-06-01 04:13:44'),
('2df996821fe3d78ff11912c88d7f1733e784eede469af10694079b32ef79aea6d7ceb9ed1045943f', 17, 3, 'authToken', '[]', 1, '2024-05-31 21:35:41', '2024-06-01 00:20:41', '2025-06-01 04:35:41'),
('c046bd69995c8b50e287defb91caf8e1e3d5238b1914f80b55d5aca4883b7f116a591362124a75f8', 2, 3, 'authToken', '[]', 0, '2024-06-01 00:20:49', '2024-06-01 00:20:49', '2025-06-01 07:20:49'),
('c469ae6dcc9b3786fe2ead1719c8c43898ecf8876f33eeb8e5758c815baf555e52fa36ec04be59ab', 2, 3, 'authToken', '[]', 1, '2024-06-01 09:17:57', '2024-06-01 11:13:26', '2025-06-01 16:17:57'),
('ae5d901c1f91edbe5d0ea95f57d55c9ead89b7d1245033caff7c3d6b4df3330a30017f0c40e45a5d', 33, 3, 'authToken', '[]', 0, '2024-06-01 11:13:41', '2024-06-01 11:13:41', '2025-06-01 18:13:41'),
('d8894b45a7911c1ae6e560af34a7416d9dd1bd317e6a876224f6cb6c46519d6dbb82d80f4841a023', 33, 3, 'authToken', '[]', 1, '2024-06-01 21:35:45', '2024-06-01 21:35:54', '2025-06-02 04:35:45'),
('be9580c4c0b454b3930323ebf16b24870723d5ede0fdcfa78c18ed5e79d5dee21da078d0e97bf15e', 33, 3, 'authToken', '[]', 1, '2024-06-01 21:40:35', '2024-06-01 23:15:43', '2025-06-02 04:40:35'),
('71eb9497af8abdee2b1af11484fa0e9adaa90482b9d8f0b0545c0aa256a63f16b3fa8011c0659259', 33, 3, 'authToken', '[]', 1, '2024-06-01 23:15:58', '2024-06-01 23:16:39', '2025-06-02 06:15:58'),
('80950018ac8f8cd9ef66795c3efb2176b56c624024b97230eeb6b552ed4f32c4cabb288b05f9c0d3', 2, 3, 'authToken', '[]', 1, '2024-06-01 23:16:50', '2024-06-01 23:16:59', '2025-06-02 06:16:50'),
('f977d37a9ff562fcd0e2f1d93adb4038c66f66c8838cf33b52ae61c853d27285a3b5016bb55c8184', 2, 3, 'authToken', '[]', 0, '2024-06-02 01:26:36', '2024-06-02 01:26:36', '2025-06-02 08:26:36'),
('849d326ed5afcdd9b32c308364dc2772a4bf18c70cb0e3b9adf8681d246c28c82670c306bcd77b7c', 2, 3, 'authToken', '[]', 0, '2024-06-02 05:34:19', '2024-06-02 05:34:19', '2025-06-02 12:34:19'),
('2179e2a4dbe9e19cbd817a4e45cd99aad232d6a0496b4212a6ee0c660857c4e1a2ec9dad8bb0631d', 2, 3, 'authToken', '[]', 1, '2024-06-02 05:59:25', '2024-06-02 06:09:41', '2025-06-02 12:59:25'),
('9c9c11f31bc6cd5bb1507527962ac43f3a3cf08772aa47bba08b37ecb04e45d7465851f49c0d6805', 2, 3, 'authToken', '[]', 1, '2024-06-02 06:10:44', '2024-06-02 06:11:02', '2025-06-02 13:10:44'),
('747ddbf13a1e6e50e5fa9b5c01c83b9c8d9610a7c096d3dfcc5d9b1d6019b77904b6de19b9cc17b4', 33, 3, 'authToken', '[]', 0, '2024-06-02 06:12:17', '2024-06-02 06:12:17', '2025-06-02 13:12:17'),
('9fea6ea8a5b5447358e2e6f3fdcd8a7386aa7f8f42fb60bdd11b25c3af0a29241a90bb01142cd8a9', 2, 3, 'authToken', '[]', 1, '2024-06-02 06:50:59', '2024-06-02 07:24:09', '2025-06-02 13:50:59'),
('7ca6eb8924060b5d8c5f56a9f75e80d9dad7fc05496221e71d42401cd07f1e00c85ac125d3f5034a', 33, 3, 'authToken', '[]', 0, '2024-06-02 07:24:33', '2024-06-02 07:24:33', '2025-06-02 14:24:33'),
('c62ae690b248d561756c75d2d89e1c2d0c1952350bf1441b04753327c71eb8cbefbedefdadd47f0a', 33, 3, 'authToken', '[]', 0, '2024-06-02 08:39:06', '2024-06-02 08:39:06', '2025-06-02 15:39:06'),
('bb330df940b1d01e7267a5166b1d61c9ecb1f557c01f707905ce4f0f6cfc79d7318e0bcbba04f02f', 33, 3, 'authToken', '[]', 0, '2024-06-02 08:52:35', '2024-06-02 08:52:35', '2025-06-02 15:52:35'),
('b482b2216ea3c4aeec0420668f9da2d7f7912e215dda6cab244ed2715c1441f2101b63bd8dc13030', 33, 3, 'authToken', '[]', 1, '2024-06-02 19:44:24', '2024-06-02 20:26:13', '2025-06-03 02:44:24'),
('7f8b0ab4326defc764cd7506a1eb2f5f3a94d6ef45709b82995f47e505713a89ac3e86a64d81ff0b', 3, 3, 'authToken', '[]', 1, '2024-06-02 20:26:34', '2024-06-02 20:38:16', '2025-06-03 03:26:34'),
('36a869c7a222019df70fa0818e8b43313ab7d6fbec764a66f55a6befbc45632ed4f73dbd9e75be41', 3, 3, 'authToken', '[]', 0, '2024-06-02 20:28:12', '2024-06-02 20:28:12', '2025-06-03 03:28:12'),
('a5a1e2636cfa6d1c8d8682562737433a89f19ed73dc5d1a6577a353341659e04360aeb22c9f0a61f', 33, 3, 'authToken', '[]', 0, '2024-06-03 00:22:23', '2024-06-03 00:22:23', '2025-06-03 07:22:23'),
('d617bc9b44b40111b2f37bfb6558f284b68d9918231fe839442b7564400852bffbd48933c9f9be2e', 33, 3, 'authToken', '[]', 1, '2024-06-03 08:31:34', '2024-06-03 08:32:23', '2025-06-03 15:31:34'),
('1a7e28c0497fd26689561fb469e2a8616994359d20764cc9f2904a15534b6f374228615a86662025', 32, 3, 'authToken', '[]', 1, '2024-06-03 08:32:41', '2024-06-03 08:33:56', '2025-06-03 15:32:41'),
('1838ee8e04379213d33a72639223e06da03e2f9a89a12b20181c4924824fa7e8f93fc6f290326f0d', 33, 3, 'authToken', '[]', 0, '2024-06-03 08:34:02', '2024-06-03 08:34:02', '2025-06-03 15:34:02'),
('fdefe17dc33a9034b1a8c2165851478c03eb4a9569dc0ca124c5ddec7b37705fb3a52e649e3eb714', 33, 3, 'authToken', '[]', 0, '2024-06-03 09:18:50', '2024-06-03 09:18:50', '2025-06-03 16:18:50'),
('b6b10b7d67f4c13815981d3d8e38df8522816882978117c7fde20f961b187ac4f2a0daebc6fed3ce', 33, 3, 'authToken', '[]', 1, '2024-06-03 09:38:37', '2024-06-03 09:44:28', '2025-06-03 16:38:37'),
('aa21991ac8d0f36fb44c2f95c25cb1cdc4e6404e40d3f7ac254cd108a8490ddb818cf38546946a44', 37, 3, 'authToken', '[]', 0, '2024-06-03 09:45:12', '2024-06-03 09:45:12', '2025-06-03 16:45:12'),
('a93361a6e545838611a9030fed71482acd42f5fb4c48a6e53117b0f0521337c2d68574c27dd694c0', 33, 3, 'authToken', '[]', 1, '2024-06-03 11:43:25', '2024-06-03 12:22:39', '2025-06-03 18:43:25'),
('c3b748cb94ea6ef74a57783f843ade1da8d05179710f836c52ec8d67a99c1154fa0ad532f1b69d92', 32, 3, 'authToken', '[]', 0, '2024-06-03 12:22:48', '2024-06-03 12:22:48', '2025-06-03 19:22:48'),
('3c6f75ff406c19b9d4465b2b913ea003d21270029544bb2b00b2ee275d5a92c0297c556e006502fb', 33, 3, 'authToken', '[]', 0, '2024-06-03 12:39:17', '2024-06-03 12:39:17', '2025-06-03 19:39:17'),
('817f4da4a30c7dafc9ed78c34eafad1d0100eb4b8a5ac412366c5a2b10a3325a0ae464b145cec73e', 33, 3, 'authToken', '[]', 1, '2024-06-03 12:55:01', '2024-06-03 22:40:16', '2025-06-03 19:55:01'),
('36211a2339338c5d7cd4311269d8739cbcc7c1d3606d24e7db72ad8013526992f99e7053432c0b50', 33, 3, 'authToken', '[]', 0, '2024-06-03 22:31:09', '2024-06-03 22:31:09', '2025-06-04 05:31:09'),
('967ed83b8c9aa69b040d4bba746776b28b410bd0ca96e28eaeac65d139034d1aa66a239bcb0ea5d7', 33, 3, 'authToken', '[]', 1, '2024-06-03 22:41:27', '2024-06-03 22:43:20', '2025-06-04 05:41:27'),
('d2b9f1ec7271fa22503ab733aeee547e85debf539fe5eee479664004c17c71ca3853da292f1a641e', 37, 3, 'authToken', '[]', 1, '2024-06-03 22:43:27', '2024-06-04 00:34:04', '2025-06-04 05:43:27'),
('d30a2b1de62839204be99af72b46224cc48193dd799e7647848f06aca4c544586d1c9f5cb46d5ea5', 33, 3, 'authToken', '[]', 0, '2024-06-04 00:34:09', '2024-06-04 00:34:09', '2025-06-04 07:34:09'),
('f978f2b04c4205244c930a2d35826bd726e01d38e29b79ac15ece54f04132eaa1b0b8116b7bbd766', 33, 3, 'authToken', '[]', 1, '2024-06-04 09:45:07', '2024-06-04 10:06:02', '2025-06-04 16:45:07'),
('3fa6e7a43bfcf2a92ae9cd64318d575de9849ad2645950453d4d766e0ca8a72163bdf12bceb39d8f', 26, 3, 'authToken', '[]', 1, '2024-06-04 10:06:18', '2024-06-04 10:06:34', '2025-06-04 17:06:18'),
('1fbb1e4c67cae2a00716ad68c0d5d723b785ec7a9e0076c60a9c162cf9626890365306aa76d47a5d', 33, 3, 'authToken', '[]', 0, '2024-06-04 10:06:54', '2024-06-04 10:06:54', '2025-06-04 17:06:54'),
('7908d1215e8a36bf09b8487cfb865b5ebe1f62eabe10f98f4fbdbcee45098714333980f3f3a9221a', 2, 3, 'authToken', '[]', 0, '2024-06-04 10:16:28', '2024-06-04 10:16:28', '2025-06-04 17:16:28'),
('99835756f65408ad825d2b49f1925a7ec3732ceed19268a4d26398013d3c9a42a21de879ef5cec8f', 2, 3, 'authToken', '[]', 0, '2024-06-04 10:34:13', '2024-06-04 10:34:13', '2025-06-04 17:34:13'),
('1849232c7b88060f37152e23fb85085fded6bb2f28e6d9354e6904981ff690236a53f50ec03859b7', 2, 3, 'authToken', '[]', 1, '2024-06-04 11:08:08', '2024-06-04 11:18:12', '2025-06-04 18:08:08'),
('2e6f7b44009238b89189f00c2a42248eaba9a65e9cd46157b8e3200d27abe7ce7da21430e28cbbfc', 33, 3, 'authToken', '[]', 1, '2024-06-04 11:18:17', '2024-06-04 11:19:15', '2025-06-04 18:18:17'),
('0fdbc9a6907bdfdfe192d6531297c6152028ecc31e2c02cd8d685bbbc380989da5fd64dce410cbf9', 2, 3, 'authToken', '[]', 1, '2024-06-04 11:19:22', '2024-06-04 16:58:47', '2025-06-04 18:19:22'),
('5e381913368e174049b369a5331fdf1c1baa809d4afbbac883422a412e448dda88db205a70276903', 3, 3, 'authToken', '[]', 1, '2024-06-04 16:59:20', '2024-06-04 16:59:42', '2025-06-04 23:59:20'),
('faf55a18fc4c264f33d55eb28e9dfc7ac51b05d994147bb98b8f3e37aa4179b2d84634ebb3935f8b', 2, 3, 'authToken', '[]', 1, '2024-06-04 16:59:55', '2024-06-04 17:01:31', '2025-06-04 23:59:55'),
('603530daa0eb1c9599cfa3de7a1b8b373c59c9ee09fda6b895e4ddde97a59b2bc8dd5f3b87e447af', 33, 3, 'authToken', '[]', 1, '2024-06-04 17:11:50', '2024-06-04 17:26:20', '2025-06-05 00:11:50'),
('fe7e7846a47837f9a1eaa50e9ac178313e4dad19452781fe4ad917ada31b244fc1a9a80ccb074ddf', 3, 3, 'authToken', '[]', 1, '2024-06-04 17:29:15', '2024-06-05 01:47:11', '2025-06-05 00:29:15'),
('7777fb954c66230146792eb70a31330a5ade0c892410131cb17723990c57b669cf32552942d1bb8d', 33, 3, 'authToken', '[]', 1, '2024-06-05 01:47:23', '2024-06-05 01:54:20', '2025-06-05 08:47:23'),
('c518695ea431971f7e44f96fe639af659c0a19124e652542b1003c46c3110f801bc669753c6b6837', 3, 3, 'authToken', '[]', 0, '2024-06-05 01:54:33', '2024-06-05 01:54:33', '2025-06-05 08:54:33'),
('51f33071aa7f0c2d24f8b6bea00fe5925d118c89d36e8b96b5465d50c366856243a62dce81ae430c', 3, 3, 'authToken', '[]', 1, '2024-06-05 02:47:54', '2024-06-05 03:00:24', '2025-06-05 09:47:54'),
('f2dc2c812343b9796338dae8846ade78d00689df7d42e90bc3f682c32a6b65391bafc555c6c95949', 33, 3, 'authToken', '[]', 1, '2024-06-05 03:00:40', '2024-06-05 03:00:56', '2025-06-05 10:00:40'),
('f2e2c63b931722a45abc6fc9cf90b0b28b15b91c42ab6ba177baae54893dd3a487ea2bfa04f46b89', 6, 3, 'authToken', '[]', 1, '2024-06-05 03:01:33', '2024-06-05 03:02:10', '2025-06-05 10:01:33'),
('cfe59a6b5c76430e6a9056e82773d54e59918d01ced451d118479c2e426c9ea6f242124e78a11e88', 2, 3, 'authToken', '[]', 1, '2024-06-05 03:02:17', '2024-06-05 03:02:49', '2025-06-05 10:02:17'),
('468fcd298ceb87f79fa9c65d35421e889d203e75f604ab0104aa7d5669eb25195aedf5bdb77e5b61', 2, 3, 'authToken', '[]', 1, '2024-06-05 03:03:13', '2024-06-05 03:04:57', '2025-06-05 10:03:13'),
('4ccaab88bec3c400b4ee2e43de77247d13bb2186afccf4c3129c3850946c8f41fa895aa16075d871', 6, 3, 'authToken', '[]', 1, '2024-06-05 03:05:05', '2024-06-05 03:07:40', '2025-06-05 10:05:05'),
('8149583215973db1e32f8dc0c4181dcdd787368b9aae361e159ada5cfaddf1cf43c00a2007a892b3', 6, 3, 'authToken', '[]', 1, '2024-06-05 03:07:48', '2024-06-05 03:08:12', '2025-06-05 10:07:48'),
('dd5b7423ff8c323831cf92ad6841fe7466e95f23e065f5b43cfd0b7609d8dad5fa932d5019bd4fa6', 33, 3, 'authToken', '[]', 1, '2024-06-05 03:08:28', '2024-06-05 03:09:26', '2025-06-05 10:08:28'),
('47b1e614dc20ac4bda81eafe08ae205e5fc450f49fdf55a915d621184c85b64a07fa47e168b65248', 3, 3, 'authToken', '[]', 1, '2024-06-05 03:09:34', '2024-06-05 03:11:00', '2025-06-05 10:09:34'),
('2d95a6f9f18965f8b7215b0d225e258dfffb2ddad35ca7783e79f763044a9226bb8a4940ce307186', 33, 3, 'authToken', '[]', 1, '2024-06-05 03:11:18', '2024-06-05 03:17:01', '2025-06-05 10:11:18'),
('a53cea7390337bae7dedf8dc6f72079e94612ebf506bd5ed9506c7f7b75412c144caabc7ac81d8fd', 3, 3, 'authToken', '[]', 0, '2024-06-05 03:17:11', '2024-06-05 03:17:11', '2025-06-05 10:17:11'),
('e38fdc03a42d1df242bdfbe7e11ad6c4ad91d36c8dfd7acc0a53c0dfece20b52ab5bab5b24f4658e', 3, 3, 'authToken', '[]', 1, '2024-06-05 07:22:41', '2024-06-05 07:25:37', '2025-06-05 14:22:41'),
('7ff518ea0a42531192dc98dd6c4b744a7030508db2a3a83c8037b9689b719be67e764c69de8daa15', 32, 3, 'authToken', '[]', 1, '2024-06-05 07:25:44', '2024-06-05 08:07:10', '2025-06-05 14:25:44'),
('b86373aa765dfdd44f4a3e1546b05e76025e67a1a14fdcf2493f15e6a6f370200d749d8ee0820fa0', 40, 3, 'MyApp', '[]', 0, '2024-06-05 07:27:04', '2024-06-05 07:27:04', '2025-06-05 14:27:04'),
('25bf725041ec9ad09ba3570a009d0baca1a1f11cfe62f1fecba3b950420c6aab94098d5bc373d24c', 33, 3, 'authToken', '[]', 1, '2024-06-05 08:07:27', '2024-06-05 11:23:42', '2025-06-05 15:07:27'),
('04432547c3e3fecf397c7244f7ee5fb024f2afe3d61209dca929d04cc036850a648e42659d9cf6cc', 33, 3, 'authToken', '[]', 1, '2024-06-05 09:09:10', '2024-06-05 09:52:09', '2025-06-05 16:09:10'),
('68f270181ebb85ff29ffa1b5496746e03294320dbffd78bf90de8fefb1f37fcfe2613147ff0856ce', 2, 3, 'authToken', '[]', 1, '2024-06-05 09:52:20', '2024-06-05 09:53:19', '2025-06-05 16:52:20'),
('2a17b3117a4ba32aa359c9024ca6103b0f82bf045e728c7ffc4b2db766104d97ee5822e913da4697', 33, 3, 'authToken', '[]', 1, '2024-06-05 09:53:40', '2024-06-05 10:23:07', '2025-06-05 16:53:40'),
('8c0781f0e5bfc3f9d0b2350032e82338fd5ef10a8e46ecd66155df210eefa519af486238c22105a2', 3, 3, 'authToken', '[]', 1, '2024-06-05 10:23:38', '2024-06-05 10:32:23', '2025-06-05 17:23:38'),
('3d2639c062c25d30c548a1c2b9beeabff3ced7577d5c6101062c69ac7279bc61e65da5ce4ad9ea43', 17, 3, 'authToken', '[]', 1, '2024-06-05 10:33:00', '2024-06-05 10:39:49', '2025-06-05 17:33:00'),
('82dbe9d6f8dd0007fe71668b63523f7363e57e6a83b87e8faa2d6987c90692d21f4c5b0e73dd071a', 39, 3, 'MyApp', '[]', 0, '2024-06-05 10:36:18', '2024-06-05 10:36:18', '2025-06-05 17:36:18'),
('e5682ff70534ca31580cdb72851e2ea185bc3598d1a5de57a3499b48e16bd6d4365513f4c4c19313', 41, 3, 'MyApp', '[]', 0, '2024-06-05 10:38:05', '2024-06-05 10:38:05', '2025-06-05 17:38:05'),
('e4ecc8f16bf9ad656dc63acd7f6bc91ead91f5c8252fbbd72c5de4dead2bde07a32d5e891dce3fc0', 41, 3, 'MyApp', '[]', 0, '2024-06-05 10:39:19', '2024-06-05 10:39:19', '2025-06-05 17:39:19'),
('c8a369c6a9b8d44c94f74cd76aaf76b1f0fe6d2a008789a240df16f96623b71b3316b5177c3af689', 17, 3, 'authToken', '[]', 1, '2024-06-05 10:41:52', '2024-06-05 10:54:35', '2025-06-05 17:41:52'),
('86a803f6a85ba9e9e5070b30e8f2af5ac262694b08ddcc45f7fd64e436a5a6480581e04111c69848', 3, 3, 'authToken', '[]', 0, '2024-06-05 10:54:54', '2024-06-05 10:54:54', '2025-06-05 17:54:54'),
('fb6ad11451c9436917732a3df652bf92822644a7ec94ebc1dc13f167d3f4c31caac8d9400d01e2ec', 3, 3, 'authToken', '[]', 1, '2024-06-05 11:24:10', '2024-06-05 18:17:20', '2025-06-05 18:24:10'),
('906457a9fdad4e23da5795a17b5dc37a0e7ff049cd636df14057d22a199da940823def5774ba2103', 3, 3, 'authToken', '[]', 1, '2024-06-05 11:47:22', '2024-06-05 11:54:29', '2025-06-05 18:47:22'),
('173c247c1d5d33b78f6860b3300a8d76c3aabf987bfa915dccffafb1dbaa33e63ee8af28ddd01f30', 33, 3, 'authToken', '[]', 1, '2024-06-05 11:54:40', '2024-06-05 11:58:53', '2025-06-05 18:54:40'),
('ea52b2ed6988085044bcdb76ec58658d0ee56595acd61645d19aa4ca7d84beb4584547f4d1eb29b6', 3, 3, 'authToken', '[]', 0, '2024-06-05 11:59:07', '2024-06-05 11:59:07', '2025-06-05 18:59:07'),
('d181cbbcf8b1127c45ca89002df33f2bb22cbb8708897e19d18dcaae1d9c987fc3e4f3176ed04911', 39, 3, 'authToken', '[]', 1, '2024-06-05 18:18:23', '2024-06-05 18:40:49', '2025-06-06 01:18:23'),
('f6a1f9bf0764d8bf4e0f7e5c93f07f766b3766b9ce436c5f92a0ac0d50649940b56aaa288f6c3a3f', 2, 3, 'authToken', '[]', 1, '2024-06-05 18:40:54', '2024-06-05 18:42:36', '2025-06-06 01:40:54'),
('5a83a24b737375510ae9f5f91556c3907f5f1b09352554274651338796bc1b890f173d08a5e35a02', 32, 3, 'authToken', '[]', 1, '2024-06-05 18:42:41', '2024-06-05 18:49:52', '2025-06-06 01:42:41'),
('adf5e71abbd6483f664169fe16ee17b37a4972cd0bde1485a35009dfdc5a25d824030e1dcbcf4db3', 33, 3, 'authToken', '[]', 1, '2024-06-05 19:05:12', '2024-06-05 19:09:45', '2025-06-06 02:05:12'),
('b196f6804d6a6637943c7d0d3523389cf352232650cb4216ab5e2b5d531d0e0ab277547dca024bf0', 3, 3, 'authToken', '[]', 1, '2024-06-05 19:29:58', '2024-06-05 19:35:33', '2025-06-06 02:29:58'),
('1c43462bcb158b345feb228cdf6f7c11a52cc09d09248f8041b3a2b569d9f9868bd53126b7383265', 8, 3, 'authToken', '[]', 1, '2024-06-05 19:38:10', '2024-06-05 19:39:02', '2025-06-06 02:38:10'),
('763d4957fb91cd95b825e3060838db8a839af01a4c7c1734fae94fc4bd39b9f8e365c7dc5dadb1a3', 32, 3, 'authToken', '[]', 1, '2024-06-05 19:39:09', '2024-06-05 19:40:02', '2025-06-06 02:39:09'),
('9c3933fc3f13d5fafa70e7aaa3593da5d98c78df7f4f6561b2119641e567aea0953609412c54ef0c', 5, 3, 'authToken', '[]', 1, '2024-06-05 19:40:08', '2024-06-05 19:41:20', '2025-06-06 02:40:08'),
('645da8bd280ca1da70b04256d81d7337962edf5bddb04e30d817400b7b7a0bcb5ce2b24ce7f71472', 32, 3, 'authToken', '[]', 1, '2024-06-05 19:47:34', '2024-06-05 19:52:39', '2025-06-06 02:47:34'),
('46b0079c96992c321c80852713417bef04e53978e914c562ed379ec93c0c646dd8328288c6535370', 33, 3, 'authToken', '[]', 1, '2024-06-05 19:52:47', '2024-06-05 19:54:49', '2025-06-06 02:52:47'),
('f7272269c0110f59864667e4a2a74254575fe5c1809dc348ecdba5818920afaa2206892c19a42102', 17, 3, 'authToken', '[]', 1, '2024-06-05 19:55:36', '2024-06-05 19:56:35', '2025-06-06 02:55:36'),
('146d380d2b5c0585c620332ec793f6e47a435cdbd4f2908bc8a7544047a12cda1f7c4103fdd2e54b', 33, 3, 'authToken', '[]', 1, '2024-06-05 19:56:45', '2024-06-05 19:58:29', '2025-06-06 02:56:45'),
('4d7a6f9fde82f3c2f089cc4abf9aab9fb10f3a08b37e5892ce3718169b072e64841e49ffb18b2afa', 17, 3, 'authToken', '[]', 1, '2024-06-05 19:58:46', '2024-06-05 20:15:28', '2025-06-06 02:58:46'),
('653d2a809668dc331d7e621fe4ba702288fc1d32b3c6653e3a31a08cee9174555d504e70374268ef', 17, 3, 'authToken', '[]', 0, '2024-06-05 20:12:22', '2024-06-05 20:12:22', '2025-06-06 03:12:22'),
('89b870d99b01d4180769a054e0505eaa615ae9567d341c2ae85ffaa774c0b2f5efc568151ef94726', 33, 3, 'authToken', '[]', 1, '2024-06-05 20:15:47', '2024-06-05 20:25:29', '2025-06-06 03:15:47'),
('aaac198229d230399aec26cbc339dec8bf3cf3c16a82650e39b08c91ac3a5aa76546891113031e0e', 42, 3, 'MyApp', '[]', 0, '2024-06-05 20:26:08', '2024-06-05 20:26:08', '2025-06-06 03:26:08'),
('5abac18ccff2e818a5114f6556808da4d19d341ba57e85f2c687c9737a80a92d020e566d59046b58', 42, 3, 'authToken', '[]', 0, '2024-06-05 20:26:12', '2024-06-05 20:26:12', '2025-06-06 03:26:12'),
('745c5da9d6dae96b86a516d4c06f767c24c05665d4f0bdb9ec23cec4d1d0036ed00a6364bb950d08', 33, 3, 'authToken', '[]', 0, '2024-06-05 21:01:54', '2024-06-05 21:01:54', '2025-06-06 04:01:54'),
('b338fd935a92b130fefea2e3593027058e613fa34efa0af54fb0a947b97ebb98f1029faf59e09e29', 33, 3, 'authToken', '[]', 0, '2024-06-05 21:12:50', '2024-06-05 21:12:50', '2025-06-06 04:12:50'),
('cc8cda54d0756ca822b9c00cd70044e2b709739f049f4c8cca912a15778426d635ffd273e0d35cf6', 33, 3, 'authToken', '[]', 0, '2024-06-05 21:15:11', '2024-06-05 21:15:11', '2025-06-06 04:15:11'),
('2c3f6e24b88389bb50d123bcb66ae42679015a25ddb81ae86f0e4c3a5b06f0eb43276e33717e5835', 33, 3, 'authToken', '[]', 1, '2024-06-05 21:20:29', '2024-06-05 22:08:31', '2025-06-06 04:20:29'),
('5b6cdcd52e4a4c206329aec0c2472bc732ddaab9edaf27edda0bd2e8a847fefd803db4edc6eacb92', 17, 3, 'authToken', '[]', 1, '2024-06-05 23:22:06', '2024-06-05 23:24:26', '2025-06-06 06:22:06'),
('0acbbce389777f3c1454eca55a12228efcade74345db53492b076deac290d7cb0babf691699316c1', 43, 3, 'MyApp', '[]', 0, '2024-06-05 23:23:35', '2024-06-05 23:23:35', '2025-06-06 06:23:35'),
('1e8dc42db42733e8a69276c27195092b9916673b5ada910db08e924da4a85b5000f9fe0219822d21', 43, 3, 'MyApp', '[]', 0, '2024-06-05 23:24:05', '2024-06-05 23:24:05', '2025-06-06 06:24:05'),
('f055ada010b63e1e50ba2335397f6e641ddabe352f26a3b9a707249d85dcc6db107cbe85d7df2522', 2, 3, 'authToken', '[]', 1, '2024-06-05 23:25:32', '2024-06-05 23:30:25', '2025-06-06 06:25:32'),
('e7b37e547f0eae3652af4c93ea24dda2a0c77ac15f495632e26bc726f605a36fed2ab5eb5ea7ca06', 33, 3, 'authToken', '[]', 1, '2024-06-05 23:30:41', '2024-06-05 23:34:39', '2025-06-06 06:30:41'),
('5bc8cb5c69042442c8198abffa4a6c739143a05beddcc6a6eec67ee2cf748a46d7ade140433f6846', 2, 3, 'authToken', '[]', 1, '2024-06-05 23:35:58', '2024-06-05 23:48:39', '2025-06-06 06:35:58'),
('06becbf76ef5c53734c7410a50c6710f1fea9357e3815a748ab2ac81a522152dd9a86d53bf9648c3', 6, 3, 'authToken', '[]', 1, '2024-06-05 23:48:51', '2024-06-05 23:48:59', '2025-06-06 06:48:51'),
('c9b0918a883882e6a4b9c0b45024e3a60e4416b6c4e1373dc998317a18cfd6e338ed9b779f6e8d5e', 6, 3, 'authToken', '[]', 1, '2024-06-05 23:49:21', '2024-06-05 23:50:05', '2025-06-06 06:49:21'),
('dc6b73339291cfab0bd3c299524ae5acb882df6aa1416ca04eb5221fe386fa0620822724d9bf6c9d', 2, 3, 'authToken', '[]', 1, '2024-06-05 23:50:15', '2024-06-05 23:50:37', '2025-06-06 06:50:15'),
('1112366eb7fb3f41f9abd263e613d7395023d0250c7c608cd8c84b3ae2b9eaf78785d6fb62e0c74e', 5, 3, 'authToken', '[]', 1, '2024-06-05 23:50:43', '2024-06-05 23:51:24', '2025-06-06 06:50:43'),
('158f65bb141924e1da9255392184b1c538f56eab2310b1ce8869f2eee744bf2789d4cb256846abbc', 33, 3, 'authToken', '[]', 1, '2024-06-05 23:51:34', '2024-06-05 23:56:22', '2025-06-06 06:51:34'),
('0c177d036c172606a8cbfeebdcaa8436e926a2234278a23c55c62f6dafb43f3d98dcd92df57d602f', 17, 3, 'authToken', '[]', 1, '2024-06-05 23:56:32', '2024-06-06 00:09:03', '2025-06-06 06:56:32'),
('b0f2241fdbd3732ef9dce8627f296cd2daa1f771f85f5f1b81d600add0ad68fab67ffe2d66412d16', 3, 3, 'authToken', '[]', 0, '2024-06-06 00:09:16', '2024-06-06 00:09:16', '2025-06-06 07:09:16'),
('dbf87e4f7f8dbf0b9c7c52680856dca82b615d0518b846680d3b20fa12e817121b0b38c3af9fbf1c', 2, 3, 'authToken', '[]', 1, '2024-06-06 19:25:22', '2024-06-06 19:25:41', '2025-06-07 02:25:22'),
('0252d9c7180cd6f597ffd50c4149cafa2b649fcba001c913047b1f2f5c697ba3294ac79a1864caf4', 32, 3, 'authToken', '[]', 1, '2024-06-06 19:25:49', '2024-06-06 20:37:31', '2025-06-07 02:25:49'),
('7a98eaf30e8a2ebeb4d74a47788590813b0e912946961ca6af6cb209bf606a730bf5b68f63533c24', 2, 3, 'authToken', '[]', 0, '2024-06-06 19:55:46', '2024-06-06 19:55:46', '2025-06-07 02:55:46');
INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('7d6367e9c6b00e84e63af0d61231e8b9e16f1c90363ebdaae1f1344c1313e3ae4b5fb8d30f0e249a', 33, 3, 'authToken', '[]', 1, '2024-06-06 20:37:36', '2024-06-06 20:39:24', '2025-06-07 03:37:36'),
('b0c0fa4e07cc9f45b6996405a9bc0407527139a927475ddba69537172ab589d208b44cdf38c7ef53', 2, 3, 'authToken', '[]', 0, '2024-06-06 20:48:28', '2024-06-06 20:48:28', '2025-06-07 03:48:28'),
('518a2c31ddf212abfefe7568cd532590518c8c29c127fb1deaca7c971b1d72fb57c8b70a8af6ccfa', 33, 3, 'authToken', '[]', 1, '2024-06-07 01:10:44', '2024-06-07 01:12:43', '2025-06-07 08:10:44'),
('99ad045d9e52b88165f63bf1567dca0c7dfee3952100b19fc8c2fc99d919d0d9b4ebe080673cd843', 32, 3, 'authToken', '[]', 1, '2024-06-07 01:13:01', '2024-06-07 02:07:55', '2025-06-07 08:13:01'),
('9fabbdb365e14da91af22160c3e1bd6717de3912ab4d0d8b04f9d09e620a2e753a0c0bb1d4fd5738', 33, 3, 'authToken', '[]', 1, '2024-06-07 02:08:06', '2024-06-07 02:08:38', '2025-06-07 09:08:06'),
('dbfce24ee40600a9275fbc2164e76b95282ba390dbe6fb5422de46aa115fe3732e64f945d5f45d77', 37, 3, 'authToken', '[]', 0, '2024-06-07 02:16:37', '2024-06-07 02:16:37', '2025-06-07 09:16:37'),
('cbdcb4eeb9587a16f0af7839f06bcfa2c532f0f57c20c9fbc051853104fbae5259fd11e6ea447490', 33, 3, 'authToken', '[]', 0, '2024-06-07 02:21:03', '2024-06-07 02:21:03', '2025-06-07 09:21:03'),
('a55679e8959fd59ad52026207c648415469d73aeecbbb90c9cbc7e823979353ac9447916cf6908e2', 2, 3, 'authToken', '[]', 1, '2024-06-07 21:13:50', '2024-06-07 21:16:22', '2025-06-08 04:13:50'),
('6666d04c98a5584a2c16a3ee409b617375b08aabc494432ab3024a1389da5e3a176bfa9e3e903220', 32, 3, 'authToken', '[]', 1, '2024-06-07 21:16:29', '2024-06-07 22:29:28', '2025-06-08 04:16:29'),
('ad25acd254601ba68f308fc67c94956700d1328a97a7da7fe0e4022b9347616b45f7ff9a29a32937', 32, 3, 'authToken', '[]', 0, '2024-06-07 21:25:20', '2024-06-07 21:25:20', '2025-06-08 04:25:20'),
('90908320c31f645eedcd5af0b837079e2bd3f43c9eacb08b562cbf40b52a37f28b2de7d13beeefde', 33, 3, 'authToken', '[]', 1, '2024-06-07 22:29:36', '2024-06-07 22:33:34', '2025-06-08 05:29:36'),
('417e01e18098158e91ea3746cb44f493e1efc2a814e2d8ce6b505c5aab9aeb19820f321be96aab6a', 32, 3, 'authToken', '[]', 1, '2024-06-07 22:33:38', '2024-06-07 22:33:52', '2025-06-08 05:33:38'),
('5673db21cd6ee3b2ced93f337661c0020bb074e1989f51c5778c9a9d391712b7cbfda32db2595959', 4, 3, 'authToken', '[]', 1, '2024-06-07 22:34:41', '2024-06-07 22:35:05', '2025-06-08 05:34:41'),
('28087f188f047baebcf471dc3927f6b359422ff330afc450ea81a29549b47c2ecaa1873e14620e68', 8, 3, 'authToken', '[]', 1, '2024-06-07 22:35:31', '2024-06-07 22:36:12', '2025-06-08 05:35:31'),
('7f4767aee615ef2f046bc7a9a67f9ca641e9f7472a42381352303c24da57ba74e7c0700d1cb25d44', 37, 3, 'authToken', '[]', 1, '2024-06-07 22:36:16', '2024-06-07 22:36:33', '2025-06-08 05:36:16'),
('a0dcf8d49288c191b60c8a85497ff681e5d36dc7b638112003f7ceffbd3aa21528e91d7ca7b2a31a', 32, 3, 'authToken', '[]', 0, '2024-06-07 22:36:40', '2024-06-07 22:36:40', '2025-06-08 05:36:40'),
('85efe5b1a2d5b4f1ffee0c4ba3f30ef02683a6a09434aba0c575e3d5cf8aa31bc39e2b59a8337d82', 32, 3, 'authToken', '[]', 1, '2024-06-09 19:02:03', '2024-06-09 19:58:54', '2025-06-10 02:02:03'),
('17bdea04ec3ed250b57c32447828bc257f5627231f5430f8b23bfc0b92b76291b1423dfa344597fa', 33, 3, 'authToken', '[]', 1, '2024-06-09 19:59:01', '2024-06-09 20:57:32', '2025-06-10 02:59:01'),
('bf746ab476316c8bab5f824d15463514634df329a4784057ccd9df5a18b08c337816a10d97d16bd5', 32, 3, 'authToken', '[]', 1, '2024-06-09 20:57:39', '2024-06-09 23:17:05', '2025-06-10 03:57:39'),
('7479455f6f128011834978403a0ac09074cf57ee115a9c361c8f88b4b47d74d8e5a6c9a7ba5746cc', 32, 3, 'authToken', '[]', 0, '2024-06-09 23:12:32', '2024-06-09 23:12:32', '2025-06-10 06:12:32'),
('45713fa4fb5bc908c2b8ddfa83715bf6ce868ca1f6ae16fefff0c848f305a8eb68589af3aa83fb31', 4, 3, 'authToken', '[]', 0, '2024-06-09 23:17:20', '2024-06-09 23:17:20', '2025-06-10 06:17:20'),
('2d159267e7c2267074577531d1fdf40abcfa8b8d70bb12b0fa0e54747b4bbaf6a4f82bf61a9d7817', 32, 3, 'authToken', '[]', 1, '2024-06-09 23:18:41', '2024-06-11 00:06:53', '2025-06-10 06:18:41'),
('9885da7fc919214e9ad1792c2211d403426ccf4f793371589d91a8826681aff6957d6b594d0e6321', 33, 3, 'authToken', '[]', 1, '2024-06-11 00:07:00', '2024-06-11 00:14:14', '2025-06-11 07:07:00'),
('088c8b609cd2f1e27e015271328ef6f90a70b22db286fecfa1690b1909ca554448fef4a477b2ad8c', 4, 3, 'authToken', '[]', 1, '2024-06-11 00:14:22', '2024-06-11 00:16:34', '2025-06-11 07:14:22'),
('5af58f89fcb490482a9a242794104e699a02a053c4c99a2ec8aa375067074e27e8b8e124dbf790c2', 37, 3, 'authToken', '[]', 1, '2024-06-11 00:17:01', '2024-06-11 00:18:11', '2025-06-11 07:17:01'),
('2586e7a3e38a90980fda4f453a59215fff0009a58bc11f3253b8ef7a01538e16a63b0fd415deeae3', 32, 3, 'authToken', '[]', 0, '2024-06-11 00:18:17', '2024-06-11 00:18:17', '2025-06-11 07:18:17'),
('0e2fd2c0f2478adfa1fd8608c81183e163b286bc2671d0d7d7d7e879d015418791dfee40e1d26c56', 37, 3, 'authToken', '[]', 1, '2024-06-11 00:21:28', '2024-06-11 01:21:32', '2025-06-11 07:21:28'),
('8c1fc11b2917d372772351ff9dee6dbde6ae7eccba0d1179ef65114633e32110a227f417b1e4dc29', 32, 3, 'authToken', '[]', 1, '2024-06-11 08:23:01', '2024-06-11 09:50:54', '2025-06-11 15:23:01'),
('fd9f0ac3e9a63b723f6e3ff341ef0ffad62eb8be530e970fbd929001697a843910a72870de896770', 33, 3, 'authToken', '[]', 0, '2024-06-11 09:50:59', '2024-06-11 09:50:59', '2025-06-11 16:50:59'),
('3bb53f995c2c3825f5247712b1ad700991119975652428382ef1f32f1ade425b21e7e73a94a10d2c', 32, 3, 'authToken', '[]', 1, '2024-06-11 18:23:49', '2024-06-11 18:24:48', '2025-06-12 01:23:49'),
('efca2167563cd74b7f7f0e350884965695ec64fbb0e28b9045d2f180d5f20da4312ce8adb6f510ea', 2, 3, 'authToken', '[]', 1, '2024-06-11 18:24:56', '2024-06-11 18:25:23', '2025-06-12 01:24:56'),
('8e9740d62355306e8c3cb729545f88364a9ffc08d6ecb28ce8447a69b32a8643f0263a8460497a90', 33, 3, 'authToken', '[]', 1, '2024-06-11 18:26:24', '2024-06-11 19:27:19', '2025-06-12 01:26:24'),
('61fc96e577e1926724eb510a5f1daef1f2e6842f3d5c47f2e3cd4b6228ca7c054154f8d4c8dacd1c', 33, 3, 'authToken', '[]', 1, '2024-06-11 19:29:00', '2024-06-11 19:37:52', '2025-06-12 02:29:00'),
('f47b8ce01c54ef4cf4e379fc7b3aa056bc751bc8b350876e37c4a102a88b75a8966f867d26dee2c0', 33, 3, 'authToken', '[]', 1, '2024-06-11 19:38:29', '2024-06-11 20:04:18', '2025-06-12 02:38:29'),
('b3310445d1bf0460cf6a1f1d7d25f7737ee1c8b081761087fdcaba40ea6f64128bb67aef21e0a9fd', 33, 3, 'authToken', '[]', 1, '2024-06-11 20:04:40', '2024-06-11 20:13:09', '2025-06-12 03:04:40'),
('d08ff939df4e67898977b0f0b17de0f1e1271de9ebb2d486fa4151338bc1843813bedb8f85ef466d', 2, 3, 'authToken', '[]', 1, '2024-06-11 20:13:22', '2024-06-11 20:14:35', '2025-06-12 03:13:22'),
('e5119d0322dbb1b9f12075e65df7aa8c393c76774c042655f388fcc19191d4bd509ec3b4eed323be', 32, 3, 'authToken', '[]', 1, '2024-06-11 20:14:46', '2024-06-11 20:16:43', '2025-06-12 03:14:46'),
('d47b12189b97635bbb3cd3aa5d349c0a6ff2c4595fbb75d6f826d1f8366fe6807059ff4488da06c7', 33, 3, 'authToken', '[]', 1, '2024-06-11 20:17:04', '2024-06-11 20:57:58', '2025-06-12 03:17:04'),
('57db60fb5e51092693aa49757ce4571c8ef830536a9e6e1cb84fe52780799b59829e7d1961eec63b', 32, 3, 'authToken', '[]', 1, '2024-06-11 20:58:28', '2024-06-11 20:59:21', '2025-06-12 03:58:28'),
('58c8f8109bb4c1b58f9473d642745750ad9a3ce9f6c3e2c45d0622556ba4a12f7413ea41c7262f0c', 3, 3, 'authToken', '[]', 1, '2024-06-11 20:59:44', '2024-06-11 21:01:49', '2025-06-12 03:59:44'),
('a82062aeaf2b7d58016b544eaf53d7e2f8ad1556ff505f947cd5af748476ac928dc3a527d549af94', 33, 3, 'authToken', '[]', 1, '2024-06-11 21:01:56', '2024-06-12 00:01:20', '2025-06-12 04:01:56'),
('8cf1a41fb5c7acd2945b70abb9f4985695fcc49ca2f7e6499adbb0726fa37c8eae346b41c78291eb', 33, 3, 'authToken', '[]', 0, '2024-06-12 00:02:48', '2024-06-12 00:02:48', '2025-06-12 07:02:48'),
('166044163fb291fc40528cca124ecbc9b426bf2de30eb7ba8bc7c7153008e2963c3ff421625cb0a3', 33, 3, 'authToken', '[]', 1, '2024-06-13 06:04:40', '2024-06-13 06:06:57', '2025-06-13 13:04:40'),
('90bacd76642b5cd9cf18fdb97c75e183bfc6f3ef7995d19b08939533c7baab62dc258afb0e1f0916', 32, 3, 'authToken', '[]', 1, '2024-06-13 06:07:03', '2024-06-13 06:53:18', '2025-06-13 13:07:03'),
('cb9637bebee2e23b26e208968f5507e8159bc60b16933850fc3f001a9a1a80d9aee9fd2ec4ce0b96', 2, 3, 'authToken', '[]', 1, '2024-06-13 06:53:28', '2024-06-13 06:59:20', '2025-06-13 13:53:28'),
('23c2f6446351f656cfb690881f0ea439aeebfce2f4df0acc053bb132212e67ee6b0696ff0d3c35eb', 32, 3, 'authToken', '[]', 1, '2024-06-13 06:59:26', '2024-06-13 07:01:08', '2025-06-13 13:59:26'),
('2910e24e5b4a366a407670b394128dabcd32312323974ede2170cb09894662d37f46df448c9f84b5', 33, 3, 'authToken', '[]', 1, '2024-06-13 07:02:18', '2024-06-13 07:02:32', '2025-06-13 14:02:18'),
('ab95a852971a7f664858d98219b5f06bc7d2e7ae9c9555d6acb4efb88265b18e6accc435693f4776', 32, 3, 'authToken', '[]', 1, '2024-06-13 07:06:11', '2024-06-13 07:49:20', '2025-06-13 14:06:11'),
('eba9c194e4122b19f54351fd88915a27989069773477a40498ea79ca6329397fb013e75f43e0c7ed', 17, 3, 'authToken', '[]', 1, '2024-06-13 07:58:43', '2024-06-13 10:17:43', '2025-06-13 14:58:43'),
('16aa8bf1a5efbad30caed86f0794a70a7083a932b76d5949d7badb172213cba9702e9637a5c457bd', 17, 3, 'authToken', '[]', 0, '2024-06-13 08:20:24', '2024-06-13 08:20:24', '2025-06-13 15:20:24'),
('898c3cd582cdbf451c141e96832d2757bd02419ce87fbc2d0f858fb827940c1420d666fff62cf987', 33, 3, 'authToken', '[]', 1, '2024-06-13 10:17:49', '2024-06-13 19:02:39', '2025-06-13 17:17:49'),
('7dc2ec009aeaa16ce5daf05b5dd54b9ad2cc4bf204754a89677996257567b8da47450f5360ed55a6', 32, 3, 'authToken', '[]', 1, '2024-06-13 19:02:54', '2024-06-13 21:23:00', '2025-06-14 02:02:54'),
('a0d2f5ce54ec7ed09589ca9afe7580b5d09a72305aa33e72e45796b347e79aca602cfb85ce5c269a', 33, 3, 'authToken', '[]', 0, '2024-06-13 21:23:16', '2024-06-13 21:23:16', '2025-06-14 04:23:16'),
('ee950cea16678dd10ac5df9f7686e28a285585e5b8ae68a41c248dad32fb321dae3881ac74e5b68e', 33, 3, 'authToken', '[]', 0, '2024-06-13 21:30:51', '2024-06-13 21:30:51', '2025-06-14 04:30:51'),
('7fdac2a46a9c6bf3a5c73464e3803ef5db4e0b77dc8a5ccfe5c56d7926c2b10632249cd08ad89470', 33, 3, 'authToken', '[]', 1, '2024-06-13 21:35:07', '2024-06-13 21:43:42', '2025-06-14 04:35:07'),
('351c9687e9f8cfe41b56b366b7ac2f9c35bcbfd8df3ce2cb6d93355843320946ad258c55b9f55920', 32, 3, 'authToken', '[]', 1, '2024-06-13 21:43:57', '2024-06-13 21:44:17', '2025-06-14 04:43:57'),
('575bb2c22e395db33818d3746b8232eeffb6c8ed597bac175965b867019f3a57f951979367f762f2', 33, 3, 'authToken', '[]', 0, '2024-06-13 21:44:22', '2024-06-13 21:44:22', '2025-06-14 04:44:22'),
('910e6fef6313a2279d241cdbda1024c60db70060791372ad5cc1a1f406dee0b3c797cc492a12036d', 32, 3, 'authToken', '[]', 1, '2024-06-13 22:00:22', '2024-06-13 23:08:20', '2025-06-14 05:00:22'),
('df0c8be49e8d7c485712745309ee7bbcbf1a570880c98bcc08a8da8c7eeccb353c75428d3385e91d', 33, 3, 'authToken', '[]', 0, '2024-06-13 22:23:44', '2024-06-13 22:23:44', '2025-06-14 05:23:44'),
('ec6d5c08f61e07cac6cec5da9898b095464da1c3321f397c0d6c1f3311bf38118820da06a872730e', 32, 3, 'authToken', '[]', 0, '2024-06-13 23:06:49', '2024-06-13 23:06:50', '2025-06-14 06:06:49'),
('bcfc258ee707854d1bcdef9599c4c1c5da0409b304a4ffafee9e0b1aac2b34418158a32a1cdb5a0f', 33, 3, 'authToken', '[]', 1, '2024-06-13 23:08:27', '2024-06-13 23:09:01', '2025-06-14 06:08:27'),
('53aa5a04a050d18ce051b5d93bbe3e0b1627a027b6bad3def5f2bc70806f82d19e9356e3cccc5dfd', 32, 3, 'authToken', '[]', 1, '2024-06-13 23:09:08', '2024-06-13 23:09:31', '2025-06-14 06:09:08'),
('a1ab104b0e800e960c6ebc87708df2fe28f90c71252bc83ae6dfa8da48efa8e29d5d2b6bc889fa75', 33, 3, 'authToken', '[]', 0, '2024-06-13 23:09:38', '2024-06-13 23:09:38', '2025-06-14 06:09:38'),
('49636e4b19178a077decc3884235c787fb91399d4da77c9e1958087c2d8179e1d95d965d617b0b8f', 32, 3, 'authToken', '[]', 0, '2024-06-14 03:25:46', '2024-06-14 03:25:46', '2025-06-14 10:25:46');

-- --------------------------------------------------------

--
-- Struktur dari tabel `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `client_id` bigint UNSIGNED NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
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
-- Dumping data untuk tabel `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `provider`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Laravel Personal Access Client', '5nVBLWuXy6cPnmSaKziqeDDDTMYAnn0Y4IXlmAqj', NULL, 'http://localhost', 1, 0, 0, '2023-05-11 20:17:13', '2023-05-11 20:17:13'),
(2, NULL, 'Laravel Password Grant Client', 'b3pRwxAgNNQH1qFnwUWIEbH2trHHyxvcgmaDGor1', 'users', 'http://localhost', 0, 1, 0, '2023-05-11 20:17:13', '2023-05-11 20:17:13'),
(3, NULL, 'Laravel Personal Access Client', '6TmWYHHNZSoorQr5tJhuVi0iYYKh8dKPxmyFQKRC', NULL, 'http://localhost', 1, 0, 0, '2023-07-04 21:23:12', '2023-07-04 21:23:12'),
(4, NULL, 'Laravel Password Grant Client', 'V5uDdUf8SLdeqUOFoW5vgwuxrNKMOo8V5QpYcsEq', 'users', 'http://localhost', 0, 1, 0, '2023-07-04 21:23:12', '2023-07-04 21:23:12');

-- --------------------------------------------------------

--
-- Struktur dari tabel `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint UNSIGNED NOT NULL,
  `client_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2023-05-11 20:17:13', '2023-05-11 20:17:13'),
(2, 3, '2023-07-04 21:23:12', '2023-07-04 21:23:12');

-- --------------------------------------------------------

--
-- Struktur dari tabel `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `payments`
--

CREATE TABLE `payments` (
  `id` bigint UNSIGNED NOT NULL,
  `schedules_id` bigint UNSIGNED NOT NULL,
  `bookings_id` bigint UNSIGNED NOT NULL,
  `method` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_date` datetime NOT NULL,
  `expired_date` datetime NOT NULL,
  `how_to_pay_page` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `how_to_pay_api` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` bigint NOT NULL,
  `virtual_account_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `snap_token` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `active` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `payments`
--

INSERT INTO `payments` (`id`, `schedules_id`, `bookings_id`, `method`, `status`, `created_date`, `expired_date`, `how_to_pay_page`, `how_to_pay_api`, `invoice_number`, `amount`, `virtual_account_number`, `snap_token`, `created_at`, `updated_at`, `active`) VALUES
(1, 1, 284, 'noncash', 'Berhasil', '2024-06-08 12:29:51', '2024-06-08 13:29:51', 'null', 'null', 'INV-EKBT-1717824591', 100000, 'null', 'c400a11a-0f50-4378-bdcf-06928b5958c9', NULL, '2024-06-08 05:29:51', 0),
(2, 1, 285, 'cash', 'Berhasil', '2024-06-08 12:34:58', '2024-06-08 13:34:58', 'null', 'null', 'INV-EKBT-1717824898', 150000, 'null', NULL, NULL, '2024-06-08 05:34:58', 0),
(3, 2, 286, 'noncash', 'Berhasil', '2024-06-10 09:59:46', '2024-06-10 10:59:46', 'null', 'null', 'INV-EKBT-1717988386', 100000, 'null', '27b09ba4-b8e9-42e6-84df-0897679e8d8a', NULL, '2024-06-10 02:59:46', 0),
(4, 3, 287, 'cash', 'Berhasil', '2024-06-10 13:17:48', '2024-06-10 14:17:48', 'null', 'null', 'INV-EKBT-1718000268', 100000, 'null', NULL, NULL, '2024-06-10 06:17:48', 0),
(5, 4, 288, 'noncash', 'Berhasil', '2024-06-11 14:07:12', '2024-06-11 15:07:12', 'null', 'null', 'INV-EKBT-1718089632', 50000, 'null', 'a4cc8a47-eb11-48c2-87b4-4c6a4e138cfc', NULL, '2024-06-11 07:07:12', 0),
(6, 4, 289, 'cash', 'Berhasil', '2024-06-11 14:16:29', '2024-06-11 15:16:29', 'null', 'null', 'INV-EKBT-1718090189', 100000, 'null', NULL, NULL, '2024-06-11 07:16:29', 0),
(7, 4, 290, 'cash', 'Berhasil', '2024-06-11 14:17:27', '2024-06-11 15:17:27', NULL, NULL, 'INV-EKBT-1718090247', 50000, NULL, NULL, NULL, '2024-06-11 07:17:27', 0),
(8, 4, 291, 'cash', 'Berhasil', '2024-06-11 14:21:50', '2024-06-11 15:21:50', NULL, NULL, 'INV-EKBT-1718090510', 25000, NULL, NULL, NULL, '2024-06-11 07:21:50', 0),
(9, 4, 292, 'cash', 'Berhasil', '2024-06-11 14:22:58', '2024-06-11 15:22:58', NULL, NULL, 'INV-EKBT-1718090578', 25000, NULL, NULL, NULL, '2024-06-11 07:22:58', 0),
(10, 4, 293, 'cash', 'Berhasil', '2024-06-11 14:46:31', '2024-06-11 15:46:31', NULL, NULL, 'INV-EKBT-1718091991', 25000, NULL, NULL, NULL, '2024-06-11 07:46:31', 0),
(11, 7, 294, 'noncash', 'Expired', '2024-06-12 09:40:33', '2024-06-12 10:40:33', 'null', 'null', 'INV-EKBT-1718160033', 150000, 'null', '094b9d14-bc89-4c7c-a9d8-9b792998d0b0', NULL, '2024-06-11 20:40:33', 0),
(12, 7, 295, 'noncash', 'Expired', '2024-06-12 09:40:38', '2024-06-12 10:40:38', 'null', 'null', 'INV-EKBT-1718160038', 150000, 'null', 'a902d42b-8e7e-4663-9d95-a9c7f4b403a3', NULL, '2024-06-11 20:40:38', 0),
(13, 7, 296, 'noncash', 'Expired', '2024-06-12 09:46:30', '2024-06-12 10:46:30', 'null', 'null', 'INV-EKBT-1718160390', 300000, 'null', '2aa6cf67-0753-4b74-8bb1-8cc97b828b76', NULL, '2024-06-11 20:52:14', 0),
(14, 7, 297, 'noncash', 'Expired', '2024-06-12 09:46:38', '2024-06-12 10:46:38', 'null', 'null', 'INV-EKBT-1718160398', 300000, 'null', '011e0a81-a1c7-4001-9e98-fae00854966e', NULL, '2024-06-11 20:52:13', 0),
(15, 7, 298, 'noncash', 'Expired', '2024-06-12 09:55:32', '2024-06-12 10:55:32', 'null', 'null', 'INV-EKBT-1718160932', 150000, 'null', 'e3f0ad75-7ab3-46da-be0e-159f3919e962', NULL, '2024-06-11 20:55:33', 0),
(16, 7, 299, 'noncash', 'Expired', '2024-06-12 09:55:39', '2024-06-12 10:55:39', 'null', 'null', 'INV-EKBT-1718160939', 150000, 'null', '39d81f86-851a-414d-b526-acfe54f49fbc', NULL, '2024-06-11 20:55:39', 0),
(17, 7, 300, 'noncash', 'Expired', '2024-06-12 09:55:42', '2024-06-12 10:55:42', 'null', 'null', 'INV-EKBT-1718160942', 150000, 'null', 'f061e3c1-440a-4227-8d12-512bb425f093', NULL, '2024-06-11 20:55:42', 0),
(18, 7, 301, 'cash', 'Expired', '2024-06-12 10:11:03', '2024-06-12 11:11:03', 'null', 'null', 'INV-EKBT-1718161863', 150000, 'null', NULL, NULL, '2024-06-12 03:11:03', 0),
(19, 7, 302, 'noncash', 'Expired', '2024-06-12 10:27:13', '2024-06-12 11:27:13', 'null', 'null', 'INV-EKBT-1718162833', 150000, 'null', 'b1259b7d-e225-4386-81c0-33d19a13de10', NULL, '2024-06-12 03:27:13', 0),
(20, 7, 303, 'cash', 'Expired', '2024-06-12 10:36:20', '2024-06-12 11:36:20', 'null', 'null', 'INV-EKBT-1718163380', 300000, 'null', NULL, NULL, '2024-06-12 03:36:20', 0),
(21, 7, 304, 'noncash', 'Expired', '2024-06-12 10:38:40', '2024-06-12 11:38:40', 'null', 'null', 'INV-EKBT-1718163520', 150000, 'null', '1eb70920-e352-4ac4-86bc-a9b491f6e244', NULL, '2024-06-12 03:38:40', 0),
(22, 7, 305, 'cash', 'Expired', '2024-06-12 10:48:02', '2024-06-12 11:48:02', 'null', 'null', 'INV-EKBT-1718164082', 300000, 'null', NULL, NULL, '2024-06-12 03:48:02', 0),
(23, 6, 306, 'cash', 'Expired', '2024-06-12 10:56:09', '2024-06-12 11:56:09', 'null', 'null', 'INV-EKBT-1718164569', 50000, 'null', NULL, NULL, '2024-06-12 03:56:09', 0),
(24, 7, 307, 'noncash', 'Expired', '2024-06-12 11:29:44', '2024-06-12 12:29:44', 'null', 'null', 'INV-EKBT-1718166584', 150000, 'null', '89b67be4-d519-4b1f-8ce5-586e63cec227', NULL, '2024-06-11 22:30:11', 0),
(25, 7, 308, 'noncash', 'Expired', '2024-06-12 11:33:31', '2024-06-12 12:33:31', 'null', 'null', 'INV-EKBT-1718166811', 300000, 'null', '9537c616-9283-419f-b5d3-73bc14ee9360', NULL, '2024-06-11 22:34:11', 0),
(26, 7, 309, 'noncash', 'Expired', '2024-06-12 11:46:04', '2024-06-12 12:46:04', 'null', 'null', 'INV-EKBT-1718167564', 300000, 'null', '9bd72697-1545-4233-b186-f403ea871dbe', NULL, '2024-06-11 23:55:48', 0),
(27, 6, 310, 'noncash', 'Expired', '2024-06-12 12:10:33', '2024-06-12 13:10:33', 'null', 'null', 'INV-EKBT-1718169033', 25000, 'null', '581ab36b-81ec-4e82-9224-352d9abdd53e', NULL, '2024-06-11 23:55:48', 0),
(28, 6, 311, 'noncash', 'Expired', '2024-06-12 13:38:42', '2024-06-12 14:38:42', 'null', 'null', 'INV-EKBT-1718174322', 50000, 'null', '85824aac-5d07-4b6c-a193-4065b0794771', NULL, '2024-06-12 00:38:43', 0),
(29, 6, 312, 'noncash', 'Expired', '2024-06-12 13:38:50', '2024-06-12 14:38:50', 'null', 'null', 'INV-EKBT-1718174330', 50000, 'null', 'e23798d0-f027-4de0-9b18-cad0f92eba24', NULL, '2024-06-12 00:38:50', 0),
(30, 3, 313, 'noncash', 'menunggu', '2024-06-14 13:18:34', '2024-06-14 14:18:34', 'null', 'null', 'INV-EKBT-1718345914', 10000, 'null', '848b65c4-0916-4e1f-86f2-a9f36f383424', NULL, '2024-06-14 06:18:34', 0);

--
-- Trigger `payments`
--
DELIMITER $$
CREATE TRIGGER `after_insert_status_berhasil` AFTER INSERT ON `payments` FOR EACH ROW BEGIN
    IF NEW.status = 'berhasil' THEN
        INSERT INTO penghasilan_per_jadwal (schedule_id, total_penghasilan, created_at, updated_at)
        VALUES (NEW.schedules_id, NEW.amount, NOW(), NOW())
        ON DUPLICATE KEY UPDATE 
            total_penghasilan = total_penghasilan + VALUES(total_penghasilan),
            updated_at = NOW();
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_payments` AFTER UPDATE ON `payments` FOR EACH ROW BEGIN
    IF NEW.status = 'berhasil' AND OLD.status != 'berhasil' THEN
        INSERT INTO penghasilan_per_jadwal (schedule_id, total_penghasilan, created_at, updated_at)
        VALUES (NEW.schedules_id, NEW.amount, NOW(), NOW())
        ON DUPLICATE KEY UPDATE 
            total_penghasilan = total_penghasilan + VALUES(total_penghasilan),
            updated_at = NOW();
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `penghasilan_per_jadwal`
--

CREATE TABLE `penghasilan_per_jadwal` (
  `id` bigint NOT NULL,
  `schedule_id` bigint UNSIGNED DEFAULT NULL,
  `total_penghasilan` bigint NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  `persentase_komisi` int DEFAULT NULL,
  `setoran_kantor` bigint DEFAULT NULL,
  `administrasi` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data untuk tabel `penghasilan_per_jadwal`
--

INSERT INTO `penghasilan_per_jadwal` (`id`, `schedule_id`, `total_penghasilan`, `created_at`, `updated_at`, `persentase_komisi`, `setoran_kantor`, `administrasi`) VALUES
(3, 1, 250000, '2024-06-08 05:31:28', '2024-06-08 05:36:24', 20, 54000, 11000),
(5, 2, 100000, '2024-06-10 03:29:34', '2024-06-10 03:29:34', 20, 54000, 11000),
(6, 3, 100000, '2024-06-10 06:18:15', '2024-06-10 06:18:15', 20, 11000, 2000),
(7, 4, 275000, '2024-06-11 00:06:36', '2024-06-11 07:46:31', 20, 54000, 3000),
(18, 12, 0, '2024-06-13 21:44:11', '2024-06-13 21:44:11', 21, 54000, 3000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `roles`
--

INSERT INTO `roles` (`id`, `role`, `created_at`, `updated_at`) VALUES
(1, 'admin_kantor', NULL, NULL),
(2, 'passenger', NULL, NULL),
(3, 'driver', NULL, NULL),
(4, 'admin_loket', NULL, NULL),
(5, 'direksi', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `routes`
--

CREATE TABLE `routes` (
  `id` bigint UNSIGNED NOT NULL,
  `derpature` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `arrival` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `harga` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `brand_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `routes`
--

INSERT INTO `routes` (`id`, `derpature`, `arrival`, `harga`, `type`, `status`, `brand_id`, `created_at`, `updated_at`) VALUES
(1, 'Medan', 'Penyabungans', '100000', 'Ekonomi', 1, 1, '2023-05-12 20:42:58', '2024-06-05 23:40:51'),
(2, 'Medan', 'Tantom', '170000', 'Ekonomi', 0, 1, '2023-05-12 20:44:33', '2023-05-23 22:04:21'),
(3, 'Medan', 'P.Sidimpuan', '160000', 'Ekonomi', 1, 1, '2023-05-12 20:45:11', '2023-05-12 20:45:11'),
(4, 'Medan', 'Sipirok', '150000', 'Ekonomi', 1, 1, '2023-05-12 20:45:48', '2023-05-12 20:45:48'),
(5, 'Medan', 'Tarutung', '140000', 'Eksekutif', 1, 1, '2023-05-12 20:46:19', '2023-05-12 20:46:19'),
(6, 'Medan', 'Sarulla', '120000', 'Ekonomi', 1, 1, '2023-05-12 20:46:55', '2023-05-12 20:46:55'),
(7, 'Medan', 'Aek raja', '115000', 'Ekonomi', 1, 1, '2023-05-12 20:47:34', '2023-05-12 20:47:34'),
(8, 'Medan', 'O.Hasang', '155000', 'Ekonomi', 1, 1, '2023-05-12 20:48:49', '2023-05-12 20:48:49'),
(9, 'Medan', 'O.Tukka', '115000', 'Ekonomi', 1, 1, '2023-05-12 20:49:43', '2023-05-12 20:49:43'),
(10, 'Medan', 'Bakkara', '110000', 'Ekonomi', 1, 1, '2023-05-12 20:52:42', '2023-05-12 20:52:42'),
(11, 'Medan', 'Lobuksikkam', '110000', 'Ekonomi', 1, 1, '2023-05-12 20:53:13', '2023-05-12 20:53:13'),
(12, 'Medan', 'Simamora Nabolak', '110000', 'Ekonomi', 1, 1, '2023-05-12 20:53:55', '2023-05-12 20:53:55'),
(13, 'Medan', 'Sipahutar', '110000', 'Ekonomi', 1, 1, '2023-05-12 20:54:45', '2023-05-12 20:54:45'),
(14, 'Medan', 'Tarutung', '110000', 'Ekonomi', 1, 1, '2023-05-12 20:55:12', '2023-05-12 20:55:12'),
(15, 'Medan', 'Muara', '105000', 'Ekonomi', 1, 1, '2023-05-12 20:55:53', '2023-05-12 20:55:53'),
(16, 'Medan', 'Siborong-borong', '95000', 'Ekonomi', 1, 1, '2023-05-12 20:56:47', '2023-05-12 20:56:47'),
(17, 'Medan', 'Toba', '85000', 'Ekonomi', 1, 1, '2023-05-12 20:57:26', '2023-05-12 20:57:26'),
(18, 'Medan', 'Parapat', '80000', 'Ekonomi', 1, 1, '2023-05-12 20:58:01', '2023-05-12 20:58:01'),
(19, 'Medan', 'P.Siantar', '65000', 'Ekonomi', 1, 1, '2023-05-12 20:58:27', '2023-05-12 20:58:27'),
(20, 'Bandara Kualanamu', 'Tarutung', '180000', 'Eksekutif', 1, 1, '2023-05-12 20:59:13', '2023-05-12 20:59:13'),
(21, 'P.Siantar', 'Tarutung', '85000', 'Ekonomi', 1, 1, '2023-05-12 20:59:59', '2023-05-12 20:59:59'),
(22, 'P.Siantar', 'Bakkara', '85000', 'Ekonomi', 1, 1, '2023-05-12 21:00:31', '2023-05-12 21:00:31'),
(23, 'P.Siantar', 'Toba', '65000', 'Ekonomi', 1, 1, '2023-05-12 21:00:56', '2023-05-12 21:00:56'),
(24, 'P.Siantar', 'Siborong-borong', '75000', 'Ekonomi', 1, 1, '2023-05-12 21:01:26', '2023-05-12 21:01:26'),
(25, 'Parapat', 'Tarutung', '75000', 'Ekonomi', 1, 1, '2023-05-12 21:01:51', '2023-05-12 21:01:51'),
(26, 'Parapat', 'Bakkara', '75000', 'Ekonomi', 1, 1, '2023-05-12 21:02:10', '2023-05-12 21:02:10'),
(27, 'P.Sidimpuan', 'Tarutung', '80000', 'Ekonomi', 1, 1, '2023-05-12 21:02:46', '2023-05-12 21:02:46'),
(28, 'Tebing Tinggi', 'Tarutung', '95000', 'Ekonomi', 1, 1, '2023-05-12 21:03:13', '2023-05-12 21:03:13'),
(29, 'Tebing Tinggi', 'Bakkara', '95000', 'Ekonomi', 1, 1, '2023-05-12 21:03:35', '2023-05-12 21:03:35'),
(30, 'Tarutung', 'Medan', '140000', 'Eksekutif', 1, 1, '2023-07-16 18:58:01', '2023-07-16 18:58:01'),
(31, 'Medan', 'Balige', '80000', 'Ekonomi', 1, 1, '2023-07-18 00:48:12', '2023-07-18 00:48:12'),
(32, 'Tarutung', 'Balige', '10000', 'Ekonomi', 1, 2, '2024-05-10 03:01:37', '2024-06-09 23:20:54'),
(33, 'Sidikalang', 'Kabanjahe', '25000', 'Ekonomi', 1, 2, '2024-05-10 04:50:46', '2024-06-13 07:43:17');

-- --------------------------------------------------------

--
-- Struktur dari tabel `schedules`
--

CREATE TABLE `schedules` (
  `id` bigint UNSIGNED NOT NULL,
  `bus_id` bigint UNSIGNED NOT NULL,
  `route_id` bigint UNSIGNED NOT NULL,
  `tanggal` datetime NOT NULL,
  `harga` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1=Generated from default schedule, 0=Manual schedule'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `schedules`
--

INSERT INTO `schedules` (`id`, `bus_id`, `route_id`, `tanggal`, `harga`, `status`, `created_at`, `updated_at`, `is_default`) VALUES
(1, 10, 32, '2024-06-08 15:29:00', '50000', 'complete', '2024-06-07 22:29:23', '2024-06-09 19:02:07', 0),
(2, 10, 32, '2024-06-10 23:00:00', '50000', 'complete', '2024-06-09 19:58:24', '2024-06-09 19:58:24', 0),
(3, 18, 32, '2024-06-15 13:16:00', '50000', 'not_started', '2024-06-09 23:16:55', '2024-06-09 23:16:55', 0),
(4, 10, 33, '2024-06-11 21:06:00', '25000', 'complete', NULL, NULL, 0),
(12, 18, 32, '2024-06-15 11:44:00', '10000', 'complete', NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `sopir_brand`
--

CREATE TABLE `sopir_brand` (
  `id` bigint UNSIGNED NOT NULL,
  `id_sopir` bigint UNSIGNED NOT NULL,
  `brand_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `sopir_brand`
--

INSERT INTO `sopir_brand` (`id`, `id_sopir`, `brand_id`, `created_at`, `updated_at`) VALUES
(1, 14, 2, NULL, NULL),
(2, 26, 2, NULL, NULL),
(3, 6, 1, NULL, NULL),
(4, 5, 1, NULL, NULL),
(5, 7, 1, NULL, NULL),
(6, 15, 1, NULL, NULL),
(7, 16, 1, NULL, NULL),
(8, 18, 1, NULL, NULL),
(9, 22, 1, NULL, NULL),
(10, 28, 1, NULL, NULL),
(11, 35, 2, NULL, NULL),
(12, 36, 2, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `phone_number`, `address`, `gender`, `photo`, `status`, `password`, `role_id`, `email_verified_at`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'admin@mail.com', '', '', '', '', 1, '$2y$12$ft927ARKCbXkcC3ROJdvf.c0qxWFgtn/68njf8hRdt8ivRYiCCeKy', 0, NULL, NULL, '2024-05-17 09:15:55', '2024-05-17 09:15:55'),
(2, 'ADMIN KBT', 'adminkantorkbt@gmail.com', '082323234354', 'Tarutung', 'Laki-laki', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 1, NULL, '6418', NULL, '2024-05-31 21:33:11'),
(3, 'admin loket', 'adminloket@gmail.com', '082626348489', 'Medan', 'Perempuan', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 4, NULL, '1869', NULL, '2023-07-17 01:40:11'),
(4, 'Penumpang01', 'penumpang@gmail.com', '0836646464', 'Tarutung', 'Laki-laki', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 2, NULL, NULL, '2023-04-16 23:51:46', '2023-05-16 00:10:08'),
(5, 'supir exe 01', 'supir01@gmail.com', '0823243280', 'Tarutung', 'Laki-laki', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 3, NULL, NULL, '2023-04-16 23:54:03', '2024-05-26 05:33:01'),
(6, 'supir 1', 'supir02@gmail.com', '6767676767', 'Silimbat', 'Laki-laki', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 3, NULL, '5920', '2023-04-16 23:56:01', '2024-06-05 23:45:56'),
(7, 'panji harahap', 'supir03@gmail.com', '82473487344', 'Tarutung Kota', 'Laki-laki', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 3, NULL, NULL, '2023-04-17 13:50:00', '2023-07-16 04:50:43'),
(8, 'Haris Daong', 'adminloket2@gmail.com', '083748374761', 'silaen', 'Laki-laki', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 4, NULL, NULL, '2023-05-11 20:59:23', '2024-05-11 21:55:34'),
(9, 'supriyanto', 'adminloket03@gmail.com', '20394837488', 'silaen\ntoba', 'Laki-laki', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 4, NULL, NULL, '2023-05-11 21:02:03', '2023-07-16 18:55:31'),
(10, 'Hutur Siagian', 'hutur@gmail.com', '08473748288', 'Porsea', 'Laki-laki', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 4, NULL, NULL, '2023-05-12 21:50:57', '2023-05-12 21:50:57'),
(11, 'Sandi Panjaitan', 'sandi@gmail.com', '039378321', 'Tarutung', 'Laki-laki', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 4, NULL, NULL, '2023-05-12 21:52:11', '2023-05-15 23:06:27'),
(12, 'Arifman', 'arifman22@gmail.com', '092408487842787', 'Medan', 'Laki-laki', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 4, NULL, NULL, '2023-05-12 21:54:59', '2023-07-16 18:55:34'),
(14, 'Supir TTI 1', 'britneyspears@gmail.com', '082626348489', 'SIlaen pedalaman', 'Laki-laki', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 3, NULL, '6016', '2023-05-22 22:58:01', '2024-06-14 03:26:11'),
(15, 'supir 04', 'supir04@gmail.com', '082473487343', 'silaen toba', 'Laki-laki', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 3, NULL, NULL, '2023-05-23 19:49:55', '2023-05-23 19:49:55'),
(16, 'uli', 'uli@gmail.com', '083273627', 'silaen', 'Laki-laki', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 3, NULL, NULL, '2023-05-23 20:31:23', '2023-05-23 20:31:23'),
(17, 'DIREKSI', 'direksi@gmail.com', '083736725442', 'Tarutung', 'Laki-laki', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 5, NULL, '4861', NULL, '2024-05-29 05:11:45'),
(18, 'supir online`', 'supironline@gmail.com', '02839238293', 'Medan', 'Perempuan', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 3, NULL, NULL, '2023-06-13 20:29:49', '2023-06-13 20:29:49'),
(19, 'Alexander Napitupulu', 'alexander@gmail.com', '0836646464', 'silaen', 'Laki-laki', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 2, NULL, NULL, '2023-07-03 05:46:25', '2023-07-03 05:46:25'),
(20, 'Clarita Butarbutar', 'claritabutar10@gmail.com', '081397154745', 'Medan', 'Perempuan', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 4, NULL, NULL, '2023-07-14 06:34:14', '2023-07-14 06:34:14'),
(21, 'sandi', 'sandika@gmail.com', '0823495849839', 'medan', 'Laki-laki', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 2, NULL, NULL, '2023-07-17 20:41:07', '2023-07-17 20:41:07'),
(22, 'Siagian', 'siagian@gmail.com', '08268883321', 'Medan', 'Laki-laki', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 3, NULL, NULL, '2023-07-17 23:30:02', '2023-07-17 23:30:02'),
(23, 'supir test', 'supirtest@gmail.com', '082473487343', 'silaen toba', 'Laki-laki', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 3, NULL, NULL, '2023-07-17 23:32:31', '2023-07-17 23:32:31'),
(24, 'testa', 'test@gmail.com', '082626348489', 'jln.Parsoburan ,simarakkir, Desa Napitupulu Kec. SIlaen, Kab. Toba, prov. Sumater Utara', 'Laki-laki', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 3, NULL, NULL, '2023-07-17 23:33:41', '2024-05-05 20:11:47'),
(25, 'testa', 'testss@gmail.com', '082626348489', 'jln.Parsoburan ,simarakkir, Desa Napitupulu Kec. SIlaen, Kab. Toba, prov. Sumater Utara', 'Laki-laki', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 3, NULL, NULL, '2023-07-17 23:34:37', '2023-07-17 23:34:37'),
(26, 'Supir TTI 2', 'testssssww@gmail.com', '082626348489', 'jln.Parsoburan ,simarakkir, Desa Napitupulu Kec. SIlaen, Kab. Toba, prov. Sumater Utara', 'Laki-laki', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 3, NULL, NULL, '2023-07-17 23:34:49', '2024-06-14 03:26:04'),
(27, 'sasa', 'sasa@dssds', '082626348489', 'Medan', 'Laki-laki', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 3, NULL, NULL, '2023-07-17 23:35:22', '2023-07-17 23:35:22'),
(28, 'yona', 'yona@gmail.com', '089278732726', 'silaen', 'Laki-laki', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 3, NULL, NULL, '2023-07-17 23:38:08', '2023-07-17 23:38:08'),
(29, 'yaya', 'yaya@gmail.com', '0839843948', 'Jayapura', 'Laki-laki', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 3, NULL, NULL, '2023-07-17 23:39:58', '2023-07-17 23:39:58'),
(30, 'zizi', 'zizi@gmail.com', '0828372837', 'Medan', 'Laki-laki', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 3, NULL, NULL, '2023-07-17 23:41:34', '2023-07-17 23:41:34'),
(31, 'Koko', 'koko@gmail.com', '082374347878', 'Tarutung', 'Laki-laki', 'null', 0, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 4, NULL, NULL, '2023-07-18 00:07:00', '2023-07-18 00:07:13'),
(32, 'Viv', 'admin_tti@gmail.com', '081234567890', 'Medan', 'Laki-laki', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 1, NULL, NULL, '2024-04-29 01:59:52', '2024-04-29 01:59:52'),
(33, '11422042 Vivaldi A. S.', 'vivadvent@gmail.com', '085277922115', 'New York', 'Perempuan', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 2, NULL, '5671', '2024-04-29 02:44:10', '2024-06-13 09:55:14'),
(34, 'AdminLoket TTI 1', 'lokettti1@gmail.com', '0888888888', 'Yunani', 'Perempuan', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 4, NULL, NULL, '2024-05-11 22:17:00', '2024-05-11 22:18:07'),
(35, 'Supir TTI 3', 'colepalmer@gmail.com', '087312812387', 'Budapest', 'Laki-laki', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 3, NULL, NULL, '2024-05-11 22:58:00', '2024-06-14 03:27:16'),
(36, 'Supir TTI 4', 'rubendias@gmail.com', '0812832982', 'Philadelphia', 'Laki-laki', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 3, NULL, NULL, '2024-05-12 00:19:58', '2024-06-14 03:27:09'),
(37, 'Benni', 'benni@gmail.com', '11111111111', 'Irlandia', 'Laki-laki', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 4, NULL, NULL, '2024-05-12 03:15:22', '2024-05-12 03:15:22'),
(38, 'masrin sinaga', 'masrin@gmail.com', '6574838290', 'Jl. Sibolga', 'Perempuan', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 1, NULL, NULL, '2024-05-28 01:28:43', '2024-05-28 01:39:34'),
(39, 'Estes Solo Lords', 'estes@gmail.com', '643782948', 'Jerman', 'Perempuan', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 1, NULL, NULL, '2024-05-28 21:54:22', '2024-06-05 10:35:32'),
(40, 'AdminLoket TTI Padangg', 'adminttipadang@gmail.com', '574890', 'New York', 'Laki-laki', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 4, NULL, NULL, '2024-06-05 07:27:04', '2024-06-05 07:27:04'),
(41, 'Admin Tiomaz', 'tiomazbus@gmail.com', '087799829991', 'JLN.sisingamangaraja', 'Laki-laki', 'null', 1, '$2y$10$xhJBbM6L/.IFb5yaNnNkPeWyoOULCG9BSFx6HpM/55zBbYJveBcym', 1, NULL, NULL, '2024-06-05 10:38:05', '2024-06-05 10:39:04'),
(42, 'aquas', 'aqua@gmail.com', '89899898', 'las vegas', 'Laki-laki', 'null', 1, '$2y$10$Z34mcoXqAMinMhFZki5nN.4X/Cj.iOYwMZ/gcDgu8lmcK.Cb768e2', 2, NULL, NULL, '2024-06-05 20:26:08', '2024-06-13 08:27:07'),
(43, 'Parisma admin', 'parisma@gmail.com', '087799829991', 'jl.sisingamangaraja', 'Laki-laki', 'null', 1, '$2y$10$R9QqY9Bcx4sKdkzLuLOZ1eWyEl0vpmRMfIGSOa4joAam0obxKhOhi', 1, NULL, NULL, '2024-06-05 23:23:35', '2024-06-05 23:23:35');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `adminloket_brand`
--
ALTER TABLE `adminloket_brand`
  ADD PRIMARY KEY (`id`),
  ADD KEY `adminloket_brand_id_adminloket_foreign` (`id_adminloket`),
  ADD KEY `adminloket_brand_brand_id_foreign` (`brand_id`);

--
-- Indeks untuk tabel `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bookings_user_id_foreign` (`user_id`),
  ADD KEY `bookings_schedules_id_foreign` (`schedules_id`);

--
-- Indeks untuk tabel `booking_seats`
--
ALTER TABLE `booking_seats`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bookingidbookingseats` (`booking_id`);

--
-- Indeks untuk tabel `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`),
  ADD KEY `adminbrand_id` (`admin_id`),
  ADD KEY `idx_id` (`id`);

--
-- Indeks untuk tabel `buses`
--
ALTER TABLE `buses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `supirusers` (`supir_id`),
  ADD KEY `loketbus` (`loket_id`),
  ADD KEY `brandnyabus` (`merk_id`);

--
-- Indeks untuk tabel `default_schedules`
--
ALTER TABLE `default_schedules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `busdefaultschedules` (`bus_id`),
  ADD KEY `rutejadwaldefault` (`route_id`);

--
-- Indeks untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `komisi`
--
ALTER TABLE `komisi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_brand_id` (`brand_id`);

--
-- Indeks untuk tabel `lokets`
--
ALTER TABLE `lokets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `adminloket` (`admin_id`);

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indeks untuk tabel `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jadwalpayment` (`schedules_id`),
  ADD KEY `bookingpayment` (`bookings_id`);

--
-- Indeks untuk tabel `penghasilan_per_jadwal`
--
ALTER TABLE `penghasilan_per_jadwal`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `schedule_id` (`schedule_id`);

--
-- Indeks untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `routes`
--
ALTER TABLE `routes`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `schedules`
--
ALTER TABLE `schedules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `busjadwal` (`bus_id`),
  ADD KEY `rutenyajadwal` (`route_id`);

--
-- Indeks untuk tabel `sopir_brand`
--
ALTER TABLE `sopir_brand`
  ADD PRIMARY KEY (`id`),
  ADD KEY `brandnyapersopir` (`brand_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `adminloket_brand`
--
ALTER TABLE `adminloket_brand`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT untuk tabel `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=314;

--
-- AUTO_INCREMENT untuk tabel `booking_seats`
--
ALTER TABLE `booking_seats`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT untuk tabel `brands`
--
ALTER TABLE `brands`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `buses`
--
ALTER TABLE `buses`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT untuk tabel `default_schedules`
--
ALTER TABLE `default_schedules`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `komisi`
--
ALTER TABLE `komisi`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `lokets`
--
ALTER TABLE `lokets`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;

--
-- AUTO_INCREMENT untuk tabel `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT untuk tabel `penghasilan_per_jadwal`
--
ALTER TABLE `penghasilan_per_jadwal`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `routes`
--
ALTER TABLE `routes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT untuk tabel `schedules`
--
ALTER TABLE `schedules`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT untuk tabel `sopir_brand`
--
ALTER TABLE `sopir_brand`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `adminloket_brand`
--
ALTER TABLE `adminloket_brand`
  ADD CONSTRAINT `brandadminloketbrand` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `idadminloket` FOREIGN KEY (`id_adminloket`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ketidakleluasaan untuk tabel `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `uesrbooking` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Ketidakleluasaan untuk tabel `booking_seats`
--
ALTER TABLE `booking_seats`
  ADD CONSTRAINT `bookingidbookingseats` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ketidakleluasaan untuk tabel `brands`
--
ALTER TABLE `brands`
  ADD CONSTRAINT `adminbrand_id` FOREIGN KEY (`admin_id`) REFERENCES `users` (`id`);

--
-- Ketidakleluasaan untuk tabel `buses`
--
ALTER TABLE `buses`
  ADD CONSTRAINT `brandnyabus` FOREIGN KEY (`merk_id`) REFERENCES `brands` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `loketbus` FOREIGN KEY (`loket_id`) REFERENCES `lokets` (`id`),
  ADD CONSTRAINT `supirusers` FOREIGN KEY (`supir_id`) REFERENCES `users` (`id`);

--
-- Ketidakleluasaan untuk tabel `default_schedules`
--
ALTER TABLE `default_schedules`
  ADD CONSTRAINT `busdefaultschedules` FOREIGN KEY (`bus_id`) REFERENCES `buses` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `rutejadwaldefault` FOREIGN KEY (`route_id`) REFERENCES `routes` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ketidakleluasaan untuk tabel `lokets`
--
ALTER TABLE `lokets`
  ADD CONSTRAINT `adminloket` FOREIGN KEY (`admin_id`) REFERENCES `users` (`id`);

--
-- Ketidakleluasaan untuk tabel `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `bookingpayment` FOREIGN KEY (`bookings_id`) REFERENCES `bookings` (`id`);

--
-- Ketidakleluasaan untuk tabel `penghasilan_per_jadwal`
--
ALTER TABLE `penghasilan_per_jadwal`
  ADD CONSTRAINT `schedulespenghasilanperjadwal` FOREIGN KEY (`schedule_id`) REFERENCES `schedules` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ketidakleluasaan untuk tabel `schedules`
--
ALTER TABLE `schedules`
  ADD CONSTRAINT `busjadwal` FOREIGN KEY (`bus_id`) REFERENCES `buses` (`id`),
  ADD CONSTRAINT `rutenyajadwal` FOREIGN KEY (`route_id`) REFERENCES `routes` (`id`);

--
-- Ketidakleluasaan untuk tabel `sopir_brand`
--
ALTER TABLE `sopir_brand`
  ADD CONSTRAINT `brandnyapersopir` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
