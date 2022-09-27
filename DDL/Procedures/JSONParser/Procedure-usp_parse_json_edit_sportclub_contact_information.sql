USE Multisport;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_parse_json_edit_sportclub_contact_information;

CREATE PROCEDURE usp_parse_json_edit_sportclub_contact_information(IN json_edit_sportclub_contact_information text)

BEGIN
    SELECT sportclub_id
    INTO   @sportclub_id
    FROM   json_table(json_edit_sportclub_contact_information, '$'
                    COLUMNS (
                        email VARCHAR(254) PATH '$.sportClub.email'
                        )
                    ) AS this_sportclub
             LEFT JOIN sportclub ON sportclub.email = this_sportclub.email;

    SELECT working_hours,
           phone_number
    INTO   @working_hours,
           @phone_number
    FROM   json_table(json_edit_sportclub_contact_information, '$'
                    COLUMNS (
                        working_hours VARCHAR(255) PATH '$.contacts.workingHours',
                        phone_number  VARCHAR(20)  PATH '$.contacts.phoneNumber'
                        )
                    ) AS sportclub_contacts;

    UPDATE sportclub_contacts
    SET    working_hours = IF(@working_hours IS NOT NULL, @working_hours, working_hours),
           phone_number = IF(@phone_number IS NOT NULL, @phone_number, phone_number)
    WHERE  sportclub_id = @sportclub_id;

END$$