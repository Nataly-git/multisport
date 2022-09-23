USE Multisport;

DROP TABLE IF EXISTS sportclub;

CREATE TABLE sportclub
(
    sportclub_id INT          NOT NULL AUTO_INCREMENT,
    email        VARCHAR(254) NOT NULL,
    name         VARCHAR(100) NOT NULL,
    guest_id     INT          NOT NULL,
    password     VARCHAR(50)  NOT NULL,
    city         VARCHAR(50)  NOT NULL,
    street       VARCHAR(50)  NOT NULL,
    building     SMALLINT     NOT NULL,

    CONSTRAINT PK_sportclub PRIMARY KEY
        (
         sportclub_id
            )
);