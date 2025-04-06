SELECT
  `ptgp`.`player_id` AS `player_id`,
  `ptgp`.`game_id` AS `game_id`,
(
    floor((`ptgp`.`total_seconds_played_before` / 60)) + 1
  ) AS `minute`,
  count(
    DISTINCT (
      CASE
        WHEN (
          (`sp`.`player_made_id` = `ptgp`.`player_id`)
          AND (`sp`.`foul_id` IS NOT NULL)
        ) THEN `sp`.`id`
      END
    )
  ) AS `fouls_committed`,
  count(
    DISTINCT (
      CASE
        WHEN (
          (`sp`.`player_suffered_id` = `ptgp`.`player_id`)
          AND (`sp`.`foul_id` IS NOT NULL)
        ) THEN `sp`.`id`
      END
    )
  ) AS `fouls_received`,
  sum(
    (
      CASE
        WHEN (
          (`sp`.`player_made_id` = `ptgp`.`player_id`)
          AND (`ds`.`point` > 0)
          AND (`ds`.`made_01` = '1')
        ) THEN `ds`.`point`
        ELSE 0
      END
    )
  ) AS `points`,
  sum(
    (
      CASE
        WHEN (
          (`sp`.`player_made_id` = `ptgp`.`player_id`)
          AND (`ds`.`point` = 2)
          AND (`ds`.`made_01` = '1')
        ) THEN 1
        ELSE 0
      END
    )
  ) AS `made_2pt`,
  sum(
    (
      CASE
        WHEN (
          (`sp`.`player_made_id` = `ptgp`.`player_id`)
          AND (`ds`.`point` = 2)
          AND (`ds`.`made_01` = '0')
        ) THEN 1
        ELSE 0
      END
    )
  ) AS `missed_2pt`,
  round(
    (
      (
        sum(
          (
            CASE
              WHEN (
                (`sp`.`player_made_id` = `ptgp`.`player_id`)
                AND (`ds`.`point` = 2)
                AND (`ds`.`made_01` = '1')
              ) THEN 1
              ELSE 0
            END
          )
        ) * 100.0
      ) / nullif(
        sum(
          (
            CASE
              WHEN (
                (`sp`.`player_made_id` = `ptgp`.`player_id`)
                AND (`ds`.`point` = 2)
              ) THEN 1
              ELSE 0
            END
          )
        ),
        0
      )
    ),
    1
  ) AS `pct_2pt`,
  sum(
    (
      CASE
        WHEN (
          (`sp`.`player_made_id` = `ptgp`.`player_id`)
          AND (`ds`.`point` = 3)
          AND (`ds`.`made_01` = '1')
        ) THEN 1
        ELSE 0
      END
    )
  ) AS `made_3pt`,
  sum(
    (
      CASE
        WHEN (
          (`sp`.`player_made_id` = `ptgp`.`player_id`)
          AND (`ds`.`point` = 3)
          AND (`ds`.`made_01` = '0')
        ) THEN 1
        ELSE 0
      END
    )
  ) AS `missed_3pt`,
  round(
    (
      (
        sum(
          (
            CASE
              WHEN (
                (`sp`.`player_made_id` = `ptgp`.`player_id`)
                AND (`ds`.`point` = 3)
                AND (`ds`.`made_01` = '1')
              ) THEN 1
              ELSE 0
            END
          )
        ) * 100.0
      ) / nullif(
        sum(
          (
            CASE
              WHEN (
                (`sp`.`player_made_id` = `ptgp`.`player_id`)
                AND (`ds`.`point` = 3)
              ) THEN 1
              ELSE 0
            END
          )
        ),
        0
      )
    ),
    1
  ) AS `pct_3pt`,
  sum(
    (
      CASE
        WHEN (
          (`sp`.`player_made_id` = `ptgp`.`player_id`)
          AND (`ds`.`point` = 1)
          AND (`ds`.`made_01` = '1')
        ) THEN 1
        ELSE 0
      END
    )
  ) AS `made_ft`,
  sum(
    (
      CASE
        WHEN (
          (`sp`.`player_made_id` = `ptgp`.`player_id`)
          AND (`ds`.`point` = 1)
          AND (`ds`.`made_01` = '0')
        ) THEN 1
        ELSE 0
      END
    )
  ) AS `missed_ft`,
  round(
    (
      (
        sum(
          (
            CASE
              WHEN (
                (`sp`.`player_made_id` = `ptgp`.`player_id`)
                AND (`ds`.`point` = 1)
                AND (`ds`.`made_01` = '1')
              ) THEN 1
              ELSE 0
            END
          )
        ) * 100.0
      ) / nullif(
        sum(
          (
            CASE
              WHEN (
                (`sp`.`player_made_id` = `ptgp`.`player_id`)
                AND (`ds`.`point` = 1)
              ) THEN 1
              ELSE 0
            END
          )
        ),
        0
      )
    ),
    1
  ) AS `pct_ft`,
  count(
    DISTINCT (
      CASE
        WHEN (
          (`sp`.`player_made_id` = `ptgp`.`player_id`)
          AND (`sp`.`rebound_offensive_01` = '1')
        ) THEN `sp`.`id`
      END
    )
  ) AS `off_reb`,
  count(
    DISTINCT (
      CASE
        WHEN (
          (`sp`.`player_made_id` = `ptgp`.`player_id`)
          AND (`sp`.`rebound_defensive_01` = '1')
        ) THEN `sp`.`id`
      END
    )
  ) AS `def_reb`,
  count(
    DISTINCT (
      CASE
        WHEN (
          (`sp`.`player_made_id` = `ptgp`.`player_id`)
          AND (`sp`.`blocks_01` = '1')
        ) THEN `sp`.`id`
      END
    )
  ) AS `blocks_made`,
  count(
    DISTINCT (
      CASE
        WHEN (
          (`sp`.`player_suffered_id` = `ptgp`.`player_id`)
          AND (`sp`.`blocks_01` = '1')
        ) THEN `sp`.`id`
      END
    )
  ) AS `blocks_suffered`,
  count(
    DISTINCT (
      CASE
        WHEN (
          (`sp`.`player_made_id` = `ptgp`.`player_id`)
          AND (`sp`.`turnover_id` IS NOT NULL)
        ) THEN `sp`.`id`
      END
    )
  ) AS `turnovers`,
  count(
    DISTINCT (
      CASE
        WHEN (
          (`sp`.`player_suffered_id` = `ptgp`.`player_id`)
          AND (`sp`.`turnover_id` IS NOT NULL)
        ) THEN `sp`.`id`
      END
    )
  ) AS `steals`,
  count(
    DISTINCT (
      CASE
        WHEN (
          (`sp`.`player_made_id` = `ptgp`.`player_id`)
          AND (`sp`.`assist_01` = '1')
        ) THEN `sp`.`id`
      END
    )
  ) AS `assists`
FROM
  (
    (
      (
        `lba`.`player_team_game_play` `ptgp`
        JOIN `lba`.`play` `p` ON((`p`.`id` = `ptgp`.`play_id`))
      )
      JOIN `lba`.`sub_play` `sp` ON((`sp`.`play_id` = `p`.`id`))
    )
    LEFT JOIN `lba`.`dz_shot` `ds` ON((`ds`.`id` = `sp`.`shot_id`))
  )
GROUP BY
  `ptgp`.`player_id`,
  `ptgp`.`game_id`,
  `minute`