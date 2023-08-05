CREATE DATABASE IF NOT EXISTS library;

CREATE USER IF NOT EXISTS 'librarian'@'%' IDENTIFIED BY 'password';

GRANT ALL PRIVILEGES ON library.* TO 'librarian'@'%';

USE library;

CREATE TABLE IF NOT EXISTS `categories` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `category_name` varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS `authors` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS `books` (
  `isbn` varchar(13) NOT NULL PRIMARY KEY,
  `name` varchar(255) NOT NULL,
  `author` int NOT NULL,
  `category` int NOT NULL,
  `price` int(11) NOT NULL,
  `year_of_edition` int(4) NOT NULL,
  FOREIGN KEY (`category`) REFERENCES `categories` (`id`),
  FOREIGN KEY (`author`) REFERENCES `authors` (`id`)
);

CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `borrows` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `isbn` varchar(13) NOT NULL,
  `user` int NOT NULL,
  `borrow_start_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `borrow_end_date` datetime,
  `returned` tinyint(1) NOT NULL DEFAULT 0,
  FOREIGN KEY (`isbn`) REFERENCES `books` (`isbn`),
  FOREIGN KEY (`user`) REFERENCES `users` (`id`)
);

CREATE TABLE IF NOT EXISTS `borrow_rules` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `rule_name` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `type` enum('string', 'numeric') NOT NULL
);

CREATE TABLE IF NOT EXISTS `user_borrows` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `borrow` int NOT NULL,
  `rule` int NOT NULL,
  FOREIGN KEY (`borrow`) REFERENCES `borrows` (`id`),
  FOREIGN KEY (`rule`) REFERENCES `borrow_rules` (`id`)
);
