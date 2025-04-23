CREATE TABLE catagories(
catagory_ID VARCHAR (10) PRIMARY KEY,
catagory_name VARCHAR (50),
discription text 
);

SELECT * FROM catagories
************************************
CREATE TABLE customers(
customer_id VARCHAR (10) PRIMARY KEY,
company_name VARCHAR (50),
contactName VARCHAR (70),
contactTitle VARCHAR (60),
city VARCHAR (30),
country VARCHAR (30)
);

SELECT * FROM customers

************************************

CREATE TABLE employees(
employeeID int PRIMARY KEY,
employeeName VARCHAR (50),
title VARCHAR (50) ,
city VARCHAR (30),
country VARCHAR (30),
reports_to int 
);

SELECT * FROM employees

************************************

CREATE TABLE order_details(
orderID VARCHAR (10),
productID VARCHAR (20),
unitPrice VARCHAR (50),
quantity VARCHAR (50),
discount VARCHAR (30)
);

SELECT * FROM order_details
****************************************

CREATE TABLE orders(
orderID VARCHAR (10) PRIMARY KEY,
customerID VARCHAR (20),
employeeID VARCHAR (50),
orderDate VARCHAR (50),
requiredDate VARCHAR (30),
shippedDate VARCHAR (30),
shipperID VARCHAR (10),
freight VARCHAR (15)
);

SELECT * FROM orders
****************************************

CREATE TABLE products(
productID VARCHAR (10) PRIMARY KEY,
productName VARCHAR (50),
quantityPerUnit VARCHAR (50),
unitPrice VARCHAR (50),
discontinued VARCHAR (30),
categoryID VARCHAR (10)
);

ALTER TABLE products
ALTER COLUMN productName TYPE VARCHAR (70);

SELECT * FROM products

**************************************** 	

CREATE TABLE shippers(
shipperID VARCHAR (10) PRIMARY KEY,
companyName VARCHAR (20)
);

SELECT * FROM shippers
**************************************

--why we choose constraints?
-- For choosing the constraints we can set the rules on our database to make sure data is correct. 
--Constraints stops users from entering wrong data. Using constrains we can keep data unique.
--we can link the data properly using constraints.
