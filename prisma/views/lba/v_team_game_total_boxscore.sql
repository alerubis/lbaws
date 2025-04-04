SELECT
  `lba`.`v_team_game_minute_boxscore`.`team_id` AS `team_id`,
  `lba`.`v_team_game_minute_boxscore`.`game_id` AS `game_id`,
  `lba`.`v_team_game_minute_boxscore`.`type_game_id` AS `type_game_id`,
  `lba`.`v_team_game_minute_boxscore`.`league_year_id` AS `league_year_id`,
  `lba`.`v_team_game_minute_boxscore`.`league_id` AS `league_id`,
  cast(
    sum(
      `lba`.`v_team_game_minute_boxscore`.`fouls_committed`
    ) AS decimal(10, 0)
  ) AS `fouls_committed`,
  cast(
    sum(
      `lba`.`v_team_game_minute_boxscore`.`fouls_received`
    ) AS decimal(10, 0)
  ) AS `fouls_received`,
  cast(
    sum(`lba`.`v_team_game_minute_boxscore`.`points`) AS decimal(10, 0)
  ) AS `points`,
  cast(
    sum(`lba`.`v_team_game_minute_boxscore`.`made_2pt`) AS decimal(10, 0)
  ) AS `made_2pt`,
  cast(
    sum(`lba`.`v_team_game_minute_boxscore`.`missed_2pt`) AS decimal(10, 0)
  ) AS `missed_2pt`,
  cast(
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
    ) AS decimal(10, 0)
  ) AS `pct_2pt`,
  cast(
    sum(`lba`.`v_team_game_minute_boxscore`.`made_3pt`) AS decimal(10, 0)
  ) AS `made_3pt`,
  cast(
    sum(`lba`.`v_team_game_minute_boxscore`.`missed_3pt`) AS decimal(10, 0)
  ) AS `missed_3pt`,
  cast(
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
    ) AS decimal(10, 0)
  ) AS `pct_3pt`,
  cast(
    sum(`lba`.`v_team_game_minute_boxscore`.`made_ft`) AS decimal(10, 0)
  ) AS `made_ft`,
  cast(
    sum(`lba`.`v_team_game_minute_boxscore`.`missed_ft`) AS decimal(10, 0)
  ) AS `missed_ft`,
  cast(
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
    ) AS decimal(10, 0)
  ) AS `pct_ft`,
  cast(
    sum(`lba`.`v_team_game_minute_boxscore`.`off_reb`) AS decimal(10, 0)
  ) AS `off_reb`,
  cast(
    sum(`lba`.`v_team_game_minute_boxscore`.`def_reb`) AS decimal(10, 0)
  ) AS `def_reb`,
  cast(
    sum(
      `lba`.`v_team_game_minute_boxscore`.`blocks_made`
    ) AS decimal(10, 0)
  ) AS `blocks_made`,
  cast(
    sum(
      `lba`.`v_team_game_minute_boxscore`.`blocks_suffered`
    ) AS decimal(10, 0)
  ) AS `blocks_suffered`,
  cast(
    sum(`lba`.`v_team_game_minute_boxscore`.`turnovers`) AS decimal(10, 0)
  ) AS `turnovers`,
  cast(
    sum(`lba`.`v_team_game_minute_boxscore`.`steals`) AS decimal(10, 0)
  ) AS `steals`,
  cast(
    sum(`lba`.`v_team_game_minute_boxscore`.`assists`) AS decimal(10, 0)
  ) AS `assists`
FROM
  `lba`.`v_team_game_minute_boxscore`
GROUP BY
  `lba`.`v_team_game_minute_boxscore`.`team_id`,
  `lba`.`v_team_game_minute_boxscore`.`game_id`,
  `lba`.`v_team_game_minute_boxscore`.`type_game_id`,
  `lba`.`v_team_game_minute_boxscore`.`league_year_id`,
  `lba`.`v_team_game_minute_boxscore`.`league_id`