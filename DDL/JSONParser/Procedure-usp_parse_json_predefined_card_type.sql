USE multisport;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_parse_json_predefined_card_type;

CREATE PROCEDURE usp_parse_json_predefined_card_type(IN json_predefined_card_type text)
BEGIN
    SELECT type, price, max_visit_number
    INTO @type, @price,@max_visit_number
    FROM json_table(json_predefined_card_type, '$[*]'
                    COLUMNS (
                        type VARCHAR(30) PATH '$.type',
                        price DECIMAL(6, 2) PATH '$.price',
                        max_visit_number TINYINT PATH '$.maxVisitsNumber'
                        )
             ) AS card_types;

    INSERT INTO card_type(type, price, max_visit_number) value (@type, @price, @max_visit_number);
END$$