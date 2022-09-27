USE Multisport;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_parse_json_visit;

CREATE PROCEDURE usp_parse_json_visit(IN json_visit TEXT)
BEGIN
    INSERT INTO visit(card_id,
                      sportclub_activity_id,
                      date_time)
    WITH cte_user_visit AS (SELECT sportclub_id,
                                   card_id,
                                   activity_id,
                                   date_time,
                                   card_type_id
                            FROM json_table(json_visit, '$'
                                            COLUMNS (
                                                card_number VARCHAR(20) PATH '$.card.number',
                                                sportclub_email VARCHAR(100) PATH '$.sportClub.email',
                                                activityName VARCHAR(30) PATH '$.activity.name',
                                                date_time DATETIME PATH '$.visit.dateTime'
                                                )
                                     ) AS user_visit
                                     LEFT JOIN sportclub ON user_visit.sportclub_email = sportclub.email
                                     LEFT JOIN activity ON user_visit.activityName = activity.name
                                     LEFT JOIN card ON user_visit.card_number = card.number),
         cte_sportclub_activity AS (SELECT sportclub_activity_id
                                    FROM sportclub_activity
                                    WHERE sportclub_activity.sportclub_id =
                                          (SELECT sportclub_activity.sportclub_id from cte_user_visit)
                                      AND sportclub_activity.activity_id =
                                          (SELECT sportclub_activity.activity_id from cte_user_visit))
    SELECT card_id, sportclub_activity_id, date_time
    FROM cte_user_visit,
         cte_sportclub_activity;
END
$$