USE Multisport;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_addUniqueKey;

CREATE PROCEDURE usp_addUniqueKey(IN tableName VARCHAR(100),
                                  IN constrName VARCHAR(100),
                                  IN columnsNames VARCHAR(250))
BEGIN
    CALL usp_isConstraintExists(tableName, constrName, 'unique', @isStatus);

    IF @isStatus = 1 THEN
        CALL usp_deleteUniqueKey(tableName, constrName);
    END IF;

    SET @sqlString :=
            CONCAT('alter table ', tableName, ' add constraint unique key ', constrName, ' (', columnsNames, ');');
    CALL usp_executeStmt(@sqlString);
END$$

DELIMITER ;