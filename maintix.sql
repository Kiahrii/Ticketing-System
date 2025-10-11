-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Oct 11, 2025 at 03:35 AM
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
-- Database: `maintix`
--
CREATE DATABASE IF NOT EXISTS `maintix` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `maintix`;

-- --------------------------------------------------------

--
-- Table structure for table `concern`
--

CREATE TABLE `concern` (
  `concern_id` int(11) NOT NULL,
  `concern_name` enum('Mouse Missing','Mouse Relocated','Mouse not Working','Keyboard Missing','Keyboard Relocated','Keyboard not Working','Monitor not Working','Monitor Dotted Screen/Lines Visible','Cabling not Proper/need fixing','CPU Damaged/Boot Error','Slow Performance','Software not Installed','Need Cleaning','Need Air-conditioning Fix','Others') NOT NULL,
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
(13, 'Need Cleaning', NULL, NULL),
(14, 'Need Air-conditioning Fix', NULL, NULL),
(15, 'Others', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `request`
--

CREATE TABLE `request` (
  `ticket_id` int(11) NOT NULL,
  `concern_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ticket`
--

CREATE TABLE `ticket` (
  `ticket_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `lab_room` enum('ITS 200','ITS 201','MAC LAB','PTC 303','PTC 304','PTC 305','PTC 306') NOT NULL,
  `status` enum('Pending','Approved','Declined','In Progress','Resolved') NOT NULL,
  `priority` enum('low','normal','high','urgent') NOT NULL,
  `date_submitted` datetime NOT NULL DEFAULT current_timestamp(),
  `date_resolved` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_info`
--

CREATE TABLE `user_info` (
  `employee_id` int(11) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `tin_no` varchar(11) NOT NULL,
  `department` enum('CITE','CEA','CAS','CMA','CCJE') DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `user_type` enum('requester','admin') NOT NULL DEFAULT 'requester',
  `user_status` enum('active','inactive') NOT NULL DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_info`
--

INSERT INTO `user_info` (`employee_id`, `first_name`, `last_name`, `tin_no`, `department`, `username`, `password_hash`, `user_type`, `user_status`) VALUES
(7, 'Keziah', 'Garcia', '123-321-213', 'CITE', 'kego.garcia.up@phinmaed.com', '$2y$10$..AcJXFxONMpR77mvuifr.XEbdjl.Bs74eEjlZFxw06iWlPK4ABFC', 'requester', 'active'),
(8, 'admin', 'Administrator', '000-000-000', 'CITE', 'admin.maintix.up@phinmaed.com', '$2y$10$X1rbOkTYpg48pPKwYx4GY.HQxIE4hmegCr0qYhsb08DPfP7sQKi6O', 'admin', 'active');

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
  ADD PRIMARY KEY (`ticket_id`),
  ADD KEY `fk_employee_id_ticket` (`employee_id`);

--
-- Indexes for table `user_info`
--
ALTER TABLE `user_info`
  ADD PRIMARY KEY (`employee_id`),
  ADD UNIQUE KEY `username_unique` (`tin_no`,`username`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `tin_no` (`tin_no`);

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
  MODIFY `ticket_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user_info`
--
ALTER TABLE `user_info`
  MODIFY `employee_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `request`
--
ALTER TABLE `request`
  ADD CONSTRAINT `fk_concern_id_ticket` FOREIGN KEY (`concern_id`) REFERENCES `concern` (`concern_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_ticket_id_request` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`ticket_id`) ON UPDATE CASCADE;

--
-- Constraints for table `ticket`
--
ALTER TABLE `ticket`
  ADD CONSTRAINT `fk_employee_id_ticket` FOREIGN KEY (`employee_id`) REFERENCES `user_info` (`employee_id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
