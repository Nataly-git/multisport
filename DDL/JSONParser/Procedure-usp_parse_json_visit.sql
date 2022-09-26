USE Multisport;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_parse_json_visit;

CREATE PROCEDURE usp_parse_json_visit(IN json_visit TEXT)
BEGIN
    SELECT sportclub_id, card_id, activity_id, date_time
    INTO @sportclub_id, @card_id, @activity_id, @date_time
    FROM json_table(json_visit, '$'
                    COLUMNS (
                        card_number VARCHAR(20) PATH '$.card.number',
                        sportclub_email VARCHAR(100) PATH '$.sportClub.email',
                        activityName VARCHAR(30) PATH '$.activity.name',
                        date_time DATETIME PATH '$.visit.dateTime'
                        )) as user_visit
             LEFT JOIN sportclub ON user_visit.sportclub_email = sportclub.email
             LEFT JOIN activity ON user_visit.activityName = activity.name
             LEFT JOIN card ON user_visit.card_number = card.number;

    SELECT sportclub_activity_id
    INTO @sportclub_activity_id
    FROM sportclub_activity
    WHERE sportclub_id = @sportclub_id
      AND activity_id = @activity_id;

    INSERT INTO visit(card_id, sportclub_activity_id, date_time) VALUES (@card_id, @sportclub_activity_id, @date_time);
        END
    $$