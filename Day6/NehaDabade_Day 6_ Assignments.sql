-- Categorize products by stock status
SELECT product_name,
CASE
  WHEN  units_in_stock = 0 THEN 'Out of Stock'
  WHEN  units_in_stock < 20 THEN 'Low Stock'
ELSE 'Instock'
END AS stock_status
FROM products;
****************************************************************************************************************************************

--Find All Products in Beverages Category

SELECT Product_name,unit_price
FROM products
WHERE category_id = (
  SELECT category_id
  FROM categories
  WHERE category_name = 'Beverages');
*******************************************************************************************************************************************

--Find Orders by Employee with Most Sales

SELECT order_id, order_date,freight,employee_id
FROM orders
WHERE employee_id = (
SELECT employee_id 
FROM orders 
GROUP BY employee_id 
ORDER BY count(*) LIMIT 1)
*********************************************************************************************************************************************

--Find orders  where for country!= ‘USA’ with freight costs higher than any order from USA.
--Subquery ANY 
SELECT order_id, freight, ship_country
FROM  orders
WHERE ship_country != 'USA' 
AND freight > ANY (
        SELECT freight 
        FROM orders 
        WHERE ship_country = 'USA')

--ALL operator


SELECT order_id, freight, ship_country
FROM  orders
WHERE ship_country != 'USA' 
AND freight > ALL (
        SELECT freight 
        FROM orders 
        WHERE ship_country = 'USA')
