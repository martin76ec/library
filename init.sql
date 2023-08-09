CREATE DATABASE IF NOT EXISTS library;

CREATE USER IF NOT EXISTS 'librarian'@'%' IDENTIFIED BY 'password';

GRANT ALL PRIVILEGES ON library.* TO 'librarian'@'%';

USE library;

CREATE TABLE IF NOT EXISTS login_credentials
(
    id       INT AUTO_INCREMENT PRIMARY KEY,
    email    VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS `librarians`
(
    `id`         int          NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `first_name` varchar(255) NOT NULL,
    `last_name`  varchar(255) NOT NULL,
    login        INT          NOT NULL,
    FOREIGN KEY (`login`) REFERENCES `login_credentials` (`id`)
);

CREATE TABLE IF NOT EXISTS `books`
(
    `isbn`            varchar(13)  NOT NULL PRIMARY KEY,
    `name`            varchar(255) NOT NULL,
    `author`          varchar(255) NOT NULL,
    `category`        varchar(255) NOT NULL,
    `price`           int(11)      NOT NULL,
    `year_of_edition` int(4)       NOT NULL
);

CREATE TABLE IF NOT EXISTS `clients`
(
    `id`         INT AUTO_INCREMENT PRIMARY KEY,
    `first_name` VARCHAR(255) NOT NULL,
    `last_name`  VARCHAR(255) NOT NULL,
    `address`    VARCHAR(255),
    `phone`      VARCHAR(20),
    `login`      INT          NOT NULL,
    FOREIGN KEY (`login`) REFERENCES `login_credentials` (`id`)
);

CREATE TABLE IF NOT EXISTS `borrows`
(
    `id`                int         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `isbn`              varchar(13) NOT NULL,
    `client`            int         NOT NULL,
    `borrow_start_date` datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `borrow_end_date`   datetime,
    `returned`          tinyint(1)  NOT NULL DEFAULT 0,
    FOREIGN KEY (`isbn`) REFERENCES `books` (`isbn`),
    FOREIGN KEY (`client`) REFERENCES `clients` (`id`)
);

INSERT INTO login_credentials (email, password) VALUES ('client@example.com', 'clientpassword');
INSERT INTO login_credentials (email, password) VALUES ('librarian@example.com', 'librarianpassword');
INSERT INTO clients (first_name, last_name, address, phone, login) VALUES ('John', 'Doe', '123 Main St', '555-1234', 1);
INSERT INTO clients (first_name, last_name, address, phone, login) VALUES ('Jane', 'Smith', '456 Elm St', '555-5678', 2);
INSERT INTO librarians (first_name, last_name, login) VALUES ('Alice', 'Johnson', 2);
INSERT INTO librarians (first_name, last_name, login) VALUES ('Bob', 'Williams', 1);
INSERT INTO books (isbn, name, author, category, price, year_of_edition)
VALUES ('9780451450522', 'Neuromancer', 'William Gibson', 'Science Fiction', 15, 1984);
INSERT INTO books (isbn, name, author, category, price, year_of_edition)
VALUES ('9780062459367', 'To Kill a Mockingbird', 'Harper Lee', 'Classic', 10, 1960);
INSERT INTO books (isbn, name, author, category, price, year_of_edition)
VALUES ('9780143110425', '1984', 'George Orwell', 'Dystopian', 12, 1949);

