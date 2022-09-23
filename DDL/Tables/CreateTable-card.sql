USE Multisport;

DROP TABLE IF EXISTS card;

CREATE TABLE card
(
    card_id      BIGINT      NOT NULL AUTO_INCREMENT,
    number       VARCHAR(20) NOT NULL,
    payment_id   BIGINT      NOT NULL,
    start_date   DATE        NOT NULL,
    card_type_id TINYINT     NOT NULL,

    CONSTRAINT PRIMARY KEY PK_card
        (
         card_id
            )
);