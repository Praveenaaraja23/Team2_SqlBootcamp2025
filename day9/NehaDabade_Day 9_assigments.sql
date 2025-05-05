--Create AFTER UPDATE trigger to track product price changes
CREATE TABLE product_price_audit(
audit_id SERIAL PRIMARY KEY,
product_id INT,
product_name VARCHAR (40),
old_price DECIMAL (10,2),
new_price DECIMAL (10,2),
change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
user_name VARCHAR (50) DEFAULT CURRENT_USER
);
--define trigger fuction
CREATE OR REPLACE FUNCTION log_new_product()
RETURNS TRIGGER AS $$
BEGIN

--insert values into table
INSERT INTO product_price_audit(
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

-- return new rows
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Create the trigger
CREATE TRIGGER after_product_update
AFTER UPDATE OF unit_price ON products
FOR EACH ROW
EXECUTE FUNCTION log_new_product()

--test the trigger
UPDATE products
SET unit_price = unit_price * 1.10
WHERE product_id = 5;

select * from product_price_audit
WHERE product_id = 5
LIMIT 1;

****************************************************************************************************************************************************************

-- Create stored procedure  using IN and INOUT parameters to assign tasks to employees
--Create table employee_tasks

CREATE TABLE IF NOT EXISTS employee_tasks(
 task_id SERIAL PRIMARY KEY,
 employee_id INT,
 task_name VARCHAR(50),
 assigned_date DATE DEFAULT CURRENT_DATE
);

CREATE OR REPLACE PROCEDURE assign_tasks(
IN p_employee_id INT,
IN p_task_name VARCHAR(50),
INOUT p_task_count INT DEFAULT 0
)
LANGUAGE plpgsql
AS $$

BEGIN

INSERT INTO employee_tasks(employee_id, task_name)
VALUES (p_employee_id, p_task_name);

SELECT COUNT (*) INTO p_task_count 
FROM employee_tasks
WHERE employee_id = p_employee_id;

RAISE NOTICE 'Task "%" assigned to employee %. Total tasks: %',
        p_task_name, p_employee_id, p_task_count;

END;
$$;

CALL assign_tasks(1, 'Review Reports',0);

SELECT * FROM employee_tasks WHERE employee_id = 1;
