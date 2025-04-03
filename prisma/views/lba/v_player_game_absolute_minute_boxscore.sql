SELECT
  `base`.`player_id` AS `player_id`,
  `base`.`game_id` AS `game_id`,
  `base`.`team_id` AS `team_id`,
  `base`.`type_game_id` AS `type_game_id`,
  `base`.`league_year_id` AS `league_year_id`,
  `base`.`league_id` AS `league_id`,
  `base`.`absolute_minute` AS `absolute_minute`,
  sum(`base`.`fouls_committed`) AS `fouls_committed`,
  sum(`base`.`fouls_received`) AS `fouls_received`,
  sum(`base`.`points`) AS `points`,
  sum(`base`.`made_2pt`) AS `made_2pt`,
  sum(`base`.`missed_2pt`) AS `missed_2pt`,
  round(
    (
      (sum(`base`.`made_2pt`) * 100.0) / nullif(sum((`base`.`made_2pt` + `base`.`missed_2pt`)), 0)
    ),
    1
  ) AS `pct_2pt`,
  sum(`base`.`made_3pt`) AS `made_3pt`,
  sum(`base`.`missed_3pt`) AS `missed_3pt`,
  round(
    (
      (sum(`base`.`made_3pt`) * 100.0) / nullif(sum((`base`.`made_3pt` + `base`.`missed_3pt`)), 0)
    ),
    1
  ) AS `pct_3pt`,
  sum(`base`.`made_ft`) AS `made_ft`,
  sum(`base`.`missed_ft`) AS `missed_ft`,
  round(
    (
      (sum(`base`.`made_ft`) * 100.0) / nullif(sum((`base`.`made_ft` + `base`.`missed_ft`)), 0)
    ),
    1
  ) AS `pct_ft`,
  sum(`base`.`off_reb`) AS `off_reb`,
  sum(`base`.`def_reb`) AS `def_reb`,
  sum(`base`.`blocks_made`) AS `blocks_made`,
  sum(`base`.`blocks_suffered`) AS `blocks_suffered`,
  sum(`base`.`turnovers`) AS `turnovers`,
  sum(`base`.`steals`) AS `steals`,
  sum(`base`.`assists`) AS `assists`
FROM
  (
    SELECT
      `lba`.`v_player_game_minute_boxscore`.`player_id` AS `player_id`,
      `lba`.`v_player_game_minute_boxscore`.`game_id` AS `game_id`,
      `lba`.`v_player_game_minute_boxscore`.`minute` AS `minute`,
      `lba`.`v_player_game_minute_boxscore`.`fouls_committed` AS `fouls_committed`,
      `lba`.`v_player_game_minute_boxscore`.`fouls_received` AS `fouls_received`,
      `lba`.`v_player_game_minute_boxscore`.`points` AS `points`,
      `lba`.`v_player_game_minute_boxscore`.`made_2pt` AS `made_2pt`,
      `lba`.`v_player_game_minute_boxscore`.`missed_2pt` AS `missed_2pt`,
      `lba`.`v_player_game_minute_boxscore`.`pct_2pt` AS `pct_2pt`,
      `lba`.`v_player_game_minute_boxscore`.`made_3pt` AS `made_3pt`,
      `lba`.`v_player_game_minute_boxscore`.`missed_3pt` AS `missed_3pt`,
      `lba`.`v_player_game_minute_boxscore`.`pct_3pt` AS `pct_3pt`,
      `lba`.`v_player_game_minute_boxscore`.`made_ft` AS `made_ft`,
      `lba`.`v_player_game_minute_boxscore`.`missed_ft` AS `missed_ft`,
      `lba`.`v_player_game_minute_boxscore`.`pct_ft` AS `pct_ft`,
      `lba`.`v_player_game_minute_boxscore`.`off_reb` AS `off_reb`,
      `lba`.`v_player_game_minute_boxscore`.`def_reb` AS `def_reb`,
      `lba`.`v_player_game_minute_boxscore`.`blocks_made` AS `blocks_made`,
      `lba`.`v_player_game_minute_boxscore`.`blocks_suffered` AS `blocks_suffered`,
      `lba`.`v_player_game_minute_boxscore`.`turnovers` AS `turnovers`,
      `lba`.`v_player_game_minute_boxscore`.`steals` AS `steals`,
      `lba`.`v_player_game_minute_boxscore`.`assists` AS `assists`,
      `lba`.`v_player_game_minute_boxscore`.`team_id` AS `team_id`,
      `lba`.`v_player_game_minute_boxscore`.`type_game_id` AS `type_game_id`,
      `lba`.`v_player_game_minute_boxscore`.`league_year_id` AS `league_year_id`,
      `lba`.`v_player_game_minute_boxscore`.`league_id` AS `league_id`,
(
        (
          (
            `lba`.`v_player_game_minute_boxscore`.`minute` - 1
          ) % 10
        ) + 1
      ) AS `absolute_minute`
    FROM
      `lba`.`v_player_game_minute_boxscore`
  ) `base`
GROUP BY
  `base`.`player_id`,
  `base`.`game_id`,
  `base`.`team_id`,
  `base`.`type_game_id`,
  `base`.`league_year_id`,
  `base`.`league_id`,
  `base`.`absolute_minute`