USE Multisport;

SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER $$

DROP FUNCTION IF EXISTS count_card_type_number;

CREATE FUNCTION count_card_type_number(month_number TINYINT, year_number SMALLINT, card_type_name TEXT)
    RETURNS INT
BEGIN
    SELECT COUNT(*)
    INTO   @number_of_orders
    FROM   card_type
         JOIN `order` o ON card_type.card_type_id = o.card_type_id
         JOIN order_status os ON os.status_id = o.status_id
    WHERE  status = 'paid'
      AND  MONTH(date) = month_number
      AND  YEAR(date) = year_number
      AND  type = card_type_name;
    RETURN @number_of_orders;
END$$