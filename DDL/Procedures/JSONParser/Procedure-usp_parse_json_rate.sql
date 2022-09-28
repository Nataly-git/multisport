USE Multisport;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_parse_json_rate;

CREATE PROCEDURE usp_parse_json_rate(IN json_rate text)

BEGIN
    INSERT INTO rating (
            user_id,
            sportclub_id,
            rate,
            comment)
    SELECT  user_id,
            sportclub_id,
            rate,
            comment
    FROM    json_table(json_rate, '$'
                    COLUMNS (
                        rate            TINYINT      PATH '$.rating.rate',
                        comment         VARCHAR(255) PATH '$.rating.comment',
                        user_email      VARCHAR(254) PATH '$.user.email',
                        sportclub_email VARCHAR(100) PATH '$.sportClub.email'
                        )
                    ) AS rate_info
             JOIN sportclub ON rate_info.sportclub_email = sportclub.email
             JOIN user ON rate_info.user_email = user.email;
END$$