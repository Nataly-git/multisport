USE Multisport;

DROP TABLE IF EXISTS payment;

CREATE TABLE payment
(
    payment_id BIGINT      NOT NULL AUTO_INCREMENT,
    order_id   BIGINT      NOT NULL,
    date       DATE        NOT NULL,
    method     VARCHAR(30) NOT NULL,

    CONSTRAINT PK_payment PRIMARY KEY
        (
         payment_id
            )
);

