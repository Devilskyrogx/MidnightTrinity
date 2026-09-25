-- Add source tracking columns to character_housing_decor and character_housing_catalog
-- SourceType: DecorSourceType enum (0=Standard, 3=Deferred, 5=Spell, 6=Item)
-- SourceValue: Context string (spell ID, item GUID, etc.)
--
-- Idempotent and a no-op on a fresh database: both tables are created (with these columns)
-- by 2026_07_09_00_characters.sql, which the updater applies after this file.

SET @table_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'character_housing_decor');
SET @columns_exist = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'character_housing_decor' AND COLUMN_NAME = 'sourceType');

SET @query = IF(@table_exists = 1 AND @columns_exist = 0,
    'ALTER TABLE `character_housing_decor`
        ADD COLUMN `sourceType` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT ''DecorSourceType: 0=Standard, 3=Deferred, 5=Spell, 6=Item'' AFTER `placementTime`,
        ADD COLUMN `sourceValue` VARCHAR(128) NOT NULL DEFAULT '''' COMMENT ''Source context (spell ID, item GUID, etc.)'' AFTER `sourceType`',
    'SELECT 1');

PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @table_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'character_housing_catalog');
SET @columns_exist = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'character_housing_catalog' AND COLUMN_NAME = 'sourceType');

SET @query = IF(@table_exists = 1 AND @columns_exist = 0,
    'ALTER TABLE `character_housing_catalog`
        ADD COLUMN `sourceType` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT ''DecorSourceType: 0=Standard, 3=Deferred, 5=Spell, 6=Item'' AFTER `acquiredTime`,
        ADD COLUMN `sourceValue` VARCHAR(128) NOT NULL DEFAULT '''' COMMENT ''Source context (spell ID, item GUID, etc.)'' AFTER `sourceType`',
    'SELECT 1');

PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
