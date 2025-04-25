select * from category

--1.Update the categoryName From “Beverages” to "Drinks" in the categories table.
UPDATE category
SET categoryname = 'Drinks'
WHERE categoryname = 'Beverages';

--2.  Insert into shipper new record (give any values) Delete that new record from shippers table.
select * from shippers
Insert INTO shippers(shipperid,companyname) values (4,'Express shipping')

DELETE FROM shippers
WHERE shipperid=4;

 ---3. Update categoryID=1 to categoryID=1001
 ---Drop existing foreign key
 ALTER TABLE products DROP CONSTRAINT products_categoryid_fkey;

 ---Adding foriegn key on updated and delete cascade
 ALTER TABLE products
ADD CONSTRAINT products_categoryid_fkey
FOREIGN KEY (categoryid) REFERENCES category(categoryid)
ON UPDATE CASCADE
ON DELETE CASCADE;

---Updating categoryID=1 to categoryID=1001 

 UPDATE category 
 SET categoryid=1001 WHERE categoryid=1;

 SELECT * FROM products WHERE categoryid=1001
 SELECT * FROM category

--Delete categoryID =3 
 ---Drop existing foreign key
ALTER TABLE orderdetails DROP CONSTRAINT orderdetails_productid_fkey;

 ---Adding foriegn key on delete cascade
 
ALTER TABLE orderdetails
ADD CONSTRAINT orderdetails_productid_fkey
FOREIGN KEY (productid)
REFERENCES products(productid)
ON DELETE CASCADE;
  

DELETE FROM category WHERE categoryid =3;
SELECT * FROM category WHERE categoryid = 3;
SELECT * FROM products WHERE categoryid = 3;


--4.Delete the customer = “VINET”  from customers. Corresponding customers in orders table should be set to null
-- Drop existing foreign key
ALTER TABLE orders DROP CONSTRAINT orders_customerid_fkey

--set with ON DELETE SET NULL
ALTER TABLE orders
ADD CONSTRAINT orders_customerid_fkey 
FOREIGN KEY (customerid) REFERENCES customer(customerid)
ON DELETE SET NULL;
--Deleting customerid = 'VINET'
DELETE FROM customer WHERE customerid = 'VINET'

SELECT * FROM orders WHERE customerid IS NULL


--5. Insert the following data to Products using UPSERT
  
INSERT INTO products(productid,productname,quantityperunit,unitprice,discontinued,categoryid)  
values (100, 'White bread', 1, 13, FALSE, 5)
ON CONFLICT (productid)
DO UPDATE 
SET quantityperunit = EXCLUDED.quantityperunit;

SELECT * FROM products WHERE productid = 100;
SELECT * FROM category

INSERT INTO products(productid,productname,quantityperunit,unitprice,discontinued,categoryid)  
values (101, 'White bread', '5 boxes', 13, FALSE, 5)
ON CONFLICT (productid)
DO UPDATE 
SET quantityperunit = EXCLUDED.quantityperunit;

SELECT * FROM products WHERE productid = 101;


INSERT INTO products (productid, productname, quantityperunit, unitprice, discontinued, categoryid)
VALUES (100, 'Wheat bread', '10 boxes', 13, FALSE, 3)
ON CONFLICT (productid)
DO UPDATE 
SET quantityperunit = EXCLUDED.quantityperunit;

SELECT * FROM products WHERE productid = 100;

---6.MERGE query
   --Creating Temp Table
   CREATE TEMPORARY TABLE updated_products (
  productid INTEGER,
  productname VARCHAR(100),
  quantityperunit VARCHAR(100),
  unitprice DECIMAL(10,2),
  discontinued INTEGER,
  categoryid INTEGER
);


INSERT INTO updated_products(productid, productname, quantityperunit, unitprice, discontinued, categoryid) VALUES
  (100, 'Wheat bread', '10', 20, 'TRUE', 3),
(101, 'White bread', '5 boxes', 19.99, 'FALSE', 3),
(102, 'Midnight Mango Fizz', '24 - 12 oz bottles', 19, 'FALSE', 1001),
(103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10, 'FALSE', 2);

SELECT * FROM updated_products;

--UPDATE if match and not discontinued,DELETE if match and discontinued and INSERT if no match and not discontinued

  MERGE INTO products p
USING updated_products u
ON p.productid = u.productid
WHEN MATCHED AND u.discontinued = 'FALSE' THEN
UPDATE SET 
        unitprice = u.unitprice,
        discontinued = u.discontinued
WHEN MATCHED AND u.discontinued = 'TRUE' THEN
DELETE
WHEN NOT MATCHED AND u.discontinued = 'FALSE' THEN
INSERT (productid, productname, quantityperunit, unitprice, discontinued, categoryid)
VALUES (u.productid, u.productname, u.quantityperunit, u.unitprice, u.discontinued, u.categoryid);

SELECT * FROM products;

--........................................................................................................................
NEW Northwind DB:
 7.List all orders with employee full names. (Inner join)

 
SELECT * FROM employees
SELECT * FROM orders

SELECT  o.order_id, 
    o.customer_id, 
    o.order_date, 
     e.first_name || ' ' || e.last_name AS employeefullname,
	 o.required_date,
     o.shipped_date,
     o.ship_via,
     o.freight
FROM 
    orders o
INNER JOIN 
    employees e ON o.employee_id = e.employee_id;

