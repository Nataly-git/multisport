USE Multisport;

DROP TABLE IF EXISTS user_contacts;

CREATE TABLE user_contacts
(
    user_contacts_id INT         NOT NULL AUTO_INCREMENT,
    user_id          INT         NOT NULL,
    apartments       SMALLINT,
    city             VARCHAR(50) NOT NULL,
    street           VARCHAR(50) NOT NULL,
    building         SMALLINT    NOT NULL,
    phone_number     VARCHAR(20) NOT NULL,

    CONSTRAINT PK_user_contacts PRIMARY KEY
        (
         user_contacts_id
            )
);