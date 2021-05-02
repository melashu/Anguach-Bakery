-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 23, 2021 at 08:07 PM
-- Server version: 10.4.8-MariaDB
-- PHP Version: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `anguach_dabo`
--

-- --------------------------------------------------------

--
-- Table structure for table `dabotable`
--

CREATE TABLE `dabotable` (
  `id` int(11) NOT NULL,
  `date` varchar(15) NOT NULL,
  `user` varchar(15) NOT NULL,
  `place` varchar(15) NOT NULL,
  `bale_2_25` int(11) NOT NULL,
  `bale_2_5` int(11) NOT NULL,
  `bale_5` int(11) NOT NULL,
  `bale_10` int(11) NOT NULL,
  `bale_75` int(11) NOT NULL,
  `bale_100` int(11) NOT NULL,
  `bale_120` int(11) NOT NULL,
  `bale_150` int(11) NOT NULL,
  `bale_200` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `dabotable`
--

INSERT INTO `dabotable` (`id`, `date`, `user`, `place`, `bale_2_25`, `bale_2_5`, `bale_5`, `bale_10`, `bale_75`, `bale_100`, `bale_120`, `bale_150`, `bale_200`) VALUES
(0, '', '', '', 3, 0, 0, 0, 0, 0, 0, 0, 0),
(1, '12', 'jhbn', 'bnmbn', 2, 3, 4, 5, 6, 4, 8, 5, 5);

-- --------------------------------------------------------

--
-- Table structure for table `payement`
--

CREATE TABLE `payement` (
  `id` int(11) NOT NULL,
  `date` varchar(15) NOT NULL,
  `user` varchar(15) NOT NULL,
  `place` varchar(15) NOT NULL,
  `bale_2_5` int(11) NOT NULL,
  `bale_5` int(11) NOT NULL,
  `bale_10` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `returndabo`
--

CREATE TABLE `returndabo` (
  `id` int(11) NOT NULL,
  `date` varchar(15) NOT NULL,
  `user` varchar(15) NOT NULL,
  `place` varchar(15) NOT NULL,
  `bale_2_5` int(11) NOT NULL,
  `bale_5` int(15) NOT NULL,
  `bale_10` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `useraccount`
--

CREATE TABLE `useraccount` (
  `id` int(11) NOT NULL,
  `userName` varchar(10) NOT NULL,
  `role` varchar(10) NOT NULL,
  `password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `useraccount`
--

INSERT INTO `useraccount` (`id`, `userName`, `role`, `password`) VALUES
(1, 'Meshu', 'Admin', '123456'),
(2, 'Meshu', 'Admin', '123456'),
(3, 'Meshu', 'Admin', '123456'),
(4, 'Meshu', 'Admin', '123456'),
(5, 'Meshu', 'Admin', '123456'),
(6, 'Meshu', 'Admin', '123456'),
(7, 'Meshu', 'Admin', '123456'),
(8, 'Meshu', 'Admin', '123456');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dabotable`
--
ALTER TABLE `dabotable`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payement`
--
ALTER TABLE `payement`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `returndabo`
--
ALTER TABLE `returndabo`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `useraccount`
--
ALTER TABLE `useraccount`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `useraccount`
--
ALTER TABLE `useraccount`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
