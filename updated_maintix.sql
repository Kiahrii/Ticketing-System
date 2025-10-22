-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 22, 2025 at 01:01 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `updated_maintix`
--

-- --------------------------------------------------------

--
-- Table structure for table `concern`
--

CREATE TABLE `concern` (
  `concern_id` int(11) NOT NULL,
  `concern_name` enum('Mouse Missing','Mouse Relocated','Mouse not Working','Keyboard Missing','Keyboard Relocated','Keyboard not Working','Monitor not Working','Monitor Dotted Screen/Lines Visible','Cabling not Proper/need fixing','CPU Damaged/Boot Error','Slow Performance','Software not Installed','Others') NOT NULL,
  `concern_install` int(11) DEFAULT NULL,
  `concern_other` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `concern`
--

INSERT INTO `concern` (`concern_id`, `concern_name`, `concern_install`, `concern_other`) VALUES
(1, 'Mouse Missing', NULL, NULL),
(2, 'Mouse Relocated', NULL, NULL),
(3, 'Mouse not Working', NULL, NULL),
(4, 'Keyboard Missing', NULL, NULL),
(5, 'Keyboard Relocated', NULL, NULL),
(6, 'Keyboard not Working', NULL, NULL),
(7, 'Monitor not Working', NULL, NULL),
(8, 'Monitor Dotted Screen/Lines Visible', NULL, NULL),
(9, 'Cabling not Proper/need fixing', NULL, NULL),
(10, 'CPU Damaged/Boot Error', NULL, NULL),
(11, 'Slow Performance', NULL, NULL),
(12, 'Software not Installed', NULL, NULL),
(13, 'Others', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `request`
--

CREATE TABLE `request` (
  `ticket_id` int(11) NOT NULL,
  `concern_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `request`
--

INSERT INTO `request` (`ticket_id`, `concern_id`) VALUES
(9, 2),
(9, 5),
(10, 6),
(10, 9),
(10, 12),
(11, 3),
(11, 6),
(11, 9),
(11, 12),
(12, 5),
(12, 6),
(12, 8),
(12, 9),
(12, 11),
(13, 6),
(13, 9),
(13, 12),
(14, 5),
(14, 8),
(14, 11),
(15, 5),
(15, 8),
(15, 11),
(16, 1),
(16, 4),
(16, 7);

-- --------------------------------------------------------

--
-- Table structure for table `ticket`
--

CREATE TABLE `ticket` (
  `ticket_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `lab_room` enum('MAC LAB','ITS 200','ITS 201','PTC 303','PTC 304','PTC 305','PTC 306') NOT NULL,
  `priority` enum('low','normal','high','urgent') NOT NULL DEFAULT 'normal',
  `description` text DEFAULT NULL,
  `attachment_filename` varchar(255) DEFAULT NULL,
  `attachment_path` varchar(500) DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `date_submitted` datetime NOT NULL DEFAULT current_timestamp(),
  `date_resolved` datetime DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `notification_read` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ticket`
--

INSERT INTO `ticket` (`ticket_id`, `employee_id`, `subject`, `lab_room`, `priority`, `description`, `attachment_filename`, `attachment_path`, `status`, `date_submitted`, `date_resolved`, `date_updated`, `notification_read`) VALUES
(14, 9, NULL, 'ITS 200', 'normal', 'Issues: Keyboard Relocated, Monitor Dotted Screen, Slow Performance', NULL, NULL, 'Pending', '2025-10-22 11:48:02', NULL, '2025-10-22 03:48:02', 0),
(15, 9, NULL, 'MAC LAB', 'normal', 'Issues: Keyboard Relocated, Monitor Dotted Screen, Slow Performance', NULL, NULL, 'Pending', '2025-10-22 11:48:15', NULL, '2025-10-22 03:48:15', 0),
(16, 9, NULL, 'MAC LAB', 'normal', 'Issues: Mouse Missing, Keyboard Missing, Monitor not working', NULL, NULL, 'Pending', '2025-10-22 11:48:26', NULL, '2025-10-22 03:48:26', 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_info`
--

CREATE TABLE `user_info` (
  `employee_id` int(11) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `emp_no` varchar(11) NOT NULL,
  `mob_no` varchar(11) NOT NULL,
  `department` enum('CEA','CITE') NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `user_type` enum('requester','admin') NOT NULL DEFAULT 'requester',
  `user_status` enum('active','inactive') NOT NULL DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_info`
--

INSERT INTO `user_info` (`employee_id`, `first_name`, `last_name`, `emp_no`, `mob_no`, `department`, `username`, `password_hash`, `user_type`, `user_status`) VALUES
(6, 'Main', 'Administrator', 'UP-11-111-P', '09123456789', 'CITE', 'admin.maintix.up@phinmaed.com', '$2y$10$qEEWY8eDoOlq3zAE.MiSWe1bg1P5XuhsORR8shDYTNZ5Q/65dbouG', 'admin', 'active'),
(7, 'Keziah', 'Garcia', 'UP-32-105-P', '09941963233', 'CITE', 'kego.garcia.up@phinmaed.com', '$2y$10$CAcSrAK6LwN.DjgahSzxPOf5tliu1LH9pWhXop9jEWYwt1h.lZWPm', 'requester', 'active'),
(8, 'Arlry', 'Baldonasa', 'UP-22-543-P', '09941964244', 'CEA', 'arlr.baldonasa.up@phinmaed.com', '$2y$10$qXe8MscAxCcLk7KPOKOjlel9cYFm5BgUj9zzykhijPW3jTKskLmSe', 'requester', 'active'),
(9, 'nono', 'nana', 'UP-98-701-P', '09124738748', 'CEA', 'user.maintix.up@phinmaed.com', '$2y$10$owfu/S5H4vZyvz8iGqRtHuPIFxO0WtqV6MD/VtsSPfjlJAiI/zu8e', 'requester', 'active');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `concern`
--
ALTER TABLE `concern`
  ADD PRIMARY KEY (`concern_id`);

--
-- Indexes for table `request`
--
ALTER TABLE `request`
  ADD PRIMARY KEY (`ticket_id`,`concern_id`),
  ADD KEY `fk_concern_id_ticket` (`concern_id`);

--
-- Indexes for table `ticket`
--
ALTER TABLE `ticket`
  ADD PRIMARY KEY (`ticket_id`);

--
-- Indexes for table `user_info`
--
ALTER TABLE `user_info`
  ADD PRIMARY KEY (`employee_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `tin_no` (`emp_no`),
  ADD UNIQUE KEY `mob_no` (`mob_no`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `concern`
--
ALTER TABLE `concern`
  MODIFY `concern_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `ticket`
--
ALTER TABLE `ticket`
  MODIFY `ticket_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `user_info`
--
ALTER TABLE `user_info`
  MODIFY `employee_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
