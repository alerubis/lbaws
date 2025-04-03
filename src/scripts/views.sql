-- Vista base: boxscore per minuto senza metadati
CREATE VIEW v_player_game_minute_boxscore_base AS
SELECT
  ptgp.player_id,
  ptgp.game_id,
  FLOOR((p.seconds_start + sp.seconds_da_start) / 60) + 1 AS minute,

  COUNT(DISTINCT CASE WHEN sp.player_made_id = ptgp.player_id AND sp.foul_id IS NOT NULL THEN sp.id END) AS fouls_committed,
  COUNT(DISTINCT CASE WHEN sp.player_suffered_id = ptgp.player_id AND sp.foul_id IS NOT NULL THEN sp.id END) AS fouls_received,

  SUM(CASE WHEN sp.player_made_id = ptgp.player_id AND ds.point > 0 AND ds.made_01 = '1' THEN ds.point ELSE 0 END) AS points,

  SUM(CASE WHEN sp.player_made_id = ptgp.player_id AND ds.point = 2 AND ds.made_01 = '1' THEN 1 ELSE 0 END) AS made_2pt,
  SUM(CASE WHEN sp.player_made_id = ptgp.player_id AND ds.point = 2 AND ds.made_01 = '0' THEN 1 ELSE 0 END) AS missed_2pt,
  ROUND(
    SUM(CASE WHEN sp.player_made_id = ptgp.player_id AND ds.point = 2 AND ds.made_01 = '1' THEN 1 ELSE 0 END) * 100.0 /
    NULLIF(SUM(CASE WHEN sp.player_made_id = ptgp.player_id AND ds.point = 2 THEN 1 ELSE 0 END), 0), 1
  ) AS pct_2pt,

  SUM(CASE WHEN sp.player_made_id = ptgp.player_id AND ds.point = 3 AND ds.made_01 = '1' THEN 1 ELSE 0 END) AS made_3pt,
  SUM(CASE WHEN sp.player_made_id = ptgp.player_id AND ds.point = 3 AND ds.made_01 = '0' THEN 1 ELSE 0 END) AS missed_3pt,
  ROUND(
    SUM(CASE WHEN sp.player_made_id = ptgp.player_id AND ds.point = 3 AND ds.made_01 = '1' THEN 1 ELSE 0 END) * 100.0 /
    NULLIF(SUM(CASE WHEN sp.player_made_id = ptgp.player_id AND ds.point = 3 THEN 1 ELSE 0 END), 0), 1
  ) AS pct_3pt,

  SUM(CASE WHEN sp.player_made_id = ptgp.player_id AND ds.point = 1 AND ds.made_01 = '1' THEN 1 ELSE 0 END) AS made_ft,
  SUM(CASE WHEN sp.player_made_id = ptgp.player_id AND ds.point = 1 AND ds.made_01 = '0' THEN 1 ELSE 0 END) AS missed_ft,
  ROUND(
    SUM(CASE WHEN sp.player_made_id = ptgp.player_id AND ds.point = 1 AND ds.made_01 = '1' THEN 1 ELSE 0 END) * 100.0 /
    NULLIF(SUM(CASE WHEN sp.player_made_id = ptgp.player_id AND ds.point = 1 THEN 1 ELSE 0 END), 0), 1
  ) AS pct_ft,

  COUNT(DISTINCT CASE WHEN sp.player_made_id = ptgp.player_id AND sp.rebound_offensive_01 = '1' THEN sp.id END) AS off_reb,
  COUNT(DISTINCT CASE WHEN sp.player_made_id = ptgp.player_id AND sp.rebound_defensive_01 = '1' THEN sp.id END) AS def_reb,

  COUNT(DISTINCT CASE WHEN sp.player_made_id = ptgp.player_id AND sp.blocks_01 = '1' THEN sp.id END) AS blocks_made,
  COUNT(DISTINCT CASE WHEN sp.player_suffered_id = ptgp.player_id AND sp.blocks_01 = '1' THEN sp.id END) AS blocks_suffered,

  COUNT(DISTINCT CASE WHEN sp.player_made_id = ptgp.player_id AND sp.turnover_id IS NOT NULL THEN sp.id END) AS turnovers,
  COUNT(DISTINCT CASE WHEN sp.player_suffered_id = ptgp.player_id AND sp.turnover_id IS NOT NULL THEN sp.id END) AS steals,

  COUNT(DISTINCT CASE WHEN sp.player_made_id = ptgp.player_id AND sp.assist_01 = '1' THEN sp.id END) AS assists

FROM
  player_team_game_play ptgp
JOIN play p ON p.id = ptgp.play_id
JOIN sub_play sp 
  ON sp.play_id = p.id
  AND (sp.player_made_id = ptgp.player_id OR sp.player_suffered_id = ptgp.player_id)
LEFT JOIN dz_shot ds ON ds.id = sp.shot_id

WHERE sp.seconds_da_start IS NOT NULL

GROUP BY
  ptgp.player_id,
  ptgp.game_id,
  minute;



-- Vista v_player_game_minute_boxscore aggiornata con league_id
CREATE VIEW v_player_game_minute_boxscore AS
SELECT
  base.player_id,
  base.game_id,
  base.minute,
  base.fouls_committed,
  base.fouls_received,
  base.points,
  base.made_2pt,
  base.missed_2pt,
  base.pct_2pt,
  base.made_3pt,
  base.missed_3pt,
  base.pct_3pt,
  base.made_ft,
  base.missed_ft,
  base.pct_ft,
  base.off_reb,
  base.def_reb,
  base.blocks_made,
  base.blocks_suffered,
  base.turnovers,
  base.steals,
  base.assists,
  t.id AS team_id,
  g.type_game_id,
  g.league_year_id,
  ly.league_id
FROM v_player_game_minute_boxscore_base base
JOIN game g ON g.id = base.game_id
JOIN league_year ly ON ly.id = g.league_year_id
JOIN player pl ON pl.id = base.player_id
JOIN player_team_game ptg ON ptg.player_id = base.player_id AND ptg.game_id = base.game_id
JOIN team t ON t.id = ptg.team_id;




-- Vista aggregata per minuto assoluto (1–10, 2–11–21–31, ecc.)
CREATE VIEW v_player_game_absolute_minute_boxscore AS
SELECT
  base.player_id,
  base.game_id,
  base.team_id,
  base.type_game_id,
  base.league_year_id,
  base.league_id,
  base.absolute_minute,

  SUM(base.fouls_committed) AS fouls_committed,
  SUM(base.fouls_received) AS fouls_received,
  SUM(base.points) AS points,
  SUM(base.made_2pt) AS made_2pt,
  SUM(base.missed_2pt) AS missed_2pt,
  ROUND(SUM(base.made_2pt) * 100.0 / NULLIF(SUM(base.made_2pt + base.missed_2pt), 0), 1) AS pct_2pt,
  SUM(base.made_3pt) AS made_3pt,
  SUM(base.missed_3pt) AS missed_3pt,
  ROUND(SUM(base.made_3pt) * 100.0 / NULLIF(SUM(base.made_3pt + base.missed_3pt), 0), 1) AS pct_3pt,
  SUM(base.made_ft) AS made_ft,
  SUM(base.missed_ft) AS missed_ft,
  ROUND(SUM(base.made_ft) * 100.0 / NULLIF(SUM(base.made_ft + base.missed_ft), 0), 1) AS pct_ft,
  SUM(base.off_reb) AS off_reb,
  SUM(base.def_reb) AS def_reb,
  SUM(base.blocks_made) AS blocks_made,
  SUM(base.blocks_suffered) AS blocks_suffered,
  SUM(base.turnovers) AS turnovers,
  SUM(base.steals) AS steals,
  SUM(base.assists) AS assists
FROM (
  SELECT
    *,
    ((minute - 1) % 10) + 1 AS absolute_minute
  FROM v_player_game_minute_boxscore
) AS base
GROUP BY
  base.player_id,
  base.game_id,
  base.team_id,
  base.type_game_id,
  base.league_year_id,
  base.league_id,
  base.absolute_minute;

  

-- Vista aggregata per partita intera
CREATE VIEW v_player_game_total_boxscore AS
SELECT
  player_id,
  game_id,
  team_id,
  type_game_id,
  league_year_id,
  league_id,

  SUM(fouls_committed) AS fouls_committed,
  SUM(fouls_received) AS fouls_received,
  SUM(points) AS points,
  SUM(made_2pt) AS made_2pt,
  SUM(missed_2pt) AS missed_2pt,
  ROUND(SUM(made_2pt) * 100.0 / NULLIF(SUM(made_2pt + missed_2pt), 0), 1) AS pct_2pt,
  SUM(made_3pt) AS made_3pt,
  SUM(missed_3pt) AS missed_3pt,
  ROUND(SUM(made_3pt) * 100.0 / NULLIF(SUM(made_3pt + missed_3pt), 0), 1) AS pct_3pt,
  SUM(made_ft) AS made_ft,
  SUM(missed_ft) AS missed_ft,
  ROUND(SUM(made_ft) * 100.0 / NULLIF(SUM(made_ft + missed_ft), 0), 1) AS pct_ft,
  SUM(off_reb) AS off_reb,
  SUM(def_reb) AS def_reb,
  SUM(blocks_made) AS blocks_made,
  SUM(blocks_suffered) AS blocks_suffered,
  SUM(turnovers) AS turnovers,
  SUM(steals) AS steals,
  SUM(assists) AS assists
FROM v_player_game_minute_boxscore
GROUP BY
  player_id,
  game_id,
  team_id,
  type_game_id,
  league_year_id,
  league_id;


-- Vista aggregata per media per stagione
CREATE VIEW v_player_season_avg_boxscore AS
SELECT
  player_id,
  team_id,
  league_year_id,
  league_id,
  COUNT(DISTINCT game_id) AS games,
  ROUND(SUM(fouls_committed) / COUNT(DISTINCT game_id), 2) AS fouls_committed,
  ROUND(SUM(fouls_received) / COUNT(DISTINCT game_id), 2) AS fouls_received,
  ROUND(SUM(points) / COUNT(DISTINCT game_id), 2) AS points,
  ROUND(SUM(made_2pt) / COUNT(DISTINCT game_id), 2) AS made_2pt,
  ROUND(SUM(missed_2pt) / COUNT(DISTINCT game_id), 2) AS missed_2pt,
  ROUND(SUM(made_2pt) * 100.0 / NULLIF(SUM(made_2pt + missed_2pt), 0), 1) AS pct_2pt,
  ROUND(SUM(made_3pt) / COUNT(DISTINCT game_id), 2) AS made_3pt,
  ROUND(SUM(missed_3pt) / COUNT(DISTINCT game_id), 2) AS missed_3pt,
  ROUND(SUM(made_3pt) * 100.0 / NULLIF(SUM(made_3pt + missed_3pt), 0), 1) AS pct_3pt,
  ROUND(SUM(made_ft) / COUNT(DISTINCT game_id), 2) AS made_ft,
  ROUND(SUM(missed_ft) / COUNT(DISTINCT game_id), 2) AS missed_ft,
  ROUND(SUM(made_ft) * 100.0 / NULLIF(SUM(made_ft + missed_ft), 0), 1) AS pct_ft,
  ROUND(SUM(off_reb) / COUNT(DISTINCT game_id), 2) AS off_reb,
  ROUND(SUM(def_reb) / COUNT(DISTINCT game_id), 2) AS def_reb,
  ROUND(SUM(blocks_made) / COUNT(DISTINCT game_id), 2) AS blocks_made,
  ROUND(SUM(blocks_suffered) / COUNT(DISTINCT game_id), 2) AS blocks_suffered,
  ROUND(SUM(turnovers) / COUNT(DISTINCT game_id), 2) AS turnovers,
  ROUND(SUM(steals) / COUNT(DISTINCT game_id), 2) AS steals,
  ROUND(SUM(assists) / COUNT(DISTINCT game_id), 2) AS assists
FROM v_player_game_total_boxscore
GROUP BY
  player_id,
  team_id,
  league_year_id,
  league_id;

-- Vista aggregata per media per stagione e tipo partita
CREATE VIEW v_player_season_game_type_avg_boxscore AS
SELECT
  player_id,
  player_name,
  player_surname,
  team_id,
  league_year_id,
  league_id,
  type_game_id,
  COUNT(DISTINCT game_id) AS games,
  ROUND(SUM(fouls_committed) / COUNT(DISTINCT game_id), 2) AS fouls_committed,
  ROUND(SUM(fouls_received) / COUNT(DISTINCT game_id), 2) AS fouls_received,
  ROUND(SUM(points) / COUNT(DISTINCT game_id), 2) AS points,
  ROUND(SUM(made_2pt) / COUNT(DISTINCT game_id), 2) AS made_2pt,
  ROUND(SUM(missed_2pt) / COUNT(DISTINCT game_id), 2) AS missed_2pt,
  ROUND(SUM(made_2pt) * 100.0 / NULLIF(SUM(made_2pt + missed_2pt), 0), 1) AS pct_2pt,
  ROUND(SUM(made_3pt) / COUNT(DISTINCT game_id), 2) AS made_3pt,
  ROUND(SUM(missed_3pt) / COUNT(DISTINCT game_id), 2) AS missed_3pt,
  ROUND(SUM(made_3pt) * 100.0 / NULLIF(SUM(made_3pt + missed_3pt), 0), 1) AS pct_3pt,
  ROUND(SUM(made_ft) / COUNT(DISTINCT game_id), 2) AS made_ft,
  ROUND(SUM(missed_ft) / COUNT(DISTINCT game_id), 2) AS missed_ft,
  ROUND(SUM(made_ft) * 100.0 / NULLIF(SUM(made_ft + missed_ft), 0), 1) AS pct_ft,
  ROUND(SUM(off_reb) / COUNT(DISTINCT game_id), 2) AS off_reb,
  ROUND(SUM(def_reb) / COUNT(DISTINCT game_id), 2) AS def_reb,
  ROUND(SUM(blocks_made) / COUNT(DISTINCT game_id), 2) AS blocks_made,
  ROUND(SUM(blocks_suffered) / COUNT(DISTINCT game_id), 2) AS blocks_suffered,
  ROUND(SUM(turnovers) / COUNT(DISTINCT game_id), 2) AS turnovers,
  ROUND(SUM(steals) / COUNT(DISTINCT game_id), 2) AS steals,
  ROUND(SUM(assists) / COUNT(DISTINCT game_id), 2) AS assists
FROM v_player_game_total_boxscore
GROUP BY
  player_id,
  team_id,
  league_year_id,
  league_id,
  type_game_id;

CREATE VIEW v_team_game_minute_boxscore AS
SELECT
  team_id,
  game_id,
  minute,
  type_game_id,
  league_year_id,
  league_id,

  SUM(fouls_committed) AS fouls_committed,
  SUM(fouls_received) AS fouls_received,
  SUM(points) AS points,

  SUM(made_2pt) AS made_2pt,
  SUM(missed_2pt) AS missed_2pt,
  ROUND(SUM(made_2pt) * 100.0 / NULLIF(SUM(made_2pt + missed_2pt), 0), 1) AS pct_2pt,

  SUM(made_3pt) AS made_3pt,
  SUM(missed_3pt) AS missed_3pt,
  ROUND(SUM(made_3pt) * 100.0 / NULLIF(SUM(made_3pt + missed_3pt), 0), 1) AS pct_3pt,

  SUM(made_ft) AS made_ft,
  SUM(missed_ft) AS missed_ft,
  ROUND(SUM(made_ft) * 100.0 / NULLIF(SUM(made_ft + missed_ft), 0), 1) AS pct_ft,

  SUM(off_reb) AS off_reb,
  SUM(def_reb) AS def_reb,

  SUM(blocks_made) AS blocks_made,
  SUM(blocks_suffered) AS blocks_suffered,

  SUM(turnovers) AS turnovers,
  SUM(steals) AS steals,
  SUM(assists) AS assists

FROM v_player_game_minute_boxscore
GROUP BY team_id, game_id, minute, type_game_id, league_year_id, league_id;

CREATE VIEW v_team_game_absolute_minute_boxscore AS
SELECT
  team_id,
  game_id,
  type_game_id,
  league_year_id,
  league_id,
  absolute_minute,

  SUM(fouls_committed) AS fouls_committed,
  SUM(fouls_received) AS fouls_received,
  SUM(points) AS points,
  SUM(made_2pt) AS made_2pt,
  SUM(missed_2pt) AS missed_2pt,
  ROUND(SUM(made_2pt) * 100.0 / NULLIF(SUM(made_2pt + missed_2pt), 0), 1) AS pct_2pt,
  SUM(made_3pt) AS made_3pt,
  SUM(missed_3pt) AS missed_3pt,
  ROUND(SUM(made_3pt) * 100.0 / NULLIF(SUM(made_3pt + missed_3pt), 0), 1) AS pct_3pt,
  SUM(made_ft) AS made_ft,
  SUM(missed_ft) AS missed_ft,
  ROUND(SUM(made_ft) * 100.0 / NULLIF(SUM(made_ft + missed_ft), 0), 1) AS pct_ft,
  SUM(off_reb) AS off_reb,
  SUM(def_reb) AS def_reb,
  SUM(blocks_made) AS blocks_made,
  SUM(blocks_suffered) AS blocks_suffered,
  SUM(turnovers) AS turnovers,
  SUM(steals) AS steals,
  SUM(assists) AS assists

FROM (
  SELECT
    *,
    ((minute - 1) % 10) + 1 AS absolute_minute
  FROM v_team_game_minute_boxscore
) AS base
GROUP BY
  team_id,
  game_id,
  type_game_id,
  league_year_id,
  league_id,
  absolute_minute;

CREATE VIEW v_team_game_total_boxscore AS
SELECT
  team_id,
  game_id,
  type_game_id,
  league_year_id,
  league_id,

  SUM(fouls_committed) AS fouls_committed,
  SUM(fouls_received) AS fouls_received,
  SUM(points) AS points,
  SUM(made_2pt) AS made_2pt,
  SUM(missed_2pt) AS missed_2pt,
  ROUND(SUM(made_2pt) * 100.0 / NULLIF(SUM(made_2pt + missed_2pt), 0), 1) AS pct_2pt,
  SUM(made_3pt) AS made_3pt,
  SUM(missed_3pt) AS missed_3pt,
  ROUND(SUM(made_3pt) * 100.0 / NULLIF(SUM(made_3pt + missed_3pt), 0), 1) AS pct_3pt,
  SUM(made_ft) AS made_ft,
  SUM(missed_ft) AS missed_ft,
  ROUND(SUM(made_ft) * 100.0 / NULLIF(SUM(made_ft + missed_ft), 0), 1) AS pct_ft,
  SUM(off_reb) AS off_reb,
  SUM(def_reb) AS def_reb,
  SUM(blocks_made) AS blocks_made,
  SUM(blocks_suffered) AS blocks_suffered,
  SUM(turnovers) AS turnovers,
  SUM(steals) AS steals,
  SUM(assists) AS assists

FROM v_team_game_minute_boxscore
GROUP BY
  team_id,
  game_id,
  type_game_id,
  league_year_id,
  league_id;

 
 CREATE VIEW v_team_season_avg_boxscore AS
SELECT
  team_id,
  league_year_id,
  league_id,
  COUNT(DISTINCT game_id) AS games,

  ROUND(SUM(fouls_committed) / COUNT(DISTINCT game_id), 2) AS fouls_committed,
  ROUND(SUM(fouls_received) / COUNT(DISTINCT game_id), 2) AS fouls_received,
  ROUND(SUM(points) / COUNT(DISTINCT game_id), 2) AS points,
  ROUND(SUM(made_2pt) / COUNT(DISTINCT game_id), 2) AS made_2pt,
  ROUND(SUM(missed_2pt) / COUNT(DISTINCT game_id), 2) AS missed_2pt,
  ROUND(SUM(made_2pt) * 100.0 / NULLIF(SUM(made_2pt + missed_2pt), 0), 1) AS pct_2pt,
  ROUND(SUM(made_3pt) / COUNT(DISTINCT game_id), 2) AS made_3pt,
  ROUND(SUM(missed_3pt) / COUNT(DISTINCT game_id), 2) AS missed_3pt,
  ROUND(SUM(made_3pt) * 100.0 / NULLIF(SUM(made_3pt + missed_3pt), 0), 1) AS pct_3pt,
  ROUND(SUM(made_ft) / COUNT(DISTINCT game_id), 2) AS made_ft,
  ROUND(SUM(missed_ft) / COUNT(DISTINCT game_id), 2) AS missed_ft,
  ROUND(SUM(made_ft) * 100.0 / NULLIF(SUM(made_ft + missed_ft), 0), 1) AS pct_ft,
  ROUND(SUM(off_reb) / COUNT(DISTINCT game_id), 2) AS off_reb,
  ROUND(SUM(def_reb) / COUNT(DISTINCT game_id), 2) AS def_reb,
  ROUND(SUM(blocks_made) / COUNT(DISTINCT game_id), 2) AS blocks_made,
  ROUND(SUM(blocks_suffered) / COUNT(DISTINCT game_id), 2) AS blocks_suffered,
  ROUND(SUM(turnovers) / COUNT(DISTINCT game_id), 2) AS turnovers,
  ROUND(SUM(steals) / COUNT(DISTINCT game_id), 2) AS steals,
  ROUND(SUM(assists) / COUNT(DISTINCT game_id), 2) AS assists

FROM v_team_game_total_boxscore
GROUP BY
  team_id,
  league_year_id,
  league_id;

 CREATE VIEW v_team_season_game_type_avg_boxscore AS
SELECT
  team_id,
  league_year_id,
  league_id,
  type_game_id,
  COUNT(DISTINCT game_id) AS games,

  ROUND(SUM(fouls_committed) / COUNT(DISTINCT game_id), 2) AS fouls_committed,
  ROUND(SUM(fouls_received) / COUNT(DISTINCT game_id), 2) AS fouls_received,
  ROUND(SUM(points) / COUNT(DISTINCT game_id), 2) AS points,
  ROUND(SUM(made_2pt) / COUNT(DISTINCT game_id), 2) AS made_2pt,
  ROUND(SUM(missed_2pt) / COUNT(DISTINCT game_id), 2) AS missed_2pt,
  ROUND(SUM(made_2pt) * 100.0 / NULLIF(SUM(made_2pt + missed_2pt), 0), 1) AS pct_2pt,
  ROUND(SUM(made_3pt) / COUNT(DISTINCT game_id), 2) AS made_3pt,
  ROUND(SUM(missed_3pt) / COUNT(DISTINCT game_id), 2) AS missed_3pt,
  ROUND(SUM(made_3pt) * 100.0 / NULLIF(SUM(made_3pt + missed_3pt), 0), 1) AS pct_3pt,
  ROUND(SUM(made_ft) / COUNT(DISTINCT game_id), 2) AS made_ft,
  ROUND(SUM(missed_ft) / COUNT(DISTINCT game_id), 2) AS missed_ft,
  ROUND(SUM(made_ft) * 100.0 / NULLIF(SUM(made_ft + missed_ft), 0), 1) AS pct_ft,
  ROUND(SUM(off_reb) / COUNT(DISTINCT game_id), 2) AS off_reb,
  ROUND(SUM(def_reb) / COUNT(DISTINCT game_id), 2) AS def_reb,
  ROUND(SUM(blocks_made) / COUNT(DISTINCT game_id), 2) AS blocks_made,
  ROUND(SUM(blocks_suffered) / COUNT(DISTINCT game_id), 2) AS blocks_suffered,
  ROUND(SUM(turnovers) / COUNT(DISTINCT game_id), 2) AS turnovers,
  ROUND(SUM(steals) / COUNT(DISTINCT game_id), 2) AS steals,
  ROUND(SUM(assists) / COUNT(DISTINCT game_id), 2) AS assists

FROM v_team_game_total_boxscore
GROUP BY
  team_id,
  league_year_id,
  league_id,
  type_game_id;


INSERT INTO player_team_game_play(player_id, team_id, game_id, play_id, seconds_start, seconds_end) VALUES(1592, 1658, 24666, 1681, 744, 752);
INSERT INTO lba.sub_play (play_id, seconds_da_start, player_made_id, team_made_id, game_made_id, player_suffered_id, team_suffered_id, game_suffered_id, shot_id, turnover_id, foul_id, rebound_defensive_01, rebound_offensive_01, assist_01, blocks_01, time_out_01, x, y)VALUES(1681, 8, 6309, 1651, 24666, 1592, 1658, 24666, NULL, NULL, 4, '', '', '', '', '', 92, 53);
INSERT INTO player_team_game_play(player_id, team_id, game_id, play_id, seconds_start, seconds_end) VALUES(7440, 1660, 24828, 25770, 1972, 1972);
INSERT INTO lba.sub_play (play_id, seconds_da_start, player_made_id, team_made_id, game_made_id, player_suffered_id, team_suffered_id, game_suffered_id, shot_id, turnover_id, foul_id, rebound_defensive_01, rebound_offensive_01, assist_01, blocks_01, time_out_01, x, y)VALUES(25770, 0, 7440, 1660, 24828, NULL, NULL, NULL, NULL, NULL, 2, '', '', '', '', '', 33, 56);