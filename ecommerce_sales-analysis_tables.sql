-- ==========================================
-- 🔧 1. Database and Tables Creation
-- ==========================================

CREATE DATABASE ecommerce_project;
USE ecommerce_project;

-- 👥 Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100)
);

-- 📦 Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(100),
    price INT
);

-- 🧾 Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT,
    total_amount INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 📋 Order Items Table
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- ==========================================
-- 🔽 2. Sample Data Insertion
-- ==========================================
INSERT INTO customers (customer_id, name, email, city, state) VALUES
(1, 'Alice', 'alice@example.com', 'Karachi', 'Sindh'),
(2, 'Bob', 'bob@example.com', 'Lahore', 'Punjab'),
(3, 'Charlie', 'charlie@example.com', 'Islamabad', 'Islamabad'),
(4, 'Diana', 'diana@example.com', 'Faisalabad', 'Punjab'),
(5, 'Ethan', 'ethan@example.com', 'Rawalpindi', 'Punjab');

INSERT INTO products (product_id, product_name, category, price) VALUES
(1, 'Wireless Mouse', 'Electronics', 1500),
(2, 'Bluetooth Speaker', 'Electronics', 2500),
(3, 'Notebook', 'Stationery', 200),
(4, 'Ball Pen Pack', 'Stationery', 100),
(5, 'Backpack', 'Accessories', 1800);

INSERT INTO orders (order_id, order_date, customer_id, total_amount) VALUES
(1, '2023-11-17', 1, 9200),
(2, '2023-05-10', 4, 16700),
(3, '2023-12-16', 1, 6600),
(4, '2023-07-12', 1, 4300),
(5, '2023-06-06', 5, 8300),
(6, '2023-07-15', 4, 600),
(7, '2023-10-16', 2, 5500),
(8, '2023-11-06', 1, 8000),
(9, '2023-05-07', 4, 3000),
(10, '2023-04-19', 3, 15000),
(11, '2023-02-11', 5, 12900),
(12, '2023-09-20', 1, 1000),
(13, '2023-02-18', 2, 20800),
(14, '2023-11-16', 2, 9000),
(15, '2023-12-27', 3, 13800);

INSERT INTO order_items (order_item_id, order_id, product_id, quantity, price) VALUES
(1, 1, 5, 5, 1800),
(2, 1, 4, 2, 100),
(3, 2, 1, 3, 1500),
(4, 2, 2, 2, 2500),
(5, 2, 5, 4, 1800),
(6, 3, 1, 2, 1500),
(7, 3, 5, 2, 1800),
(8, 4, 3, 5, 200),
(9, 4, 2, 1, 2500),
(10, 4, 3, 4, 200),
(11, 5, 1, 5, 1500),
(12, 5, 4, 4, 100),
(13, 5, 4, 4, 100),
(14, 6, 3, 3, 200),
(15, 7, 1, 3, 1500),
(16, 7, 3, 5, 200),
(17, 8, 4, 4, 100),
(18, 8, 4, 1, 100),
(19, 8, 1, 5, 1500),
(20, 9, 1, 2, 1500),
(21, 10, 2, 3, 2500),
(22, 10, 1, 5, 1500),
(23, 11, 2, 3, 2500),
(24, 11, 5, 3, 1800),
(25, 12, 3, 5, 200),
(26, 13, 3, 4, 200),
(27, 13, 2, 5, 2500),
(28, 13, 1, 5, 1500),
(29, 14, 5, 5, 1800),
(30, 15, 4, 3, 100),
(31, 15, 2, 3, 2500),
(32, 15, 1, 4, 1500);