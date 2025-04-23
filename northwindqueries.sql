CREATE TABLE Category (
    categoryID INTEGER PRIMARY KEY,
    categoryName VARCHAR(50),
    description TEXT
);

SELECT * FROM category
ORDER BY categoryid ASC 


CREATE TABLE customer (
    customerID VARCHAR(5) PRIMARY KEY,
    companyName VARCHAR(50),
    contactName VARCHAR(50),
    contactTitle VARCHAR(50),
    city VARCHAR(50),
    country VARCHAR(50)
);

SELECT * FROM customer

CREATE TABLE employees (
    employeeID INTEGER PRIMARY KEY,
    employeeName VARCHAR(50) NOT NULL,
    title VARCHAR(50),
    city VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    reportsTo INTEGER 
);

Select * from employees

ALTER TABLE employees
ALTER COLUMN reportsTo
SET NOT NULL;


CREATE TABLE shippers (
    shipperID INTEGER PRIMARY KEY,
    companyName VARCHAR(50)
);

select * from shippers

CREATE TABLE orderdetails (
    orderID INTEGER,
    productID INTEGER,
    unitPrice NUMERIC(10,2),
    quantity INTEGER,
    discount NUMERIC(3,2),
    PRIMARY KEY (orderID, productID),
    FOREIGN KEY (orderID) REFERENCES orders(orderID),
    FOREIGN KEY (productID) REFERENCES products(productID)
);
select * from orderdetails


CREATE TABLE products (
    productID INTEGER PRIMARY KEY,
    productName VARCHAR(100),
    quantityPerUnit VARCHAR(50),
    unitPrice DECIMAL(10,2),
    discontinued BOOLEAN,
    categoryID INTEGER,
    FOREIGN KEY (categoryID) REFERENCES Category(categoryID)
);

select * from products

CREATE TABLE Orders (
    orderID INTEGER PRIMARY KEY,
    customerID VARCHAR(5),
    employeeID INTEGER,
    orderDate DATE,
    requiredDate DATE,
    shippedDate DATE,
    shipperID INTEGER,
    freight DECIMAL(10,2),
    FOREIGN KEY (customerID) REFERENCES customer(customerID),
    FOREIGN KEY (employeeID) REFERENCES employees(employeeID),
    FOREIGN KEY (shipperID) REFERENCES shippers(shipperID)
);

select * from orders







