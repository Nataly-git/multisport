USE Multisport;

DELIMITER $$;

DROP PROCEDURE IF EXISTS usp_get_most_popular_sportclub_by_rating;

CREATE PROCEDURE usp_get_most_popular_sportclub_by_rating(IN club_count TINYINT)
BEGIN

    SELECT concat(name, ', ', city, ', ', street, ', ', building) as `sportclub name`,
           avg(rating.rate) AS 'average sportclub rate',
           count(rating.rate) AS 'rate count'
    FROM rating
             JOIN sportclub ON rating.sportclub_id = sportclub.sportclub_id
    GROUP BY `name`
    ORDER BY `average sportclub rate` DESC
    LIMIT club_count;

END$$;