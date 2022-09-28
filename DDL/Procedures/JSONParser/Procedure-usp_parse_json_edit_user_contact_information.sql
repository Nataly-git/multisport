USE Multisport;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_parse_json_edit_user_contact_information;

CREATE PROCEDURE usp_parse_json_edit_user_contact_information(IN json_edit_user_contact_information TEXT)

BEGIN
    WITH   cte_contacts_info AS(
        SELECT user_id,
               apartments,
               city,
               street,
               building,
               phone_number
        FROM   json_table(json_edit_user_contact_information, '$'
                    COLUMNS (
                        email VARCHAR(254) PATH '$.user.email',
                        apartments   SMALLINT    PATH '$.contacts.apartments',
                        city         VARCHAR(50) PATH '$.contacts.city',
                        street       VARCHAR(50) PATH '$.contacts.street',
                        building     SMALLINT    PATH '$.contacts.building',
                        phone_number VARCHAR(20) PATH '$.contacts.phoneNumber'
                        )
                    ) AS user_contacts
               JOIN user ON user_contacts.email = user.email
            )

    UPDATE user_contacts uc, cte_contacts_info cte
    SET    uc.apartments = IF(cte.apartments IS NOT NULL, cte.apartments, uc.apartments),
           uc.city = IF(cte.city IS NOT NULL, cte.city, uc.city),
           uc.street = IF(cte.street IS NOT NULL, cte.street, uc.street),
           uc.building = IF(cte.building IS NOT NULL, cte.building, uc.building),
           uc.phone_number = IF(cte.phone_number IS NOT NULL, cte.phone_number, uc.phone_number)
    WHERE  uc.user_id = cte.user_id;
END$$