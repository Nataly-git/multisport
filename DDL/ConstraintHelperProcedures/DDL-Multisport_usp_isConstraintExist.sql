USE Multisport;

DELIMITER $$

DROP PROCEDURE IF EXISTS usp_isConstraintExists;

CREATE PROCEDURE usp_isConstraintExists(IN tableName VARCHAR(100),
                                        IN constrName VARCHAR(100),
                                        IN constrType VARCHAR(50),
                                        OUT isStatus INT)
BEGIN
    SELECT COUNT(1)
    INTO isStatus
    FROM information_schema.table_constraints
    WHERE constraint_schema = database()
      AND table_name = tableName
      AND constraint_name = constrName
      AND constraint_type = constrType;
END$$