CREATE USER 'kelompokit20'@'%' IDENTIFIED BY 'passwordit20';
CREATE USER 'kelompokit20'@'localhost' IDENTIFIED BY 'passwordit20';
CREATE DATABASE dbkelompokit20;
GRANT ALL PRIVILEGES ON *.* TO 'kelompokit20'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'kelompokit20'@'localhost';
FLUSH PRIVILEGES;