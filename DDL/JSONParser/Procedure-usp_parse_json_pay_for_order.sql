USE Multisport;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_parse_json_pay_for_order;

CREATE PROCEDURE usp_parse_json_pay_for_order(IN json_pay_for_order TEXT)
BEGIN
    SELECT order_date,
           user_id,
           status_id
    INTO @order_date,
        @user_id,
        @status_id
    FROM json_table(json_pay_for_order, '$'
                    COLUMNS (
                        order_date   DATE         PATH '$.order.date',
                        order_status VARCHAR(20)  PATH '$.order.orderStatus.status',
                        user_email   VARCHAR(254) PATH '$.order.user.email'
                        )
                    ) AS orders
             LEFT JOIN order_status ON orders.order_status = order_status.status
             LEFT JOIN user ON orders.user_email = user.email;

    SELECT order_id,
           card_type_id
    INTO @order_id,
        @card_type_id
    FROM `order`
    WHERE `order`.date = @order_date
      AND `order`.user_id = @user_id;

    UPDATE `order`
    SET `order`.status_id = @status_id
    WHERE order_id = @order_id;

    SELECT payment_date,
           payment_method
    INTO @payment_date,
        @payment_method
    FROM json_table(json_pay_for_order, '$'
                    COLUMNS (
                        payment_date   DATE        PATH '$.payment.date',
                        payment_method VARCHAR(30) PATH '$.payment.method'
                        )
                    ) AS payments;

    INSERT INTO payment(order_id,
                        date,
                        method)
        VALUE (@order_id,
               @payment_date,
               @payment_method);

    SELECT last_insert_id() INTO @payment_id;

    SELECT number,
           start_date
    INTO @number,
        @start_date
    FROM json_table(json_pay_for_order, '$'
                    COLUMNS (
                        number         VARCHAR(20) PATH '$.card.number',
                        start_date     DATE        PATH '$.card.startDate'
                        )
                    ) AS paid_card;

    INSERT INTO card(number,
                     payment_id,
                     start_date,
                     card_type_id)
        VALUE (@number,
               @payment_id,
               @start_date,
               @card_type_id);
END$$