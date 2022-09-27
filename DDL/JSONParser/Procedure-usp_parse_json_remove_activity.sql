USE Multisport;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_parse_json_remove_activity;

CREATE PROCEDURE usp_parse_json_remove_activity(IN json_remove_activity TEXT)
BEGIN
    SELECT sportclub_id,
           activity_id
    INTO   @sportclub_id,
           @activity_id
    FROM   json_table(json_remove_activity, '$'
                    COLUMNS (
                        sportclub_email VARCHAR(254) PATH '$.sportClub.email',
                        activity_name   VARCHAR(30)  PATH '$.activity.name'
                        )
                    ) AS sportclub_activity
             LEFT JOIN sportclub ON sportclub_activity.sportclub_email = sportclub.email
             LEFT JOIN activity ON sportclub_activity.activity_name = activity.name;

    DELETE FROM sportclub_activity
           WHERE sportclub_id = @sportclub_id
             AND activity_id = @activity_id;
END$$