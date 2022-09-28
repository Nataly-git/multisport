USE Multisport;

DELIMITER $$;

DROP PROCEDURE IF EXISTS usp_get_most_popular_sportclub_by_rating;

CREATE PROCEDURE usp_get_most_popular_sportclub_by_rating(IN club_count TINYINT)
BEGIN
    WITH cte_rating AS(
        SELECT CONCAT(name, ', ', city, ', ', street, ', ', building) AS `sportclub name`,
               AVG(r.rate)   AS 'average sportclub rate',
               COUNT(r.rate) AS 'rate count'
        FROM rating r
            JOIN sportclub s ON r.sportclub_id = s.sportclub_id),
    cte_visits AS(
        SELECT COUNT(visit_id) AS `visits count`
        FROM visit v
            JOIN sportclub_activity sa ON v.sportclub_activity_id = sa.sportclub_activity_id)
    SELECT *
    FROM cte_rating
       CROSS JOIN cte_visits
    GROUP BY `sportclub name`
    ORDER BY `average sportclub rate` DESC
    LIMIT club_count;

END$$;