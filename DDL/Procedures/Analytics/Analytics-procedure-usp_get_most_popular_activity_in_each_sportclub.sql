USE Multisport;

DELIMITER $$;

DROP PROCEDURE IF EXISTS usp_get_most_popular_activity_in_each_sportclub;

CREATE PROCEDURE usp_get_most_popular_activity_in_each_sportclub()
BEGIN
    SELECT         sportclub_name,
                   activity_name most_popular_activity,
                   MAX(visits_number) visits
    FROM   (SELECT s.name sportclub_name,
                   a.name activity_name,
                   COUNT(a.name) visits_number
            FROM visit v
                   LEFT JOIN sportclub_activity sa ON v.sportclub_activity_id = sa.sportclub_activity_id
                   LEFT JOIN sportclub s ON sa.sportclub_id = s.sportclub_id
                   LEFT JOIN activity a ON sa.activity_id = a.activity_id
            GROUP BY s.name, a.name
            ORDER BY visits_number DESC
            ) AS visits
    GROUP BY sportclub_name
    ORDER BY sportclub_name;
END$$;