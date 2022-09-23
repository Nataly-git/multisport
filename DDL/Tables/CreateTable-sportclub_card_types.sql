USE Multisport;

DROP TABLE IF EXISTS sportclub_card_types;

CREATE TABLE sportclub_card_types
(
    sportclub_id INT     NOT NULL,
    card_type_id TINYINT NOT NULL,

    CONSTRAINT PK_sportclub_card_types PRIMARY KEY
        (
         sportclub_id, card_type_id
            )
);