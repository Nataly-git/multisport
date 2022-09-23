USE Multisport;

DROP TABLE IF EXISTS card_type;

CREATE TABLE card_type
(
    card_type_id     INT           NOT NULL AUTO_INCREMENT,
    type             VARCHAR(30)   NOT NULL,
    price            DECIMAL(4, 2) NOT NULL,
    max_visit_number INT           NOT NULL,

    CONSTRAINT PRIMARY KEY PK_card_type
        (
         card_type_id
            )
);