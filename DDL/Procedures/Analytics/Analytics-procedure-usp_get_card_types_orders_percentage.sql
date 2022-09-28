USE Multisport;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_get_card_types_orders_percentage;

CREATE PROCEDURE usp_get_card_types_orders_percentage(IN month_number TINYINT, IN year_number SMALLINT)
BEGIN
    SET @prev_month = IF(month_number = 1, 12, month_number - 1);
    SET @prev_year = IF(month_number = 1, year_number - 1, year_number);

    WITH cte_all_orders_in_prev_month AS (SELECT COUNT(*) all_orders
                                          FROM `order`
                                                   join order_status os on os.status_id = `order`.status_id
                                          WHERE status = 'paid'
                                            AND MONTH(date) = @prev_month
                                            AND YEAR(date) = @prev_year)

       , cte_card_type_orers_in_prev_month AS (SELECT card_type.type
                                                    , COUNT(card_type.type) number_of_orders
                                               FROM card_type
                                                        left join `order` o
                                                                  on card_type.card_type_id = o.card_type_id
                                                        join order_status os on os.status_id = o.status_id
                                               WHERE status = 'paid'
                                                 AND MONTH(date) = @prev_month
                                                 AND YEAR(date) = @prev_year
                                               GROUP BY card_type.type)

       , cte_prev_month_stat AS (SELECT card_type.type,
                                        IF(cte_card_type_orers_in_prev_month.number_of_orders
                                            , cte_card_type_orers_in_prev_month.number_of_orders
                                            , 0) paid_orders_in_prev_month,
                                        cte_all_orders_in_prev_month.all_orders
                                 FROM card_type
                                          left join cte_card_type_orers_in_prev_month
                                                    on cte_card_type_orers_in_prev_month.type = card_type.type
                                          join cte_all_orders_in_prev_month)

       , cte_prev_month_percentage AS (select cte_prev_month_stat.type,
                                              ROUND(100 * (IF(cte_prev_month_stat.paid_orders_in_prev_month
                                                  , cte_prev_month_stat.paid_orders_in_prev_month
                                                  , 0)) / cte_prev_month_stat.all_orders,
                                                    2) prev_month_percentage
                                       from cte_prev_month_stat)

       , cte_all_orders_in_current_month AS (SELECT COUNT(*) all_orders
                                             FROM `order`
                                                      join order_status os on os.status_id = `order`.status_id
                                             WHERE status = 'paid'
                                               AND MONTH(date) = month_number
                                               AND YEAR(date) = year_number)

       , cte_card_type_orders_in_current_month AS (SELECT card_type.type
                                                        , COUNT(card_type.type) number_of_orders
                                                   FROM card_type
                                                            left join `order` o
                                                                      on card_type.card_type_id = o.card_type_id
                                                            join order_status os on os.status_id = o.status_id
                                                   WHERE status = 'paid'
                                                     AND MONTH(date) = month_number
                                                     AND YEAR(date) = year_number
                                                   GROUP BY card_type.type)

       , cte_current_month_stat AS (SELECT card_type.type
                                         , IF
            (cte_card_type_orders_in_current_month.number_of_orders
            , cte_card_type_orders_in_current_month.number_of_orders
            , 0)
            paid_orders_in_current_month
                                         , cte_all_orders_in_current_month.all_orders
                                    FROM card_type
                                             left join cte_card_type_orders_in_current_month
                                                       on cte_card_type_orders_in_current_month.type = card_type.type
                                             join cte_all_orders_in_current_month)

       , cte_current_month_percentage AS (select cte_current_month_stat.type,
                                                 ROUND(100 * (IF(cte_current_month_stat.paid_orders_in_current_month
                                                     , cte_current_month_stat.paid_orders_in_current_month
                                                     , 0)) / cte_current_month_stat.all_orders,
                                                       2) current_month_percentage
                                          from cte_current_month_stat)
       , cte_difference AS (select card_type.type, current_month_percentage - prev_month_percentage difference
                            from card_type
                                     join cte_current_month_percentage
                                          on card_type.type = cte_current_month_percentage.type
                                     join cte_prev_month_percentage
                                          on card_type.type = cte_prev_month_percentage.type)
    select card_type.type,
           cte_prev_month_stat.paid_orders_in_prev_month,
           cte_prev_month_stat.all_orders,
           cte_prev_month_percentage.prev_month_percentage,
           cte_current_month_stat.paid_orders_in_current_month,
           cte_current_month_stat.all_orders,
           cte_current_month_percentage.current_month_percentage,
           cte_difference.difference
    from card_type
             join cte_current_month_stat on card_type.type = cte_current_month_stat.type
             join cte_prev_month_stat on card_type.type = cte_prev_month_stat.type
             join cte_prev_month_percentage on card_type.type = cte_prev_month_percentage.type
             join cte_current_month_percentage on card_type.type = cte_current_month_percentage.type
             join cte_difference on card_type.type = cte_difference.type;
END
$$




