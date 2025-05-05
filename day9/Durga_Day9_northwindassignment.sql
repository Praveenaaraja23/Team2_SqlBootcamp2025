--1.Create AFTER UPDATE trigger to track product price changes
--Create new table
CREATE TABLE product_price_audit (
    audit_id SERIAL PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(40),
    old_price DECIMAL(10,2),
    new_price DECIMAL(10,2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_name VARCHAR(50) DEFAULT CURRENT_USER
);

--Create a trigger function
CREATE OR REPLACE FUNCTION log_new_product()
RETURNS TRIGGER AS $$
BEGIN  
 
-- Insert values into table

INSERT INTO product_price_audit (
        product_id,
        product_name,
        old_price,
        new_price
    )
    VALUES (
        OLD.product_id,
        OLD.product_name,
        OLD.unit_price,
        NEW.unit_price
    );

	RETURN NEW;
END;
$$ LANGUAGE plpgsql; 

--Create a row level trigger for below event:
CREATE TRIGGER after_product_update
AFTER UPDATE OF unit_price ON products
FOR EACH ROW
EXECUTE FUNCTION log_new_product()

UPDATE products
SET unit_price = unit_price * 1.10
WHERE product_id = 2;

SELECT *
FROM product_price_audit
WHERE product_id = 2
ORDER BY audit_id 
LIMIT 1;


--2.      Create stored procedure  using IN and INOUT parameters to assign tasks to employees
 
-- Parameters:
--IN p_employee_id INT, IN p_task_name VARCHAR(50),INOUT p_task_count INT DEFAULT, Inside Logic: Create table employee_tasks:
CREATE OR REPLACE PROCEDURE assign_tasks(
    IN p_employee_id INT,
	IN p_task_name VARCHAR(50),
	INOUT p_task_count INT DEFAULT 0
	)
    LANGUAGE plpgsql
	AS $$
	BEGIN
-- Create table employee_tasks:
	   CREATE TABLE IF NOT EXISTS employee_task(
        task_id SERIAL PRIMARY KEY,
        employee_id INT,
        task_name VARCHAR(50),
        assigned_date DATE DEFAULT CURRENT_DATE
		);
--Insert employee_id, task_name  into employee_tasks		
		INSERT INTO employee_task(employee_id, task_name)
		VALUES(p_employee_id, p_task_name);

--Count total tasks for employee and put the total count into p_task_count 
       SELECT COUNT(*)
		INTO p_task_count
		FROM employee_task
		WHERE employee_id = p_employee_id;
		
--Raise NOTICE message:
	   IF NOT EXISTS (SELECT 1 FROM employees WHERE employee_id = p_employee_id) THEN
	       RAISE NOTICE 'Task "%" assigned to employee %. Total tasks: %',p_task_name, 
		                  p_employee_id, p_task_count;
		END IF;
		
	END;
$$;

--After creating stored procedure test by calling  it:
 CALL assign_tasks(1, 'Review Reports');

 --To check if values are inserted in new employee_task table
 SELECT * FROM employee_task


 

	