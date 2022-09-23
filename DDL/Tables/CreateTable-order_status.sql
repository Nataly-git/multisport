USE Multisport;

DROP TABLE IF EXISTS order_status;

CREATE TABLE order_status
(
    status_id INT         NOT NULL AUTO_INCREMENT,
    status    VARCHAR(20) NOT NULL,

    CONSTRAINT PRIMARY KEY PK_order_status
    (
         status_id
    )
);