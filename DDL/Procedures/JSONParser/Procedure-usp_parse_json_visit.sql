USE Multisport;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_parse_json_visit;

CREATE PROCEDURE usp_parse_json_visit(IN json_visit TEXT)
BEGIN
    INSERT INTO visit(
                      card_id,
                      sportclub_activity_id,
                      date_time)
    WITH cte_user_visit AS
        (SELECT       sportclub_id,
                      card_id,
                      activity_id,
                      date_time,
                      card_type_id
         FROM json_table(json_visit, '$'
                    COLUMNS (
                             card_number     VARCHAR(20)  PATH '$.card.number',
                             sportclub_email VARCHAR(100) PATH '$.sportClub.email',
                             activityName    VARCHAR(30)  PATH '$.activity.name',
                             date_time       DATETIME     PATH '$.visit.dateTime'
                             )
                    ) AS user_visit
             JOIN sportclub ON user_visit.sportclub_email = sportclub.email
             JOIN activity ON user_visit.activityName = activity.name
             JOIN card ON user_visit.card_number = card.number
         )

    SELECT            card_id,
                      sportclub_activity_id,
                      date_time
    FROM              cte_user_visit cte
             JOIN sportclub_activity sa ON cte.sportclub_id = sa.sportclub_id
                AND cte_user_visit.activity_id = sa.activity_id
             JOIN sportclub_card_types ct ON cte.sportclub_id = ct.sportclub_id
                AND cte.card_type_id = ct.card_type_id;
END$$