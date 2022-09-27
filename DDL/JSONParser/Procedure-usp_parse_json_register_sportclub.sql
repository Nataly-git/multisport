USE Multisport;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_parse_json_register_sportclub;

CREATE PROCEDURE usp_parse_json_register_sportclub(IN json_add_sportclub text)

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
                    COLUMNS (
                        time    DATETIME     PATH '$.guest.time',
                        browser VARCHAR(100) PATH '$.guest.browser',
                        ip      VARCHAR(15)  PATH '$.guest.ipAddress',
                        device  VARCHAR(100) PATH '$.guest.device'
                        )
                    ) AS guest;

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
                    COLUMNS (
                        email    VARCHAR(254) PATH '$.sportclub.email',
                        name     VARCHAR(100) PATH '$.sportclub.name',
                        password VARCHAR(50)  PATH '$.sportclub.password',
                        city     VARCHAR(50)  PATH '$.sportclub.city',
                        street   VARCHAR(50)  PATH '$.sportclub.street',
                        building SMALLINT     PATH '$.sportclub.building'
                        )
                    ) AS sportclub;

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
    INTO @working_hours,
        @phone_number
    FROM json_table(json_add_sportclub, '$'
                    COLUMNS (
                        working_hours VARCHAR(255) PATH '$.contacts.workingHours',
                        phone_number  VARCHAR(20)  PATH '$.contacts.phoneNumber'
                        )
                    ) AS sportclub_contacts;

    INSERT INTO sportclub_contacts
    (sportclub_id,
     working_hours,
     phone_number)
    VALUES (@sportclub_id,
            @working_hours,
            @phone_number);

    INSERT INTO sportclub_card_types(sportclub_id,
                                     card_type_id)
    SELECT @sportclub_id,
           card_type_id
    FROM json_table(json_add_sportclub, '$.cardTypes[*]'
                    COLUMNS (
                        type VARCHAR(30) PATH '$.type'
                        )
                    ) AS types
             LEFT JOIN card_type ON types.type = card_type.type;

    INSERT INTO sportclub_activity(sportclub_id,
                                   activity_id,
                                   duration)
    SELECT @sportclub_id,
           activity_id,
           duration
    FROM json_table(json_add_sportclub, '$.activities[*]'
                    COLUMNS (
                        activity_name VARCHAR(30)   PATH '$.activity.name',
                        duration      DECIMAL(3, 2) PATH '$.duration'
                        )
                    ) AS activities
             LEFT JOIN activity ON activities.activity_name = activity.name;
END$$