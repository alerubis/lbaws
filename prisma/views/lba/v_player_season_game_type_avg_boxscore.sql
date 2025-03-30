SELECT
  `lba`.`v_player_game_total_boxscore`.`player_id` AS `player_id`,
  `lba`.`v_player_game_total_boxscore`.`player_name` AS `player_name`,
  `lba`.`v_player_game_total_boxscore`.`player_surname` AS `player_surname`,
  `lba`.`v_player_game_total_boxscore`.`team_name` AS `team_name`,
  `lba`.`v_player_game_total_boxscore`.`league_year_id` AS `league_year_id`,
  `lba`.`v_player_game_total_boxscore`.`league_id` AS `league_id`,
  `lba`.`v_player_game_total_boxscore`.`type_game_id` AS `type_game_id`,
  count(
    DISTINCT `lba`.`v_player_game_total_boxscore`.`game_id`
  ) AS `games`,
  round(
    (
      sum(
        `lba`.`v_player_game_total_boxscore`.`fouls_committed`
      ) / count(
        DISTINCT `lba`.`v_player_game_total_boxscore`.`game_id`
      )
    ),
    2
  ) AS `fouls_committed`,
  round(
    (
      sum(
        `lba`.`v_player_game_total_boxscore`.`fouls_received`
      ) / count(
        DISTINCT `lba`.`v_player_game_total_boxscore`.`game_id`
      )
    ),
    2
  ) AS `fouls_received`,
  round(
    (
      sum(`lba`.`v_player_game_total_boxscore`.`points`) / count(
        DISTINCT `lba`.`v_player_game_total_boxscore`.`game_id`
      )
    ),
    2
  ) AS `points`,
  round(
    (
      sum(`lba`.`v_player_game_total_boxscore`.`made_2pt`) / count(
        DISTINCT `lba`.`v_player_game_total_boxscore`.`game_id`
      )
    ),
    2
  ) AS `made_2pt`,
  round(
    (
      sum(
        `lba`.`v_player_game_total_boxscore`.`missed_2pt`
      ) / count(
        DISTINCT `lba`.`v_player_game_total_boxscore`.`game_id`
      )
    ),
    2
  ) AS `missed_2pt`,
  round(
    (
      (
        sum(`lba`.`v_player_game_total_boxscore`.`made_2pt`) * 100.0
      ) / nullif(
        sum(
          (
            `lba`.`v_player_game_total_boxscore`.`made_2pt` + `lba`.`v_player_game_total_boxscore`.`missed_2pt`
          )
        ),
        0
      )
    ),
    1
  ) AS `pct_2pt`,
  round(
    (
      sum(`lba`.`v_player_game_total_boxscore`.`made_3pt`) / count(
        DISTINCT `lba`.`v_player_game_total_boxscore`.`game_id`
      )
    ),
    2
  ) AS `made_3pt`,
  round(
    (
      sum(
        `lba`.`v_player_game_total_boxscore`.`missed_3pt`
      ) / count(
        DISTINCT `lba`.`v_player_game_total_boxscore`.`game_id`
      )
    ),
    2
  ) AS `missed_3pt`,
  round(
    (
      (
        sum(`lba`.`v_player_game_total_boxscore`.`made_3pt`) * 100.0
      ) / nullif(
        sum(
          (
            `lba`.`v_player_game_total_boxscore`.`made_3pt` + `lba`.`v_player_game_total_boxscore`.`missed_3pt`
          )
        ),
        0
      )
    ),
    1
  ) AS `pct_3pt`,
  round(
    (
      sum(`lba`.`v_player_game_total_boxscore`.`made_ft`) / count(
        DISTINCT `lba`.`v_player_game_total_boxscore`.`game_id`
      )
    ),
    2
  ) AS `made_ft`,
  round(
    (
      sum(`lba`.`v_player_game_total_boxscore`.`missed_ft`) / count(
        DISTINCT `lba`.`v_player_game_total_boxscore`.`game_id`
      )
    ),
    2
  ) AS `missed_ft`,
  round(
    (
      (
        sum(`lba`.`v_player_game_total_boxscore`.`made_ft`) * 100.0
      ) / nullif(
        sum(
          (
            `lba`.`v_player_game_total_boxscore`.`made_ft` + `lba`.`v_player_game_total_boxscore`.`missed_ft`
          )
        ),
        0
      )
    ),
    1
  ) AS `pct_ft`,
  round(
    (
      sum(`lba`.`v_player_game_total_boxscore`.`off_reb`) / count(
        DISTINCT `lba`.`v_player_game_total_boxscore`.`game_id`
      )
    ),
    2
  ) AS `off_reb`,
  round(
    (
      sum(`lba`.`v_player_game_total_boxscore`.`def_reb`) / count(
        DISTINCT `lba`.`v_player_game_total_boxscore`.`game_id`
      )
    ),
    2
  ) AS `def_reb`,
  round(
    (
      sum(
        `lba`.`v_player_game_total_boxscore`.`blocks_made`
      ) / count(
        DISTINCT `lba`.`v_player_game_total_boxscore`.`game_id`
      )
    ),
    2
  ) AS `blocks_made`,
  round(
    (
      sum(
        `lba`.`v_player_game_total_boxscore`.`blocks_suffered`
      ) / count(
        DISTINCT `lba`.`v_player_game_total_boxscore`.`game_id`
      )
    ),
    2
  ) AS `blocks_suffered`,
  round(
    (
      sum(`lba`.`v_player_game_total_boxscore`.`turnovers`) / count(
        DISTINCT `lba`.`v_player_game_total_boxscore`.`game_id`
      )
    ),
    2
  ) AS `turnovers`,
  round(
    (
      sum(`lba`.`v_player_game_total_boxscore`.`steals`) / count(
        DISTINCT `lba`.`v_player_game_total_boxscore`.`game_id`
      )
    ),
    2
  ) AS `steals`,
  round(
    (
      sum(`lba`.`v_player_game_total_boxscore`.`assists`) / count(
        DISTINCT `lba`.`v_player_game_total_boxscore`.`game_id`
      )
    ),
    2
  ) AS `assists`
FROM
  `lba`.`v_player_game_total_boxscore`
GROUP BY
  `lba`.`v_player_game_total_boxscore`.`player_id`,
  `lba`.`v_player_game_total_boxscore`.`player_name`,
  `lba`.`v_player_game_total_boxscore`.`player_surname`,
  `lba`.`v_player_game_total_boxscore`.`team_name`,
  `lba`.`v_player_game_total_boxscore`.`league_year_id`,
  `lba`.`v_player_game_total_boxscore`.`league_id`,
  `lba`.`v_player_game_total_boxscore`.`type_game_id`