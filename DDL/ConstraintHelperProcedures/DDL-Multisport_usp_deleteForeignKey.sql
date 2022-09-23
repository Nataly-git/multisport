USE FoodOrderPlatform;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_deleteForeignKey;

CREATE PROCEDURE usp_deleteForeignKey(IN tableName VARCHAR(100),
                                      IN constrName VARCHAR(100))
BEGIN
    SET @sqlString := CONCAT('alter table ', tableName, ' drop foreign key ', constrName, ';');
    CALL usp_executeStmt(@sqlString);
END$$