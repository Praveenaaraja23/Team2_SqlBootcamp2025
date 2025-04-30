--1
SELECT
    product_name,
    CASE
        WHEN units_in_stock = 0 THEN 'Out of Stock'
        WHEN units_in_stock < 20 THEN 'Low Stock'
        ELSE 'In Stock'
    END AS stock_status
FROM
    products;

--2
SELECT product_name, unit_price
FROM products
WHERE category_id = (
        SELECT category_id 
        FROM categories 
        WHERE category_name = 'Beverages'
    );
	
--3
SELECT order_id, order_date, freight, employee_id
FROM orders
WHERE employee_id = (
        SELECT employee_id
        FROM (
            SELECT employee_id, COUNT(*) AS total_orders
            FROM orders
            GROUP BY employee_id
            ORDER BY total_orders DESC
            LIMIT 1
        ) AS top_employee
    );

--4
SELECT order_id, order_date, customer_id, freight, ship_country
FROM orders
WHERE ship_country != 'USA'
    AND freight > ANY (
        SELECT freight 
        FROM orders 
        WHERE ship_country = 'USA'
    );
	