-- Add exteriorLocked, houseSize, houseType columns to character_housing
-- Idempotent and a no-op on a fresh database: `character_housing` is created (with these
-- columns) by 2026_07_09_00_characters.sql, which the updater applies after this file.
SET @table_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'character_housing');
SET @columns_exist = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'character_housing' AND COLUMN_NAME = 'exteriorLocked');

SET @query = IF(@table_exists = 1 AND @columns_exist = 0,
    'ALTER TABLE `character_housing`
      ADD COLUMN `exteriorLocked` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT ''Whether exterior editing is locked (1=locked, 0=unlocked)'' AFTER `settingsFlags`,
      ADD COLUMN `houseSize` TINYINT UNSIGNED NOT NULL DEFAULT 2 COMMENT ''HousingFixtureSize: 1=Any, 2=Small, 3=Medium, 4=Large'' AFTER `exteriorLocked`,
      ADD COLUMN `houseType` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT ''HouseExteriorWmoData DB2 entry ID (architectural style)'' AFTER `houseSize`',
    'SELECT 1');

PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
