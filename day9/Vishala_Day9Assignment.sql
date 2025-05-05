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

SELECT * FROM product_price_audit;







CREATE OR REPLACE PROCEDURE assign_task(
    IN p_employee_id INT,
    IN p_task_name VARCHAR(50),
    INOUT p_task_count INT DEFAULT 0
)
LANGUAGE plpgsql
AS $$
BEGIN

--To create the table if it doesn't exist
    CREATE TABLE IF NOT EXISTS employee_tasks (
        task_id SERIAL PRIMARY KEY,
        employee_id INT,
        task_name VARCHAR(50),
        assigned_date DATE DEFAULT CURRENT_DATE
    );

-- To insert the task for the employee
    INSERT INTO employee_tasks (employee_id, task_name)
    VALUES (p_employee_id, p_task_name);

-- To count total tasks assigned to the employee
    SELECT COUNT(*) INTO p_task_count
    FROM employee_tasks
    WHERE employee_id = p_employee_id;

-- To show a notice with task details
    RAISE NOTICE 'Task "%" assigned to employee %. Total tasks: %',
        p_task_name, p_employee_id, p_task_count;
END;
$$;

-- To Test the Procedure

DO $$
DECLARE
    v_task_count INT := 0;
BEGIN
    CALL assign_task(1, 'Review Reports', v_task_count);
    RAISE NOTICE 'Returned task count: %', v_task_count;
END;
$$;

--To check if the Task Was Inserted

SELECT * FROM employee_tasks
WHERE employee_id = 1;