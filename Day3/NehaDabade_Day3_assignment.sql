-- Update the categoryName From “Beverages” to "Drinks" in the categories table.

UPDATE catagories 
SET catagory_name = 'Drinks'
WHERE catagoryid = 1;

select * from catagories

****************************************************************************************************
--  Insert into shipper new record (give any values) Delete that new record from shippers table.

INSERT INTO shippers (shipperid, companyname)
VALUES (4, 'UPS Express');

select * from shippers

****************************************************************************************************
--  Update categoryID
ALTER TABLE products
ADD CONSTRAINT fk_products_catagories
FOREIGN KEY (catagoryid)
REFERENCES catagories(catagoryid)
ON UPDATE CASCADE
ON DELETE CASCADE;

UPDATE catagories 
SET catagoryid = 1001
WHERE catagoryid = 1;

select * from catagories;

select * from products;
--Delete the categoryID= “3”  from categories

DELETE FROM catagories
WHERE catagoryid = 3;
****************************************************************************************************
--Delete the customer = “VINET”  from customers. Corresponding customers in orders table should be set to null

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customerid)
REFERENCES customers(customerid)
ON UPDATE CASCADE
ON DELETE SET NULL;

INSERT INTO customers(customerid,company_name,contactname,contacttitle,city,country)
VALUES ('VINET','AMAZON','John Washington','Sales Representative','Boston','USA');

DELETE FROM customers
WHERE customerid = 'VINET';

select * from customers where customerid = 'VINET';

select * from orders where customerid = 'VINET';
****************************************************************************************************

--insert the data to Products using UPSERT: product_id = 100, product_name = Wheat bread, quantityperunit=1,unitprice = 13, discontinued = 0, categoryID=5
INSERT INTO products (productid,productname,quantityperunit,unitprice,discontinued,catagoryid)
VALUES (100,'Wheat bread',1,13,0,5)
ON CONFLICT (productid)
DO UPDATE
SET quantityperunit = EXCLUDED.quantityperunit;

--product_id = 101, product_name = White bread, quantityperunit=5 boxes,unitprice = 13, discontinued = 0, categoryID=5
INSERT INTO products (productid,productname,quantityperunit,unitprice,discontinued,catagoryid)
VALUES (101,'White bread',5,13,0,5)
ON CONFLICT (productid)
DO UPDATE
SET quantityperunit = EXCLUDED.quantityperunit;


select * from products where productid = 101;

--product_id = 100, product_name = Wheat bread, quantityperunit=10 boxes,unitprice = 13, discontinued = 0, categoryID=5

select * from products where productid = 100;

INSERT INTO products (productid,productname,quantityperunit,unitprice,discontinued,catagoryid)
VALUES (100,'Wheat bread',10,13,0,5)
ON CONFLICT (productid)
DO UPDATE
SET quantityperunit = EXCLUDED.quantityperunit;
	
****************************************************************************************************
--Write a MERGE query:
--Update the price and discontinued status for from below table ‘updated_products’ only if there are matching products and updated_products .discontinued =0 
 CREATE TEMP TABLE updated_products(
productID int,
productName VARCHAR (50),
quantityPerUnit VARCHAR (50),
unitPrice numeric (50),
discontinued int,
categoryID int
 );

INSERT INTO updated_products(productID,productName,quantityPerUnit,unitPrice,discontinued,categoryID)
VALUES (100,'Wheat bread',10,20,1,5),
		(101,'Wheat bread','5 boxes',19.99,0,5),
		(102,'Midnight Mango Fizz','24 - 12 oz bottles',19,0,1),
		(103,'Savory Fire Sauce','12 - 550 ml bottles',10,0,2);

select * from updated_products

INSERT INTO catagories(catagoryid,catagory_name,discription)
VALUES (1,'Drinks','Soft drinks,coffees,teas,beers,and ales');

--UPDATE if match and not discontinued,DELETE if match and discontinued and INSERT if no match and not discontinued

MERGE INTO products p
USING updated_products u
ON p.productid = u.productID
WHEN MATCHED AND u.discontinued = 0 THEN
UPDATE SET 
        unitprice = u.unitPrice,
        discontinued = u.discontinued

WHEN MATCHED AND u.discontinued = 1 THEN
DELETE

WHEN NOT MATCHED AND u.discontinued = 0 THEN
INSERT (productID, productName, quantityPerUnit, unitPrice, discontinued, catagoryid)
VALUES (u.productID, u.productName, u.quantityPerUnit, u.unitPrice, u.discontinued, u.categoryID);

SELECT * FROM products;

select * from catagories;

*******************************************************************************************************
--List all orders with employee full names. (Inner join) (Used northwind DB)

select employees.first_name, employees.last_name,orders.* from orders
inner join employees
ON orders.employee_id = employees.employee_id;

select * from orders

select * from employees
	