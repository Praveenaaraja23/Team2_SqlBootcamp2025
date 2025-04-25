-- DAY 3 ASSIGNMENT
-- 1) Update the categoryName From “Beverages” to "Drinks" in the categories table.
SELECT * FROM Categories
UPDATE Categories
SET CategoryName = 'Drinks'
WHERE CategoryName = 'Beverages'

SELECT * FROM Categories
ORDER BY CategoryID

--2)Insert into shipper new record (give any values) Delete that new record from shippers table.
SELECT * FROM Shippers
INSERT INTO Shippers (ShipperID, CompanyName)
Values(4, 'Federal Package')

DELETE FROM Shippers
WHERE ShipperID = 4

--3)Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. Display the both category and products table to show the cascade.
--Delete the categoryID= “3”  from categories. Verify that the corresponding records are deleted automatically from products.
--(HINT: Alter the foreign key on products(categoryID) to add ON UPDATE CASCADE, ON DELETE CASCADE)
ALTER TABLE Products 
DROP CONSTRAINT IF EXISTS products_categoryid_fkey

ALTER TABLE OrderDetails
DROP CONSTRAINT IF EXISTS orderdetails_productid_fkey


ALTER TABLE Products
ADD CONSTRAINT products_categoryid_fkey
FOREIGN KEY(CategoryID)
REFERENCES Categories(CategoryID)
ON UPDATE CASCADE
ON DELETE CASCADE

ALTER TABLE OrderDetails
ADD CONSTRAINT orderdetails_productid_fkey
FOREIGN KEY(ProductID)
REFERENCES Products(ProductID)
ON UPDATE CASCADE
ON DELETE SET NULL


UPDATE Categories
SET CategoryID = 1001
WHERE CategoryID = 1;

SELECT * FROM Categories
SELECT * FROM Products
SELECT * FROM OrderDetails

DELETE FROM Categories
WHERE CategoryID = 3


-- 4)Delete the customer = “VINET”  from customers. Corresponding customers in orders table should be set to null (HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL)
 SELECT * FROM Customers
 WHERE CustomerID = 'VINET';

ALTER TABLE Orders
DROP CONSTRAINT IF EXISTS orders_customerid_fkey;

ALTER TABLE OrderDetails
DROP CONSTRAINT IF EXISTS orderdetails_orderid_fkey;

ALTER TABLE Orders
ADD CONSTRAINT orders_customerid_fkey
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID)
ON UPDATE CASCADE
ON DELETE SET NULL;

ALTER TABLE OrderDetails
ADD CONSTRAINT orderdetails_orderid_fkey
FOREIGN KEY(OrderID)
REFERENCES Orders(OrderID)
ON UPDATE CASCADE
ON DELETE SET NULL;

DELETE FROM Customers
WHERE CustomerID = 'VINET';

SELECT * FROM Customers
SELECT * FROM Orders
SELECT * FROM OrderDetails

--5)Insert the following data to Products using UPSERT:

SELECT * FROM Products WHERE ProductID = 100

INSERT INTO Products(ProductId, ProductName, Quantityperunit,
Price_in_usd, Discontinued, CategoryID)
VALUES(100,'Wheat bread' , 1, 13, 0, 5)
ON CONFLICT(ProductID)
DO UPDATE
SET ProductName = Excluded.ProductName,
Quantityperunit = Excluded.Quantityperunit,
Price_in_usd = Excluded.Price_in_usd,
Discontinued = Excluded.Discontinued,
CategoryID = Excluded.CategoryID;

INSERT INTO Products(ProductId, ProductName, Quantityperunit,
Price_in_usd, Discontinued, CategoryID)
VALUES(101,'Wheat bread' , 5, 13, 0, 5)
ON CONFLICT(ProductID)
DO UPDATE
SET ProductName = Excluded.ProductName,
Quantityperunit = Excluded.Quantityperunit,
Price_in_usd = Excluded.Price_in_usd,
Discontinued = Excluded.Discontinued,
CategoryID = Excluded.CategoryID;

SELECT * FROM Products WHERE ProductID = 101

INSERT INTO Products(ProductId, ProductName, Quantityperunit,
Price_in_usd, Discontinued, CategoryID)
VALUES(100,'Wheat bread' , 10, 13, 0, 5)
ON CONFLICT(ProductID)
DO UPDATE
SET ProductName = Excluded.ProductName,
Quantityperunit = Excluded.Quantityperunit,
Price_in_usd = Excluded.Price_in_usd,
Discontinued = Excluded.Discontinued,
CategoryID = Excluded.CategoryID;

SELECT * FROM Products WHERE ProductID = 100;

--6)Write a MERGE query:Create temp table with name:  ‘updated_products’ and insert values 

MERGE INTO Products AS P
USING(
   VALUES
   (100, 'Wheat bread', '10', 20, 1, 5),
   (101, 'White bread', '5 boxes', 19.99, 0, 5),
   (102, 'Midnight Mango Fizz', '24 - 12 oz bottles', 19, 0, 1001),
   (103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10, 0, 2)
)AS Updated_Products(ProductId, ProductName, Quantityperunit,Price_in_usd, Discontinued, CategoryID)
ON P.ProductID = Updated_Products.ProductId

WHEN MATCHED AND  Updated_Products.Discontinued = 1 THEN
DELETE
WHEN MATCHED AND  Updated_Products.Discontinued = 0 THEN
UPDATE SET
   ProductName = Updated_Products.ProductName,
   Price_in_usd = Updated_Products.Price_in_usd
WHEN NOT MATCHED AND  Updated_Products.Discontinued = 0 THEN
   INSERT(ProductId, ProductName, Quantityperunit,
Price_in_usd, Discontinued, CategoryID)
   VALUES (Updated_Products.ProductId, Updated_Products.ProductName, Updated_Products.Quantityperunit,
Updated_Products.Price_in_usd, Updated_Products.Discontinued, Updated_Products.CategoryID)

SELECT * FROM Products WHERE ProductID IN (100, 101, 102, 103)


   
   


