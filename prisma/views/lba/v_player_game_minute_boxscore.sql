SELECT
  `lba`.`base`.`player_id` AS `player_id`,
  `lba`.`base`.`game_id` AS `game_id`,
  `lba`.`base`.`minute` AS `minute`,
  `lba`.`base`.`fouls_committed` AS `fouls_committed`,
  `lba`.`base`.`fouls_received` AS `fouls_received`,
  `lba`.`base`.`points` AS `points`,
  `lba`.`base`.`made_2pt` AS `made_2pt`,
  `lba`.`base`.`missed_2pt` AS `missed_2pt`,
  `lba`.`base`.`pct_2pt` AS `pct_2pt`,
  `lba`.`base`.`made_3pt` AS `made_3pt`,
  `lba`.`base`.`missed_3pt` AS `missed_3pt`,
  `lba`.`base`.`pct_3pt` AS `pct_3pt`,
  `lba`.`base`.`made_ft` AS `made_ft`,
  `lba`.`base`.`missed_ft` AS `missed_ft`,
  `lba`.`base`.`pct_ft` AS `pct_ft`,
  `lba`.`base`.`off_reb` AS `off_reb`,
  `lba`.`base`.`def_reb` AS `def_reb`,
  `lba`.`base`.`blocks_made` AS `blocks_made`,
  `lba`.`base`.`blocks_suffered` AS `blocks_suffered`,
  `lba`.`base`.`turnovers` AS `turnovers`,
  `lba`.`base`.`steals` AS `steals`,
  `lba`.`base`.`assists` AS `assists`,
  `pl`.`name` AS `player_name`,
  `pl`.`surname` AS `player_surname`,
  `t`.`name` AS `team_name`,
  `g`.`type_game_id` AS `type_game_id`,
  `g`.`league_year_id` AS `league_year_id`,
  `ly`.`league_id` AS `league_id`
FROM
  (
    (
      (
        (
          (
            `lba`.`v_player_game_minute_boxscore_base` `base`
            JOIN `lba`.`game` `g` ON((`g`.`id` = `lba`.`base`.`game_id`))
          )
          JOIN `lba`.`league_year` `ly` ON((`ly`.`id` = `g`.`league_year_id`))
        )
        JOIN `lba`.`player` `pl` ON((`pl`.`id` = `lba`.`base`.`player_id`))
      )
      JOIN `lba`.`player_team_game` `ptg` ON(
        (
          (`ptg`.`player_id` = `lba`.`base`.`player_id`)
          AND (`ptg`.`game_id` = `lba`.`base`.`game_id`)
        )
      )
    )
    JOIN `lba`.`team` `t` ON((`t`.`id` = `ptg`.`team_id`))
  )