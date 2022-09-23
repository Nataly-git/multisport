USE
Multisport;

DROP TABLE IF EXISTS guest;

CREATE TABLE guest
(
    guest_id  INT          NOT NULL AUTO_INCREMENT,
    timestamp DATETIME     NOT NULL,
    browser   VARCHAR(100) NOT NULL,
    ip        VARCHAR(15)  NOT NULL,
    device    VARCHAR(100) NOT NULL,

    CONSTRAINT PK_guest PRIMARY KEY
        (
         guest_id
            )
);