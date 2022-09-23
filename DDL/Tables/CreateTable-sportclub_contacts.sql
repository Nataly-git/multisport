USE Multisport;

DROP TABLE IF EXISTS sportclub_contacts;

CREATE TABLE sportclub_contacts
(
    sportclub_contacts_id INT          NOT NULL AUTO_INCREMENT,
    sportclub_id          INT          NOT NULL,
    working_hours         VARCHAR(255) NOT NULL,
    phone_number          VARCHAR(20)  NOT NULL,

    CONSTRAINT PK_sportclub_contacts PRIMARY KEY
        (
         sportclub_contacts_id
            )
);