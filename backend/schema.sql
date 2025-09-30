-- schema.sql
CREATE DATABASE IF NOT EXISTS random_adventures CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE random_adventures;

CREATE TABLE IF NOT EXISTS adventures (
  id INT AUTO_INCREMENT PRIMARY KEY,
  text VARCHAR(1024) NOT NULL,
  categories JSON NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
