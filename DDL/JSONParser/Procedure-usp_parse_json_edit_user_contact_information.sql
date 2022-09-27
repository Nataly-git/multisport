USE Multisport;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_parse_json_edit_user_contact_information;

CREATE PROCEDURE usp_parse_json_edit_user_contact_information(IN json_edit_user_contact_information text)

BEGIN
    SELECT user_id
    INTO   @user_id
    FROM   json_table(json_edit_user_contact_information, '$'
                    COLUMNS (
                        email VARCHAR(254) PATH '$.user.email'
                        )
                    ) AS this_user
    LEFT JOIN user ON user.email = this_user.email;

    SELECT apartments,
           city,
           street,
           building,
           phone_number
    INTO   @apartments,
           @city,
           @street,
           @building,
           @phone_number
    FROM   json_table(json_edit_user_contact_information, '$'
                    COLUMNS (
                        apartments   SMALLINT    PATH '$.contacts.apartments',
                        city         VARCHAR(50) PATH '$.contacts.city',
                        street       VARCHAR(50) PATH '$.contacts.street',
                        building     SMALLINT    PATH '$.contacts.building',
                        phone_number VARCHAR(20) PATH '$.contacts.phoneNumber'
                        )
                    ) AS user_contacts;

    UPDATE user_contacts
    SET    apartments = IF(@apartments IS NOT NULL, @apartments, apartments,
           city = IF(@city IS NOT NULL, @city, city),
           street = IF(@street IS NOT NULL, @street, street),
           building = IF(@building IS NOT NULL, @building, building),
           phone_number = IF(@phone_number IS NOT NULL, @phone_number, phone_number);
    WHERE  user_id = @user_id;
END$$