# Bookstore Database Schema

This project defines a comprehensive relational database schema for a bookstore management system. It includes entities for books, authors, customers, orders, shipping, addresses, and more — suitable for supporting various bookstore operations such as order tracking, customer management, and inventory handling.

## 📦 Database Name
```sql
BOOKSTORE_DB;
```

---

## 🧱 Tables Overview

### 1. Publisher
Stores book publisher details.
```sql
CREATE TABLE Publisher (
  publisher_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);
```

### 2. Book Language
Languages in which books are available.
```sql
CREATE TABLE book_language (
  language_id INT AUTO_INCREMENT PRIMARY KEY,
  language_name VARCHAR(50) NOT NULL
);
```

### 3. Book
Stores book details with links to publisher and language.
```sql
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
```

### 4. Author
Contains author names.
```sql
CREATE TABLE author (
  author_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(100),
  last_name VARCHAR(100)
);
```

### 5. Book_Author
Many-to-Many relationship between books and authors.
```sql
CREATE TABLE book_author (
  book_id INT,
  author_id INT,
  PRIMARY KEY (book_id, author_id),
  FOREIGN KEY (book_id) REFERENCES book(book_id),
  FOREIGN KEY (author_id) REFERENCES author(author_id)
);
```

### 6. Customer
Customer personal information.
```sql
CREATE TABLE customer (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  email VARCHAR(150) UNIQUE,
  phone_number VARCHAR(20),
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

### 7. Country
List of countries for address referencing.
```sql
CREATE TABLE country (
  country_id INT AUTO_INCREMENT PRIMARY KEY,
  country_name VARCHAR(100)
);
```

### 8. Address
Stores physical address data.
```sql
CREATE TABLE address (
  address_id INT AUTO_INCREMENT PRIMARY KEY,
  street VARCHAR(255),
  city VARCHAR(100),
  postal_code VARCHAR(20),
  country_id INT,
  FOREIGN KEY (country_id) REFERENCES country(country_id)
);
```

### 9. Address Status
Defines whether an address is active or inactive.
```sql
CREATE TABLE address_status (
  status_id INT AUTO_INCREMENT PRIMARY KEY,
  status_name VARCHAR(50) NOT NULL
);
```

### 10. Customer_Address
Joins customers to addresses with status.
```sql
CREATE TABLE customer_address (
  customer_id INT,
  address_id INT,
  status_id INT DEFAULT 1,
  PRIMARY KEY (customer_id, address_id),
  FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
  FOREIGN KEY (address_id) REFERENCES address(address_id),
  FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);
```

### 11. Shipping Method
Available shipping options and their costs.
```sql
CREATE TABLE shipping_method (
  method_id INT AUTO_INCREMENT PRIMARY KEY,
  method_name VARCHAR(100),
  cost DECIMAL(10, 2)
);
```

### 12. Order Status
Defines possible statuses for an order.
```sql
CREATE TABLE order_status (
  status_id INT AUTO_INCREMENT PRIMARY KEY,
  status_name VARCHAR(50)
);
```

### 13. Cust_Order
Customer order details.
```sql
CREATE TABLE cust_order (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT,
  order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  shipping_method_id INT,
  status_id INT,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
  FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(method_id),
  FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);
```

### 14. Order Line
Books included in each order.
```sql
CREATE TABLE order_line (
  order_line_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  book_id INT,
  quantity INT,
  price DECIMAL(10, 2),
  FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
  FOREIGN KEY (book_id) REFERENCES book(book_id)
);
```

### 15. Order History
Track status changes of orders.
```sql
CREATE TABLE order_history (
  history_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  status_id INT,
  update_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
  FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);
```

---

## 🔍 Indexes for Optimization

```sql
CREATE INDEX idx_book_publisher ON book (publisher_id);
CREATE INDEX idx_book_language ON book (language_id);
CREATE INDEX idx_customer_email ON customer (email);
CREATE INDEX idx_order_customer ON cust_order (customer_id);
```

---

## 📥 Default Data Inserts

```sql
INSERT INTO address_status (status_name) VALUES ('Active'), ('Inactive');
```

---

## 🧪 Validation Query

```sql
-- Find orders with NULL order_date (should be none if schema is working)
SELECT * FROM cust_order WHERE order_date IS NULL;
```

---

## 📌 Notes

- Email in the `customer` table is unique.
- Timestamp fields help with tracking record updates.
- `customer_address.status_id` defaults to 'Active'.
- Designed to support real-world use like multi-address customers, order tracking, and multiple shipping methods.

---

## 📚 License

This schema is open-source and can be used or modified freely for educational or commercial projects.

---

## 🧑‍💻 Contributors

- **Bonface Mamboleo** – Admin & Lead Developer  
- **Sylvester Omondi** – Contributor 
- **George Mayia** – Contributor

Special thanks to the team for collaborative efforts, All members contributed equally to the entire project, from database design to implementation.
# BOOKSTORE_DB-PROJECT
