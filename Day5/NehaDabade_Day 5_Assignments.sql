--GROUP BY with WHERE - Orders by Year and Quarter
select * from orders

SELECT 
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(QUARTER FROM order_date) AS order_quarter,
    COUNT(*) AS order_count,
    AVG(freight) AS avg_freight_cost
FROM orders
WHERE freight > 100 
GROUP BY order_year, order_quarter
ORDER BY order_year,order_quarter;

********************************************************************************************************************************************************

--GROUP BY with HAVING - High Volume Ship Regions

SELECT Ship_region,
COUNT(*) AS Order_Count,
MIN(freight) AS min_freight,
MAX(freight) AS max_freight
FROM orders
GROUP BY Ship_region
HAVING COUNT (*) >= 5;

********************************************************************************************************************************************************

--Get all title designations across employees and customers 
--with UNION
SELECT title AS Designation FROM employees
UNION
SELECT contact_title AS Designation FROM customers;

-- With UNION ALL

SELECT title AS Designation FROM employees
UNION ALL
SELECT contact_title AS Designation FROM customers;

************************************************************************************************************************************
--Find categories that have both discontinued and in-stock products
SELECT category_id
FROM products
WHERE discontinued = 1

INTERSECT

SELECT category_id
FROM products
WHERE units_in_stock > 0;

****************************************************************************************************************************************
--Find orders that have no discounted items 
SELECT order_id
FROM Order_details

EXCEPT

SELECT order_id
FROM Order_details
WHERE discount>0



