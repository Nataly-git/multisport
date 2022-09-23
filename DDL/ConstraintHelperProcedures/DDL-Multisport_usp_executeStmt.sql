USE Multisport;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_executeStmt;

CREATE PROCEDURE usp_executeStmt(IN sqlString text)
BEGIN
    SET @sqlQuery := sqlString;
    PREPARE stmt FROM @sqlQuery;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DELIMITER ;