-- Add houseName and houseDescription columns to character_housing
-- Idempotent and a no-op on a fresh database: `character_housing` is created (with these
-- columns) by 2026_07_09_00_characters.sql, which the updater applies after this file.
SET @table_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'character_housing');
SET @columns_exist = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'character_housing' AND COLUMN_NAME = 'houseName');

SET @query = IF(@table_exists = 1 AND @columns_exist = 0,
    'ALTER TABLE `character_housing`
      ADD COLUMN `houseName` VARCHAR(64) NOT NULL DEFAULT '''' COMMENT ''Player-set house display name'' AFTER `facing`,
      ADD COLUMN `houseDescription` VARCHAR(256) NOT NULL DEFAULT '''' COMMENT ''Player-set house description'' AFTER `houseName`',
    'SELECT 1');

PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
