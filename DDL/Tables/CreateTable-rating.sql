USE Multisport;

DROP TABLE IF EXISTS rating;

CREATE TABLE rating
(
    user_id      INT NOT NULL,
    sportclub_id INT NOT NULL,
    rate         INT NOT NULL,
    comment      VARCHAR(255),

    CONSTRAINT PK_rating PRIMARY KEY
    (
         user_id, sportclub_id
    )
);