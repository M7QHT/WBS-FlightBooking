-- Adminer 4.8.1 MySQL 8.0.45-0ubuntu0.24.04.1 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `bookings`;
CREATE TABLE `bookings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `flight_id` int NOT NULL,
  `passenger_name` varchar(100) NOT NULL,
  `passport_number` varchar(20) NOT NULL,
  `seat_number` varchar(10) DEFAULT NULL,
  `booking_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('Confirmed','Cancelled') DEFAULT 'Confirmed',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `flight_id` (`flight_id`),
  CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`flight_id`) REFERENCES `flights` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `bookings` (`id`, `user_id`, `flight_id`, `passenger_name`, `passport_number`, `seat_number`, `booking_date`, `status`) VALUES
(1,	2,	1,	'Ahmed Al-Saud',	'A1234567',	'12A',	'2026-05-02 14:46:27',	'Confirmed'),
(2,	1,	1,	'Mohammed',	'223018654',	'',	'2026-05-02 16:43:41',	'Cancelled'),
(3,	4,	1,	'Mohammed Alqahtani',	'A223018645',	'3D',	'2026-05-02 17:33:14',	'Confirmed'),
(4,	5,	6,	'Yyy',	'123466',	'4F',	'2026-05-02 18:01:31',	'Confirmed'),
(5,	6,	1,	'abdulelah',	'A123456',	'1C',	'2026-05-02 18:02:43',	'Confirmed');

DROP TABLE IF EXISTS `flights`;
CREATE TABLE `flights` (
  `id` int NOT NULL AUTO_INCREMENT,
  `flight_number` varchar(10) NOT NULL,
  `airline` varchar(50) NOT NULL,
  `origin` varchar(50) NOT NULL,
  `origin_code` varchar(5) NOT NULL,
  `destination` varchar(50) NOT NULL,
  `destination_code` varchar(5) NOT NULL,
  `departure_time` datetime NOT NULL,
  `arrival_time` datetime NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `class` enum('Economy','Business','First Class') DEFAULT 'Economy',
  `status` enum('Scheduled','Delayed','Departed','Arrived','Cancelled') DEFAULT 'Scheduled',
  `seats_available` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `flights` (`id`, `flight_number`, `airline`, `origin`, `origin_code`, `destination`, `destination_code`, `departure_time`, `arrival_time`, `price`, `class`, `status`, `seats_available`) VALUES
(1,	'SV105',	'Saudia',	'Riyadh',	'RUH',	'Jeddah',	'JED',	'2026-05-10 10:00:00',	'2026-05-10 11:45:00',	350.00,	'Economy',	'Scheduled',	148),
(2,	'EK303',	'Emirates',	'Dubai',	'DXB',	'Riyadh',	'RUH',	'2026-05-15 09:00:00',	'2026-05-15 11:00:00',	550.00,	'Business',	'Scheduled',	40),
(3,	'XY101',	'Flynas',	'Riyadh',	'RUH',	'Dammam',	'DMM',	'2026-05-12 08:00:00',	'2026-05-12 09:10:00',	250.00,	'Economy',	'Scheduled',	120),
(4,	'SV202',	'Saudia',	'Jeddah',	'JED',	'Dubai',	'DXB',	'2026-05-13 14:00:00',	'2026-05-13 17:00:00',	850.00,	'Economy',	'Scheduled',	200),
(5,	'QR404',	'Qatar Airways',	'Doha',	'DOH',	'Riyadh',	'RUH',	'2026-05-14 10:00:00',	'2026-05-14 11:30:00',	650.00,	'Business',	'Scheduled',	30),
(6,	'BA033',	'British Airways',	'London',	'LHR',	'Riyadh',	'RUH',	'2026-05-16 09:00:00',	'2026-05-16 18:00:00',	3200.00,	'Economy',	'Scheduled',	249),
(7,	'EK404',	'Emirates',	'Dubai',	'DXB',	'Jeddah',	'JED',	'2026-05-17 12:00:00',	'2026-05-17 14:30:00',	700.00,	'Economy',	'Scheduled',	180),
(8,	'SV101',	'Saudia',	'Riyadh',	'RUH',	'London',	'LHR',	'2026-06-01 08:00:00',	'2026-06-01 13:30:00',	3200.00,	'Economy',	'Scheduled',	180),
(9,	'EK202',	'Emirates',	'Dubai',	'DXB',	'New York',	'JFK',	'2026-06-01 14:00:00',	'2026-06-02 02:00:00',	4500.00,	'Business',	'Scheduled',	40),
(10,	'XY303',	'Flynas',	'Dammam',	'DMM',	'Cairo',	'CAI',	'2026-06-02 09:00:00',	'2026-06-02 11:45:00',	1100.00,	'Economy',	'Scheduled',	150),
(11,	'QR404',	'Qatar Airways',	'Doha',	'DOH',	'Paris',	'CDG',	'2026-06-02 16:00:00',	'2026-06-02 21:30:00',	3800.00,	'First Class',	'Scheduled',	12),
(12,	'TK505',	'Turkish Airlines',	'Istanbul',	'IST',	'Medina',	'MED',	'2026-06-03 10:00:00',	'2026-06-03 13:30:00',	1400.00,	'Economy',	'Scheduled',	220),
(13,	'SV606',	'Saudia',	'Jeddah',	'JED',	'Riyadh',	'RUH',	'2026-06-03 18:00:00',	'2026-06-03 19:45:00',	450.00,	'Economy',	'Scheduled',	160),
(14,	'G9707',	'Air Arabia',	'Sharjah',	'SHJ',	'Abha',	'AHB',	'2026-06-04 07:00:00',	'2026-06-04 09:15:00',	600.00,	'Economy',	'Scheduled',	140),
(15,	'KU808',	'Kuwait Airways',	'Kuwait',	'KWI',	'Jeddah',	'JED',	'2026-06-04 12:00:00',	'2026-06-04 14:10:00',	950.00,	'Economy',	'Scheduled',	170),
(16,	'EY909',	'Etihad Airways',	'Abu Dhabi',	'AUH',	'Tokyo',	'NRT',	'2026-06-05 22:00:00',	'2026-06-06 11:00:00',	5200.00,	'Business',	'Scheduled',	35),
(17,	'GF110',	'Gulf Air',	'Bahrain',	'BAH',	'Riyadh',	'RUH',	'2026-06-05 15:00:00',	'2026-06-05 16:15:00',	700.00,	'Economy',	'Scheduled',	110),
(18,	'SV211',	'Saudia',	'Riyadh',	'RUH',	'Madrid',	'MAD',	'2026-06-06 02:00:00',	'2026-06-06 08:30:00',	2900.00,	'Economy',	'Scheduled',	190),
(19,	'LH312',	'Lufthansa',	'Frankfurt',	'FRA',	'Jeddah',	'JED',	'2026-06-06 13:00:00',	'2026-06-06 19:30:00',	3100.00,	'Economy',	'Scheduled',	210),
(20,	'MS413',	'EgyptAir',	'Cairo',	'CAI',	'Dammam',	'DMM',	'2026-06-07 05:00:00',	'2026-06-07 08:45:00',	1250.00,	'Economy',	'Scheduled',	165),
(21,	'EK514',	'Emirates',	'Dubai',	'DXB',	'London',	'LHR',	'2026-06-07 09:00:00',	'2026-06-07 13:45:00',	3500.00,	'Economy',	'Scheduled',	300),
(22,	'SV615',	'Saudia',	'Jeddah',	'JED',	'Casablanca',	'CMN',	'2026-06-08 10:30:00',	'2026-06-08 16:45:00',	2100.00,	'Economy',	'Scheduled',	240),
(23,	'XY716',	'Flynas',	'Riyadh',	'RUH',	'Dubai',	'DXB',	'2026-06-08 20:00:00',	'2026-06-08 22:50:00',	550.00,	'Economy',	'Scheduled',	155),
(24,	'QR817',	'Qatar Airways',	'Doha',	'DOH',	'Milan',	'MXP',	'2026-06-09 01:00:00',	'2026-06-09 06:45:00',	4200.00,	'Business',	'Scheduled',	28),
(25,	'TK918',	'Turkish Airlines',	'Istanbul',	'IST',	'Riyadh',	'RUH',	'2026-06-09 11:00:00',	'2026-06-09 15:15:00',	1350.00,	'Economy',	'Scheduled',	195),
(26,	'SV119',	'Saudia',	'Medina',	'MED',	'Jeddah',	'JED',	'2026-06-10 16:00:00',	'2026-06-10 17:15:00',	350.00,	'Economy',	'Scheduled',	145),
(27,	'AI220',	'Air India',	'Mumbai',	'BOM',	'Dammam',	'DMM',	'2026-06-10 21:00:00',	'2026-06-11 00:15:00',	1200.00,	'Economy',	'Scheduled',	250);

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('admin','user') DEFAULT 'user',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `users` (`id`, `username`, `email`, `password_hash`, `role`) VALUES
(1,	'admin',	'admin@flightbook.com',	'$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',	'admin'),
(2,	'khalid_m',	'khalid@example.com',	'$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',	'user'),
(4,	'Mohammed',	'123513@hotmail.com',	'$2y$10$aMkbpXtkNCPoKjgepDFhFekjgO1h7UVbxASPZs0K5OoCnHy3pjPHy',	'user'),
(5,	'Jay',	'oker.hh@gmail.com',	'$2y$10$hr5MS.Xv6w1siKhQyQELAOC6hnFBJt92BU9MRuYSNX3ZcQ.kCiVaq',	'user'),
(6,	'abdulelah',	'grgosh@gmail.com',	'$2y$10$ErITbev9XKX/SVjpfrUhF.nreiOJqAOwl5Y8EJDfbjyf3pzyR1Y1O',	'user');

-- 2026-05-02 18:36:40
