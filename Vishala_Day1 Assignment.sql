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
