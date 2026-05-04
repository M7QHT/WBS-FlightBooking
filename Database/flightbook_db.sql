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
  `pnr` varchar(20) DEFAULT NULL,
  `passenger_name` varchar(100) NOT NULL,
  `passport_number` varchar(20) NOT NULL,
  `seat_number` varchar(10) DEFAULT NULL,
  `baggage` varchar(50) DEFAULT '20KG (Included)',
  `price_paid` decimal(10,2) DEFAULT '0.00',
  `booking_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('Confirmed','Cancelled') DEFAULT 'Confirmed',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `flight_id` (`flight_id`),
  CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`flight_id`) REFERENCES `flights` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `bookings` (`id`, `user_id`, `flight_id`, `pnr`, `passenger_name`, `passport_number`, `seat_number`, `baggage`, `price_paid`, `booking_date`, `status`) VALUES
(1,	2,	1,	NULL,	'Ahmed Al-Saud',	'A1234567',	'12A',	'20KG (Included)',	0.00,	'2026-05-02 14:46:27',	'Confirmed'),
(3,	4,	1,	NULL,	'Mohammed Alqahtani',	'A223018645',	'3D',	'20KG (Included)',	0.00,	'2026-05-02 17:33:14',	'Confirmed'),
(4,	5,	6,	NULL,	'Yyy',	'123466',	'4F',	'20KG (Included)',	0.00,	'2026-05-02 18:01:31',	'Confirmed'),
(5,	6,	1,	NULL,	'abdulelah',	'A123456',	'1C',	'20KG (Included)',	0.00,	'2026-05-02 18:02:43',	'Confirmed'),
(6,	4,	1,	'PNR-0MEC57',	'test',	'123',	'1E',	'20KG (Included)',	400.00,	'2026-05-04 12:23:24',	'Confirmed'),
(7,	4,	1,	'PNR-GIH9KC',	'mohammed alqahtani',	'A223018654',	'2F',	'40KG',	650.00,	'2026-05-04 12:29:23',	'Confirmed');

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
(1,	'SV105',	'Saudia',	'Riyadh',	'RUH',	'Jeddah',	'JED',	'2026-05-10 10:00:00',	'2026-05-10 11:45:00',	350.00,	'Economy',	'Scheduled',	146),
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
(27,	'AI220',	'Air India',	'Mumbai',	'BOM',	'Dammam',	'DMM',	'2026-06-10 21:00:00',	'2026-06-11 00:15:00',	1200.00,	'Economy',	'Scheduled',	250),
(28,	'SV100',	'Saudia',	'Riyadh',	'RUH',	'Jeddah',	'JED',	'2026-05-15 08:00:00',	'2026-05-15 09:45:00',	350.00,	'Economy',	'Scheduled',	120),
(29,	'SV101',	'Saudia',	'Jeddah',	'JED',	'Riyadh',	'RUH',	'2026-05-15 12:00:00',	'2026-05-15 13:45:00',	350.00,	'Economy',	'Scheduled',	120),
(30,	'XY200',	'Flynas',	'Riyadh',	'RUH',	'Dammam',	'DMM',	'2026-05-16 07:00:00',	'2026-05-16 08:10:00',	180.00,	'Economy',	'Scheduled',	150),
(31,	'XY201',	'Flynas',	'Dammam',	'DMM',	'Riyadh',	'RUH',	'2026-05-16 10:00:00',	'2026-05-16 11:10:00',	180.00,	'Economy',	'Scheduled',	150),
(32,	'EK300',	'Emirates',	'Dubai',	'DXB',	'Riyadh',	'RUH',	'2026-05-17 09:00:00',	'2026-05-17 11:00:00',	650.00,	'Economy',	'Scheduled',	200),
(33,	'EK301',	'Emirates',	'Riyadh',	'RUH',	'Dubai',	'DXB',	'2026-05-17 14:00:00',	'2026-05-17 16:00:00',	700.00,	'Business',	'Scheduled',	40),
(34,	'QR400',	'Qatar Airways',	'Doha',	'DOH',	'Jeddah',	'JED',	'2026-05-18 16:00:00',	'2026-05-18 18:30:00',	850.00,	'Economy',	'Scheduled',	180),
(35,	'TK500',	'Turkish Airlines',	'Istanbul',	'IST',	'Medina',	'MED',	'2026-05-19 23:00:00',	'2026-05-20 03:00:00',	1200.00,	'Economy',	'Scheduled',	250),
(36,	'BA600',	'British Airways',	'London',	'LHR',	'Riyadh',	'RUH',	'2026-05-21 10:00:00',	'2026-05-21 18:00:00',	3200.00,	'Economy',	'Scheduled',	220),
(37,	'MS700',	'EgyptAir',	'Cairo',	'CAI',	'Jeddah',	'JED',	'2026-05-22 05:00:00',	'2026-05-22 07:30:00',	950.00,	'Economy',	'Scheduled',	170),
(38,	'SV110',	'Saudia',	'Medina',	'MED',	'Jeddah',	'JED',	'2026-05-23 09:00:00',	'2026-05-23 10:00:00',	250.00,	'Economy',	'Scheduled',	140),
(39,	'XY210',	'Flynas',	'Abha',	'AHB',	'Riyadh',	'RUH',	'2026-05-24 14:00:00',	'2026-05-24 15:45:00',	300.00,	'Economy',	'Scheduled',	155),
(40,	'EY800',	'Etihad Airways',	'Abu Dhabi',	'AUH',	'Riyadh',	'RUH',	'2026-05-25 08:30:00',	'2026-05-25 10:15:00',	550.00,	'Economy',	'Scheduled',	190),
(41,	'SV120',	'Saudia',	'Riyadh',	'RUH',	'London',	'LHR',	'2026-05-26 01:00:00',	'2026-05-26 07:30:00',	3500.00,	'Business',	'Scheduled',	30),
(42,	'LH900',	'Lufthansa',	'Frankfurt',	'FRA',	'Riyadh',	'RUH',	'2026-05-27 13:00:00',	'2026-05-27 20:00:00',	2800.00,	'Economy',	'Scheduled',	210),
(43,	'SV130',	'Saudia',	'Jeddah',	'JED',	'Cairo',	'CAI',	'2026-05-28 10:00:00',	'2026-05-28 11:30:00',	800.00,	'Economy',	'Scheduled',	200),
(44,	'XY220',	'Flynas',	'Riyadh',	'RUH',	'Dubai',	'DXB',	'2026-05-29 18:00:00',	'2026-05-29 20:00:00',	450.00,	'Economy',	'Scheduled',	160),
(45,	'TK510',	'Turkish Airlines',	'Medina',	'MED',	'Istanbul',	'IST',	'2026-05-30 04:00:00',	'2026-05-30 08:00:00',	1350.00,	'Economy',	'Scheduled',	240),
(46,	'EK310',	'Emirates',	'Dubai',	'DXB',	'Jeddah',	'JED',	'2026-05-31 11:00:00',	'2026-05-31 13:45:00',	900.00,	'Economy',	'Scheduled',	280),
(47,	'SV140',	'Saudia',	'Tabuk',	'TUU',	'Riyadh',	'RUH',	'2026-06-01 07:00:00',	'2026-06-01 08:45:00',	320.00,	'Economy',	'Scheduled',	130),
(48,	'XY230',	'Flynas',	'Riyadh',	'RUH',	'Jizan',	'GIZ',	'2026-06-02 09:30:00',	'2026-06-02 11:15:00',	280.00,	'Economy',	'Scheduled',	145),
(49,	'QR410',	'Qatar Airways',	'Doha',	'DOH',	'London',	'LHR',	'2026-06-03 08:00:00',	'2026-06-03 15:00:00',	4200.00,	'First Class',	'Scheduled',	12),
(50,	'BA610',	'British Airways',	'London',	'LHR',	'Dubai',	'DXB',	'2026-06-04 22:00:00',	'2026-06-05 06:00:00',	3800.00,	'Business',	'Scheduled',	45),
(51,	'SV150',	'Saudia',	'Riyadh',	'RUH',	'Paris',	'CDG',	'2026-06-05 02:00:00',	'2026-06-05 08:30:00',	4100.00,	'Economy',	'Scheduled',	180),
(52,	'EK320',	'Emirates',	'Dubai',	'DXB',	'New York',	'JFK',	'2026-06-06 08:30:00',	'2026-06-06 14:00:00',	5200.00,	'Economy',	'Scheduled',	320),
(53,	'XY240',	'Flynas',	'Dammam',	'DMM',	'Cairo',	'CAI',	'2026-06-07 10:00:00',	'2026-06-07 13:00:00',	850.00,	'Economy',	'Scheduled',	175),
(54,	'TK520',	'Turkish Airlines',	'Istanbul',	'IST',	'Riyadh',	'RUH',	'2026-06-08 19:00:00',	'2026-06-08 23:00:00',	1100.00,	'Economy',	'Scheduled',	215),
(55,	'SV160',	'Saudia',	'Jeddah',	'JED',	'Medina',	'MED',	'2026-06-09 15:00:00',	'2026-06-09 16:00:00',	250.00,	'Economy',	'Scheduled',	110),
(56,	'MS710',	'EgyptAir',	'Cairo',	'CAI',	'Riyadh',	'RUH',	'2026-06-10 11:00:00',	'2026-06-10 14:30:00',	1050.00,	'Economy',	'Scheduled',	195),
(57,	'SV170',	'Saudia',	'Riyadh',	'RUH',	'Casablanca',	'CMN',	'2026-06-11 04:00:00',	'2026-06-11 11:30:00',	2900.00,	'Economy',	'Scheduled',	230),
(58,	'XY250',	'Flynas',	'Riyadh',	'RUH',	'Medina',	'MED',	'2026-06-12 17:00:00',	'2026-06-12 18:30:00',	220.00,	'Economy',	'Scheduled',	165),
(59,	'EK330',	'Emirates',	'Dubai',	'DXB',	'London',	'LHR',	'2026-06-13 09:15:00',	'2026-06-13 13:30:00',	3100.00,	'Economy',	'Scheduled',	300),
(60,	'SV180',	'Saudia',	'Jeddah',	'JED',	'Dubai',	'DXB',	'2026-06-14 13:00:00',	'2026-06-14 16:00:00',	750.00,	'Economy',	'Scheduled',	220),
(61,	'QR420',	'Qatar Airways',	'Doha',	'DOH',	'Riyadh',	'RUH',	'2026-06-15 10:30:00',	'2026-06-15 12:00:00',	600.00,	'Business',	'Scheduled',	25),
(62,	'BA620',	'British Airways',	'London',	'LHR',	'Jeddah',	'JED',	'2026-06-16 11:00:00',	'2026-06-16 19:30:00',	3400.00,	'Economy',	'Scheduled',	240),
(63,	'TK530',	'Turkish Airlines',	'Istanbul',	'IST',	'London',	'LHR',	'2026-06-17 08:00:00',	'2026-06-17 10:00:00',	1250.00,	'Economy',	'Scheduled',	210),
(64,	'LH910',	'Lufthansa',	'Frankfurt',	'FRA',	'Dubai',	'DXB',	'2026-06-18 20:00:00',	'2026-06-19 04:00:00',	2950.00,	'Economy',	'Scheduled',	205),
(65,	'SV190',	'Saudia',	'Riyadh',	'RUH',	'Geneva',	'GVA',	'2026-06-20 03:30:00',	'2026-06-20 09:00:00',	4800.00,	'Business',	'Scheduled',	28),
(66,	'XY260',	'Flynas',	'Medina',	'MED',	'Riyadh',	'RUH',	'2026-06-21 07:00:00',	'2026-06-21 08:30:00',	220.00,	'Economy',	'Scheduled',	170),
(67,	'EK340',	'Emirates',	'Dubai',	'DXB',	'Paris',	'CDG',	'2026-06-22 08:20:00',	'2026-06-22 13:30:00',	3300.00,	'Economy',	'Scheduled',	310),
(68,	'SV200',	'Saudia',	'Jeddah',	'JED',	'London',	'LHR',	'2026-06-23 01:15:00',	'2026-06-23 07:45:00',	3600.00,	'Economy',	'Scheduled',	215),
(69,	'QR430',	'Qatar Airways',	'Doha',	'DOH',	'Cairo',	'CAI',	'2026-06-24 16:30:00',	'2026-06-24 19:45:00',	1100.00,	'Economy',	'Scheduled',	190),
(70,	'SV210',	'Saudia',	'Riyadh',	'RUH',	'Dammam',	'DMM',	'2026-06-25 18:00:00',	'2026-06-25 19:10:00',	190.00,	'Economy',	'Scheduled',	145),
(71,	'XY270',	'Flynas',	'Dammam',	'DMM',	'Jeddah',	'JED',	'2026-06-26 12:00:00',	'2026-06-26 14:15:00',	380.00,	'Economy',	'Scheduled',	160),
(72,	'TK540',	'Turkish Airlines',	'Istanbul',	'IST',	'Dubai',	'DXB',	'2026-06-27 21:00:00',	'2026-06-28 01:30:00',	1400.00,	'Economy',	'Scheduled',	225),
(73,	'EK350',	'Emirates',	'Dubai',	'DXB',	'Milan',	'MXP',	'2026-06-28 09:45:00',	'2026-06-28 14:20:00',	3050.00,	'Economy',	'Scheduled',	290),
(74,	'SV220',	'Saudia',	'Medina',	'MED',	'Cairo',	'CAI',	'2026-06-29 10:30:00',	'2026-06-29 12:15:00',	850.00,	'Economy',	'Scheduled',	185),
(75,	'XY280',	'Flynas',	'Riyadh',	'RUH',	'Istanbul',	'IST',	'2026-06-30 14:00:00',	'2026-06-30 18:30:00',	950.00,	'Economy',	'Scheduled',	170),
(76,	'QR440',	'Qatar Airways',	'Doha',	'DOH',	'Dubai',	'DXB',	'2026-07-01 11:00:00',	'2026-07-01 12:15:00',	500.00,	'Economy',	'Scheduled',	210),
(77,	'SV230',	'Saudia',	'Riyadh',	'RUH',	'Doha',	'DOH',	'2026-07-02 08:00:00',	'2026-07-02 09:30:00',	450.00,	'Economy',	'Scheduled',	190);

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

-- 2026-05-04 12:37:18
