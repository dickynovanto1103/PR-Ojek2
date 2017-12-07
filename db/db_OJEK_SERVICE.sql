# noinspection SqlNoDataSourceInspectionForFile

-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 07, 2017 at 03:23 PM
-- Server version: 5.7.20-0ubuntu0.17.10.1
-- PHP Version: 7.1.8-1ubuntu1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS = @@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION = @@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_OJEK_SERVICE`
--

-- --------------------------------------------------------

--
-- Table structure for table `driver`
--

CREATE TABLE `driver` (
  `id`     INT(11) NOT NULL,
  `rating` FLOAT        DEFAULT NULL,
  `votes`  INT(11)      DEFAULT NULL,
  `status` VARCHAR(255) DEFAULT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = latin1;

--
-- Dumping data for table `driver`
--

INSERT INTO `driver` (`id`, `rating`, `votes`, `status`) VALUES
  (2, NULL, NULL, NULL),
  (4, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id`      INT(11)      NOT NULL,
  `date`          DATE         NOT NULL,
  `origin`        VARCHAR(255) NOT NULL,
  `destination`   VARCHAR(255) NOT NULL,
  `order_rating`  INT(11)               DEFAULT NULL,
  `comment`       VARCHAR(255)          DEFAULT NULL,
  `id_user`       INT(11)      NOT NULL,
  `id_driver`     INT(11)      NOT NULL,
  `hidden_driver` TINYINT(1)   NOT NULL DEFAULT '0',
  `hidden_user`   TINYINT(1)   NOT NULL DEFAULT '0'
)
  ENGINE = InnoDB
  DEFAULT CHARSET = latin1;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `date`, `origin`, `destination`, `order_rating`, `comment`, `id_user`, `id_driver`, `hidden_driver`, `hidden_user`)
VALUES
  (1, '1997-10-23', 'ITB', 'LA LA LAND', 3, 'MATA PANCING', 1, 4, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `preferred_loc`
--

CREATE TABLE `preferred_loc` (
  `id`       INT(11)      NOT NULL,
  `sequence` INT(11)      NOT NULL,
  `place`    VARCHAR(255) NOT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = latin1;

--
-- Dumping data for table `preferred_loc`
--

INSERT INTO `preferred_loc` (`id`, `sequence`, `place`) VALUES
  (2, 1, 'LA LA LAND'),
  (4, 2, 'Labtek V');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `driver`
--
ALTER TABLE `driver`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`);

--
-- Indexes for table `preferred_loc`
--
ALTER TABLE `preferred_loc`
  ADD PRIMARY KEY (`sequence`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` INT(11) NOT NULL AUTO_INCREMENT,
  AUTO_INCREMENT = 2;
--
-- AUTO_INCREMENT for table `preferred_loc`
--
ALTER TABLE `preferred_loc`
  MODIFY `sequence` INT(11) NOT NULL AUTO_INCREMENT,
  AUTO_INCREMENT = 3;
/*!40101 SET CHARACTER_SET_CLIENT = @OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS = @OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION = @OLD_COLLATION_CONNECTION */;
