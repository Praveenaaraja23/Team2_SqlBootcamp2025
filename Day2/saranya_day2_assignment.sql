--Day 2
--1 Alter Table:

ALTER TABLE employees
ADD COLUMN linkedin_profile VARCHAR(100);

ALTER TABLE employees
ALTER COLUMN linkedin_profile TYPE TEXT; 

ALTER TABLE employees
ALTER COLUMN linkedin_profile SET NOT NULL,
ADD CONSTRAINT linkedin_profile_unique UNIQUE (linkedin_profile);

ALTER TABLE employees
DROP COLUMN linkedin_profile;

--2 Querying (Select)

SELECT employeename, title
FROM employees;

select * from employees;

select * from products;

SELECT DISTINCT unitprice
FROM products;

select * from customers;

SELECT *
FROM customers
ORDER BY companyname ASC;

SELECT productname, unitprice AS price_in_usd
FROM products;

--3  Filtering

SELECT * 
FROM customers
WHERE country = 'Germany';

SELECT *
FROM customers
WHERE country IN ('France', 'Spain');

SELECT *
FROM orders
WHERE EXTRACT(YEAR FROM orderdate) = 2014
  AND (freight > 50 OR shippeddate IS NOT NULL);

--4 Filtering

SELECT productid, productname, unitprice
FROM products
WHERE unitprice > 15;

SELECT *
FROM employees
WHERE country = 'USA'
  AND title = 'Sales Representative';
  
SELECT *
FROM products
WHERE discontinued = 1
  AND unitprice > 30;

--5 LIMIT/FETCH

SELECT *
FROM orders
LIMIT 10;

SELECT *
FROM orders
ORDER BY orderid
OFFSET 10          
LIMIT 10; 

--6 Filtering (IN, BETWEEN)

SELECT *
FROM customers
WHERE contacttitle IN ('Sales Representative', 'Owner');

SELECT *
FROM orders
WHERE orderdate BETWEEN '2013-01-01' AND '2013-12-31'

---7 Filtering
SELECT *
FROM products
WHERE categoryid NOT IN (1, 2, 3);


--8 INSERT into orders table:

INSERT INTO orders (
    orderid, customerid, employeeid, orderdate, requireddate, 
    shippeddate, shipperid, freight
) 
VALUES (
    11078, 'ALFKI', 5, '2025-04-23', '2025-04-30', 
    '2025-04-25', 2, 45.50
)

select * from orders;

--9 

UPDATE products
SET unitprice = unitprice * 1.10
WHERE categoryid = 2;

select * from products;


  







