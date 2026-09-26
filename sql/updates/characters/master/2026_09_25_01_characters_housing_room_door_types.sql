-- Housing: doorway style per door ("componentId:variant,..."). A room has several doors and both sides of a
-- connection must agree; the single doorTypeId/doorSlot pair could hold only one door per room.
SET @column_exists := (SELECT COUNT(*) FROM `information_schema`.`COLUMNS` WHERE `TABLE_SCHEMA` = DATABASE() AND `TABLE_NAME` = 'character_housing_rooms' AND `COLUMN_NAME` = 'doorTypes');
SET @sql := IF(@column_exists = 0, 'ALTER TABLE `character_housing_rooms` ADD COLUMN `doorTypes` varchar(255) NOT NULL DEFAULT '''' AFTER `ceilingThemeId`', 'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
