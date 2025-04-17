SELECT
  `lba`.`q`.`game_id` AS `game_id`,
  `lba`.`q`.`team_id` AS `team_id`,
  cast(
    substring_index(
      substring_index(`lba`.`q`.`lineup_hash`, '-', 1),
      '-',
      -(1)
    ) AS UNSIGNED
  ) AS `player1_id`,
  cast(
    substring_index(
      substring_index(`lba`.`q`.`lineup_hash`, '-', 2),
      '-',
      -(1)
    ) AS UNSIGNED
  ) AS `player2_id`,
  cast(
    substring_index(
      substring_index(`lba`.`q`.`lineup_hash`, '-', 3),
      '-',
      -(1)
    ) AS UNSIGNED
  ) AS `player3_id`,
  cast(
    substring_index(
      substring_index(`lba`.`q`.`lineup_hash`, '-', 4),
      '-',
      -(1)
    ) AS UNSIGNED
  ) AS `player4_id`,
  cast(
    substring_index(
      substring_index(`lba`.`q`.`lineup_hash`, '-', 5),
      '-',
      -(1)
    ) AS UNSIGNED
  ) AS `player5_id`,
  round(
    (
      sum(
        (
          `lba`.`q`.`seconds_end` - `lba`.`q`.`seconds_start`
        )
      ) / 60.0
    ),
    2
  ) AS `minuti_giocati`
FROM
  `lba`.`v_play_lineup_window` `q`
GROUP BY
  `lba`.`q`.`game_id`,
  `lba`.`q`.`team_id`,
  `lba`.`q`.`lineup_hash`
ORDER BY
  `lba`.`q`.`game_id`,
  `lba`.`q`.`team_id`,
  `minuti_giocati` DESC