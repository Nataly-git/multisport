USE Multisport;

DROP TABLE IF EXISTS payment;

CREATE TABLE payment
(
    payment_id INT         NOT NULL AUTO_INCREMENT,
    order_id   INT         NOT NULL,
    date       DATE        NOT NULL,
    method     VARCHAR(20) NOT NULL,

    CONSTRAINT PK_payment PRIMARY KEY
    (
         payment_id
    )
);

