-- Add house position persistence columns to character_housing (idempotent)
-- No-op on a fresh database: `character_housing` is created (with these columns) by
-- 2026_07_09_00_characters.sql, which the updater applies after this file.
SET @table_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'character_housing');
SET @columns_exist = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'character_housing' AND COLUMN_NAME = 'posX');

SET @query = IF(@table_exists = 1 AND @columns_exist = 0,
    'ALTER TABLE `character_housing`
      ADD COLUMN `posX` FLOAT NOT NULL DEFAULT 0 COMMENT ''House X position on plot'' AFTER `houseType`,
      ADD COLUMN `posY` FLOAT NOT NULL DEFAULT 0 COMMENT ''House Y position on plot'' AFTER `posX`,
      ADD COLUMN `posZ` FLOAT NOT NULL DEFAULT 0 COMMENT ''House Z position on plot'' AFTER `posY`,
      ADD COLUMN `facing` FLOAT NOT NULL DEFAULT 0 COMMENT ''House facing angle on plot'' AFTER `posZ`',
    'SELECT 1');

PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
