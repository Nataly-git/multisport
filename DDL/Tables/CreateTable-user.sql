USE Multisport;

DROP TABLE IF EXISTS user;

CREATE TABLE user
(
    user_id  INT         NOT NULL AUTO_INCREMENT,
    email    VARCHAR(50) NOT NULL,
    name     VARCHAR(20) NOT NULL,
    surname  VARCHAR(30) NOT NULL,
    password VARCHAR(50) NOT NULL,
    guest_id INT         NOT NULL,

    CONSTRAINT PK_user PRIMARY KEY
    (
         user_id
    )
);