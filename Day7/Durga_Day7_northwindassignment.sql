--Day 7
--1.Rank employees by their total sales
--(Total sales = Total no of orders handled, JOIN employees and orders table)

-- Using Dense rank
SELECT e.employee_id,
       COUNT(o.order_id) AS total_sales,
       DENSE_RANK() OVER (ORDER BY COUNT(o.order_id) DESC) AS employee_sales_rank
FROM Employees e
LEFT JOIN Orders o ON e.employee_id = o.employee_id
GROUP BY e.employee_id
ORDER BY employee_sales_rank

-- Rank over
SELECT e.employee_id,
       COUNT(o.order_id) AS total_sales,
       RANK() OVER (ORDER BY COUNT(o.order_id) DESC) AS employee_sales_rank
FROM Employees e
LEFT JOIN Orders o ON e.employee_id = o.employee_id
GROUP BY e.employee_id
ORDER BY employee_sales_rank

--2.Compare current order's freight with previous and next order for each customer.
--(Display order_id,  customer_id,  order_date,  freight,
--Use lead(freight) and lag(freight).
-- LAG (FREIGHT)
SELECT order_id,  customer_id,  order_date,  freight,
lag(freight) over(partition by customer_id ORDER BY order_date) AS previous_freight,
freight - lag(freight) over(partition by customer_id ORDER BY order_date) AS freight_difference

FROM Orders

--LEAD(FREIGHT)
SELECT order_id,  customer_id,  order_date,  freight,
lead(freight) over(partition by customer_id ORDER BY order_date) AS next_freight,
freight - lead(freight) over(partition by customer_id ORDER BY order_date)  AS freight_difference

FROM Orders

 
--3.Show products and their price categories, product count in each category, avg price:
      
WITH CTE_price AS(
  SELECT product_id,
         unit_price,
		 CASE 
		    WHEN unit_price < 20 THEN 'Low Price'
            WHEN unit_price < 50 THEN 'Medium Price'
            ELSE 'High Price'
		END AS Price_category
   FROM Products
)
SELECT Price_category,  COUNT(price_category) AS product_count,
       ROUND(AVG(unit_price)::numeric, 2) as avg_price
FROM CTE_price
GROUP BY Price_category



