USE Multisport;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_parse_json_predefined_order_statuses;

CREATE PROCEDURE usp_parse_json_predefined_order_statuses(IN json_predefined_order_statuses TEXT)

BEGIN
    INSERT INTO order_status(status)
    SELECT status
    FROM json_table(json_predefined_order_statuses, '$[*]'
                    COLUMNS (
                        status VARCHAR(20) PATH '$.status'
                        )
             ) as order_statuses;
END$$