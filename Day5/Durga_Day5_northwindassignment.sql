--DAY 5 ASSIGNMENT
--  1. GROUP BY with WHERE - Orders by Year and Quarter
--Display, order year, quarter, order count, avg freight cost only for those orders where freight cost > 100

SELECT EXTRACT (YEAR FROM Order_date) AS order_year, EXTRACT (QUARTER FROM Order_date) AS quarter_o , 
       COUNT(*) AS order_count, AVG(freight) AS average_freightcost
FROM Orders
WHERE freight>100
GROUP BY order_year, quarter_o
ORDER BY order_year,  quarter_o

--2. GROUP BY with HAVING - High Volume Ship Regions
--Display, ship region, no of orders in each region, min and max freight cost. Filter regions where no of orders >= 5
SELECT ship_region, COUNT(ship_region) AS no_of_orders, ROUND(MIN(freight)::NUMERIC,2) AS min_freightcost,  
       ROUND(MAX(freight)::NUMERIC,2) AS max_freightcost
FROM Orders
GROUP BY ship_region
HAVING COUNT(ship_region) > 5
ORDER BY no_of_orders DESC

--3. Get all title designations across employees and customers ( Try UNION & UNION ALL)
-- Using UNION (Merge and Removes Duplicate values)
SELECT title AS designation_title
FROM Employees
UNION
SELECT contact_title AS designation_title 
FROM Customers
ORDER BY designation_title 

--Using UNION ALL (Merge and Keeps duplicate values)
SELECT title AS designation_title
FROM Employees
UNION ALL
SELECT contact_title AS designation_title 
FROM Customers
ORDER BY designation_title 

--4.Find categories that have both discontinued and in-stock products
--(Display category_id, instock means units_in_stock > 0, Intersect)

SELECT category_id
FROM Products
WHERE discontinued = 1

INTERSECT

SELECT category_id
FROM Products
WHERE units_in_stock>0

--5. Find orders that have no discounted items (Display the  order_id, EXCEPT)

SELECT order_id
FROM Order_details

EXCEPT

SELECT order_id
FROM Order_details
WHERE discount>0










