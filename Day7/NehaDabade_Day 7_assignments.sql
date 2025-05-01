--Rank employees by their total sales

SELECT employee_id, employee_name, total_orders_handled,
    RANK() OVER (ORDER BY total_orders_handled DESC) AS rank
	FROM (
    SELECT e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    COUNT(o.order_id) AS total_orders_handled
    FROM employees e
    JOIN orders o ON e.employee_id = o.employee_id
    GROUP BY e.employee_id
	) AS employee_sales;
***************************************************************************************************************************************************

--Compare current order's freight with previous and next order for each customer.

SELECT order_id, customer_id, order_date, freight,
    LAG(freight) OVER (PARTITION BY customer_id ORDER BY order_date) AS previous_freight,
    LEAD(freight) OVER (PARTITION BY customer_id ORDER BY order_date) AS next_freight
FROM orders;

*************************************************************************************************************************************************
--Show products and their price categories, product count in each category, avg price: 

WITH price_cte AS (
    SELECT product_id, product_name,unit_price,
        CASE 
            WHEN unit_price < 20 THEN 'Low Price'
            WHEN unit_price < 50 THEN 'Medium Price'
            ELSE 'High Price'
        END AS price_category
    FROM products)
SELECT price_category,
    COUNT(*) AS product_count,
    ROUND(AVG(unit_price)::numeric, 2) AS avg_price
FROM price_cte
GROUP BY price_category;

