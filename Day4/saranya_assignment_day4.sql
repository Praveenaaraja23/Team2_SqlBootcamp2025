--1
SELECT 
    c.companyname AS customer,
    o.orderid,
    p.productname,
    od.quantity,
    o.orderdate
FROM 
    customers c
INNER JOIN 
    orders o ON c.customerid = o.customerid
INNER JOIN 
    order_details od ON  cast (o.orderid as integer) = od.orderid 
INNER JOIN 
    products p ON od.productid = p.productid
ORDER BY 
    c.companyname, o.orderid;


--2
SELECT 
    o.orderid,
    c.companyname AS customer,
    e.employeename AS employee,
    s.companyname AS shipper,
    p.productname AS product,
    od.quantity
FROM 
    orders o
LEFT JOIN 
    customers c ON o.customerid = c.customerid
LEFT JOIN 
    employees e ON o.employeeid = e.employeeid
LEFT JOIN 
    shippers s ON o.shipperid = s.shipperid
LEFT JOIN 
    order_details od ON cast (o.orderid as integer) = od.orderid
LEFT JOIN 
    products p ON od.productid = p.productid
ORDER BY 
    o.orderid;

---3

SELECT 
    od.orderid,
    p.productid,
    od.quantity,
    p.productname
FROM 
    order_details od
RIGHT JOIN 
    products p ON od.productid = p.productid
ORDER BY 
    p.productid;
	
---4
SELECT 
    categories.categoryid,
    products.productname
FROM 
    categories
FULL OUTER JOIN products ON categories.categoryid = products.categoryid;

select * from categories;
---5

SELECT 
    products.productname,
    categories.categoryname
FROM 
    products
CROSS JOIN categories;

--6
SELECT 
    e1.employeeid AS employee1id,
    e1.employeename AS employee1name,
    e2.employeeid AS employee2_id,
    e2.employeename AS employee2name,
    m.employeeid AS manager_id,
    m.employeename AS manager_name
FROM 
    employees e1
JOIN employees e2 
    ON e1.reportsto = e2.reportsto AND e1.employeeid < e2.employeeid
JOIN employees m 
    ON e1.reportsto = cast (m.employeeid as integer);

---7
SELECT DISTINCT 
    customers.customerid,
    customers.companyname
FROM 
    customers
JOIN orders ON customers.customerid = orders.customerid
WHERE 
    orders.shipperid IS NULL;
	



	
