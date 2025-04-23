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

--Explanation
--Brief about why have you chose each constraints
-- Primary key is a column of Unique values.
-- Foreign key is a column that creates relationship between 2tables and it is a primary key of another table. 
-- Example, In Categories table CategoryID is Unique similarly in Customers table customerId is unique hence its a PRIMARY KEY.
-- In Orders table, CustomerId is a foreign key and in Products table CategoryId is a foreign key

