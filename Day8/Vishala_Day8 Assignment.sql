--simple updatable view

CREATE OR REPLACE VIEW vw_updatable_products AS
SELECT 
    product_id,
    product_name,
    unit_price,
    units_in_stock
FROM 
    products;

--Run the Update Query on the View

UPDATE vw_updatable_products
SET unit_price = unit_price * 1.1
WHERE units_in_stock < 10;

SELECT * FROM vw_updatable_products;

-- Check if the Base Table Is Updated

SELECT product_id, product_name, unit_price, units_in_stock
FROM products
WHERE units_in_stock < 10;



--Start the transaction

BEGIN;

--Run your update

UPDATE products
SET unit_price = unit_price * 1.10
WHERE category_id = 1;


BEGIN;

UPDATE products
SET unit_price = unit_price * 1.10
WHERE category_id = 1;

--  See the output here
SELECT product_id, product_name, unit_price
FROM products
WHERE category_id = 1;

COMMIT
ROLLBACK



CREATE OR REPLACE VIEW vw_employee_territory_details AS
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


SELECT * FROM vw_employee_territory_details;




WITH RECURSIVE cte_employeehierarchy AS (
    -- Base case: top-level employees
    SELECT 
        employee_id,
        first_name,
        last_name,
        reports_to,
        0 AS level
    FROM 
	employees e
    WHERE 
	reports_to IS NULL

    UNION ALL

    -- Recursive case: employees reporting to managers
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

-- FINAL SELECT must be here to avoid syntax error
SELECT 
    level,
    employee_id,
    first_name || ' ' || last_name AS employee_name
FROM cte_employeehierarchy
ORDER BY level, employee_id;




	
