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
           phone_number
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
           @phone_number
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
                        phone_number    VARCHAR(20)   PATH '$.contacts.phoneNumber'
                        )
                    ) AS register_info;

    INSERT INTO guest (
            time,
            browser,
            ip,
            device)
    VALUES (@time,
            @browser,
            @ip,
            @device);

    INSERT INTO sportclub (
            email,
            name,
            password,
            city,
            street,
            building,
            guest_id)
    WITH cte_guest AS(
        SELECT guest_id
        FROM guest
        WHERE guest.time = @time
          AND guest.browser = @browser
          AND guest.device = @device
          AND guest.ip = @ip
    )
    SELECT  @email,
            @name,
            @password,
            @city,
            @street,
            @building,
            cte_guest.guest_id
    FROM cte_guest;


    SELECT sportclub_id
    INTO @sportclub_id
    FROM sportclub
    WHERE email = @email;
#     INSERT INTO @sportclub_id
#     WITH cte_sportclubInfo AS(
#         SELECT sportclub_id
#         FROM sportclub
#         WHERE email = @email
#     )
#     SELECT sportclub_id
#     FROM cte_sportclubInfo;

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
            card_type_id
    FROM    json_table(json_add_sportclub, '$.cardTypes[*]'
                       COLUMNS (
                           type VARCHAR(30) PATH '$.type'
                           )
                ) AS types
                   JOIN card_type ON types.type = card_type.type;

    INSERT INTO sportclub_activity(
        sportclub_id,
        activity_id,
        duration)
    SELECT  @sportclub_id,
            activity_id,
            duration
    FROM    json_table(json_add_sportclub, '$.activities[*]'
                       COLUMNS (
                           activity_name VARCHAR(30)   PATH '$.activity.name',
                           duration      DECIMAL(3, 2) PATH '$.duration'
                           )
                ) AS activities
                   JOIN activity ON activities.activity_name = activity.name;

    COMMIT;
END$$