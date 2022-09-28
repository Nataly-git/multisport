USE Multisport;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_parse_json_pay_for_order;

CREATE PROCEDURE usp_parse_json_pay_for_order(IN json_pay_for_order TEXT)
BEGIN
    START TRANSACTION;

    SELECT order_date,
           user_id,
           status_id,
           payment_date,
           payment_method,
           number,
           start_date
    INTO   @order_date,
           @user_id,
           @status_id,
           @payment_date,
           @payment_method,
           @number,
           @start_date
    FROM   json_table(json_pay_for_order, '$'
                    COLUMNS (
                        order_date     DATE         PATH '$.order.date',
                        order_status   VARCHAR(20)  PATH '$.order.orderStatus.status',
                        user_email     VARCHAR(254) PATH '$.order.user.email',
                        payment_date   DATE         PATH '$.payment.date',
                        payment_method VARCHAR(30)  PATH '$.payment.method',
                        number         VARCHAR(20)  PATH '$.card.number',
                        start_date     DATE         PATH '$.card.startDate'
                        )
                    ) AS payment_info
             JOIN order_status ON payment_info.order_status = order_status.status
             JOIN user ON payment_info.user_email = user.email;

    SELECT order_id,
           card_type_id
    INTO   @order_id,
           @card_type_id
    FROM   `order`
    WHERE  `order`.date = @order_date
      AND  `order`.user_id = @user_id;

    UPDATE `order`
    SET    `order`.status_id = @status_id
    WHERE  order_id = @order_id;

    INSERT INTO payment(
           order_id,
           date,
           method)
        VALUE (
           @order_id,
           @payment_date,
           @payment_method);

    SELECT last_insert_id() INTO @payment_id;

    INSERT INTO card(
           number,
           payment_id,
           start_date,
           card_type_id)
        VALUE (
           @number,
           @payment_id,
           @start_date,
           @card_type_id);

    COMMIT;
END$$