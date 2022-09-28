USE Multisport;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_parse_json_create_order;

CREATE PROCEDURE usp_parse_json_create_order(IN json_create_order TEXT)
BEGIN
    INSERT INTO `order`(
            user_id,
            date,
            status_id,
            card_type_id)
    SELECT  user_id,
            `date`,
            status_id,
            card_type_id
    FROM    json_table(json_create_order, '$'
                    COLUMNS (
                        user_email   VARCHAR(254) PATH '$.user.email',
                        `date`       DATE         PATH '$.order.date',
                        order_status VARCHAR(20)  PATH '$.order.orderStatus.status',
                        card_type    VARCHAR(30)  PATH '$.cardType.type'
                        )
                    ) AS card_order
             JOIN user ON card_order.user_email = user.email
             JOIN order_status ON card_order.order_status = order_status.status
             JOIN card_type ON card_order.card_type = card_type.type;
END$$