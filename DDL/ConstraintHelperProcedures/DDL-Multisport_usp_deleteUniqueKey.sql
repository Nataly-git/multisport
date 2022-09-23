USE Multisport;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_deleteUniqueKey;

CREATE PROCEDURE usp_deleteUniqueKey(IN tableName VARCHAR(100),
                                     IN constrName VARCHAR(100))
BEGIN
    SET @sqlString := CONCAT('alter table ', tableName, ' drop unique ', constrName, ';');
    CALL usp_executeStmt(@sqlString);
END$$