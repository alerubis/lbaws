SELECT
  `lba`.`v_team_game_minute_boxscore`.`team_id` AS `team_id`,
  `lba`.`v_team_game_minute_boxscore`.`game_id` AS `game_id`,
  `lba`.`v_team_game_minute_boxscore`.`type_game_id` AS `type_game_id`,
  `lba`.`v_team_game_minute_boxscore`.`league_year_id` AS `league_year_id`,
  `lba`.`v_team_game_minute_boxscore`.`league_id` AS `league_id`,
  sum(
    `lba`.`v_team_game_minute_boxscore`.`fouls_committed`
  ) AS `fouls_committed`,
  sum(
    `lba`.`v_team_game_minute_boxscore`.`fouls_received`
  ) AS `fouls_received`,
  sum(`lba`.`v_team_game_minute_boxscore`.`points`) AS `points`,
  sum(`lba`.`v_team_game_minute_boxscore`.`made_2pt`) AS `made_2pt`,
  sum(`lba`.`v_team_game_minute_boxscore`.`missed_2pt`) AS `missed_2pt`,
  round(
    (
      (
        sum(`lba`.`v_team_game_minute_boxscore`.`made_2pt`) * 100.0
      ) / nullif(
        sum(
          (
            `lba`.`v_team_game_minute_boxscore`.`made_2pt` + `lba`.`v_team_game_minute_boxscore`.`missed_2pt`
          )
        ),
        0
      )
    ),
    1
  ) AS `pct_2pt`,
  sum(`lba`.`v_team_game_minute_boxscore`.`made_3pt`) AS `made_3pt`,
  sum(`lba`.`v_team_game_minute_boxscore`.`missed_3pt`) AS `missed_3pt`,
  round(
    (
      (
        sum(`lba`.`v_team_game_minute_boxscore`.`made_3pt`) * 100.0
      ) / nullif(
        sum(
          (
            `lba`.`v_team_game_minute_boxscore`.`made_3pt` + `lba`.`v_team_game_minute_boxscore`.`missed_3pt`
          )
        ),
        0
      )
    ),
    1
  ) AS `pct_3pt`,
  sum(`lba`.`v_team_game_minute_boxscore`.`made_ft`) AS `made_ft`,
  sum(`lba`.`v_team_game_minute_boxscore`.`missed_ft`) AS `missed_ft`,
  round(
    (
      (
        sum(`lba`.`v_team_game_minute_boxscore`.`made_ft`) * 100.0
      ) / nullif(
        sum(
          (
            `lba`.`v_team_game_minute_boxscore`.`made_ft` + `lba`.`v_team_game_minute_boxscore`.`missed_ft`
          )
        ),
        0
      )
    ),
    1
  ) AS `pct_ft`,
  sum(`lba`.`v_team_game_minute_boxscore`.`off_reb`) AS `off_reb`,
  sum(`lba`.`v_team_game_minute_boxscore`.`def_reb`) AS `def_reb`,
  sum(
    `lba`.`v_team_game_minute_boxscore`.`blocks_made`
  ) AS `blocks_made`,
  sum(
    `lba`.`v_team_game_minute_boxscore`.`blocks_suffered`
  ) AS `blocks_suffered`,
  sum(`lba`.`v_team_game_minute_boxscore`.`turnovers`) AS `turnovers`,
  sum(`lba`.`v_team_game_minute_boxscore`.`steals`) AS `steals`,
  sum(`lba`.`v_team_game_minute_boxscore`.`assists`) AS `assists`
FROM
  `lba`.`v_team_game_minute_boxscore`
GROUP BY
  `lba`.`v_team_game_minute_boxscore`.`team_id`,
  `lba`.`v_team_game_minute_boxscore`.`game_id`,
  `lba`.`v_team_game_minute_boxscore`.`type_game_id`,
  `lba`.`v_team_game_minute_boxscore`.`league_year_id`,
  `lba`.`v_team_game_minute_boxscore`.`league_id`