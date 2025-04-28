SELECT * FROM Orders AS o
SELECT * FROM Employees AS e

SELECT o.order_id, o.order_date,
e.first_name || ' ' || e.last_name AS Employee_Name

FROM Orders o 
INNER JOIN Employees e
ON e.employee_id = o.employee_id

--DAY 4 ASSIGNMENT
--1.     List all customers and the products they ordered with the order date. (Inner join)

SELECT * FROM Customers c
SELECT * FROM Products p
SELECT * FROM Orders o
SELECT * FROM Order_details od

SELECT c.company_name AS customer, o.order_id, p.product_name, od.quantity, o.order_date
FROM Customers AS c
INNER JOIN Orders o ON c.customer_id = o.customer_id
INNER JOIN order_details od ON o.order_id = od.order_id
INNER JOIN products p ON od.product_id = p.product_id

SELECT * FROM Orders

--2.Show each order with customer, employee, shipper, and product info — even if some parts are missing. (Left Join)
SELECT c.company_name AS customer, o.order_id, o.order_date, s.company_name AS shipper_name,
e.first_name ||' '|| e.last_name AS employee_name, p.product_name, od.quantity
FROM Orders o 
LEFT JOIN Customers c ON o.customer_id = c.customer_id
LEFT JOIN Employees e ON o.employee_id = e.employee_id
LEFT JOIN Shippers s ON o.ship_via = s.shipper_id
LEFT JOIN Order_details od ON o.order_id = od.order_id
LEFT JOIN Products p ON od.product_id = p.product_id
ORDER BY order_id 
NULLS FIRST;

-- 3.Show all order details and products (include all products even if they were never ordered). (Right Join)
SELECT od. order_id, p.product_id, p.product_name, od.quantity
FROM Order_details od
RIGHT JOIN Products p ON od.product_id = p.product_id
ORDER BY p.product_id NULLS FIRST

-- 4.List all product categories and their products — including categories that have no products, and products that are not assigned to any category.(Outer Join)
SELECT * FROM Categories
SELECT * FROM Products

SELECT p.product_id, p.product_name, c.category_name, c.description
FROM Categories c
FULL OUTER JOIN Products p ON c.category_id = p.category_id
ORDER BY  c.category_name
NULLS FIRST,
p.product_name

--5. Show all possible product and category combinations (Cross join).
SELECT p.product_id, p.product_name, c.category_name, c.category_id
FROM Products p
CROSS JOIN Categories c

-- 6. 	Show all employees and their manager(Self join(left join))
SELECT e1.first_name || ' ' || e1.last_name AS Employee_name,
e2.first_name || ' ' || e2.last_name AS Manager_name
FROM Employees e1
LEFT JOIN Employees e2 ON e1.reports_to  = e2.employee_id;

--7. List all customers who have not selected a shipping method.
SELECT c.customer_id, o.ship_via, c.company_name
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.ship_via IS NULL;

