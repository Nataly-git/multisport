USE FoodOrderPlatform;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_addIndex;

CREATE PROCEDURE usp_addIndex(IN tableName VARCHAR(100),
                              IN indexName VARCHAR(100),
                              IN columnName VARCHAR(50))
BEGIN
    CALL usp_isIndexExists(tableName, indexName, @isStatus);

    IF @isStatus = 1 THEN
        CALL usp_deleteIndex(tableName, indexName);
    END IF;

    SET @sqlString := CONCAT('alter table ', tableName, ' add index ', indexName, ' (', columnName, ');');
    CALL usp_executeStmt(@sqlString);
END$$