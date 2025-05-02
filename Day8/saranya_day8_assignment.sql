--1
CREATE VIEW vw_updatable_products AS
SELECT 
    product_id,
    product_name,
    unit_price,
    units_in_stock
FROM 
    products;

UPDATE vw_updatable_products 
SET unit_price = unit_price * 1.1 
WHERE units_in_stock < 10;

SELECT 
    product_id, product_name, unit_price, units_in_stock
FROM 
    products
WHERE 
    units_in_stock < 10;

--2
BEGIN;

UPDATE products
SET unit_price = unit_price * 1.10
WHERE category_id = 1;

SELECT product_id, product_name, unit_price 
FROM products
WHERE category_id = 1;COMMIT;

COMMIT;

ROLLBACK;

--3
CREATE VIEW vw_employee_territories AS
SELECT 
    e.employee_id,
    e.first_name || ' ' || e.last_name AS employee_full_name,
    e.title,
    t.territory_id,
    t.territory_description,
    r.region_description
FROM 
    employees e
JOIN 
    employee_territories et ON e.employee_id = et.employee_id
JOIN 
    territories t ON et.territory_id = t.territory_id
JOIN 
    region r ON t.region_id = r.region_id;

SELECT * FROM vw_employee_territories;	

--4
WITH RECURSIVE cte_employeehierarchy AS (
    SELECT employee_id, first_name,last_name, reports_to,
        0 AS level
    FROM employees e
    WHERE 
	reports_to IS NULL

    UNION ALL

    SELECT 
        e.employee_id,
        e.first_name,
        e.last_name,
        e.reports_to,
        eh.level + 1
    FROM employees e
    JOIN cte_employeehierarchy eh
      ON eh.employee_id = e.reports_to
)

SELECT 
    level,
    employee_id,
    first_name || ' ' || last_name AS employee_name
FROM cte_employeehierarchy
ORDER BY level, employee_id;