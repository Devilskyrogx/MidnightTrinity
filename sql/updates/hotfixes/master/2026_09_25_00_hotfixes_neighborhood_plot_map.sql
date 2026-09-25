--
-- Housing: fix swapped NeighborhoodMapID in `neighborhood_plot`.
--
-- 2026_07_09_00_hotfixes.sql reseeded `neighborhood_map` with the client numbering (ID 1 -> map 2735 Alliance,
-- ID 2 -> map 2736 Horde) but kept the `neighborhood_plot` rows from the older, swapped seed ("55 plots for
-- NeighborhoodMapID=1 (Horde), 55 for NeighborhoodMapID=2 (Alliance)"). HousingMap::SpawnPlotGameObjects looks
-- plots up by the neighborhood's NeighborhoodMapID, so each faction's neighborhood spawned the other faction's
-- cornerstones at the other map's coordinates and no plot could be bought.
--
-- Apart from NeighborhoodMapID these 114 rows already equal NeighborhoodPlot.db2 of build 12.1.0.69933; the IDs
-- below come from that table. Explicit ID lists keep this safe to re-run.
--

-- Founder's Point (map 2735, Alliance): 55 plots
UPDATE `neighborhood_plot` SET `NeighborhoodMapID` = 1 WHERE `ID` IN (
    417, 418, 419, 420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430,
    431, 432, 433, 434, 435, 436, 437, 438, 439, 440, 441, 442, 443, 444,
    445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458,
    459, 460, 461, 462, 463, 464, 465, 466, 467, 468, 469, 470, 471);

-- Razorwind Shores (map 2736, Horde): 55 plots
UPDATE `neighborhood_plot` SET `NeighborhoodMapID` = 2 WHERE `ID` IN (
    359, 360, 361, 362, 363, 364, 365, 366, 367, 368, 369, 370, 371, 372,
    373, 374, 375, 376, 377, 378, 379, 380, 381, 382, 383, 384, 385, 386,
    387, 388, 389, 390, 391, 392, 393, 394, 395, 396, 397, 398, 399, 400,
    401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413);
