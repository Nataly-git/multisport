USE Multisport;

DROP TABLE IF EXISTS card_type;

CREATE TABLE card_type
(
    card_type_id     TINYINT       NOT NULL AUTO_INCREMENT,
    type             VARCHAR(30)   NOT NULL,
    price            DECIMAL(6, 2) NOT NULL,
    max_visit_number TINYINT       NOT NULL,

    CONSTRAINT PRIMARY KEY PK_card_type
        (
         card_type_id
            )
);