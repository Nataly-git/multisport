USE Multisport;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_AddForeignKey;

CREATE PROCEDURE usp_AddForeignKey(IN tableName VARCHAR(100),
                                   IN constrName VARCHAR(100),
                                   IN columnName VARCHAR(50),
                                   IN refTableName VARCHAR(100),
                                   IN refColumnName VARCHAR(50))
BEGIN
    CALL usp_isConstraintExists(tableName, constrName, 'foreign key', @isStatus);

    IF @isStatus = 1 THEN
        CALL usp_deleteForeignKey(tableName, constrName);
    END IF;

    SET @sqlString := CONCAT('alter table ', tableName, ' add constraint foreign key ', constrName, ' (', columnName,
                             ') references ', refTableName, ' (', refColumnName, ');');
    CALL usp_executeStmt(@sqlString);
END$$

DELIMITER ;