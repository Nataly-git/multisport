USE Multisport;

SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER $$

DROP FUNCTION IF EXISTS count_all_paid_orders;

CREATE FUNCTION count_all_paid_orders(month_number TINYINT, year_number SMALLINT)
    RETURNS INT
BEGIN
    SELECT COUNT(*) all_paid_orders
    INTO @all_paid_orders
    FROM `order`
             JOIN order_status os
                  ON os.status_id = `order`.status_id
    WHERE status = 'paid'
      AND MONTH(date) = month_number
      AND YEAR(date) = year_number;
    RETURN @all_paid_orders;
END
$$