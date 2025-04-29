--1. GROUP BY with WHERE

SELECT 
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(QUARTER FROM order_date) AS order_quarter,
    COUNT(*) AS order_count,
    AVG(freight) AS avg_freight_cost
FROM 
    orders
WHERE 
    freight > 100GROUP BY with HAVING
GROUP BY 
    EXTRACT(YEAR FROM order_date),
    EXTRACT(QUARTER FROM order_date)
ORDER BY 
    order_year,
    order_quarter;

--2.GROUP BY with HAVING
SELECT 
    Ship_region,
    COUNT(*) AS OrderCount,
    MIN(freight) AS minfreight,
    MAX(freight) AS maxfreight
FROM orders
WHERE Ship_region IS NOT NULL
GROUP BY Ship_region
HAVING COUNT(*) >= 5;

--3.Get all title designations across employees and customers ( Try UNION & UNION ALL)

-- Using UNION (removes duplicates)
SELECT title AS Designation FROM employees
UNION
SELECT contact_title AS Designation FROM Customers;

-- Using UNION ALL (includes duplicates)
SELECT title AS Designation FROM Employees
UNION ALL
SELECT contact_title AS Designation FROM Customers;

--4.Find categories that have both discontinued and in-stock products
-- Using INTERSECT
SELECT category_id
FROM products
WHERE discontinued = 1

INTERSECT

SELECT category_id
FROM products
WHERE units_in_stock > 0;

--5.Find orders that have no discounted items (Display the  order_id, EXCEPT)

SELECT order_id
FROM order_details
GROUP BY order_id
HAVING SUM(discount) = 0;








