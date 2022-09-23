USE Multisport;

DROP TABLE IF EXISTS sportclub_activity;

CREATE TABLE sportclub_activity
(
    sportclub_activity_id BIGINT        NOT NULL AUTO_INCREMENT,
    sportclub_id          INT           NOT NULL,
    activity_id           SMALLINT      NOT NULL,
    duration              DECIMAL(3, 2) NOT NULL,

    CONSTRAINT PK_sportclub_activity PRIMARY KEY
        (
         sportclub_activity_id
            )
);