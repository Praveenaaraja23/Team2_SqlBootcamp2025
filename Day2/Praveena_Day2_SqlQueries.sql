---1.Alter Table
---Add new column 
Alter Table employees  ADD COLUMN  linkedin_profile VARCHAR(80);

---Change the linkedin_profile column data type from VARCHAR to TEXT.

Alter Table employees 
Alter COLUMN  linkedin_profile
SET DATA TYPE text;
UPDATE employees

--Updating values without Null 
UPDATE employees
SET linkedin_profile = 'linkedin' || employeeid
WHERE linkedin_profile IS NULL;

---Now Adding Not null and Unique constraints
Alter Table Employees 
ALTER COLUMN linkedin_profile SET NOT NULL,
ADD CONSTRAINT unique_linkedin UNIQUE(linkedin_profile)

---Drop column linkedin_profile
   ALTER TABLE employees DROP COLUMN linkedin_profile;

   select * from employees

--............................................................................................................................................................ 
---2.Querying (Select)
--Retrieve the employee name and title of all employees

SELECT  employeename, title FROM employees;

--Find all unique unit prices of products
SELECT DISTINCT unitprice FROM products;

--List all customers sorted by company name in ascending order
SELECT * from customer ORDER BY companyname ASC

--Display product name and unit price, but rename the unit_price column as price_in_usd

Select productname,unitprice As price_in_usd from products
--............................................................................................................................................................
--3.Filtering from customers and orders

--Get all customers from Germany
SELECT * from customer where country ='Germany';

----Find all customers from France or Spain
SELECT * FROM customer WHERE country IN ('France', 'Spain');

---Retrieve all orders placed in 2014(based on order_date), and either have freight greater than 50 or the shipped date available
       SELECT * FROM orders 
       WHERE EXTRACT(YEAR FROM orderDate) = 2014 
          AND (freight > 50 OR shippedDate IS NOT NULL);
--............................................................................................................................................................		  
    ---4.Filtering		  
	---Products with unit price > 15
	       SELECT productID, productName, unitPrice FROM products WHERE unitPrice > 15;

   ---List all employees who are located in the USA and have the title "Sales Representative".

          SELECT * FROM employees 
		  WHERE country = 'USA' AND title = 'Sales Representative';

		  --Retrieve all products that are not discontinued and priced greater than 30

		        SELECT * FROM products WHERE discontinued = FALSE AND unitPrice > 30;
--............................................................................................................................................................				
	--5.LIMIT/FETCH
    --- Retrieve the first 10 orders from the orders table

      SELECT * FROM orders ORDER BY orderID LIMIT 10;

	  --- Retrieve orders starting from the 11th order, fetching 10 rows

	     SELECT * FROM orders ORDER BY orderID OFFSET 10 LIMIT 10;

--............................................................................................................................................................
---6.Filtering (IN, BETWEEN)
----List all customers who are either Sales Representative, Owner

SELECT * FROM customer
WHERE contactTitle IN ('Sales Representative', 'Owner');


---Retrieve orders placed between January 1, 2013, and December 31, 2013

SELECT * FROM orders WHERE orderdate BETWEEN '2013-01-01' AND '2013-12-31';

--............................................................................................................................................................
---7.Filtering
  --- List all products whose category_id is not 1, 2, or 3.
    SELECT * FROM products WHERE categoryID NOT IN (1, 2, 3);

	--Find customers whose company name starts with "A".
      SELECT * FROM customer where companyname LIKE 'A%'

--............................................................................................................................................................
	  ---8.INSERT into orders table
         	---Add a new order

	   INSERT INTO orders (orderid,customerid,employeeid,orderdate,requireddate,shippeddate,shipperid,freight) 
	   values(11078,'ALFKI',5,'2025-04-23','2025-04-30','2025-04-25',2,45.50);

	   select * from orders where orderid ='11078';
--..........................................................................................................................................................
	---9.Increase(Update)  the unit price of all products in category_id =2		

        UPDATE products
		SET unitprice = unitprice * 1.10
		WHERE categoryid = 2


 select * from products where categoryid = 2



