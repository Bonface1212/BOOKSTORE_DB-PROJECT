USE bookstore_db;

SELECT b.title, a.first_name, a.last_name
FROM book b
JOIN book_author ba ON b.book_id = ba.book_id
JOIN author a ON ba.author_id = a.author_id;

SELECT co.order_id, co.order_date, os.status_name
FROM cust_order co
JOIN order_status os ON co.status_id = os.status_id
WHERE co.customer_id = 1;

SELECT c.first_name, c.last_name, a.street, cs.status_name
FROM customer c
JOIN customer_address ca ON c.customer_id = ca.customer_id
JOIN address a ON ca.address_id = a.address_id
JOIN address_status cs ON ca.status_id = cs.status_id;

EXPLAIN SELECT * FROM book WHERE publisher_id = 1;

SELECT language_name FROM book_language;




