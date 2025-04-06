SELECT
  `lba`.`v`.`player_id` AS `player_id`,
  `lba`.`v`.`game_id` AS `game_id`,
  `lba`.`v`.`team_id` AS `team_id`,
  `lba`.`v`.`type_game_id` AS `type_game_id`,
  `lba`.`v`.`league_year_id` AS `league_year_id`,
  `lba`.`v`.`league_id` AS `league_id`,
  sum(`lba`.`v`.`fouls_committed`) AS `fouls_committed`,
  sum(`lba`.`v`.`fouls_received`) AS `fouls_received`,
  sum(`lba`.`v`.`points`) AS `points`,
  sum(`lba`.`v`.`made_2pt`) AS `made_2pt`,
  sum(`lba`.`v`.`missed_2pt`) AS `missed_2pt`,
  round(
    (
      (sum(`lba`.`v`.`made_2pt`) * 100.0) / nullif(
        sum((`lba`.`v`.`made_2pt` + `lba`.`v`.`missed_2pt`)),
        0
      )
    ),
    1
  ) AS `pct_2pt`,
  sum(`lba`.`v`.`made_3pt`) AS `made_3pt`,
  sum(`lba`.`v`.`missed_3pt`) AS `missed_3pt`,
  round(
    (
      (sum(`lba`.`v`.`made_3pt`) * 100.0) / nullif(
        sum((`lba`.`v`.`made_3pt` + `lba`.`v`.`missed_3pt`)),
        0
      )
    ),
    1
  ) AS `pct_3pt`,
  sum(`lba`.`v`.`made_ft`) AS `made_ft`,
  sum(`lba`.`v`.`missed_ft`) AS `missed_ft`,
  round(
    (
      (sum(`lba`.`v`.`made_ft`) * 100.0) / nullif(
        sum((`lba`.`v`.`made_ft` + `lba`.`v`.`missed_ft`)),
        0
      )
    ),
    1
  ) AS `pct_ft`,
  sum(`lba`.`v`.`off_reb`) AS `off_reb`,
  sum(`lba`.`v`.`def_reb`) AS `def_reb`,
  sum(`lba`.`v`.`blocks_made`) AS `blocks_made`,
  sum(`lba`.`v`.`blocks_suffered`) AS `blocks_suffered`,
  sum(`lba`.`v`.`turnovers`) AS `turnovers`,
  sum(`lba`.`v`.`steals`) AS `steals`,
  sum(`lba`.`v`.`assists`) AS `assists`,
  floor(
    (
      (
        SELECT
          max(`ptgp`.`total_seconds_played_before`)
        FROM
          `lba`.`player_team_game_play` `ptgp`
        WHERE
          (
            (`ptgp`.`player_id` = `lba`.`v`.`player_id`)
            AND (`ptgp`.`game_id` = `lba`.`v`.`game_id`)
          )
      ) / 60
    )
  ) AS `minute`
FROM
  `lba`.`v_player_game_minute_boxscore` `v`
GROUP BY
  `lba`.`v`.`player_id`,
  `lba`.`v`.`game_id`,
  `lba`.`v`.`team_id`,
  `lba`.`v`.`type_game_id`,
  `lba`.`v`.`league_year_id`,
  `lba`.`v`.`league_id`