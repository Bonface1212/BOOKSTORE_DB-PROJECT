USE bookstore_db;

-- 1. Publisher
CREATE TABLE Publisher (
publisher_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL
);

-- 2. Language
CREATE TABLE book_language (
language_id INT AUTO_INCREMENT PRIMARY KEY,
language_name VARCHAR(50) NOT NULL
);

-- 3. Book
CREATE TABLE book (
book_id INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(255) NOT NULL,
genre VARCHAR(100),
publisher_id INT,
language_id INT,
price DECIMAL(10, 2),
FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
FOREIGN KEY (language_id) REFERENCES book_language(language_id)
);

-- 4. AUTHOR
CREATE TABLE author (
author_id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(100),
last_name VARCHAR(100)
);

-- 5. BOOK_AUTHOR (Many-to-Many)
CREATE TABLE book_author (
book_id INT,
author_id INT,
PRIMARY KEY (book_id, author_id),
FOREIGN KEY (book_id) REFERENCES book(book_id),
FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- 6. CUSTOMER
CREATE TABLE customer (
customer_id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(100),
last_name VARCHAR(100),
email VARCHAR(150),
phone_number VARCHAR(20)
);

-- 7. COUNTRY 
CREATE TABLE country (
country_id INT AUTO_INCREMENT PRIMARY KEY,
country_name VARCHAR(100)
);

-- 8. ADDRESS
CREATE TABLE address (
address_id INT AUTO_INCREMENT PRIMARY KEY,
street VARCHAR(255),
city VARCHAR(100),
postal_code VARCHAR(20),
country_id INT,
FOREIGN KEY (country_id) REFERENCES country(country_id)
);

-- 9. address_status
CREATE TABLE address_status (
status_id INT AUTO_INCREMENT PRIMARY KEY,
status_name VARCHAR(50) NOT NULL
);

-- 10. CUSTOMER_ADDRESS
CREATE TABLE customer_address (
customer_id INT,
address_id INT,
PRIMARY KEY (customer_id, address_id),
FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
FOREIGN KEY (address_id) REFERENCES address(address_id)
);

-- 11. SHIPPING_METHOD
CREATE TABLE shipping_method (
method_id INT AUTO_INCREMENT PRIMARY KEY,
method_name VARCHAR(100),
cost DECIMAL(10, 2)
);

-- 12. ORDER_STATUS
CREATE TABLE order_status (
status_id INT AUTO_INCREMENT PRIMARY KEY,
status_name VARCHAR(50)
);

-- 13. CUST_ORDER
CREATE TABLE cust_order (
order_id INT AUTO_INCREMENT PRIMARY KEY,
customer_id INT,
order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
shipping_method_id INT,
status_id INT,
FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(method_id),
FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

-- 14. ORDER_LINE
CREATE TABLE order_line (
order_line_id INT AUTO_INCREMENT PRIMARY KEY,
order_id INT,
book_id INT,
quantity INT,
price DECIMAL(10, 2),
FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- 15. ORDER_HISTORY
CREATE TABLE order_history (
history_id INT AUTO_INCREMENT PRIMARY KEY,
order_id INT,
status_id INT,
update_time DATETIME DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

-- Add status_id column
ALTER TABLE customer_address
ADD COLUMN status_id INT;

-- Add foreign key constraint to link it with address_status table
ALTER TABLE customer_address
ADD CONSTRAINT fk_status_id
FOREIGN KEY (status_id) REFERENCES address_status(status_id);

CREATE INDEX idx_book_publisher ON book (publisher_id);
CREATE INDEX idx_book_language ON book (language_id);
CREATE INDEX idx_customer_email ON customer (email);
CREATE INDEX idx_order_customer ON cust_order (customer_id);

ALTER TABLE customer ADD UNIQUE (email);

INSERT INTO address_status (status_name) VALUES ('Active'), ('Inactive');
ALTER TABLE cust_order MODIFY COLUMN order_date DATETIME NOT NULL;
ALTER TABLE customer ADD COLUMN updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE cust_order ADD COLUMN updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
-- Add default value for status_id column in customer_address table
ALTER TABLE customer_address
  MODIFY COLUMN status_id INT DEFAULT 1;
  
  -- Check for records with NULL order_date in cust_order
SELECT * FROM cust_order WHERE order_date IS NULL;







