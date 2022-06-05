-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 05, 2022 at 08:08 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `codingthunder`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(11) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone_num` varchar(50) NOT NULL,
  `msg` text NOT NULL,
  `date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `email`, `phone_num`, `msg`, `date`) VALUES
(1, 'First Post', 'firstpost@gmail.com', '1234567890', 'First Post!!', '2022-05-31 17:06:17'),
(2, 'dfg', 'natjo@gmail.com', '7890543456', 'test', NULL),
(3, 'Natasha Joshi', 'natashajoshi@gmail.com', '8765435678', 'Test message!! first blog post', NULL),
(4, 'Natasha Joshi', 'natashajoshi@gmail.com', '8765435678', 'Test message!! first blog post', '2022-05-31 17:36:46'),
(5, 'Prashant Joshi', 'pj@yahoo.com', '7654321345', 'Hi, this is my first blog post!', '2022-05-31 17:37:11'),
(6, 'Prashant Joshi', 'pj@yahoo.com', '7654321345', 'Hi, this is my first blog post!', '2022-05-31 23:08:34'),
(7, 'Alexei', 'alex@jin.com', '6789876523', 'Hey there!!', '2022-05-31 23:09:05'),
(8, 'tom', 'tom@gmail.com', '8765432456', 'heyy', '2022-05-31 23:09:34'),
(9, 'sara', 'sneg@yahoo.com', '8765434567', 'heyyyyyyyyyyy', '2022-06-01 10:32:26'),
(10, 'sara', 'sneg@yahoo.com', '9876543456', 'test message sent', '2022-06-01 10:35:52'),
(11, 'sara', 'sneg@yahoo.com', '8765678904', 'test msg!!', '2022-06-01 10:37:27'),
(12, 'sara', 'sneg@yahoo.com', '7890543456', 'errewrewg4rg', '2022-06-01 10:38:01'),
(13, 'feg', 'alex@jin.com', '8765435678', 'sdgregre', '2022-06-01 10:39:32'),
(14, 'natasha', 'natjo@gmail.com', '8765678904', 'fegreg', '2022-06-01 10:41:22'),
(15, 'sara', 'pj@yahoo.com', '7654321345', 'mko', '2022-06-01 12:31:40'),
(16, 'sara', 'pj@yahoo.com', '7654321345', 'mko', '2022-06-01 12:32:26'),
(17, 'sara', 'pj@yahoo.com', '7654321345', 'mko', '2022-06-01 12:34:04'),
(18, 'Natasha Joshi', 'natasha.priolkar@ibm.com', '6789876523', 'hey pls contact me', '2022-06-02 21:34:22');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `title` text NOT NULL,
  `subtitle` text NOT NULL,
  `slug` varchar(25) NOT NULL,
  `content` text NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `img_file` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `subtitle`, `slug`, `content`, `date`, `img_file`) VALUES
(1, 'Python Flask', 'By CodeWithHarry', 'first-post', 'Hey this is my first blog post!', '2022-06-04 22:16:26', 'home-bg'),
(2, 'Python Iterators', 'Python Iterators (__iter__ and __next__) ', 'second-post', 'Iterators are everywhere in Python. They are elegantly implemented within for loops, comprehensions, generators etc. but are hidden in plain sight.\r\n\r\nIterator in Python is simply an object that can be iterated upon. An object which will return data, one element at a time.\r\n\r\nTechnically speaking, a Python iterator object must implement two special methods, __iter__() and __next__(), collectively called the iterator protocol.\r\n\r\nAn object is called iterable if we can get an iterator from it. Most built-in containers in Python like: list, tuple, string etc. are iterables.\r\n\r\nThe iter() function (which in turn calls the __iter__() method) returns an iterator from them.\r\n\r\n', '2022-06-04 22:17:24', 'web-dev-bg'),
(3, 'Generators in Python', 'Python yield, Generators and Generator Expressions', 'generators-python', 'There is a lot of work in building an iterator in Python. We have to implement a class with __iter__() and __next__() method, keep track of internal states, and raise StopIteration when there are no values to be returned.\r\n\r\nThis is both lengthy and counterintuitive. Generator comes to the rescue in such situations.\r\n\r\nPython generators are a simple way of creating iterators. All the work we mentioned above are automatically handled by generators in Python.\r\n\r\nSimply speaking, a generator is a function that returns an object (iterator) which we can iterate over (one value at a time).', '2022-06-04 22:18:09', 'web-dev-bg'),
(4, 'Python Decorators Tutorial: What is a Decorator?', 'Decorators in Python', 'decorators-python', 'A decorator is a design pattern in Python that allows a user to add new functionality to an existing object without modifying its structure. Decorators are usually called before the definition of a function you want to decorate.', '2022-06-04 22:19:07', 'web-dev-bg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
