USE Multisport;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_parse_json_add_activity;

CREATE PROCEDURE usp_parse_json_add_activity(IN json_add_activity TEXT)
BEGIN
    INSERT INTO sportclub_activity(
           sportclub_id,
           activity_id,
           duration)
    SELECT sportclub_id,
           activity_id,
           duration
    FROM   json_table(json_add_activity, '$'
                    COLUMNS (
                        sportclubEmail VARCHAR(254)  PATH '$.sportClub.email',
                        activityName   VARCHAR(30)   PATH '$.activity.name',
                        duration       DECIMAL(3, 2) PATH '$.duration'
                        )
                    ) AS add_activity
             JOIN sportclub ON add_activity.sportclubEmail = sportclub.email
             JOIN activity ON add_activity.activityName = activity.name;
END$$