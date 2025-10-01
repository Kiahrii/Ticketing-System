-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 01, 2025 at 07:40 AM
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

-- --------------------------------------------------------

--
-- Table structure for table `concern`
--

CREATE TABLE `concern` (
  `concern_id` int(11) NOT NULL,
  `concern_name` enum('Missing Keyboard','Missing Mouse','Missing Cables','Non-working Keyboard','Non-working Mouse','Non-working PCs','Need Cleaning') NOT NULL,
  `concern_install` varchar(50) DEFAULT NULL,
  `concern_other` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `concern`:
--

-- --------------------------------------------------------

--
-- Table structure for table `request`
--

CREATE TABLE `request` (
  `ticket_id` int(11) NOT NULL,
  `concern_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `request`:
--   `concern_id`
--       `concern` -> `concern_id`
--   `ticket_id`
--       `ticket` -> `ticket_id`
--

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
  `date_submitted` date NOT NULL DEFAULT current_timestamp(),
  `date_resolved` date DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `ticket`:
--   `employee_id`
--       `user_info` -> `employee_id`
--

-- --------------------------------------------------------

--
-- Table structure for table `user_info`
--

CREATE TABLE `user_info` (
  `employee_id` int(11) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `tin_no` varchar(11) NOT NULL,
  `department` enum('CITE','CEA') NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(20) NOT NULL,
  `user_type` enum('requester','admin') NOT NULL DEFAULT 'requester',
  `user_status` enum('active','inactive') NOT NULL DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `user_info`:
--

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
  ADD PRIMARY KEY (`ticket_id`,`employee_id`),
  ADD KEY `fk_employee_id_ticket` (`employee_id`);

--
-- Indexes for table `user_info`
--
ALTER TABLE `user_info`
  ADD PRIMARY KEY (`employee_id`),
  ADD UNIQUE KEY `username_unique` (`tin_no`,`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `concern`
--
ALTER TABLE `concern`
  MODIFY `concern_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ticket`
--
ALTER TABLE `ticket`
  MODIFY `ticket_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_info`
--
ALTER TABLE `user_info`
  MODIFY `employee_id` int(11) NOT NULL AUTO_INCREMENT;

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
