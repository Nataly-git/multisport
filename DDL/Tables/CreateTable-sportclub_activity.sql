USE
    Multisport;

DROP TABLE IF EXISTS sportclub_activities;

CREATE TABLE sportclub_activities
(
    sportclub_id INT           NOT NULL,
    activity_id  INT           NOT NULL,
    duration     DECIMAL(3, 2) NOT NULL,

    CONSTRAINT PK_sportclub_activities PRIMARY KEY
    (
         sportclub_id, activity_id
    )
);