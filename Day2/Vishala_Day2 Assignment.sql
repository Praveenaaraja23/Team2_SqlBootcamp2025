CREATE DATABASE day1

CREATE TABLE categories (
    categoryID SERIAL PRIMARY KEY,
    categoryName VARCHAR(255) NOT NULL,
    description TEXT
);
SELECT * FROM categories

-- CUSTOMERS
CREATE TABLE customers (
    customerID VARCHAR(10) PRIMARY KEY,
    companyName VARCHAR(255) NOT NULL,
    contactName VARCHAR(255),
    contactTitle VARCHAR(255),
    city VARCHAR(100),
    country VARCHAR(100)
);

SELECT * FROM customers

SELECT * FROM customers
ORDER BY companyName ASC;

SELECT * FROM customers
WHERE country = 'Germany';

SELECT * FROM customers
WHERE country IN ('France', 'Spain');

SELECT * FROM customers
WHERE contacttitle IN ('Sales Representative', 'Owner');

SELECT * FROM customers
WHERE companyname LIKE 'A%';



-- EMPLOYEES
CREATE TABLE employees (
    employeeID SERIAL PRIMARY KEY,
    employeeName VARCHAR(255) NOT NULL,
	city VARCHAR(255),
	country VARCHAR(255),
    title VARCHAR(255),
    reportsTo INTEGER,
    FOREIGN KEY (reportsTo) REFERENCES employees(employeeID)
);


SELECT * FROM employees

ALTER TABLE employees ADD COLUMN linkedin_profile VARCHAR;

ALTER TABLE employees ALTER COLUMN linkedin_profile TYPE TEXT;

ALTER TABLE employees
    ALTER COLUMN linkedin_profile SET NOT NULL,
    ADD CONSTRAINT unique_linkedin_profile UNIQUE (linkedin_profile);

ALTER TABLE employees DROP COLUMN linkedin_profile;

SELECT first_name, last_name, title FROM employees;

SELECT * FROM employees
WHERE title = 'USA'
  AND city = 'Sales Representative';
-- SHIPPERS
CREATE TABLE shippers (
    shipperID SERIAL PRIMARY KEY,
    companyName VARCHAR(255) NOT NULL,
);

SELECT * FROM shippers

-- PRODUCTS
CREATE TABLE products (
    productID SERIAL PRIMARY KEY,
    productName VARCHAR(255) NOT NULL,
    quantityPerUnit VARCHAR(255),
    unitPrice DECIMAL(10, 2),
    discontinued BOOLEAN,
    categoryID INTEGER,
    FOREIGN KEY (categoryID) REFERENCES categories(categoryID)
);

SELECT * FROM products
SELECT DISTINCT unitPrice FROM products;
SELECT productName, unitprice AS priceinusd FROM products;
SELECT productid, productname, unitprice
FROM products
WHERE unitprice > 15;
SELECT * FROM products
WHERE discontinued = FALSE
  AND unitprice > 30;
SELECT * FROM products
WHERE categoryid NOT IN (1, 2, 3);

UPDATE products
SET unitprice = unitprice * 1.10
WHERE categoryid = 2;



-- ORDERS
CREATE TABLE orders (
    orderID INTEGER PRIMARY KEY,
    customerID VARCHAR(10),
    employeeID INTEGER,
    orderDate DATE,
    requiredDate DATE,
    shippedDate DATE,
    shipperID INTEGER,
    freight NUMERIC(10, 2)
   
);

SELECT * FROM orders

SELECT * FROM orders
WHERE EXTRACT(YEAR FROM orderdate) = 2014
  AND (freight > 50 OR shippeddate IS NOT NULL);

SELECT * FROM orders
LIMIT 10;

SELECT * FROM orders
OFFSET 10
LIMIT 10;

SELECT * FROM orders
WHERE orderdate BETWEEN '2013-01-01' AND '2013-12-31';

INSERT INTO orders (
  orderid, customerid, employeeid, orderdate,
  requireddate, shippeddate, shipperid, freight
)
VALUES (
  11078, 'ALFKI', 5, '2025-04-23',
  '2025-04-30', '2025-04-25', 2, 45.50
);

-- ORDER_DETAILS (junction table with composite primary key)
CREATE TABLE order_details (
    orderID INTEGER,
    productID INTEGER,
    unitPrice DECIMAL(10, 2),
    quantity INTEGER,
    discount DECIMAL(4, 2),
    PRIMARY KEY (orderID, productID),
    FOREIGN KEY (orderID) REFERENCES orders(orderID),
    FOREIGN KEY (productID) REFERENCES products(productID)
);

SELECT * FROM order_details
