-- Housing: spell 1234193 "Leave House" (cast by the interior door) takes the player out to the plot
DELETE FROM `spell_script_names` WHERE `spell_id` = 1234193 AND `ScriptName` = 'spell_housing_leave_house';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(1234193, 'spell_housing_leave_house');
