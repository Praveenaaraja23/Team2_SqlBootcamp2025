-- 1. Alter Table
-- Add column

ALTER TABLE employees
ADD COLUMN linkedin_profile VARCHAR;

select * from employees;


-- change data type

ALTER TABLE employees
ALTER COLUMN linkedin_profile
SET DATA TYPE text;

-- add UNIQUE NOT NULL constraint

ALTER TABLE employees
    ALTER COLUMN linkedin_profile SET NOT NULL,
    ADD CONSTRAINT unique_linkedin_profile UNIQUE (linkedin_profile);

-- Drop column
ALTER TABLE employees
DROP COLUMN linkedin_profile;
***********************************************************************************************************************

--2. Querying (Select) 
--Retrieve the employee name and title of all employees

select * from employees;

select employeename, title from employees;

--Find all unique unit prices of products

select * from products;

select distinct unitprice from products;

--List all customers sorted by company name in ascending order

select * from customers

select contactname, company_name from customers order by company_name asc;

--Display product name and unit price, but rename the unit_price column as price_in_usd

select productname, unitprice as price_in_usd from products;

******************************************************************************************************************************************

--3. Fltering
--Get all customers from Germany.

select * from customers where country = 'Germany';

--Find all customers from France or Spain

select * from customers where country IN ('France' , 'Spain');

--Retrieve all orders placed in 2014(based on order_date), and either have freight greater than 50 or the shipped date available (i.e., non-NULL)  (Hint: EXTRACT(YEAR FROM order_date))

select * from orders 
where EXTRACT(YEAR FROM orderdate) = 2014
AND (freight > 50 or shippeddate is not null);

*****************************************************************************************************************************************************
--4.filtering
-- Retrieve the product_id, product_name, and unit_price of products where the unit_price is greater than 15.

select * from products

select productid, productname, unitprice from products where unitprice > 15;

--List all employees who are located in the USA and have the title "Sales Representative".
 
select * from employees where country = 'USA' AND title = 'Sales Representative';

--Retrieve all products that are not discontinued and priced greater than 30.

select * from products where discontinued = FALSE and unitprice > 30;

***********************************************************************************************************************************************************
--5. Limit/Fetch
-- Retrieve the first 10 orders from the orders table.

select * from orders limit 10;

--Retrieve orders starting from the 11th order, fetching 10 rows (i.e., fetch rows 11-20).

select * from orders 
offset 10 rows 
fetch next 10 rows only;

*********************************************************************************************************************************************************
--6 Filtering (IN, BETWEEN)
--List all customers who are either Sales Representative, Owner 
 select * from customers 
 where contacttitle = 'Sales Reprentative'
 or contacttitle = 'Owner';

--Retrieve orders placed between January 1, 2013, and December 31, 2013.

select * from orders where orderdate between '2013-01-01' and '2013-12-31';

*********************************************************************************************************************************************************
--7 Filtering
-- List all products whose category_id is not 1, 2, or 3.

select * from products where categoryid NOT  IN (1,2,3);

--Find customers whose company name starts with "A".

select * from customers where company_name like 'A%';

*********************************************************************************************************************************************************
--8 
