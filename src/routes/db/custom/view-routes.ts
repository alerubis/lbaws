import { dz_shot } from '.prisma/client';
import { PrismaClient } from '@prisma/client';
import express from 'express';
import { wrapAsync } from '../../../shared/functions';
import { JSend } from '../../../shared/jsend';
import path from 'path';
import fs from 'fs';

const prisma = new PrismaClient();
const router = express.Router();
async function getGetItems(req: any): Promise<any[]> {
  const { player_id, team_id, game_ids, view, playerIn, playerNotIn, stresView } = req.body;
  if (!view || !Array.isArray(game_ids) || game_ids.length === 0) {
    throw new Error('Parametri mancanti o errati: game_ids');
  }

  let sub_play = '';
  if (playerIn.length > 0) {
    sub_play = `
    SELECT sp.*
    FROM sub_play sp
    JOIN play p ON p.id = sp.play_id
    WHERE (
      SELECT COUNT(DISTINCT ptgp.player_id)
      FROM player_team_game_play ptgp
      WHERE ptgp.play_id = sp.play_id
        AND ptgp.player_id IN (${playerIn.join(',')})
        AND ptgp.seconds_start <= (p.seconds_start + sp.seconds_da_start)
        AND (p.seconds_start + sp.seconds_da_start) <= ptgp.seconds_end
    ) = ${playerIn.length}
  `;

    if (playerNotIn.length > 0) {
      sub_play += `
      AND (
        SELECT COUNT(DISTINCT ptgp.player_id)
        FROM player_team_game_play ptgp
        WHERE ptgp.play_id = sp.play_id
          AND ptgp.player_id IN (${playerNotIn.join(',')})
          AND ptgp.seconds_start <= (p.seconds_start + sp.seconds_da_start)
          AND (p.seconds_start + sp.seconds_da_start) <= ptgp.seconds_end
        ) = 0
    `;
    }
  }
  else {
    if (playerNotIn.length > 0) {
      sub_play = `
      SELECT sp.*
      FROM sub_play sp
      JOIN play p ON p.id = sp.play_id
      WHERE (
        SELECT COUNT(DISTINCT ptgp.player_id)
        FROM player_team_game_play ptgp
        WHERE ptgp.play_id = sp.play_id
          AND ptgp.player_id IN (${playerNotIn.join(',')})
          AND ptgp.seconds_start <= (p.seconds_start + sp.seconds_da_start)
          AND (p.seconds_start + sp.seconds_da_start) <= ptgp.seconds_end
        ) = 0
    `;
    }
    else {
      sub_play = `
      SELECT sp.*
      FROM sub_play sp
      `;
    }
  }

  let minuteStres = 'FLOOR((p.seconds_start + sp.seconds_da_start) / 60) + 1 AS minute';
  if (stresView) {
    minuteStres = 'GREATEST(1, LEAST(40, FLOOR(((FLOOR((p.seconds_start + sp.seconds_da_start) / 60) / 2.0) + 1) * ((20 - LEAST(20, ABS(p.score_guest - p.score_home))) + 1) / 40))) AS minute';
  }

  const v_player_game_minute_boxscore_base = `
SELECT
  ptgp.player_id,
  ptgp.game_id,
  `+ minuteStres + `,

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
JOIN (`+ sub_play + `) sp 
  ON sp.play_id = p.id
  AND (sp.player_made_id = ptgp.player_id OR sp.player_suffered_id = ptgp.player_id)
LEFT JOIN dz_shot ds ON ds.id = sp.shot_id

WHERE sp.seconds_da_start IS NOT NULL

GROUP BY
  ptgp.player_id,
  ptgp.game_id,
  minute
`;
  const v_player_game_minute_boxscore = `
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
FROM (`+ v_player_game_minute_boxscore_base + `) base
JOIN game g ON g.id = base.game_id
JOIN league_year ly ON ly.id = g.league_year_id
JOIN player pl ON pl.id = base.player_id
JOIN player_team_game ptg ON ptg.player_id = base.player_id AND ptg.game_id = base.game_id
JOIN team t ON t.id = ptg.team_id
`;
  const v_player_game_absolute_minute_boxscore = `
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
  FROM (`+ v_player_game_minute_boxscore + `) v_player_game_minute_boxscore
) AS base
GROUP BY
  base.player_id,
  base.game_id,
  base.team_id,
  base.type_game_id,
  base.league_year_id,
  base.league_id,
  base.absolute_minute
`;
  const v_player_game_total_boxscore = `
SELECT
  v.player_id,
  v.game_id,
  v.team_id,
  v.type_game_id,
  v.league_year_id,
  v.league_id,

  SUM(v.fouls_committed) AS fouls_committed,
  SUM(v.fouls_received) AS fouls_received,
  SUM(v.points) AS points,

  SUM(v.made_2pt) AS made_2pt,
  SUM(v.missed_2pt) AS missed_2pt,
  ROUND(SUM(v.made_2pt) * 100.0 / NULLIF(SUM(v.made_2pt + v.missed_2pt), 0), 1) AS pct_2pt,

  SUM(v.made_3pt) AS made_3pt,
  SUM(v.missed_3pt) AS missed_3pt,
  ROUND(SUM(v.made_3pt) * 100.0 / NULLIF(SUM(v.made_3pt + v.missed_3pt), 0), 1) AS pct_3pt,

  SUM(v.made_ft) AS made_ft,
  SUM(v.missed_ft) AS missed_ft,
  ROUND(SUM(v.made_ft) * 100.0 / NULLIF(SUM(v.made_ft + v.missed_ft), 0), 1) AS pct_ft,

  SUM(v.off_reb) AS off_reb,
  SUM(v.def_reb) AS def_reb,
  SUM(v.blocks_made) AS blocks_made,
  SUM(v.blocks_suffered) AS blocks_suffered,
  SUM(v.turnovers) AS turnovers,
  SUM(v.steals) AS steals,
  SUM(v.assists) AS assists,

  FLOOR((
    SELECT MAX(ptgp.total_seconds_played_before)
    FROM player_team_game_play ptgp
    WHERE ptgp.player_id = v.player_id AND ptgp.game_id = v.game_id
  ) / 60) AS minute

FROM (`+ v_player_game_minute_boxscore + `) v_player_game_minute_boxscore v

GROUP BY
  v.player_id,
  v.game_id,
  v.team_id,
  v.type_game_id,
  v.league_year_id,
  v.league_id
`;
  const v_player_season_avg_boxscore = `
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
FROM (`+ v_player_game_total_boxscore + `) v_player_game_total_boxscore
GROUP BY
  player_id,
  team_id,
  league_year_id,
  league_id
`;
  const v_player_season_game_type_avg_boxscore = `
SELECT
  player_id,
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
FROM (`+ v_player_game_total_boxscore + `) v_player_game_total_boxscore
GROUP BY
  player_id,
  team_id,
  league_year_id,
  league_id,
  type_game_id
`;
  const v_team_game_minute_boxscore = `
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

FROM (`+ v_player_game_minute_boxscore + `) v_player_game_minute_boxscore
GROUP BY team_id, game_id, minute, type_game_id, league_year_id, league_id
`;
  const v_team_game_absolute_minute_boxscore = `
SELECT
  team_id,
  game_id,
  type_game_id,
  league_year_id,
  league_id,
  absolute_minute,

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
    *,
    ((minute - 1) % 10) + 1 AS absolute_minute
  FROM (`+ v_team_game_minute_boxscore + `) v_team_game_minute_boxscore
) AS base
GROUP BY
  team_id,
  game_id,
  type_game_id,
  league_year_id,
  league_id,
  absolute_minute
`;
  const v_team_game_total_boxscore = `
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

FROM (`+ v_team_game_minute_boxscore + `) v_team_game_minute_boxscore
GROUP BY
  team_id,
  game_id,
  type_game_id,
  league_year_id,
  league_id
`;
  const v_team_season_avg_boxscore = `
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

FROM (`+ v_team_game_total_boxscore + `) v_team_game_total_boxscore
GROUP BY
  team_id,
  league_year_id,
  league_id
`;
  const v_team_season_game_type_avg_boxscore = `
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

FROM (`+ v_team_game_total_boxscore + `) v_team_game_total_boxscore
GROUP BY
  team_id,
  league_year_id,
  league_id,
  type_game_id
`;
  const v_game = `
SELECT
  g.*,
  th.name AS team_home_name,
  tg.name AS team_guest_name
FROM
  game g
JOIN team th ON g.team_home_id = th.id
JOIN team tg ON g.team_guest_id = tg.id
`;
  const v_player_game_minute_boxscore_consecutive = `
select
	ptgp.player_id,
	ptgp.game_id,
	FLOOR(ptgp.consecutive_seconds_playing / 60) + 1 as minute,

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
JOIN sub_play sp ON sp.play_id = p.id
LEFT JOIN dz_shot ds ON ds.id = sp.shot_id

GROUP BY ptgp.player_id, ptgp.game_id, minute
`;
  const v_player_game_minute_boxscore_total = `
SELECT
  ptgp.player_id,
  ptgp.game_id,
  FLOOR(ptgp.total_seconds_played_before / 60) + 1 AS minute,

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
JOIN sub_play sp ON sp.play_id = p.id
LEFT JOIN dz_shot ds ON ds.id = sp.shot_id

GROUP BY ptgp.player_id, ptgp.game_id, minute
`;
  const v_play_lineup_window = `
SELECT
  p.id AS play_id,
  p.game_id,
  ptgp.team_id,
  MIN(ptgp.seconds_start) AS seconds_start,
  MAX(ptgp.seconds_end) AS seconds_end,
  GROUP_CONCAT(DISTINCT ptgp.player_id ORDER BY ptgp.player_id) AS player_ids,
  REPLACE(GROUP_CONCAT(DISTINCT ptgp.player_id ORDER BY ptgp.player_id), ',', '-') AS lineup_hash

FROM player_team_game_play ptgp
JOIN play p ON p.id = ptgp.play_id

GROUP BY p.id, ptgp.team_id
HAVING
  LENGTH(player_ids) - LENGTH(REPLACE(player_ids, ',', '')) = 4
`;
  const v_team_game_lineup_minutes = `
SELECT
  q.game_id,
  q.team_id,
  CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(q.lineup_hash, '-', 1), '-', -1) AS UNSIGNED) AS player1_id,
  CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(q.lineup_hash, '-', 2), '-', -1) AS UNSIGNED) AS player2_id,
  CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(q.lineup_hash, '-', 3), '-', -1) AS UNSIGNED) AS player3_id,
  CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(q.lineup_hash, '-', 4), '-', -1) AS UNSIGNED) AS player4_id,
  CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(q.lineup_hash, '-', 5), '-', -1) AS UNSIGNED) AS player5_id,
  ROUND(SUM(q.seconds_end - q.seconds_start) / 60.0, 2) AS minuti_giocati

FROM (`+ v_play_lineup_window + `) v_play_lineup_window q

GROUP BY
  q.game_id,
  q.team_id,
  q.lineup_hash

ORDER BY q.game_id, q.team_id, minuti_giocati DESC
`;

  const queries = {
    v_player_game_minute_boxscore_base: v_player_game_minute_boxscore_base,
    v_player_game_minute_boxscore: v_player_game_minute_boxscore,
    v_player_game_absolute_minute_boxscore: v_player_game_absolute_minute_boxscore,
    v_player_game_total_boxscore: v_player_game_total_boxscore,
    v_player_season_avg_boxscore: v_player_season_avg_boxscore,
    v_player_season_game_type_avg_boxscore: v_player_season_game_type_avg_boxscore,
    v_team_game_minute_boxscore: v_team_game_minute_boxscore,
    v_team_game_absolute_minute_boxscore: v_team_game_absolute_minute_boxscore,
    v_team_game_total_boxscore: v_team_game_total_boxscore,
    v_team_season_avg_boxscore: v_team_season_avg_boxscore,
    v_team_season_game_type_avg_boxscore: v_team_season_game_type_avg_boxscore,
    v_game: v_game,
    v_player_game_minute_boxscore_consecutive: v_player_game_minute_boxscore_consecutive,
    v_player_game_minute_boxscore_total: v_player_game_minute_boxscore_total,
    v_play_lineup_window: v_play_lineup_window,
    v_team_game_lineup_minutes: v_team_game_lineup_minutes,
    sub_play: sub_play,
  }

  const baseQuery = queries[view as keyof typeof queries];

  let gameQuery = `game_id IN (${game_ids.join(',')})`
  const teamQuery = ` AND team_id = ${team_id}`
  const playerQuery = ` AND player_id = ${player_id}`

  if (team_id) {
    gameQuery = gameQuery + teamQuery;
  }
  if (player_id) {
    gameQuery = gameQuery + playerQuery;
  }
  // Costruzione della query dinamica
  let query = '';
  if (view === 'sub_play') {
    query = `
    SELECT *
    FROM (
      ${baseQuery}
    ) AS filtered_boxscore
    WHERE team_made_id = ${team_id}
    AND game_made_id IN (${game_ids.join(',')})
    AND shot_id IN (1,2,3,4)
    `;
  }
  else {
    query = `
    SELECT *
    FROM (
      ${baseQuery}
    ) AS filtered_boxscore
    WHERE 
    ${gameQuery}
  `;
  }

  // Calcola il percorso del file nella stessa cartella
  const filePath = path.join(__dirname, 'last-query.sql');

  // Scrive il contenuto nel file (sincrono per semplicità, puoi anche usare la versione async)
  fs.writeFileSync(filePath, query);

  // Esegue la query dopo averla scritta
  const viewItems = await prisma.$queryRawUnsafe<any[]>(query);
  return viewItems;
}

router.post('/view', wrapAsync(async (req: any, res: any) => {
  const viewItems = await getGetItems(req);
  res.status(200).json(JSend.success(viewItems));
}));

router.post('/plus-minus', wrapAsync(async (req: any, res: any) => {
  const { team_id, game_ids, playerIn, playerNotIn, stresView } = req.body;
  const view = 'v_team_game_total_boxscore';

  if (!team_id || !Array.isArray(game_ids) || game_ids.length === 0 || !view) {
    return res.status(400).json(JSend.fail('Parametri mancanti o errati'));
  }

  let totalTeamPoints = 0;
  let totalOpponentPoints = 0;

  for (const gameId of game_ids) {
    // 1. Squadra principale
    const reqTeam = {
      body: {
        team_id,
        game_ids: [gameId],
        view,
        playerIn,
        playerNotIn,
        stresView,
      }
    };
    const teamItems = await getGetItems(reqTeam);
    const teamPoints = teamItems.reduce((sum, row) => sum + (row.points || 0), 0);
    totalTeamPoints += +teamPoints;

    // 2. Squadra avversaria
    const game = await prisma.game.findUnique({
      where: { id: gameId },
      select: {
        team_home_id: true,
        team_guest_id: true,
      }
    });

    const opponentId = (game?.team_home_id === team_id) ? game?.team_guest_id : game?.team_home_id;
    if (!opponentId) continue;

    const reqOpponent = {
      body: {
        team_id: opponentId,
        game_ids: [gameId],
        view,
        playerIn,
        playerNotIn,
        stresView,
      }
    };
    const oppItems = await getGetItems(reqOpponent);
    const oppPoints = oppItems.reduce((sum, row) => sum + (row.points || 0), 0);
    totalOpponentPoints += +oppPoints;
  }

  const plusMinus = +totalTeamPoints - +totalOpponentPoints;

  res.status(200).json(JSend.success({
    team_points: totalTeamPoints,
    opponent_points: totalOpponentPoints,
    plus_minus: plusMinus
  }));
}));


router.post('/minute', wrapAsync(async (req: any, res: any) => {
  const { team_id, game_ids, playerIn = [], playerNotIn = [] } = req.body;

  if (!Array.isArray(game_ids) || game_ids.length === 0 || !team_id) {
    return res.status(400).json(JSend.fail('Parametri mancanti o errati'));
  }

  // Pulizia parametri
  const safeGameIds = game_ids.map(Number).filter((n: any) => !isNaN(n));
  const safePlayerIn = playerIn.map(Number).filter((n: any) => !isNaN(n));
  const safePlayerNotIn = playerNotIn.map(Number).filter((n: any) => !isNaN(n));

  // Costruzione query
  let query = `
    SELECT play_id, game_id, player_id, seconds_start, seconds_end
    FROM player_team_game_play
    WHERE team_id = ?
      AND game_id IN (${safeGameIds.join(',')})
  `;

  // Applica filtro player_id solo se necessario
  if (safePlayerIn.length > 0) {
    const allPlayerIds = [...new Set([...safePlayerIn, ...safePlayerNotIn])];
    query += ` AND player_id IN (${allPlayerIds.join(',')})`;
  }
    
  // Esegui query
  const intervals = await prisma.$queryRawUnsafe<any[]>(query, team_id);

  // Organizza per play_id
  const byPlay: Record<number, { game_id: number, in: any[], notIn: any[], all: any[] }> = {};

  for (const row of intervals) {
    if (!byPlay[row.play_id]) {
      byPlay[row.play_id] = { game_id: row.game_id, in: [], notIn: [], all: [] };
    }
    byPlay[row.play_id].all.push(row);
    if (safePlayerIn.includes(row.player_id)) {
      byPlay[row.play_id].in.push(row);
    }
    if (safePlayerNotIn.includes(row.player_id)) {
      byPlay[row.play_id].notIn.push(row);
    }
  }

  let totalSeconds = 0;

  for (const playId in byPlay) {
    if (playId === '311'){
      const aa = 0;
    }
    const { in: inPlays, notIn: notInPlays, all } = byPlay[playId];
    let allB: boolean = false;
    // Se richiesto, verifica che tutti i playerIn siano presenti nel play
    if (safePlayerIn.length > 0 && inPlays.length < safePlayerIn.length) continue;

    // Seleziona i player da cui calcolare l'intervallo comune
    let relevantPlays;
    if (safePlayerIn.length > 0) {
      relevantPlays = inPlays;
    } else if (safePlayerNotIn.length > 0) {
      // Solo playerNotIn → considera solo i player NON esclusi
      relevantPlays = all.filter(p => !safePlayerNotIn.includes(p.player_id));
    } else {
      // Nessun filtro → considera tutti
      relevantPlays = all;
      allB = true;
    }

    // Se non c'è nessun player utile, salta
    if (relevantPlays.length === 0) continue;

    const maxStart = Math.min(...relevantPlays.map(p => p.seconds_start));
    const minEnd = Math.max(...relevantPlays.map(p => p.seconds_end));

    // Se non esiste intervallo comune, salta
    if (maxStart >= minEnd) continue;

    let start = maxStart;
    let end = minEnd;

    // Se richiesto, escludi i playerNotIn presenti in quell'intervallo
    if (safePlayerNotIn.length > 0) {
      const hasExcluded = notInPlays.some(p =>
        p.seconds_start < end && p.seconds_end > start
      );
      if (hasExcluded) continue;
    }

    totalSeconds += (end - start);
  }

  const totalMinutes = Math.floor(totalSeconds / 60);
  return res.json(JSend.success({ total_minutes: totalMinutes }));
}));

export default router;