SELECT
  `t`.`id` AS `team_id`,
  `t`.`name` AS `team_name`,
  `ly`.`id` AS `league_year_id`,
  `l`.`id` AS `league_id`,
  `l`.`name` AS `league_name`,
  count(`sp`.`id`) AS `total_sub_plays`,
  sum(
    (
      CASE
        WHEN (`sp`.`shot_id` IS NOT NULL) THEN 1
        ELSE 0
      END
    )
  ) AS `total_shots`,
  sum(
    (
      CASE
        WHEN (
          (`ds`.`point` = 1)
          AND (`ds`.`made_01` = '1')
        ) THEN 1
        ELSE 0
      END
    )
  ) AS `one_point_shots_made`,
  sum(
    (
      CASE
        WHEN (
          (`ds`.`point` = 1)
          AND (`ds`.`made_01` = '0')
        ) THEN 1
        ELSE 0
      END
    )
  ) AS `one_point_shots_miss`,
  sum(
    (
      CASE
        WHEN (
          (`ds`.`point` = 2)
          AND (`ds`.`made_01` = '1')
        ) THEN 1
        ELSE 0
      END
    )
  ) AS `two_point_shots_made`,
  sum(
    (
      CASE
        WHEN (
          (`ds`.`point` = 2)
          AND (`ds`.`made_01` = '0')
        ) THEN 1
        ELSE 0
      END
    )
  ) AS `two_point_shots_miss`,
  sum(
    (
      CASE
        WHEN (
          (`ds`.`point` = 3)
          AND (`ds`.`made_01` = '1')
        ) THEN 1
        ELSE 0
      END
    )
  ) AS `three_point_shots_made`,
  sum(
    (
      CASE
        WHEN (
          (`ds`.`point` = 3)
          AND (`ds`.`made_01` = '0')
        ) THEN 1
        ELSE 0
      END
    )
  ) AS `three_point_shots_miss`,
(
    CASE
      WHEN (
        sum(
          (
            CASE
              WHEN (`ds`.`point` = 1) THEN 1
              ELSE 0
            END
          )
        ) > 0
      ) THEN (
        sum(
          (
            CASE
              WHEN (
                (`ds`.`point` = 1)
                AND (`ds`.`made_01` = '1')
              ) THEN 1
              ELSE 0
            END
          )
        ) / sum(
          (
            CASE
              WHEN (`ds`.`point` = 1) THEN 1
              ELSE 0
            END
          )
        )
      )
      ELSE 0
    END
  ) AS `one_point_shot_perc`,
(
    CASE
      WHEN (
        sum(
          (
            CASE
              WHEN (`ds`.`point` = 2) THEN 1
              ELSE 0
            END
          )
        ) > 0
      ) THEN (
        sum(
          (
            CASE
              WHEN (
                (`ds`.`point` = 2)
                AND (`ds`.`made_01` = '1')
              ) THEN 1
              ELSE 0
            END
          )
        ) / sum(
          (
            CASE
              WHEN (`ds`.`point` = 2) THEN 1
              ELSE 0
            END
          )
        )
      )
      ELSE 0
    END
  ) AS `two_point_shot_perc`,
(
    CASE
      WHEN (
        sum(
          (
            CASE
              WHEN (`ds`.`point` = 3) THEN 1
              ELSE 0
            END
          )
        ) > 0
      ) THEN (
        sum(
          (
            CASE
              WHEN (
                (`ds`.`point` = 3)
                AND (`ds`.`made_01` = '1')
              ) THEN 1
              ELSE 0
            END
          )
        ) / sum(
          (
            CASE
              WHEN (`ds`.`point` = 3) THEN 1
              ELSE 0
            END
          )
        )
      )
      ELSE 0
    END
  ) AS `three_point_shot_perc`,
  sum(
    (
      CASE
        WHEN (`sp`.`foul_id` IS NOT NULL) THEN 1
        ELSE 0
      END
    )
  ) AS `total_fouls`,
  sum(
    (
      CASE
        WHEN (`sp`.`infraction_id` IS NOT NULL) THEN 1
        ELSE 0
      END
    )
  ) AS `total_infractions`,
  sum(
    (
      CASE
        WHEN (`sp`.`turnover_id` IS NOT NULL) THEN 1
        ELSE 0
      END
    )
  ) AS `total_turnovers`,
  sum(
    (
      CASE
        WHEN (`sp`.`rebound_defensive_01` = '1') THEN 1
        ELSE 0
      END
    )
  ) AS `total_defensive_rebounds`,
  sum(
    (
      CASE
        WHEN (`sp`.`rebound_offensive_01` = '1') THEN 1
        ELSE 0
      END
    )
  ) AS `total_offensive_rebounds`,
  sum(
    (
      CASE
        WHEN (`sp`.`assist_01` = '1') THEN 1
        ELSE 0
      END
    )
  ) AS `total_assists`,
  sum(
    (
      CASE
        WHEN (`sp`.`blocks_01` = '1') THEN 1
        ELSE 0
      END
    )
  ) AS `total_blocks`,
  sum(
    (
      CASE
        WHEN (`sp`.`time_out_01` = '1') THEN 1
        ELSE 0
      END
    )
  ) AS `total_timeouts`
FROM
  (
    (
      (
        (
          (
            (
              (
                (
                  (
                    `lba`.`game` `g`
                    JOIN `lba`.`league_year` `ly` ON((`g`.`league_year_id` = `ly`.`id`))
                  )
                  JOIN `lba`.`league` `l` ON((`ly`.`league_id` = `l`.`id`))
                )
                JOIN `lba`.`play` `p` ON((`g`.`id` = `p`.`game_id`))
              )
              JOIN `lba`.`sub_play` `sp` ON((`p`.`id` = `sp`.`play_id`))
            )
            LEFT JOIN `lba`.`dz_shot` `ds` ON((`sp`.`shot_id` = `ds`.`id`))
          )
          LEFT JOIN `lba`.`dz_foul` `df` ON((`sp`.`foul_id` = `df`.`id`))
        )
        LEFT JOIN `lba`.`dz_infraction` `di` ON((`sp`.`infraction_id` = `di`.`id`))
      )
      LEFT JOIN `lba`.`dz_turnover` `dt` ON((`sp`.`turnover_id` = `dt`.`id`))
    )
    JOIN `lba`.`team` `t` ON(
      (
        `t`.`id` IN (`sp`.`team_made_id`, `sp`.`team_suffered_id`)
      )
    )
  )
GROUP BY
  `t`.`id`,
  `ly`.`id`,
  `l`.`id`