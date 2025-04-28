SELECT * FROM employees
SELECT * FROM orders
SELECT * FROM products
SELECT * FROM customers
SELECT * FROM order_details
SELECT * FROM shippers

SELECT  o.order_id, 
    o.customer_id, 
    o.order_date, 
     e.first_name || ' ' || e.last_name AS employeefullname,
	 o.required_date,
     o.shipped_date,
     o.ship_via,
     o.freight
FROM 
    orders o
INNER JOIN 
    employees e ON o.employee_id = e.employee_id;
--Day4:1. List all customers and the products they ordered with the order date. (Inner join)
	SELECT 
    c.company_name AS customer,
    o.order_id,
    p.product_name,
    od.quantity,
    o.order_date
FROM 
    customers c
INNER JOIN 
    orders o ON c.customer_id=o.customer_id
	INNER JOIN 
    order_details od ON o.order_id = od.order_id
INNER JOIN 
    products p ON od.product_id = p.product_id;

--2.Show each order with customer, employee, shipper, and product info — even if some parts are missing. (Left Join)

SELECT 
    o.order_id,
    c.company_name AS customer,
    e.first_name || ' ' || e.last_name AS employee,
    s.company_name AS shipper,
    p.product_name,
    od.quantity
FROM 
    orders o
LEFT JOIN 
    customers c ON o.customer_id = c.customer_id
LEFT JOIN 
    employees e ON o.employee_id = e.employee_id
LEFT JOIN 
    shippers s ON o.ship_via = s.shipper_id
LEFT JOIN 
    order_details od ON o.order_id = od.order_id
LEFT JOIN 
    products p ON od.product_id = p.product_id;


--3.Show all order details and products (include all products even if they were never ordered). (Right Join)
   SELECT  od.order_id,
    p.product_id,
    od.quantity,
    p.product_name
FROM order_details od RIGHT JOIN products p ON p.product_id = od.product_id

--4.List all product categories and their products(Outer Join)
SELECT 
    c.category_name,
    p.product_name
FROM 
    categories c
FULL OUTER JOIN 
    products p ON c.category_id = p.category_id;

--5.Show all possible product and category combinations (Cross join).
SELECT 
    c.category_name,
    p.product_name
FROM 
    categories c
CROSS JOIN 
    products p;
	
6.Show all employees and their manager(Self join(left join))

SELECT 
    e1.first_name || ' ' || e1.last_name AS employee,
    e2.first_name || ' ' || e2.last_name AS manager
FROM 
    employees e1
LEFT JOIN 
    employees e2 ON e1.reports_to = e2.employee_id;

--7.List all customers who have not selected a shipping method.
SELECT 
    c.customer_id,
    c.company_name
FROM 
    customers c
LEFT JOIN 
    orders o ON c.customer_id = o.customer_id
WHERE 
    o.ship_via IS NULL;
