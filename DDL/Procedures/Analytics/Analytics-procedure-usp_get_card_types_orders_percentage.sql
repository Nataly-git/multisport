USE Multisport;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_get_card_types_orders_percentage;

CREATE PROCEDURE usp_get_card_types_orders_percentage(IN month_number TINYINT, IN year_number SMALLINT)
BEGIN
    SET @prev_month = IF(month_number = 1, 12, month_number - 1);
    SET @prev_year = IF(month_number = 1, year_number - 1, year_number);

    WITH cte_all_orders_in_prev_month AS(
        SELECT count_all_paid_orders(@prev_month,
                                     @prev_year
            ) AS all_paid_orders
        ),
    cte_orders_in_prev_month AS(
        SELECT card_type.type,
               count_card_type_number(@prev_month,
                                      @prev_year,
                                      card_type.type
             ) AS number_of_orders
        FROM card_type
        ),
    cte_prev_month_stat AS(
        SELECT card_type.type,
               IF(opm.number_of_orders, opm.number_of_orders, 0
                   ) AS paid_orders_in_prev_month,
               cte_all_orders_in_prev_month.all_paid_orders
        FROM card_type
              JOIN cte_orders_in_prev_month opm ON opm.type = card_type.type
              JOIN cte_all_orders_in_prev_month
        ),
    cte_prev_month_percentage AS(
        SELECT ps.type,
               count_percentage(ps.paid_orders_in_prev_month,
                                ps.all_paid_orders
                   ) AS prev_month_percentage
        FROM cte_prev_month_stat ps
        ),
    cte_all_orders_in_current_month AS(
        SELECT count_all_paid_orders(month_number,
                                     year_number
            ) AS all_paid_orders
        ),
    cte_orders_in_current_month AS(
        SELECT card_type.type,
               count_card_type_number(month_number,
                                      year_number,
                                      card_type.type
                   ) AS number_of_orders
        FROM card_type
        ),
    cte_current_month_stat AS(
        SELECT card_type.type,
               IF(ord.number_of_orders, ord.number_of_orders, 0
                   ) AS paid_orders_in_current_month,
               cte_all_orders_in_current_month.all_paid_orders
        FROM card_type
            JOIN cte_orders_in_current_month ord ON ord.type = card_type.type
            JOIN cte_all_orders_in_current_month
        ),
    cte_current_month_percentage AS(
        SELECT st.type,
               count_percentage(st.paid_orders_in_current_month, st.all_paid_orders
                   ) AS current_month_percentage
        FROM cte_current_month_stat st
        ),
    cte_difference AS (
        SELECT card_type.type,
               current_month_percentage - prev_month_percentage AS difference
        FROM card_type
            JOIN cte_current_month_percentage cm ON card_type.type = cm.type
            JOIN cte_prev_month_percentage pm ON card_type.type = pm.type
        )
    SELECT ct.type                          AS `Card type`,
           pms.paid_orders_in_prev_month    AS `Orders in previous month`,
           pmp.prev_month_percentage        AS `Previous month percentage`,
           cms.paid_orders_in_current_month AS `Orders in current month`,
           cmp.current_month_percentage     AS `Current month percentage`,
           d.difference                     AS `Difference`
    FROM card_type ct
        JOIN cte_current_month_stat cms ON ct.type = cms.type
        JOIN cte_prev_month_stat pms ON ct.type = pms.type
        JOIN cte_prev_month_percentage pmp ON ct.type = pmp.type
        JOIN cte_current_month_percentage cmp ON ct.type = cmp.type
        JOIN cte_difference d ON ct.type = d.type;
END$$