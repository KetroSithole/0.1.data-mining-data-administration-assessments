
-- 3.1 Create database
CREATE DATABASE book_store;

-- Connect to the database before running the rest of the script.
-- In psql: \c book_store

-- 3.2 Create Orders table and insert sample data
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    book_title VARCHAR(150) NOT NULL,
    quantity_ordered INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount NUMERIC(10, 2) NOT NULL
);

INSERT INTO orders (
    order_id,
    customer_id,
    book_title,
    quantity_ordered,
    order_date,
    total_amount
)
VALUES
    (501, 10, 'Data Science Essentials', 1, '2024-03-01', 450.00),
    (502, 11, 'Python for Beginners', 2, '2024-03-02', 600.00),
    (503, 10, 'Advanced SQL Queries', 1, '2024-03-05', 520.00),
    (504, 12, 'Machine Learning in Practice', 3, '2024-03-06', 1650.00);

-- 3.3 Orders with Total_Amount > 1000 and Quantity_Ordered >= 2
SELECT
    *
FROM
    orders
WHERE
    total_amount > 1000
    AND quantity_ordered >= 2;

-- 3.4 Insert new order
INSERT INTO orders (
    order_id,
    customer_id,
    book_title,
    quantity_ordered,
    order_date,
    total_amount
)
VALUES
    (505, 11, 'Deep Learning Fundamentals', 2, '2024-03-08', 1200.00);

-- 3.5 Create Customers table and insert records
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(150) NOT NULL
);

INSERT INTO customers (customer_id, customer_name, customer_email)
VALUES
    (10, 'Lerato Maseko', 'lerato.m@example.com'),
    (11, 'Yusuf Daniels', 'yusuf.d@example.com'),
    (12, 'Nomsa Khumalo', 'nomsa.k@example.com');

-- 3.6 Display required columns for orders by Customer_ID = 11
SELECT
    o.customer_id,
    o.order_id,
    c.customer_name,
    c.customer_email,
    o.book_title,
    o.quantity_ordered,
    o.total_amount
FROM
    orders o
INNER JOIN customers c ON c.customer_id = o.customer_id
WHERE
    o.customer_id = 11;

-- 3.7 Total books ordered and total amount spent per customer
SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.quantity_ordered) AS total_books_ordered,
    SUM(o.total_amount) AS total_amount_spent
FROM
    customers c
INNER JOIN orders o ON o.customer_id = c.customer_id
GROUP BY
    c.customer_id,
    c.customer_name;

-- 3.8 Customers with large orders (Quantity_Ordered > 2)
SELECT
    c.customer_id,
    c.customer_name,
    o.order_date,
    o.quantity_ordered
FROM
    orders o
INNER JOIN customers c ON c.customer_id = o.customer_id
WHERE
    o.quantity_ordered > 2;