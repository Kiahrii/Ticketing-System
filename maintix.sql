-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 16, 2025 at 07:25 AM
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
(9, 11),
(10, 12),
(10, 13),
(11, 7),
(12, 7);

-- --------------------------------------------------------

--
-- Table structure for table `ticket`
--

CREATE TABLE `ticket` (
  `ticket_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `lab_room` enum('ITS 200','ITS 201','MAC LAB','PTC 303','PTC 304','PTC 305','PTC 306') NOT NULL,
  `priority` enum('low','normal','high','urgent') NOT NULL DEFAULT 'normal',
  `description` text DEFAULT NULL,
  `attachment` longblob DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `date_submitted` datetime NOT NULL DEFAULT current_timestamp(),
  `date_resolved` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ticket`
--

INSERT INTO `ticket` (`ticket_id`, `employee_id`, `subject`, `lab_room`, `priority`, `description`, `attachment`, `status`, `date_submitted`, `date_resolved`) VALUES
(6, 3, 'Software Installation', 'MAC LAB', 'high', 'Lack of extension installation in VSC, especially in php.', 0x313736303536303037315f53637265656e73686f7420283736292e706e67, 'Pending', '2025-10-16 04:27:51', NULL),
(7, 5, 'Hardware', 'PTC 303', 'normal', 'There are numerous pc that aren\'t working.', NULL, 'Pending', '2025-10-16 04:33:52', NULL),
(9, 3, NULL, 'MAC LAB', 'normal', 'Slow Performance', NULL, 'pending', '2025-10-16 05:08:33', NULL),
(10, 3, NULL, 'MAC LAB', 'high', 'Software not installed, Other Issue', NULL, 'pending', '2025-10-16 06:12:00', NULL),
(11, 3, NULL, 'MAC LAB', 'normal', 'Monitor not working', NULL, 'pending', '2025-10-16 06:38:39', NULL),
(12, 3, NULL, 'MAC LAB', '', 'Monitor not working', NULL, 'pending', '2025-10-16 06:38:57', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_info`
--

CREATE TABLE `user_info` (
  `employee_id` int(11) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `emp_no` varchar(11) NOT NULL,
  `department` enum('CITE','CEA','CAS','CMA','CCJE') DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `user_type` enum('requester','admin') NOT NULL DEFAULT 'requester',
  `user_status` enum('active','inactive') NOT NULL DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_info`
--

INSERT INTO `user_info` (`employee_id`, `first_name`, `last_name`, `emp_no`, `department`, `username`, `password_hash`, `user_type`, `user_status`) VALUES
(1, 'Main', 'Administrator', 'UP-11-111-P', 'CITE', 'admin.maintix.up@phinmaed.com', '$2y$10$X1rbOkTYpg48pPKwYx4GY.HQxIE4hmegCr0qYhsb08DPfP7sQKi6O', 'admin', 'active'),
(2, 'Arlry', 'Baldonasa', 'UP-22-123-P', 'CITE', 'arlr.baldonasa.up@phinmaed.com', '$2y$10$aBS9hAxC.oCSWNdzVqoZWuicNo0WNSdAFD6naIK059ioPskrJvNN.', 'admin', 'active'),
(3, 'Keziah', 'Garcia', 'UP-23-789-P', 'CITE', 'kego.garcia.up@phinmaed.com', '$2y$10$lpkS0uhh6o9wxoZWIFG5Auz/yzFD9hHvsrNicuXU5aCIjVBXnsIx.', 'requester', 'active'),
(4, 'Jan Lewis', 'Agas', 'UP-22-468-P', 'CEA', 'jata.agas.up@phinmaed.com', '$2y$10$RAwPqJGpVJa6akIg0t1tCe0Om6idNJJkXuU0UL0M6kMQ0.q7ljH2S', 'admin', 'active'),
(5, 'Cedrick Rhae', 'Alcaide', 'UP-22-538-P', 'CITE', 'ceal.alcaide.up@phinmaed.com', '$2y$10$km0LMGxSRFOtjeIR9i8.B.f.OAGikT76vplotSrRp3wKcJJrH5.Ty', 'requester', 'active'),
(6, 'Mariam', 'Magalong', 'UP-24-152-P', 'CEA', 'made.magalong.up@phinmaed.com', '$2y$10$sugOkwOFckm95kqyfq5urePxv162bcYtR.P1SevpFEMZo06LC2Kam', 'requester', 'active');

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
  ADD UNIQUE KEY `username_unique` (`emp_no`,`username`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `tin_no` (`emp_no`),
  ADD UNIQUE KEY `username_2` (`username`),
  ADD UNIQUE KEY `emp_no` (`emp_no`);

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
  MODIFY `ticket_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `user_info`
--
ALTER TABLE `user_info`
  MODIFY `employee_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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
