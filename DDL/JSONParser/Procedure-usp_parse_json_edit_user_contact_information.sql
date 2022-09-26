USE Multisport;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_parse_json_edit_user_contact_information;

CREATE PROCEDURE usp_parse_json_edit_user_contact_information(IN json_edit_user_contact_information text)

BEGIN
    SELECT user_id
    INTO @user_id
    FROM json_table(json_edit_user_contact_information, '$'
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
    INTO @apartments,
        @city,
        @street,
        @building,
        @phone_number
    FROM json_table(json_edit_user_contact_information, '$'
                    COLUMNS (
                        apartments   SMALLINT    PATH '$.contacts.apartments',
                        city         VARCHAR(50) PATH '$.contacts.city',
                        street       VARCHAR(50) PATH '$.contacts.street',
                        building     SMALLINT    PATH '$.contacts.building',
                        phone_number VARCHAR(20) PATH '$.contacts.phoneNumber'
                        )
             ) AS user_contacts;

    UPDATE user_contacts
    SET    apartments = @apartments
    WHERE  user_id = @user_id AND @apartments IS NOT NULL;

    UPDATE user_contacts
    SET    city = @city
    WHERE  user_id = @user_id AND @city IS NOT NULL;

    UPDATE user_contacts
    SET    street = @street
    WHERE  user_id = @user_id AND @street IS NOT NULL;

    UPDATE user_contacts
    SET    building = @building
    WHERE  user_id = @user_id AND @building IS NOT NULL;

    UPDATE user_contacts
    SET    phone_number = @phone_number
    WHERE  user_id = @user_id AND @phone_number IS NOT NULL;
END$$