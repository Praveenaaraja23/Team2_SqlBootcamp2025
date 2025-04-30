-- DAY 5 ASSIGNMENT
SELECT * FROM products

--1.Categorize products by stock status
--(Display product_name, a new column stock_status whose values are based on below condition 
--units_in_stock = 0 is 'Out of Stock' units_in_stock < 20  is 'Low Stock')

SELECT product_name, 
   CASE
     WHEN units_in_stock = 0 THEN 'Out of Stock'
     WHEN units_in_stock < 20 THEN 'Low Stock'
  ELSE 'In Stock'
  END AS stock_status
FROM Products


 
--2.Find All Products in Beverages Category (Subquery, Display product_name,unitprice)

SELECT product_name, unit_price
FROM Products 
WHERE category_id IN (
            SELECT category_id
			FROM Categories 
			WHERE Category_name = 'Beverages'
)


--3.Find Orders by Employee with Most Sales
SELECT order_id, employee_id, order_date, freight
FROM Orders
WHERE employee_id = (
                  SELECT employee_id
				  FROM Orders
				  GROUP BY employee_id
				  ORDER BY 
				    COUNT(order_id) DESC
				  LIMIT 1
				  )


--4.Find orders  where for country!= ‘USA’ with freight costs higher than any order from USA. 
--(Subquery, Try with ANY, ALL operators)
--ANY OPERATOR
SELECT order_id, freight, ship_country
FROM Orders
WHERE ship_country!='USA' AND
      freight > ANY (
                    SELECT freight
					FROM Orders
					WHERE ship_country='USA' 
					 )
ORDER BY freight

--USING ALL OPERATOR
SELECT order_id, freight, ship_country
FROM Orders
WHERE ship_country!='USA' AND
      freight > ALL (
                    SELECT freight
					FROM Orders
					WHERE ship_country='USA' 
					 )
ORDER BY freight

