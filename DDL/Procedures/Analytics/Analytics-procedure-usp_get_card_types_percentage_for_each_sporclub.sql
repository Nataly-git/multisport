USE Multisport;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_get_card_types_percentage_for_each_sportclub;

CREATE PROCEDURE usp_get_card_types_percentage_for_each_sportclub(IN month_number TINYINT, IN year_number SMALLINT)
BEGIN
    WITH cte_card_type_visits AS (
        SELECT sa.sportclub_id,
               c.card_type_id,
               COUNT(sa.sportclub_id) count
        FROM   visit
            JOIN sportclub_activity sa ON visit.sportclub_activity_id = sa.sportclub_activity_id
            JOIN card c ON c.card_id = visit.card_id
            JOIN card_type ct ON ct.card_type_id = c.card_type_id
        WHERE  MONTH(date_time)=month_number
        AND    YEAR(date_time)=year_number
        GROUP BY sa.sportclub_id,
                 c.card_type_id
        ),
    cte_all_visits AS (
        SELECT s.sportclub_id,
               COUNT(s.name) AS `All visits number`
        FROM   visit
            JOIN sportclub_activity sa ON visit.sportclub_activity_id = sa.sportclub_activity_id
            JOIN sportclub s ON s.sportclub_id = sa.sportclub_id
        WHERE  MONTH(date_time)=month_number
          AND    YEAR(date_time)=year_number
        GROUP BY s.name
        )
    SELECT sportclub.name `Sportclub name`,
           ct.type `Card type`,
           IF(cte_card_type_visits.count, cte_card_type_visits.count, 0) AS `Number of visits`,
           IF(cte_card_type_visits.count, ROUND((cte_card_type_visits.count / cte_all_visits.`All visits number`) * 100, 2), 0) AS Percentage
    FROM   sportclub
        JOIN sportclub_card_types sct ON sportclub.sportclub_id = sct.sportclub_id
        JOIN card_type ct ON sct.card_type_id = ct.card_type_id
        JOIN cte_card_type_visits ON cte_card_type_visits.sportclub_id = sportclub.sportclub_id
         AND cte_card_type_visits.card_type_id = ct.card_type_id
        JOIN cte_all_visits ON cte_all_visits.sportclub_id = sportclub.sportclub_id
    ORDER BY sportclub.name,
             Percentage DESC;
END$$