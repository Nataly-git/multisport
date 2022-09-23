USE Multisport;

DROP TABLE IF EXISTS visit;

CREATE TABLE visit
(
    visit_id              BIGINT   NOT NULL AUTO_INCREMENT,
    card_id               BIGINT   NOT NULL,
    sportclub_activity_id BIGINT   NOT NULL,
    date_time             DATETIME NOT NULL,

    CONSTRAINT PK_visit PRIMARY KEY
        (
         visit_id
            )
);