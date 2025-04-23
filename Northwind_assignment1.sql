CREATE TABLE Categories(
CategoryID INT PRIMARY KEY,
CategoryName VARCHAR(100) NOT NULL,
Description VARCHAR(100) NOT NULL
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
ReportsTo INT
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
CategoryID INT
);

SELECT * FROM Products

CREATE TABLE OrderDetails(
OrderID INT,
ProductID INT,
UnitPrice FLOAT,
Quantity INT,
Discount FLOAT 
);

SELECT * FROM OrderDetails

CREATE TABLE Orders(
OrderID INT PRIMARY KEY,
CustomerID VARCHAR(20),
EmployeeID INT,
OrderDate DATE,
RequiredDate DATE,
ShippedDate DATE,
ShipperID INT,
Freight FLOAT
);

SELECT * FROM Orders