--  List all customers and the products they ordered with the order date. 

select c.company_name AS customer, o.order_id, p.product_name, od.quantity, o.order_date
from customers c
INNER JOIN 
    orders o ON c.customer_id = o.customer_id
INNER JOIN 
    order_details od ON o.order_id = od.order_id
INNER JOIN 
    products p ON od.product_id = p.product_id;

********************************************************************************************************************************

--Show each order with customer, employee, shipper, and product info — even if some parts are missing. (Left Join)

SELECT 
    o.order_id,c.company_name AS customer,e.first_name || ' ' || e.last_name AS employeename, s.company_name AS shipper,p.product_name, od.quantity
FROM orders o
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
*****************************************************************************************************************************************

--Show all order details and products (include all products even if they were never ordered). (Right Join)

SELECT  od.order_id,p.product_id,od.quantity,p.product_name
FROM order_details od 
RIGHT JOIN products p ON p.product_id = od.product_id;

**************************************************************************************************************************************

--List all product categories and their products — including categories that have no products, and products that are not assigned to any category.(Outer Join)

SELECT c.category_name, p.product_name
FROM categories c
FULL OUTER JOIN 
    products p ON c.category_id = p.category_id;

**************************************************************************************************************************************

--Show all possible product and category combinations (Cross join).

SELECT  c.category_name,p.product_name
FROM categories c
CROSS JOIN products p;
**************************************************************************************************************************************

--Show all employees and their manager(Self join(left join))
select * from customers
SELECT 
    e1.first_name || ' ' || e1.last_name AS employeename,
    e2.first_name || ' ' || e2.last_name AS managername
FROM employees e1
LEFT JOIN 
    employees e2 ON e1.reports_to = e2.employee_id;
*********************************************************************************************************************************************

--List all customers who have not selected a shipping method.
SELECT c.customer_id, c.company_name, c.contact_name
FROM customers c
LEFT JOIN 
    orders o ON c.customer_id = o.customer_id
WHERE 
    o.ship_via IS NULL;
