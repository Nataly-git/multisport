USE Multisport;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_get_card_types_percentage_for_each_sportclub;

CREATE PROCEDURE usp_get_card_types_percentage_for_each_sportclub()
BEGIN
    WITH cte_card_type_visits AS (SELECT sa.sportclub_id,
                                         c.card_type_id,
                                         COUNT(sa.sportclub_id) count
                                  from visit
                                           join sportclub_activity sa
                                                on visit.sportclub_activity_id = sa.sportclub_activity_id
                                           join card c
                                                on c.card_id = visit.card_id
                                           join card_type ct
                                                on ct.card_type_id = c.card_type_id
                                  GROUP BY sa.sportclub_id, c.card_type_id),

         cte_all_visits AS (SELECT s.sportclub_id,
                                   COUNT(s.name) all_visits_number
                            FROM visit
                                     JOIN sportclub_activity sa
                                          on visit.sportclub_activity_id = sa.sportclub_activity_id
                                     JOIN sportclub s
                                          on s.sportclub_id = sa.sportclub_id
                            GROUP BY s.name)
    select sportclub.name,
           ct.type,
           IF(cte_card_type_visits.count, cte_card_type_visits.count, 0)
               AS number_of_visits,
           IF(cte_card_type_visits.count,
              ROUND((cte_card_type_visits.count / cte_all_visits.all_visits_number) * 100, 2), 0)
               AS percentage
    from sportclub
             join sportclub_card_types sct
                  on sportclub.sportclub_id = sct.sportclub_id
             join card_type ct
                  on sct.card_type_id = ct.card_type_id
             left join cte_card_type_visits
                       on cte_card_type_visits.sportclub_id = sportclub.sportclub_id
                           and cte_card_type_visits.card_type_id = ct.card_type_id
             join cte_all_visits
                  on cte_all_visits.sportclub_id = sportclub.sportclub_id
    ORDER BY sportclub.name,
             percentage DESC;
END$$