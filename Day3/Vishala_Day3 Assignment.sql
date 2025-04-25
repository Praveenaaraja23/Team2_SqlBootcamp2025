CREATE DATABASE day1

CREATE TABLE categories (
    categoryID SERIAL PRIMARY KEY,
    categoryName VARCHAR(255) NOT NULL,
    description TEXT
);
SELECT * FROM categories

UPDATE categories
SET categoryname = 'Drinks'
WHERE categoryname = 'Beverages';

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
DELETE FROM customers WHERE customerid = 'ALFKI';
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

INSERT INTO shippers (shipperid, companyname)
VALUES (04, 'Speedy Express');

DELETE FROM shippers
WHERE shipperid = 4;

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

ALTER TABLE products
DROP CONSTRAINT products_categoryid_fkey,
ADD CONSTRAINT products_categoryid_fkey
FOREIGN KEY (categoryId)
REFERENCES categories(categoryId)
ON UPDATE CASCADE
ON DELETE CASCADE;

UPDATE categories
SET categoryid = 102
WHERE categoryid = 101;

INSERT INTO categories (categoryid,categoryname)
VALUES (101, 'Test Category');

INSERT INTO products (productid, productname ,discontinued, categoryid)
VALUES
 (201, 'Test product A', FALSE, 101),
 (202, 'Test product B', FALSE, 101);


SELECT * FROM products where categoryid= 101;
SELECT * FROM categories where categoryid= 101;
DELETE FROM categories
WHERE categoryid = 102;



INSERT INTO products (productID, productName, quantityPerUnit, unitPrice, discontinued, categoryID)
VALUES (100, 'Wheat bread', '10 boxes', 13, FALSE, 3)
ON CONFLICT (productID)
DO UPDATE SET
    quantityPerUnit = EXCLUDED.quantityPerUnit,
    unitPrice = EXCLUDED.unitPrice,
    discontinued = EXCLUDED.discontinued,
    categoryID = EXCLUDED.categoryID;

INSERT INTO products (productID, productName, quantityPerUnit, unitPrice, discontinued, categoryID)
VALUES (100, 'Wheat bread', '1', 13, FALSE, 3)
ON CONFLICT (productID)
DO UPDATE SET
    quantityPerUnit = EXCLUDED.quantityPerUnit,
    unitPrice = EXCLUDED.unitPrice,
    discontinued = EXCLUDED.discontinued,
    categoryID = EXCLUDED.categoryID;



SELECT * FROM products 



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


ALTER TABLE orders
DROP CONSTRAINT orders_customerid_fkey,
ADD CONSTRAINT orders_customerid_fkey
FOREIGN KEY (customerID)
REFERENCES customers(customerID)
ON DELETE SET NULL;

DELETE FROM customers WHERE customerid = 'VINET';


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


CREATE TABLE updatedproducts (
  productID INTEGER PRIMARY KEY,
  productName VARCHAR,
  quantityPerUnit VARCHAR,
  unitPrice DECIMAL(10,2),
  discontinued BOOLEAN,
  categoryID INTEGER
);
SELECT * FROM updatedproducts

INSERT INTO updatedproducts (productID, productName, quantityPerUnit, unitPrice, discontinued, categoryID)
VALUES 
  (100, 'Wheat bread', '10', 20, TRUE, 3),
  (101, 'White bread', '5 boxes', 19.99, FALSE, 3),
  (102, 'Midnight Mango Fizz', '24 - 12 oz bottles', 19, FALSE, 1),
  (103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10, FALSE, 2);

UPDATE updatedproducts p
SET 
  unitPrice = u.unitPrice,
  discontinued = u.discontinued
FROM updatedproducts u
WHERE p.productID = u.productID AND u.discontinued = FALSE;

DELETE FROM products
USING updatedproducts u
WHERE p.productID = u.productID AND u.discontinued = TRUE;

DELETE FROM products
USING updatedproducts u
WHERE products.productID = u.productID
  AND u.discontinued = TRUE;