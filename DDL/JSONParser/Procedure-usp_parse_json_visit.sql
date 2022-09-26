USE Multisport;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_parse_json_visit;

CREATE PROCEDURE usp_parse_json_visit(IN json_visit TEXT)
BEGIN
    INSERT INTO visit(card_id, sportclub_activity_id, date_time)
    SELECT card_id, sportclub_activity_id, date_time
    FROM json_table(json_visit, '$'
                    COLUMNS (
                        card_number          VARCHAR(20)  PATH '$.card.number',
                        sportclub_email VARCHAR(100) PATH '$.sportClub.email',
                        activityName    VARCHAR(30)  PATH '$.activity.name',
                        date_time       DATETIME     PATH '$.visit.dateTime'
                        )) as this_visit
             LEFT JOIN sportclub ON this_visit.sportclub_email = sportclub.email
             LEFT JOIN activity ON this_visit.activityName = activity.name
             LEFT JOIN sportclub_activity ON sportclub.sportclub_id = sportclub_activity.sportclub_id
                AND activity.activity_id = sportclub_activity_id
             LEFT JOIN card ON this_visit.card_number = card.number;

END$$