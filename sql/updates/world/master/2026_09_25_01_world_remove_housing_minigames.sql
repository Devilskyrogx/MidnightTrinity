-- Housing: drop the Decor Duels and Going Postal minigame tables. Their server code (DecorDuelMgr,
-- GoingPostalMgr, .decorduel/.postal commands, npc_going_postal) was removed; nothing reads these tables.
DROP TABLE IF EXISTS `decor_duel_template`;
DROP TABLE IF EXISTS `going_postal_route_checkpoint`;
DROP TABLE IF EXISTS `going_postal_route`;
