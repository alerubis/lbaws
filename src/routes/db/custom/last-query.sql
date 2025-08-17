
    SELECT *
    FROM (
      
SELECT
  team_id,
  game_id,
  type_game_id,
  league_year_id,
  league_id,

  CAST(SUM(fouls_committed) AS DECIMAL(10,0)) AS fouls_committed,
  CAST(SUM(fouls_received) AS DECIMAL(10,0)) AS fouls_received,
  CAST(SUM(points) AS DECIMAL(10,0)) AS points,
  CAST(SUM(made_2pt) AS DECIMAL(10,0)) AS made_2pt,
  CAST(SUM(missed_2pt) AS DECIMAL(10,0)) AS missed_2pt,
  CAST(ROUND(SUM(made_2pt) * 100.0 / NULLIF(SUM(made_2pt + missed_2pt), 0), 1) AS DECIMAL(10,0)) AS pct_2pt,
  CAST(SUM(made_3pt) AS DECIMAL(10,0)) AS made_3pt,
  CAST(SUM(missed_3pt) AS DECIMAL(10,0)) AS missed_3pt,
  CAST(ROUND(SUM(made_3pt) * 100.0 / NULLIF(SUM(made_3pt + missed_3pt), 0), 1) AS DECIMAL(10,0)) AS pct_3pt,
  CAST(SUM(made_ft) AS DECIMAL(10,0)) AS made_ft,
  CAST(SUM(missed_ft) AS DECIMAL(10,0)) AS missed_ft,
  CAST(ROUND(SUM(made_ft) * 100.0 / NULLIF(SUM(made_ft + missed_ft), 0), 1) AS DECIMAL(10,0)) AS pct_ft,
  CAST(SUM(off_reb) AS DECIMAL(10,0)) AS off_reb,
  CAST(SUM(def_reb) AS DECIMAL(10,0)) AS def_reb,
  CAST(SUM(blocks_made) AS DECIMAL(10,0)) AS blocks_made,
  CAST(SUM(blocks_suffered) AS DECIMAL(10,0)) AS blocks_suffered,
  CAST(SUM(turnovers) AS DECIMAL(10,0)) AS turnovers,
  CAST(SUM(steals) AS DECIMAL(10,0)) AS steals,
  CAST(SUM(assists) AS DECIMAL(10,0)) AS assists

FROM (
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

FROM (
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
FROM (
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
JOIN (
    SELECT sp.*
    FROM sub_play sp
    JOIN play p ON p.id = sp.play_id
    WHERE (
      SELECT COUNT(DISTINCT ptgp.player_id)
      FROM player_team_game_play ptgp
      WHERE ptgp.play_id = sp.play_id
        AND ptgp.player_id IN (3176,5150,6138,7015,7406)
        AND ptgp.seconds_start <= (p.seconds_start + sp.seconds_da_start)
        AND (p.seconds_start + sp.seconds_da_start) <= ptgp.seconds_end
    ) = 5
  ) sp 
  ON sp.play_id = p.id
  AND (sp.player_made_id = ptgp.player_id OR sp.player_suffered_id = ptgp.player_id)
LEFT JOIN dz_shot ds ON ds.id = sp.shot_id

WHERE sp.seconds_da_start IS NOT NULL

GROUP BY
  ptgp.player_id,
  ptgp.game_id,
  minute
) base
JOIN game g ON g.id = base.game_id
JOIN league_year ly ON ly.id = g.league_year_id
JOIN player pl ON pl.id = base.player_id
JOIN player_team_game ptg ON ptg.player_id = base.player_id AND ptg.game_id = base.game_id
JOIN team t ON t.id = ptg.team_id
) v_player_game_minute_boxscore
GROUP BY team_id, game_id, minute, type_game_id, league_year_id, league_id
) v_team_game_minute_boxscore
GROUP BY
  team_id,
  game_id,
  type_game_id,
  league_year_id,
  league_id

    ) AS filtered_boxscore
    WHERE 
    game_id IN (25010) AND team_id = 1646
  