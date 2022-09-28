USE Multisport;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_parse_json_edit_sportclub_contact_information;

CREATE PROCEDURE usp_parse_json_edit_sportclub_contact_information(IN json_edit_sportclub_contact_information TEXT)

BEGIN
    WITH cte_contacts_info AS(
        SELECT sportclub_id,
               working_hours,
               phone_number
        FROM   json_table(json_edit_sportclub_contact_information, '$'
                    COLUMNS (
                        email         VARCHAR(254) PATH '$.sportClub.email',
                        working_hours VARCHAR(255) PATH '$.contacts.workingHours',
                        phone_number  VARCHAR(20)  PATH '$.contacts.phoneNumber'
                        )
                    ) AS sportclub_contacts
               JOIN sportclub ON sportclub.email = sportclub_contacts.email
            )
    UPDATE sportclub_contacts sc, cte_contacts_info cte
    SET    sc.working_hours = IF(cte.working_hours IS NOT NULL, cte.working_hours, sc.working_hours),
           sc.phone_number = IF(cte.phone_number IS NOT NULL, cte.phone_number, sc.phone_number)
    WHERE sc.sportclub_id = cte.sportclub_id;
END$$