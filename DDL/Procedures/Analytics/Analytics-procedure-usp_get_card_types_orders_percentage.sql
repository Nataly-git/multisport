USE Multisport;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_get_card_types_orders_percentage;

CREATE PROCEDURE usp_get_card_types_orders_percentage(IN month_number TINYINT, IN year_number SMALLINT)
BEGIN
    SET @prev_month = IF(month_number = 1, 12, month_number - 1);
    SET @prev_year = IF(month_number = 1, year_number - 1, year_number);

    WITH cte_all_orders_in_prev_month AS (SELECT count_all_paid_orders(@prev_month
                                                     , @prev_year) all_paid_orders)

       , cte_orers_in_prev_month AS (SELECT card_type.type
                                          , count_card_type_number(@prev_month,
                                                                   @prev_year,
                                                                   card_type.type) number_of_orders
                                     FROM card_type)

       , cte_prev_month_stat AS (SELECT card_type.type,
                                        IF(cte_orers_in_prev_month.number_of_orders
                                            , cte_orers_in_prev_month.number_of_orders
                                            , 0) paid_orders_in_prev_month,
                                        cte_all_orders_in_prev_month.all_paid_orders
                                 FROM card_type
                                          LEFT JOIN cte_orers_in_prev_month
                                                    ON cte_orers_in_prev_month.type = card_type.type
                                          JOIN cte_all_orders_in_prev_month)

       , cte_prev_month_percentage AS (SELECT cte_prev_month_stat.type,
                                              count_percentage(cte_prev_month_stat.paid_orders_in_prev_month,
                                                               cte_prev_month_stat.all_paid_orders) prev_month_percentage
                                       FROM cte_prev_month_stat)

       , cte_all_orders_in_current_month AS (SELECT count_all_paid_orders(month_number
                                                        , year_number) all_paid_orders)

       , cte_orders_in_current_month AS (SELECT card_type.type
                                              , count_card_type_number(month_number,
                                                                       year_number,
                                                                       card_type.type) number_of_orders
                                         FROM card_type)

       , cte_current_month_stat AS (SELECT card_type.type
                                         , IF(cte_orders_in_current_month.number_of_orders
                                         , cte_orders_in_current_month.number_of_orders
                                         , 0) paid_orders_in_current_month
                                         , cte_all_orders_in_current_month.all_paid_orders
                                    FROM card_type
                                             LEFT JOIN cte_orders_in_current_month
                                                       ON cte_orders_in_current_month.type = card_type.type
                                             JOIN cte_all_orders_in_current_month)

       , cte_current_month_percentage AS (SELECT cte_current_month_stat.type,
                                                 count_percentage(cte_current_month_stat.paid_orders_in_current_month,
                                                                  cte_current_month_stat.all_paid_orders) current_month_percentage
                                          FROM cte_current_month_stat)

       , cte_difference AS (SELECT card_type.type,
                                   current_month_percentage - prev_month_percentage difference
                            FROM card_type
                                     JOIN cte_current_month_percentage
                                          ON card_type.type = cte_current_month_percentage.type
                                     JOIN cte_prev_month_percentage
                                          ON card_type.type = cte_prev_month_percentage.type)

    SELECT card_type.type                                        `Card type`,
           cte_prev_month_stat.paid_orders_in_prev_month         `Orders in previous month`,
           cte_prev_month_percentage.prev_month_percentage       `Previous month percentage`,
           cte_current_month_stat.paid_orders_in_current_month   `Orders in current month`,
           cte_current_month_percentage.current_month_percentage `Current month percentage`,
           cte_difference.difference AS                          `Difference`
    FROM card_type
             JOIN cte_current_month_stat
                  ON card_type.type = cte_current_month_stat.type
             JOIN cte_prev_month_stat
                  ON card_type.type = cte_prev_month_stat.type
             JOIN cte_prev_month_percentage
                  ON card_type.type = cte_prev_month_percentage.type
             JOIN cte_current_month_percentage
                  ON card_type.type = cte_current_month_percentage.type
             JOIN cte_difference
                  ON card_type.type = cte_difference.type;
END
$$