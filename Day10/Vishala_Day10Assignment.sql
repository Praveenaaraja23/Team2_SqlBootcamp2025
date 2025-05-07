CREATE OR REPLACE FUNCTION get_total_stock_value(p_category_id INT)
RETURNS DECIMAL(10,2) AS $$
DECLARE
    total_value DECIMAL(10,2);
BEGIN
    SELECT ROUND(SUM(unit_price * units_in_stock)::DECIMAL, 2)
    INTO total_value
    FROM products
    WHERE category_id = p_category_id;

    RETURN COALESCE(total_value, 0.00);
END;
$$ LANGUAGE plpgsql;


SELECT get_total_stock_value(2);




CREATE OR REPLACE FUNCTION get_total_stock_value_cursor(p_category_id INT)
RETURNS DECIMAL(10,2) AS $$
DECLARE
    prod_cursor CURSOR FOR
        SELECT unit_price, units_in_stock
        FROM products
        WHERE category_id = p_category_id;

    rec RECORD;
    total_value DECIMAL(10,2) := 0.00;
BEGIN
    OPEN prod_cursor;

    LOOP
        FETCH prod_cursor INTO rec;
        EXIT WHEN NOT FOUND;
        total_value := total_value + (rec.unit_price * rec.units_in_stock);
    END LOOP;

    CLOSE prod_cursor;

    RETURN ROUND(total_value, 2);
END;
$$ LANGUAGE plpgsql;

SELECT get_total_stock_value_cursor(2);