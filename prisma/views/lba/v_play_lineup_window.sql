SELECT
  `p`.`id` AS `play_id`,
  `p`.`game_id` AS `game_id`,
  `ptgp`.`team_id` AS `team_id`,
  min(`ptgp`.`seconds_start`) AS `seconds_start`,
  max(`ptgp`.`seconds_end`) AS `seconds_end`,
  GROUP_CONCAT(
    DISTINCT `ptgp`.`player_id`
    ORDER BY
      `ptgp`.`player_id` ASC SEPARATOR ','
  ) AS `player_ids`,
  REPLACE(
    GROUP_CONCAT(
      DISTINCT `ptgp`.`player_id`
      ORDER BY
        `ptgp`.`player_id` ASC SEPARATOR ','
    ),
    ',',
    '-'
  ) AS `lineup_hash`
FROM
  (
    `lba`.`player_team_game_play` `ptgp`
    JOIN `lba`.`play` `p` ON((`p`.`id` = `ptgp`.`play_id`))
  )
GROUP BY
  `p`.`id`,
  `ptgp`.`team_id`
HAVING
  (
    (
      length(`player_ids`) - length(REPLACE(`player_ids`, ',', ''))
    ) = 4
  )