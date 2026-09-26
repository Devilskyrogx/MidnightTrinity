-- Housing: theme and material of each room component ("componentId:themeId:textureId,..."). Retail changes a single
-- wall/floor/ceiling slot; one value per surface restyled every wall of the room on the next rebuild.
SET @column_exists := (SELECT COUNT(*) FROM `information_schema`.`COLUMNS` WHERE `TABLE_SCHEMA` = DATABASE() AND `TABLE_NAME` = 'character_housing_rooms' AND `COLUMN_NAME` = 'componentStyles');
SET @sql := IF(@column_exists = 0, 'ALTER TABLE `character_housing_rooms` ADD COLUMN `componentStyles` varchar(1024) NOT NULL DEFAULT '''' AFTER `doorTypes`', 'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
