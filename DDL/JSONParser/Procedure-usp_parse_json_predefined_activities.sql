USE Multisport;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_parse_json_predefined_activities;

CREATE PROCEDURE usp_parse_json_predefined_activities(IN json_predefined_activities TEXT)
BEGIN
    INSERT INTO activity(name)
    SELECT name
    FROM json_table(json_predefined_activities, '$[*]'
                    COLUMNS (
                        name VARCHAR(30) PATH '$.name')) as activities;
END
$$