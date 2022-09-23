USE Multisport;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_parse_json_predefined_card_type;

CREATE PROCEDURE usp_parse_json_predefined_card_type(IN json_predefined_card_type text)
BEGIN
    INSERT INTO card_type(type, price, max_visit_number)
    SELECT type, price, max_visit_number
    FROM json_table(json_predefined_card_type, '$[*]'
                    COLUMNS (
                        type VARCHAR(30) PATH '$.type',
                        price DECIMAL(6, 2) PATH '$.price',
                        max_visit_number TINYINT PATH '$.maxVisitsNumber'
                        )
             ) as card_types;


END$$