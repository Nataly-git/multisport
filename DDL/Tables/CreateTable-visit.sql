USE Multisport;

DROP TABLE IF EXISTS visit;

CREATE TABLE visit
(
    visit_id     INT      NOT NULL AUTO_INCREMENT,
    card_id      INT      NOT NULL,
    sportclub_id INT      NOT NULL,
    activity_id  INT      NOT NULL,
    timestamp    DATETIME NOT NULL,

    CONSTRAINT PK_visit PRIMARY KEY
        (
         visit_id
            )
);