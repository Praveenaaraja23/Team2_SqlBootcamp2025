--DAY 2 ASSIGNENT IS BELOW DAY 1 
--DAY 1 ASSIGNMENT
CREATE TABLE Categories(
CategoryID INT PRIMARY KEY,
CategoryName VARCHAR(100) NOT NULL,
Description VARCHAR(100)
);

SELECT * FROM Categories

CREATE TABLE Customers(
CustomerID VARCHAR(20) PRIMARY KEY,
CompanyName VARCHAR(50),
ContactName VARCHAR(50),
ContactTitle VARCHAR(50),
City VARCHAR(30),
Country VARCHAR(30)
);

SELECT * FROM Customers

CREATE TABLE DataDictionaary(
Tablename VARCHAR(30),
Field VARCHAR(30),
Description VARCHAR(100)
);

SELECT * FROM DataDictionaary

CREATE TABLE Employees(
EmployeeID INT PRIMARY KEY,
EmployeeName VARCHAR(30),
Title VARCHAR(30),
City VARCHAR(20),
Country VARCHAR(20),
ReportsTo INT,
);

SELECT * FROM Employees


SELECT current_database();

CREATE TABLE Shippers(
ShipperID INT PRIMARY KEY,
CompanyName VARCHAR(50)
);

SELECT * FROM Shippers

CREATE TABLE Products(
ProductID INT PRIMARY KEY,
ProductName VARCHAR(50),
QuantityperUnit VARCHAR(50),
Unitprice FLOAT,
Discontinued INT,
CategoryID INT,
FOREIGN KEY(CategoryID) REFERENCES Categories(CategoryID)
);


SELECT * FROM Products

CREATE TABLE OrderDetails(
OrderID INT,
ProductID INT,
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
FOREIGN KEY (ProductID ) REFERENCES Products(ProductID ),
UnitPrice FLOAT,
Quantity INT,
Discount FLOAT 
);

SELECT * FROM OrderDetails

CREATE TABLE Orders(
OrderID INT PRIMARY KEY,
CustomerID VARCHAR(20),
EmployeeID INT,
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
OrderDate DATE,
RequiredDate DATE,
ShippedDate DATE,
ShipperID INT,
FOREIGN KEY (ShipperID) REFERENCES Shippers(ShipperID),
Freight FLOAT
);

SELECT * FROM Orders

--DAY 2 ASSIGNMENT

-- 1. Alter table, add column, change data type, delete column
ALTER TABLE Employees
ADD COLUMN Linkedin_profile VARCHAR(30);

ALTER TABLE Employees
ALTER COLUMN Linkedin_profile
SET DATA TYPE TEXT;

ALTER TABLE Employees
ALTER COLUMN Linkedin_profile
SET NOT NULL;

ALTER TABLE Employees
DROP COLUMN Linkedin_profile;

--2. Querying
SELECT EmployeeName,
--split_part(EmployeeName,' ' ,1)AS FirstName,
--split_part(EmployeeName, ' ', 2) AS LastName,
Title
FROM Employees;

SELECT DISTINCT UnitPrice
FROM Products;

SELECT *
FROM Customers
ORDER BY CompanyName;

SELECT ProductName, UnitPrice
FROM Products;

ALTER TABLE Products
RENAME UnitPrice to Price_in_usd;

SELECT * FROM Products;

--3. Filtering
SELECT * FROM Customers
WHERE Country = 'Germany';

SELECT * FROM Customers
WHERE Country = 'France' or Country= 'Spain';


SELECT * 
FROM(
SELECT *, EXTRACT (YEAR FROM OrderDate)AS Order_year
FROM Orders)
WHERE Order_year = 2014 AND
(FREIGHT > 50 OR ShippedDate IS NOT NULL);

--4. Filtering
SELECT ProductID, ProductName, Price_in_usd
FROM Products
WHERE Price_in_usd> 15;

SELECT EmployeeName
FROM Employees
WHERE Country = 'USA' AND Title = 'Sales Representative';

SELECT *
FROM Products
WHERE Price_in_usd >30 AND Discontinued = 0;

--5. Limit/Fetch
SELECT * FROM Orders
ORDER BY OrderDate
LIMIT 10;

SELECT * FROM Orders
ORDER BY OrderDate
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY;

--6. Filtering (IN/BETWEEN)
SELECT CustomerID, CompanyName, ContactName
FROM Customers
WHERE ContactTitle IN ('Sales Representative', 'Owner');

SELECT OrderID, CustomerID, ShipperID, OrderDate
FROM Orders
WHERE OrderDate BETWEEN '01-01-2013' AND '12-31-2013';

--7. Filtering
SELECT ProductID, ProductName
FROM Products
WHERE CategoryID NOT IN (1,2,3);

SELECT CustomerID, Country, CompanyName
FROM Customers
WHERE CompanyName LIKE 'A%';

--8. Insert into Orders table
SELECT * FROM Orders

INSERT INTO Orders(
OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipperID, Freight)
VALUES(
11078, 'ALFKI', 5, '2025-04-23', '2025-04-30', '2025-04-25', 2, 45.50);

SELECT * FROM Orders
WHERE OrderID = 11078

--9.       Increase(Update)  the unit price of all products in category_id =2 by 10%.
--(HINT: unit_price =unit_price * 1.10)
SELECT * FROM Products

UPDATE Products
SET Price_in_usd = Price_in_usd * 1.10
WHERE CategoryID = 2;

SELECT * FROM Products
WHERE CategoryID = 2;








--Explanation
--Brief about why have you chose each constraints
-- Primary key is a column of Unique values.
-- Foreign key is a column that creates relationship between 2tables and it is a primary key of another table. 
-- Example, In Categories table CategoryID is Unique similarly in Customers table customerId is unique hence its a PRIMARY KEY.
-- In Orders table, CustomerId is a foreign key and in Products table CategoryId is a foreign key

