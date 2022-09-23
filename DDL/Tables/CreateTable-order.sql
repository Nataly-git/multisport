USE Multisport;

DROP TABLE IF EXISTS order;

CREATE TABLE order
(
    order_id     BIGINT  NOT NULL AUTO_INCREMENT,
    user_id      INT     NOT NULL,
    date         DATE    NOT NULL,
    status_id    TINYINT NOT NULL,
    card_type_id TINYINT NOT NULL,

    CONSTRAINT PRIMARY KEY PK_order
        (
         order_id
            )
);