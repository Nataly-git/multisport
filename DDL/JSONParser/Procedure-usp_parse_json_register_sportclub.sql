USE Multisport;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_parse_json_add_sportclub;

CREATE PROCEDURE usp_parse_json_add_sportclub(IN json_add_sportclub text)

BEGIN
    SELECT time,
           browser,
           ip,
           device
    INTO @time,
        @browser,
        @ip,
        @device
    FROM json_table(json_add_sportclub, '$'
                    COLUMNS(
                        time             DATETIME     PATH '$.guest.time',
                        browser          VARCHAR(100) PATH '$.guest.browser',
                        ip               VARCHAR(15)  PATH '$.guest.ipAddress',
                        device           VARCHAR(100) PATH '$.guest.device'
                        )
             )AS guest;

    INSERT INTO guest
    (time,
     browser,
     ip,
     device)
    VALUES (@time,
            @browser,
            @ip,
            @device);

    SELECT LAST_INSERT_ID() INTO @guest_id;

    SELECT email,
           name,
           password,
           city,
           street,
           building
    INTO @email,
        @name,
        @password,
        @city,
        @street,
        @building
    FROM json_table(json_add_sportclub, '$'
                    COLUMNS(
                        email            VARCHAR(254) PATH '$.sportclub.email',
                        name             VARCHAR(100) PATH '$.sportclub.name',
                        password         VARCHAR(50)  PATH '$.sportclub.password',
                        city             VARCHAR(50)  PATH '$.sportclub.city',
                        street           VARCHAR(50)  PATH '$.sportclub.street',
                        building         SMALLINT     PATH '$.sportclub.building'
                        )
             )AS sportclub;

    INSERT INTO sportclub
    (email,
     name,
     password,
     city,
     street,
     building,
     guest_id)
    VALUES (@email,
            @name,
            @password,
            @city,
            @street,
            @building,
            @guest_id);

    SELECT LAST_INSERT_ID() INTO @sportclub_id;

    SELECT working_hours,
           phone_number
    INTO  @working_hours,
        @phone_number
    FROM json_table(json_add_sportclub, '$'
                    COLUMNS(
                        working_hours    VARCHAR(255) PATH '$.contacts.workingHours',
                        phone_number     VARCHAR(20)  PATH '$.contacts.phoneNumber'
                        )
             )AS sportclub_contacts;

    INSERT INTO sportclub_contacts
    (sportclub_id,
     working_hours,
     phone_number)
    VALUES (@sportclub_id,
            @working_hours,
            @phone_number);

#     INSERT INTO sportclub_card_types
#     (sportclub_id,
#      card_type_id)
#     WITH cte_sportclub_id AS (SELECT sportclub_id
#                               FROM sportclub
#                                        INNER JOIN json_table(json_add_sportclub, '$'
#                                                              COLUMNS (
#                                                                  email   VARCHAR(254) PATH '$.sportclub.email'
#                                                                  )
#                                   ) AS selected_club ON sportclub.email = selected_club.email),
#          cte_card_type_id AS (SELECT card_type_id
#                               FROM card_type
#                                        INNER JOIN json_table(json_add_sportclub, '$'
#                                                              COLUMNS (
#                                                                  type VARCHAR(30) PATH '$.cardTypes.type'
#                                                                  )
#                                   ) AS selected_type ON card_type.type = selected_type.type)
#     SELECT sportclub_id, card_type_id
#     FROM cte_sportclub_id
#              CROSS JOIN cte_card_type_id;


    SELECT s.sportclub_id,
           c.card_type_id
    FROM json_table(json_add_sportclub, '$[*]'
                    COLUMNS (
                        email VARCHAR(254) PATH '$.sportclub.email',
                        type  VARCHAR(30)  PATH '$.cardTypes.type'
                        )
             ) AS card_types
             INNER JOIN sportclub s on card_types.email = s.email
             INNER JOIN card_type c on card_types.type = c.type;



END$$