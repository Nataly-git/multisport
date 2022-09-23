USE Multisport;

DROP TABLE IF EXISTS activity;

CREATE TABLE activity
(
    activity_id SMALLINT    NOT NULL AUTO_INCREMENT,
    name        VARCHAR(30) NOT NULL,

    CONSTRAINT PK_rating PRIMARY KEY
        (
         activity_id
            )
);