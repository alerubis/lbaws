SELECT
  `g`.`id` AS `id`,
  `g`.`league_year_id` AS `league_year_id`,
  `g`.`type_game_id` AS `type_game_id`,
  `g`.`team_home_id` AS `team_home_id`,
  `g`.`team_guest_id` AS `team_guest_id`,
  `g`.`team_home_points` AS `team_home_points`,
  `g`.`team_guest_points` AS `team_guest_points`,
  `g`.`date_hours_utc` AS `date_hours_utc`,
  `g`.`referee_1_id` AS `referee_1_id`,
  `g`.`referee_2_id` AS `referee_2_id`,
  `g`.`referee_3_id` AS `referee_3_id`,
  `th`.`name` AS `team_home_name`,
  `tg`.`name` AS `team_guest_name`
FROM
  (
    (
      `lba`.`game` `g`
      JOIN `lba`.`team` `th` ON((`g`.`team_home_id` = `th`.`id`))
    )
    JOIN `lba`.`team` `tg` ON((`g`.`team_guest_id` = `tg`.`id`))
  )