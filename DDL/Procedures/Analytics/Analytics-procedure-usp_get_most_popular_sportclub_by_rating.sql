USE Multisport;

DELIMITER $$;

DROP PROCEDURE IF EXISTS usp_get_most_popular_sportclub_by_rating;

CREATE PROCEDURE usp_get_most_popular_sportclub_by_rating(IN club_count TINYINT, IN card_type_name VARCHAR(30))
BEGIN
    WITH cte_rating AS(
        SELECT CONCAT(name, ', ', city, ', ', street, ', ', building) AS `Sportclub name`,
               AVG(r.rate)   AS `Average sportclub rate`,
               COUNT(r.rate) AS `Rate count`,
               r.sportclub_id
        FROM   rating r
            JOIN sportclub s ON r.sportclub_id = s.sportclub_id
        GROUP BY `Sportclub name`
        ORDER BY `Average sportclub rate` DESC
        ),
    cte_visits AS(
        SELECT COUNT(visit_id) AS `Visits count`,
               sportclub_id
        FROM   visit v
            JOIN sportclub_activity sa ON v.sportclub_activity_id = sa.sportclub_activity_id
            JOIN card c ON v.card_id = c.card_id
            JOIN card_type ct ON c.card_type_id = ct.card_type_id
        WHERE ct.type = card_type_name
        GROUP BY sportclub_id
        )

    SELECT `Sportclub name`,
           `Average sportclub rate`,
           `Rate count`,
           `Visits count`,
            card_type_name AS `Card type`
    FROM cte_rating
       JOIN cte_visits ON cte_rating.sportclub_id = cte_visits.sportclub_id
    LIMIT club_count;

END$$;