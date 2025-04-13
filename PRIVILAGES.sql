CREATE DATABASE bookstore_db;
USE bookstore_db;
CREATE USER 'Bonface_Mamboleo'@'localhost' IDENTIFIED BY 'BonfacePass123';
CREATE USER 'Sylvester_user'@'%' IDENTIFIED BY 'SylvesterPass123';
CREATE USER 'George_user'@'%' IDENTIFIED BY 'GeorgePass456';
CREATE USER 'read_user'@'%' IDENTIFIED BY 'ReadOnly123';
GRANT ALL PRIVILEGES ON bookstore_db.* TO 'Bonface_Mamboleo'@'localhost';
GRANT CREATE, DELETE, SELECT, INSERT, UPDATE ON bookstore_db.* TO 'Sylvester_user'@'%';
GRANT CREATE, DELETE, SELECT, INSERT, UPDATE ON bookstore_db.* TO 'George_user'@'%';
GRANT SELECT ON bookstore_db.* TO 'read_user'@'%';

FLUSH PRIVILEGES;
SHOW GRANTS FOR 'Sylvester_user'@'%';
SHOW GRANTS FOR 'George_user'@'%';
