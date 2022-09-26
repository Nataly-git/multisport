USE Multisport;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_parse_json_add_user;

CREATE PROCEDURE usp_parse_json_add_user(IN json_add_user text)

BEGIN
    SELECT time,
           browser,
           ip,
           device
    INTO @time,
        @browser,
        @ip,
        @device
    FROM json_table(json_add_user, '$'
                    COLUMNS (
                        time DATETIME PATH '$.guest.time',
                        browser VARCHAR(100) PATH '$.guest.browser',
                        ip VARCHAR(15) PATH '$.guest.ipAddress',
                        device VARCHAR(100) PATH '$.guest.device'
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
           surname,
           password
    INTO @email,
        @name,
        @surname,
        @password
    FROM json_table(json_add_user, '$'
                    COLUMNS (
                        email VARCHAR(254) PATH '$.user.email',
                        name VARCHAR(100) PATH '$.user.name',
                        surname VARCHAR(100) PATH '$.user.surname',
                        password VARCHAR(50) PATH '$.user.password'
                        )
             ) AS user;

    INSERT INTO user
    (email,
     name,
     surname,
     password,
     guest_id)
    VALUES (@email,
            @name,
            @surname,
            @password,
            @guest_id);

    SELECT LAST_INSERT_ID() INTO @user_id;

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
    FROM json_table(json_add_user, '$'
                    COLUMNS (
                        apartments SMALLINT PATH '$.contacts.apartments',
                        city VARCHAR(50) PATH '$.contacts.city',
                        street VARCHAR(50) PATH '$.contacts.street',
                        building SMALLINT PATH '$.contacts.building',
                        phone_number VARCHAR(20) PATH '$.contacts.phoneNumber'
                        )
             ) AS user_contacts;

    INSERT INTO user_contacts
    (user_id,
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
END$$