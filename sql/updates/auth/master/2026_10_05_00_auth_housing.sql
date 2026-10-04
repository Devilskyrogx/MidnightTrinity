DELETE FROM `rbac_permissions` WHERE `id` BETWEEN 886 AND 891;
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(886, 'Command: housing set'),
(887, 'Command: housing set level'),
(888, 'Command: housing delete'),
(889, 'Command: housing charter create'),
(890, 'Command: housing charter set'),
(891, 'Command: housing charter delete');

DELETE FROM `rbac_linked_permissions` WHERE `linkedId` BETWEEN 886 AND 891;
INSERT INTO `rbac_linked_permissions` (`id`, `linkedId`) VALUES
(196, 886),
(196, 887),
(196, 888),
(196, 889),
(196, 890),
(196, 891);
