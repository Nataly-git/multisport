USE Multisport;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_parse_json_register_user;

CREATE PROCEDURE usp_parse_json_register_user(IN json_add_user TEXT)

BEGIN
    START TRANSACTION;

    SELECT  time,
            browser,
            ip,
            device,
            email,
            name,
            surname,
            password,
            apartments,
            city,
            street,
            building,
            phone_number
    INTO    @time,
            @browser,
            @ip,
            @device,
            @email,
            @name,
            @surname,
            @password,
            @apartments,
            @city,
            @street,
            @building,
            @phone_number
    FROM    json_table(json_add_user, '$'
                    COLUMNS (
                        time         DATETIME     PATH '$.guest.time',
                        browser      VARCHAR(100) PATH '$.guest.browser',
                        ip           VARCHAR(15)  PATH '$.guest.ipAddress',
                        device       VARCHAR(100) PATH '$.guest.device',
                        email        VARCHAR(254) PATH '$.user.email',
                        name         VARCHAR(100) PATH '$.user.name',
                        surname      VARCHAR(100) PATH '$.user.surname',
                        password     VARCHAR(50)  PATH '$.user.password',
                        apartments   SMALLINT     PATH '$.contacts.apartments',
                        city         VARCHAR(50)  PATH '$.contacts.city',
                        street       VARCHAR(50)  PATH '$.contacts.street',
                        building     SMALLINT     PATH '$.contacts.building',
                        phone_number VARCHAR(20)  PATH '$.contacts.phoneNumber'
                        )
                    ) AS register_info;

    INSERT INTO guest(
            time,
            browser,
            ip,
            device)
    VALUES (@time,
            @browser,
            @ip,
            @device);

    INSERT INTO user(
            email,
            name,
            surname,
            password,
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
            @surname,
            @password,
            cte_guest.guest_id
    FROM    cte_guest;

    SELECT  user_id
    INTO    @user_id
    FROM    user
    WHERE   email=@email;

    INSERT INTO user_contacts(
            user_id,
            apartments,
            city,
            street,
            building,
            phone_number)
    VALUES (@user_id,
            @apartments,
            @city,
            @street,
            @building,
            @phone_number);
    COMMIT;
END$$