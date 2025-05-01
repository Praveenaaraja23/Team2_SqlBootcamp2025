SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    COUNT(o.order_id) AS total_orders,
    RANK() OVER (ORDER BY COUNT(o.order_id) DESC) AS rank
FROM 
    employees e
JOIN 
    orders o ON e.employee_id = o.employee_id
GROUP BY 
    e.employee_id, e.first_name, e.last_name
ORDER BY 
    rank;



SELECT 
    order_id,
    customer_id,
    order_date,
    freight,
    LAG(freight) OVER (PARTITION BY customer_id ORDER BY order_date) AS previous_freight,
    LEAD(freight) OVER (PARTITION BY customer_id ORDER BY order_date) AS next_freight
FROM 
    orders;



WITH price_cte AS (
    SELECT 
        product_name,
        unit_price,
        CASE 
            WHEN unit_price < 20 THEN 'Low Price'
            WHEN unit_price < 50 THEN 'Medium Price'
            ELSE 'High Price'
        END AS price_category
    FROM 
        products
)
SELECT 
    price_category,
    COUNT(*) AS product_count,
    ROUND(AVG(unit_price)::numeric, 2) AS avg_price
FROM 
    price_cte
GROUP BY 
    price_category
ORDER BY 
    price_category;

