--DAY 8
--1.     Create view vw_updatable_products (use same query whatever I used in the training)
--Try updating view with below query and see if the product table also gets updated.
--Update query:
--UPDATE updatable_products SET unit_price = unit_price * 1.1 WHERE units_in_stock < 10;

--CREATE VIEWS
CREATE VIEW vw_updatable_products AS
SELECT product_id, 
       product_name, 
	   unit_price, 
	   units_in_stock, 
	   discontinued
FROM Products
WHERE discontinued = 0
WITH CHECK OPTION;

-- UPDATE QUERY
UPDATE vw_updatable_products 
SET unit_price = unit_price * 1.1
WHERE units_in_stock < 10

SELECT * 
FROM Products
WHERE units_in_stock < 10

SELECT * FROM vw_updatable_products 



--2.     Transaction:
--Update the product price for products by 10% in category id=1
--Try COMMIT and ROLLBACK and observe what happens
-- Before updating the product price 
SELECT product_id, product_name, unit_price
FROM Products
WHERE category_id = 1
ORDER BY product_id;

BEGIN;
UPDATE products
SET unit_price = unit_price*1.10
WHERE category_id = 1

--Check if any product price exceeds $50
-- If yes, then rollback. If no then commit 
DO $$
  BEGIN
    IF EXISTS(
	  SELECT 1 --For each row that matches i.e even if there is one product that matches the below condition then raise exception else notice
	  FROM Products
	  WHERE category_id=1 AND unit_price > 50
	  ) THEN 
	  RAISE EXCEPTION 'Some price exceeds $50';
	 ELSE 
	 RAISE NOTICE 'Price update successful';
	 END IF;
END $$;

COMMIT;
ROLLBACK;

SELECT * FROM Products where category_id = 1 AND unit_price>40
     

--3.Create a regular view which will have below details (Need to do joins):
--Employee_id, Employee_full_name,Title,Territory_id,territory_description,region_description
CREATE view vw_employee_territory_region AS
 SELECT
  e.employee_id,
  e.first_name || ' ' || e.last_name  AS employee_name,
  e.title,
  t.territory_id,
  t.territory_description,
  r.region_description
FROM employees e
LEFT JOIN employee_territories et ON e.employee_id = et.employee_id
LEFT JOIN territories t ON et.territory_id = t.territory_id
LEFT JOIN region r ON t.region_id = r.region_id

SELECT * FROM vw_employee_territory_region


--4. Create a recursive CTE based on Employee Hierarchy
-- Defining Common table expression
WITH RECURSIVE cte_employeehierarchy AS (
--Top level employees - No manager- level 0 indicates top of hierarchy (Base case for recursion)
SELECT 
      employee_id,
	  first_name,
	  last_name,
	  reports_to,
	  0 as level
FROM employees e  
WHERE 
    reports_to IS NULL

UNION ALL
--Finds everyone who reports to someone already in CTE
SELECT 
      e.employee_id,
	  e.first_name,
	  e.last_name,
	  e.reports_to,
	  eh.level+1
FROM 
    employees e
JOIN cte_employeehierarchy eh
ON e.reports_to = eh.employee_id

)

SELECT 
eh.level,
eh.employee_id,
eh.first_name || ' ' || eh.last_name AS employee_name,
eh.reports_to,
m.first_name || ' ' || m.last_name AS manager_name
FROM cte_employeehierarchy eh
LEFT JOIN employees m ON eh.reports_to = m.employee_id --Left join the employee table again alias m to lookup manager name
ORDER BY 
level, employee_id
 
