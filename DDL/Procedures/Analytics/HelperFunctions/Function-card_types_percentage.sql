USE Multisport;

SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER $$

DROP FUNCTION IF EXISTS count_percentage;

CREATE FUNCTION count_percentage(number_of_orders INT, all_orders INT)
    RETURNS DOUBLE
BEGIN
    RETURN ROUND(100 * number_of_orders / all_orders, 2);
END$$