USE Multisport;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_parse_json_register_sportclub;

CREATE PROCEDURE usp_parse_json_register_sportclub(IN json_add_sportclub TEXT)

BEGIN
    START TRANSACTION;

    SELECT time,
           browser,
           ip,
           device,
           email,
           name,
           password,
           city,
           street,
           building,
           working_hours,
           phone_number,
           card_type_id,
           activity_id,
           duration
    INTO   @time,
           @browser,
           @ip,
           @device,
           @email,
           @name,
           @password,
           @city,
           @street,
           @building,
           @working_hours,
           @phone_number,
           @card_type_id,
           @activity_id,
           @duration
    FROM   json_table(json_add_sportclub, '$'
                    COLUMNS (
                        time            DATETIME      PATH '$.guest.time',
                        browser         VARCHAR(100)  PATH '$.guest.browser',
                        ip              VARCHAR(15)   PATH '$.guest.ipAddress',
                        device          VARCHAR(100)  PATH '$.guest.device',
                        email           VARCHAR(254)  PATH '$.sportclub.email',
                        name            VARCHAR(100)  PATH '$.sportclub.name',
                        password        VARCHAR(50)   PATH '$.sportclub.password',
                        city            VARCHAR(50)   PATH '$.sportclub.city',
                        street          VARCHAR(50)   PATH '$.sportclub.street',
                        building        SMALLINT      PATH '$.sportclub.building',
                        working_hours   VARCHAR(255)  PATH '$.contacts.workingHours',
                        phone_number    VARCHAR(20)   PATH '$.contacts.phoneNumber',
                        type            VARCHAR(30)   PATH '$.cardTypes.type',
                        activity_name   VARCHAR(30)   PATH '$.activities.activity.name',
                        duration        DECIMAL(3, 2) PATH '$.activities.duration'
                        )
                    ) AS register_info
               JOIN card_type ON register_info.type = card_type.type
               JOIN activity ON register_info.activity_name = activity.name;

    INSERT INTO guest (
            time,
            browser,
            ip,
            device)
    VALUES (@time,
            @browser,
            @ip,
            @device);

    SELECT last_insert_id() INTO @guest_id;

    INSERT INTO sportclub (
            email,
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

    SELECT last_insert_id() INTO @sportclub_id;

    INSERT INTO sportclub_contacts (
            sportclub_id,
            working_hours,
            phone_number)
    VALUES (@sportclub_id,
            @working_hours,
            @phone_number);

    INSERT INTO sportclub_card_types(
            sportclub_id,
            card_type_id)
    SELECT  @sportclub_id,
            @card_type_id;

    INSERT INTO sportclub_activity(
            sportclub_id,
            activity_id,
            duration)
    SELECT  @sportclub_id,
            @activity_id,
            @duration;

    COMMIT;
END$$