--1
SELECT
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(QUARTER FROM order_date) AS order_quarter,
    COUNT(*) AS order_count,
    AVG(freight) AS avg_freight_cost
FROM
    orders
WHERE
    freight > 100
GROUP BY
    order_year,
    order_quarter
ORDER BY
    order_year,
    order_quarter;

--2
select* from orders;

select ship_region as ship_region,
 COUNT(*) AS order_count,
 min(freight) as min_freight,
 max(freight) as max_freight
 FROM
    orders
	group by ship_region
HAVING
     COUNT(*) >= 5
order BY ship_region;

--3
select* from employees;
select* from customers;


SELECT title AS designation
FROM employees

UNION  -- UNION removes duplicates by default


SELECT contact_title AS designation
FROM customers
UNION
select title as designation
from employees


UNION ALL  -- UNION ALL includes all rows, including duplicates

SELECT contact_title AS designation
FROM customers
UNION ALL
select title as designation
from employees

--4
select* from products;

SELECT category_id,
units_in_stock as instock
FROM products
WHERE product_id IN (
    SELECT product_id
    FROM products
    WHERE discontinued = 1
)
INTERSECT
SELECT category_id,
units_in_stock as instock
FROM products
WHERE product_id IN (
    SELECT product_id
    FROM products
    WHERE units_in_stock > 0
);

---5
SELECT order_id
FROM orders
WHERE order_id NOT IN (
    SELECT order_id
    FROM order_details
    WHERE discount > 0 
);

















	