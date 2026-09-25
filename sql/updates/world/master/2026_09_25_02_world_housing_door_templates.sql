-- Housing entrance GOs referenced by ExteriorComponent.GameObjectID that were missing (retail sniff 12.1.0.69933)
INSERT IGNORE INTO `gameobject_template` (`entry`,`type`,`displayId`,`name`,`size`,`Data0`,`Data3`,`Data10`,`Data23`,`Data31`,`ScriptName`,`VerifiedBuild`) VALUES
(602700, 10, 116972, 'Front Door', 1, 4296, 3000, 1271876, 1, 1, 'go_housing_door', 69933),
(613904, 10, 116980, 'Front Door', 1, 4296, 3000, 1271876, 1, 1, 'go_housing_door', 69933),
(613906, 10, 116982, 'Front Door', 1, 4296, 3000, 1271876, 1, 1, 'go_housing_door', 69933),
(648554, 10, 124218, 'Front Door', 1, 4296, 3000, 1271876, 1, 1, 'go_housing_door', 69933);

UPDATE `gameobject_template` SET `Data10` = 1271876, `ScriptName` = 'go_housing_door' WHERE `entry` IN (602700, 613904, 613906, 648554);
