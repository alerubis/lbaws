CREATE VIEW v_team_year_league_summary AS
SELECT
    t.id AS team_id,
    t.name AS team_name,
    ly.id AS league_year_id,
    l.id AS league_id,
    l.name AS league_name,
    COUNT(sp.id) AS total_sub_plays,

    -- Shot types aggregation
    SUM(CASE WHEN sp.shot_id IS NOT NULL THEN 1 ELSE 0 END) AS total_shots,
    SUM(CASE WHEN ds.point = 1 AND ds.made_01 = '1' THEN 1 ELSE 0 END) AS one_point_shots_made,
    SUM(CASE WHEN ds.point = 1 AND ds.made_01 = '0' THEN 1 ELSE 0 END) AS one_point_shots_miss,
    SUM(CASE WHEN ds.point = 2 AND ds.made_01 = '1' THEN 1 ELSE 0 END) AS two_point_shots_made,
    SUM(CASE WHEN ds.point = 2 AND ds.made_01 = '0' THEN 1 ELSE 0 END) AS two_point_shots_miss,
    SUM(CASE WHEN ds.point = 3 AND ds.made_01 = '1' THEN 1 ELSE 0 END) AS three_point_shots_made,
    SUM(CASE WHEN ds.point = 3 AND ds.made_01 = '0' THEN 1 ELSE 0 END) AS three_point_shots_miss,

    -- Shot perc
    CASE
        WHEN SUM(CASE WHEN ds.point = 1 THEN 1 ELSE 0 END) > 0
        THEN SUM(CASE WHEN ds.point = 1 AND ds.made_01 = '1' THEN 1 ELSE 0 END) / SUM(CASE WHEN ds.point = 1 THEN 1 ELSE 0 END)
        ELSE 0
    END AS one_point_shot_perc,
    CASE
        WHEN SUM(CASE WHEN ds.point = 2 THEN 1 ELSE 0 END) > 0
        THEN SUM(CASE WHEN ds.point = 2 AND ds.made_01 = '1' THEN 1 ELSE 0 END) / SUM(CASE WHEN ds.point = 2 THEN 1 ELSE 0 END)
        ELSE 0
    END AS two_point_shot_perc,
    CASE
        WHEN SUM(CASE WHEN ds.point = 3 THEN 1 ELSE 0 END) > 0
        THEN SUM(CASE WHEN ds.point = 3 AND ds.made_01 = '1' THEN 1 ELSE 0 END) / SUM(CASE WHEN ds.point = 3 THEN 1 ELSE 0 END)
        ELSE 0
    END AS three_point_shot_perc,

    -- Fouls aggregation
    SUM(CASE WHEN sp.foul_id IS NOT NULL THEN 1 ELSE 0 END) AS total_fouls,

    -- Infractions aggregation
    SUM(CASE WHEN sp.infraction_id IS NOT NULL THEN 1 ELSE 0 END) AS total_infractions,

    -- Turnovers aggregation
    SUM(CASE WHEN sp.turnover_id IS NOT NULL THEN 1 ELSE 0 END) AS total_turnovers,

    -- Boolean values aggregation
    SUM(CASE WHEN sp.rebound_defensive_01 = '1' THEN 1 ELSE 0 END) AS total_defensive_rebounds,
    SUM(CASE WHEN sp.rebound_offensive_01 = '1' THEN 1 ELSE 0 END) AS total_offensive_rebounds,
    SUM(CASE WHEN sp.assist_01 = '1' THEN 1 ELSE 0 END) AS total_assists,
    SUM(CASE WHEN sp.blocks_01 = '1' THEN 1 ELSE 0 END) AS total_blocks,
    SUM(CASE WHEN sp.time_out_01 = '1' THEN 1 ELSE 0 END) AS total_timeouts

FROM game g
JOIN league_year ly ON g.league_year_id = ly.id
JOIN league l ON ly.league_id = l.id
JOIN play p ON g.id = p.game_id
JOIN sub_play sp ON p.id = sp.play_id
LEFT JOIN dz_shot ds ON sp.shot_id = ds.id
LEFT JOIN dz_foul df ON sp.foul_id = df.id
LEFT JOIN dz_infraction di ON sp.infraction_id = di.id
LEFT JOIN dz_turnover dt ON sp.turnover_id = dt.id
JOIN team t ON t.id IN (sp.team_made_id, sp.team_suffered_id)
GROUP BY t.id, ly.id, l.id;


CREATE VIEW v_team_year_league_summary_seconds_play AS
SELECT
    t.id AS team_id,
    t.name AS team_name,
    ly.id AS league_year_id,
    l.id AS league_id,
    l.name AS league_name,
    sp.seconds_da_start AS second_in_play,
    COUNT(sp.id) AS total_sub_plays,

    -- Shot types aggregation
    SUM(CASE WHEN sp.shot_id IS NOT NULL THEN 1 ELSE 0 END) AS total_shots,
    SUM(CASE WHEN ds.point = 1 AND ds.made_01 = '1' THEN 1 ELSE 0 END) AS one_point_shots_made,
    SUM(CASE WHEN ds.point = 1 AND ds.made_01 = '0' THEN 1 ELSE 0 END) AS one_point_shots_miss,
    SUM(CASE WHEN ds.point = 2 AND ds.made_01 = '1' THEN 1 ELSE 0 END) AS two_point_shots_made,
    SUM(CASE WHEN ds.point = 2 AND ds.made_01 = '0' THEN 1 ELSE 0 END) AS two_point_shots_miss,
    SUM(CASE WHEN ds.point = 3 AND ds.made_01 = '1' THEN 1 ELSE 0 END) AS three_point_shots_made,
    SUM(CASE WHEN ds.point = 3 AND ds.made_01 = '0' THEN 1 ELSE 0 END) AS three_point_shots_miss,

    -- Shot ratios
    CASE
        WHEN SUM(CASE WHEN ds.point = 1 THEN 1 ELSE 0 END) > 0
        THEN SUM(CASE WHEN ds.point = 1 AND ds.made_01 = '1' THEN 1 ELSE 0 END) / SUM(CASE WHEN ds.point = 1 THEN 1 ELSE 0 END)
        ELSE 0
    END AS one_point_shot_ratio,
    CASE
        WHEN SUM(CASE WHEN ds.point = 2 THEN 1 ELSE 0 END) > 0
        THEN SUM(CASE WHEN ds.point = 2 AND ds.made_01 = '1' THEN 1 ELSE 0 END) / SUM(CASE WHEN ds.point = 2 THEN 1 ELSE 0 END)
        ELSE 0
    END AS two_point_shot_ratio,
    CASE
        WHEN SUM(CASE WHEN ds.point = 3 THEN 1 ELSE 0 END) > 0
        THEN SUM(CASE WHEN ds.point = 3 AND ds.made_01 = '1' THEN 1 ELSE 0 END) / SUM(CASE WHEN ds.point = 3 THEN 1 ELSE 0 END)
        ELSE 0
    END AS three_point_shot_ratio,

    -- Fouls aggregation
    SUM(CASE WHEN sp.foul_id IS NOT NULL THEN 1 ELSE 0 END) AS total_fouls,

    -- Infractions aggregation
    SUM(CASE WHEN sp.infraction_id IS NOT NULL THEN 1 ELSE 0 END) AS total_infractions,

    -- Turnovers aggregation
    SUM(CASE WHEN sp.turnover_id IS NOT NULL THEN 1 ELSE 0 END) AS total_turnovers,

    -- Boolean values aggregation
    SUM(CASE WHEN sp.rebound_defensive_01 = '1' THEN 1 ELSE 0 END) AS total_defensive_rebounds,
    SUM(CASE WHEN sp.rebound_offensive_01 = '1' THEN 1 ELSE 0 END) AS total_offensive_rebounds,
    SUM(CASE WHEN sp.assist_01 = '1' THEN 1 ELSE 0 END) AS total_assists,
    SUM(CASE WHEN sp.blocks_01 = '1' THEN 1 ELSE 0 END) AS total_blocks,
    SUM(CASE WHEN sp.time_out_01 = '1' THEN 1 ELSE 0 END) AS total_timeouts

FROM game g
JOIN league_year ly ON g.league_year_id = ly.id
JOIN league l ON ly.league_id = l.id
JOIN play p ON g.id = p.game_id
JOIN sub_play sp ON p.id = sp.play_id
LEFT JOIN dz_shot ds ON sp.shot_id = ds.id
LEFT JOIN dz_foul df ON sp.foul_id = df.id
LEFT JOIN dz_infraction di ON sp.infraction_id = di.id
LEFT JOIN dz_turnover dt ON sp.turnover_id = dt.id
JOIN team t ON t.id IN (sp.team_made_id, sp.team_suffered_id)
GROUP BY t.id, ly.id, l.id, sp.seconds_da_start;


CREATE VIEW v_team_year_league_summary_minutes_quarter AS
SELECT
    t.id AS team_id,
    t.name AS team_name,
    ly.id AS league_year_id,
    l.id AS league_id,
    l.name AS league_name,
    FLOOR((p.seconds_start % 600) / 60) AS minute_in_quarter,
    COUNT(sp.id) AS total_sub_plays,

    -- Shot types aggregation
    SUM(CASE WHEN sp.shot_id IS NOT NULL THEN 1 ELSE 0 END) AS total_shots,
    SUM(CASE WHEN ds.point = 1 AND ds.made_01 = '1' THEN 1 ELSE 0 END) AS one_point_shots_made,
    SUM(CASE WHEN ds.point = 1 AND ds.made_01 = '0' THEN 1 ELSE 0 END) AS one_point_shots_miss,
    SUM(CASE WHEN ds.point = 2 AND ds.made_01 = '1' THEN 1 ELSE 0 END) AS two_point_shots_made,
    SUM(CASE WHEN ds.point = 2 AND ds.made_01 = '0' THEN 1 ELSE 0 END) AS two_point_shots_miss,
    SUM(CASE WHEN ds.point = 3 AND ds.made_01 = '1' THEN 1 ELSE 0 END) AS three_point_shots_made,
    SUM(CASE WHEN ds.point = 3 AND ds.made_01 = '0' THEN 1 ELSE 0 END) AS three_point_shots_miss,

    -- Shot ratios
    CASE
        WHEN SUM(CASE WHEN ds.point = 1 THEN 1 ELSE 0 END) > 0
        THEN SUM(CASE WHEN ds.point = 1 AND ds.made_01 = '1' THEN 1 ELSE 0 END) / SUM(CASE WHEN ds.point = 1 THEN 1 ELSE 0 END)
        ELSE 0
    END AS one_point_shot_ratio,
    CASE
        WHEN SUM(CASE WHEN ds.point = 2 THEN 1 ELSE 0 END) > 0
        THEN SUM(CASE WHEN ds.point = 2 AND ds.made_01 = '1' THEN 1 ELSE 0 END) / SUM(CASE WHEN ds.point = 2 THEN 1 ELSE 0 END)
        ELSE 0
    END AS two_point_shot_ratio,
    CASE
        WHEN SUM(CASE WHEN ds.point = 3 THEN 1 ELSE 0 END) > 0
        THEN SUM(CASE WHEN ds.point = 3 AND ds.made_01 = '1' THEN 1 ELSE 0 END) / SUM(CASE WHEN ds.point = 3 THEN 1 ELSE 0 END)
        ELSE 0
    END AS three_point_shot_ratio,

    -- Fouls aggregation
    SUM(CASE WHEN sp.foul_id IS NOT NULL THEN 1 ELSE 0 END) AS total_fouls,

    -- Infractions aggregation
    SUM(CASE WHEN sp.infraction_id IS NOT NULL THEN 1 ELSE 0 END) AS total_infractions,

    -- Turnovers aggregation
    SUM(CASE WHEN sp.turnover_id IS NOT NULL THEN 1 ELSE 0 END) AS total_turnovers,

    -- Boolean values aggregation
    SUM(CASE WHEN sp.rebound_defensive_01 = '1' THEN 1 ELSE 0 END) AS total_defensive_rebounds,
    SUM(CASE WHEN sp.rebound_offensive_01 = '1' THEN 1 ELSE 0 END) AS total_offensive_rebounds,
    SUM(CASE WHEN sp.assist_01 = '1' THEN 1 ELSE 0 END) AS total_assists,
    SUM(CASE WHEN sp.blocks_01 = '1' THEN 1 ELSE 0 END) AS total_blocks,
    SUM(CASE WHEN sp.time_out_01 = '1' THEN 1 ELSE 0 END) AS total_timeouts

FROM game g
JOIN league_year ly ON g.league_year_id = ly.id
JOIN league l ON ly.league_id = l.id
JOIN play p ON g.id = p.game_id
JOIN sub_play sp ON p.id = sp.play_id
LEFT JOIN dz_shot ds ON sp.shot_id = ds.id
LEFT JOIN dz_foul df ON sp.foul_id = df.id
LEFT JOIN dz_infraction di ON sp.infraction_id = di.id
LEFT JOIN dz_turnover dt ON sp.turnover_id = dt.id
JOIN team t ON t.id IN (sp.team_made_id, sp.team_suffered_id)
GROUP BY t.id, ly.id, l.id, minute_in_quarter;


CREATE VIEW v_team_year_league_summary_minutes_game AS
SELECT
    t.id AS team_id,
    t.name AS team_name,
    ly.id AS league_year_id,
    l.id AS league_id,
    l.name AS league_name,
    FLOOR(p.seconds_start / 60) AS minute_in_game,
    COUNT(sp.id) AS total_sub_plays,

    -- Shot types aggregation
    SUM(CASE WHEN sp.shot_id IS NOT NULL THEN 1 ELSE 0 END) AS total_shots,
    SUM(CASE WHEN ds.point = 1 AND ds.made_01 = '1' THEN 1 ELSE 0 END) AS one_point_shots_made,
    SUM(CASE WHEN ds.point = 1 AND ds.made_01 = '0' THEN 1 ELSE 0 END) AS one_point_shots_miss,
    SUM(CASE WHEN ds.point = 2 AND ds.made_01 = '1' THEN 1 ELSE 0 END) AS two_point_shots_made,
    SUM(CASE WHEN ds.point = 2 AND ds.made_01 = '0' THEN 1 ELSE 0 END) AS two_point_shots_miss,
    SUM(CASE WHEN ds.point = 3 AND ds.made_01 = '1' THEN 1 ELSE 0 END) AS three_point_shots_made,
    SUM(CASE WHEN ds.point = 3 AND ds.made_01 = '0' THEN 1 ELSE 0 END) AS three_point_shots_miss,

    -- Shot ratios
    CASE
        WHEN SUM(CASE WHEN ds.point = 1 THEN 1 ELSE 0 END) > 0
        THEN SUM(CASE WHEN ds.point = 1 AND ds.made_01 = '1' THEN 1 ELSE 0 END) / SUM(CASE WHEN ds.point = 1 THEN 1 ELSE 0 END)
        ELSE 0
    END AS one_point_shot_ratio,
    CASE
        WHEN SUM(CASE WHEN ds.point = 2 THEN 1 ELSE 0 END) > 0
        THEN SUM(CASE WHEN ds.point = 2 AND ds.made_01 = '1' THEN 1 ELSE 0 END) / SUM(CASE WHEN ds.point = 2 THEN 1 ELSE 0 END)
        ELSE 0
    END AS two_point_shot_ratio,
    CASE
        WHEN SUM(CASE WHEN ds.point = 3 THEN 1 ELSE 0 END) > 0
        THEN SUM(CASE WHEN ds.point = 3 AND ds.made_01 = '1' THEN 1 ELSE 0 END) / SUM(CASE WHEN ds.point = 3 THEN 1 ELSE 0 END)
        ELSE 0
    END AS three_point_shot_ratio,

    -- Fouls aggregation
    SUM(CASE WHEN sp.foul_id IS NOT NULL THEN 1 ELSE 0 END) AS total_fouls,

    -- Infractions aggregation
    SUM(CASE WHEN sp.infraction_id IS NOT NULL THEN 1 ELSE 0 END) AS total_infractions,

    -- Turnovers aggregation
    SUM(CASE WHEN sp.turnover_id IS NOT NULL THEN 1 ELSE 0 END) AS total_turnovers,

    -- Boolean values aggregation
    SUM(CASE WHEN sp.rebound_defensive_01 = '1' THEN 1 ELSE 0 END) AS total_defensive_rebounds,
    SUM(CASE WHEN sp.rebound_offensive_01 = '1' THEN 1 ELSE 0 END) AS total_offensive_rebounds,
    SUM(CASE WHEN sp.assist_01 = '1' THEN 1 ELSE 0 END) AS total_assists,
    SUM(CASE WHEN sp.blocks_01 = '1' THEN 1 ELSE 0 END) AS total_blocks,
    SUM(CASE WHEN sp.time_out_01 = '1' THEN 1 ELSE 0 END) AS total_timeouts

FROM game g
JOIN league_year ly ON g.league_year_id = ly.id
JOIN league l ON ly.league_id = l.id
JOIN play p ON g.id = p.game_id
JOIN sub_play sp ON p.id = sp.play_id
LEFT JOIN dz_shot ds ON sp.shot_id = ds.id
LEFT JOIN dz_foul df ON sp.foul_id = df.id
LEFT JOIN dz_infraction di ON sp.infraction_id = di.id
LEFT JOIN dz_turnover dt ON sp.turnover_id = dt.id
JOIN team t ON t.id IN (sp.team_made_id, sp.team_suffered_id)
GROUP BY t.id, ly.id, l.id, minute_in_game;


CREATE VIEW v_player_year_league_summary AS
SELECT
    p.id AS player_id,
    p.name AS player_name,
    p.surname AS player_surname,
    ly.id AS league_year_id,
    l.id AS league_id,
    l.name AS league_name,
    COUNT(sp.id) AS total_sub_plays,

    -- Shot types aggregation
    SUM(CASE WHEN sp.shot_id IS NOT NULL THEN 1 ELSE 0 END) AS total_shots,
    SUM(CASE WHEN ds.point = 1 AND ds.made_01 = '1' THEN 1 ELSE 0 END) AS one_point_shots_made,
    SUM(CASE WHEN ds.point = 1 AND ds.made_01 = '0' THEN 1 ELSE 0 END) AS one_point_shots_miss,
    SUM(CASE WHEN ds.point = 2 AND ds.made_01 = '1' THEN 1 ELSE 0 END) AS two_point_shots_made,
    SUM(CASE WHEN ds.point = 2 AND ds.made_01 = '0' THEN 1 ELSE 0 END) AS two_point_shots_miss,
    SUM(CASE WHEN ds.point = 3 AND ds.made_01 = '1' THEN 1 ELSE 0 END) AS three_point_shots_made,
    SUM(CASE WHEN ds.point = 3 AND ds.made_01 = '0' THEN 1 ELSE 0 END) AS three_point_shots_miss,

    -- Shot ratios
    CASE
        WHEN SUM(CASE WHEN ds.point = 1 THEN 1 ELSE 0 END) > 0
        THEN SUM(CASE WHEN ds.point = 1 AND ds.made_01 = '1' THEN 1 ELSE 0 END) / SUM(CASE WHEN ds.point = 1 THEN 1 ELSE 0 END)
        ELSE 0
    END AS one_point_shot_ratio,
    CASE
        WHEN SUM(CASE WHEN ds.point = 2 THEN 1 ELSE 0 END) > 0
        THEN SUM(CASE WHEN ds.point = 2 AND ds.made_01 = '1' THEN 1 ELSE 0 END) / SUM(CASE WHEN ds.point = 2 THEN 1 ELSE 0 END)
        ELSE 0
    END AS two_point_shot_ratio,
    CASE
        WHEN SUM(CASE WHEN ds.point = 3 THEN 1 ELSE 0 END) > 0
        THEN SUM(CASE WHEN ds.point = 3 AND ds.made_01 = '1' THEN 1 ELSE 0 END) / SUM(CASE WHEN ds.point = 3 THEN 1 ELSE 0 END)
        ELSE 0
    END AS three_point_shot_ratio,

    -- Fouls aggregation
    SUM(CASE WHEN sp.foul_id IS NOT NULL THEN 1 ELSE 0 END) AS total_fouls,

    -- Infractions aggregation
    SUM(CASE WHEN sp.infraction_id IS NOT NULL THEN 1 ELSE 0 END) AS total_infractions,

    -- Turnovers aggregation
    SUM(CASE WHEN sp.turnover_id IS NOT NULL THEN 1 ELSE 0 END) AS total_turnovers,

    -- Boolean values aggregation
    SUM(CASE WHEN sp.rebound_defensive_01 = '1' THEN 1 ELSE 0 END) AS total_defensive_rebounds,
    SUM(CASE WHEN sp.rebound_offensive_01 = '1' THEN 1 ELSE 0 END) AS total_offensive_rebounds,
    SUM(CASE WHEN sp.assist_01 = '1' THEN 1 ELSE 0 END) AS total_assists,
    SUM(CASE WHEN sp.blocks_01 = '1' THEN 1 ELSE 0 END) AS total_blocks,
    SUM(CASE WHEN sp.time_out_01 = '1' THEN 1 ELSE 0 END) AS total_timeouts

FROM game g
JOIN league_year ly ON g.league_year_id = ly.id
JOIN league l ON ly.league_id = l.id
JOIN play pl ON g.id = pl.game_id
JOIN sub_play sp ON pl.id = sp.play_id
LEFT JOIN dz_shot ds ON sp.shot_id = ds.id
LEFT JOIN dz_foul df ON sp.foul_id = df.id
LEFT JOIN dz_infraction di ON sp.infraction_id = di.id
LEFT JOIN dz_turnover dt ON sp.turnover_id = dt.id
JOIN player p ON p.id = sp.player_made_id OR p.id = sp.player_suffered_id
GROUP BY p.id, ly.id, l.id;


CREATE VIEW v_player_year_league_summary_seconds_play AS
SELECT
    p.id AS player_id,
    p.name AS player_name,
    ly.id AS league_year_id,
    l.id AS league_id,
    l.name AS league_name,
    sp.seconds_da_start AS second_in_play,
    COUNT(sp.id) AS total_sub_plays,

    -- Shot types aggregation
    SUM(CASE WHEN sp.shot_id IS NOT NULL THEN 1 ELSE 0 END) AS total_shots,
    SUM(CASE WHEN ds.point = 1 AND ds.made_01 = '1' THEN 1 ELSE 0 END) AS one_point_shots_made,
    SUM(CASE WHEN ds.point = 1 AND ds.made_01 = '0' THEN 1 ELSE 0 END) AS one_point_shots_miss,
    SUM(CASE WHEN ds.point = 2 AND ds.made_01 = '1' THEN 1 ELSE 0 END) AS two_point_shots_made,
    SUM(CASE WHEN ds.point = 2 AND ds.made_01 = '0' THEN 1 ELSE 0 END) AS two_point_shots_miss,
    SUM(CASE WHEN ds.point = 3 AND ds.made_01 = '1' THEN 1 ELSE 0 END) AS three_point_shots_made,
    SUM(CASE WHEN ds.point = 3 AND ds.made_01 = '0' THEN 1 ELSE 0 END) AS three_point_shots_miss,

    -- Shot ratios
    CASE
        WHEN SUM(CASE WHEN ds.point = 1 THEN 1 ELSE 0 END) > 0
        THEN SUM(CASE WHEN ds.point = 1 AND ds.made_01 = '1' THEN 1 ELSE 0 END) / SUM(CASE WHEN ds.point = 1 THEN 1 ELSE 0 END)
        ELSE 0
    END AS one_point_shot_ratio,
    CASE
        WHEN SUM(CASE WHEN ds.point = 2 THEN 1 ELSE 0 END) > 0
        THEN SUM(CASE WHEN ds.point = 2 AND ds.made_01 = '1' THEN 1 ELSE 0 END) / SUM(CASE WHEN ds.point = 2 THEN 1 ELSE 0 END)
        ELSE 0
    END AS two_point_shot_ratio,
    CASE
        WHEN SUM(CASE WHEN ds.point = 3 THEN 1 ELSE 0 END) > 0
        THEN SUM(CASE WHEN ds.point = 3 AND ds.made_01 = '1' THEN 1 ELSE 0 END) / SUM(CASE WHEN ds.point = 3 THEN 1 ELSE 0 END)
        ELSE 0
    END AS three_point_shot_ratio,

    -- Fouls aggregation
    SUM(CASE WHEN sp.foul_id IS NOT NULL THEN 1 ELSE 0 END) AS total_fouls,

    -- Infractions aggregation
    SUM(CASE WHEN sp.infraction_id IS NOT NULL THEN 1 ELSE 0 END) AS total_infractions,

    -- Turnovers aggregation
    SUM(CASE WHEN sp.turnover_id IS NOT NULL THEN 1 ELSE 0 END) AS total_turnovers,

    -- Boolean values aggregation
    SUM(CASE WHEN sp.rebound_defensive_01 = '1' THEN 1 ELSE 0 END) AS total_defensive_rebounds,
    SUM(CASE WHEN sp.rebound_offensive_01 = '1' THEN 1 ELSE 0 END) AS total_offensive_rebounds,
    SUM(CASE WHEN sp.assist_01 = '1' THEN 1 ELSE 0 END) AS total_assists,
    SUM(CASE WHEN sp.blocks_01 = '1' THEN 1 ELSE 0 END) AS total_blocks,
    SUM(CASE WHEN sp.time_out_01 = '1' THEN 1 ELSE 0 END) AS total_timeouts

FROM game g
JOIN league_year ly ON g.league_year_id = ly.id
JOIN league l ON ly.league_id = l.id
JOIN play pl ON g.id = pl.game_id
JOIN sub_play sp ON pl.id = sp.play_id
LEFT JOIN dz_shot ds ON sp.shot_id = ds.id
LEFT JOIN dz_foul df ON sp.foul_id = df.id
LEFT JOIN dz_infraction di ON sp.infraction_id = di.id
LEFT JOIN dz_turnover dt ON sp.turnover_id = dt.id
JOIN player p ON p.id = sp.player_made_id
GROUP BY p.id, ly.id, l.id, sp.seconds_da_start;


CREATE VIEW v_player_year_league_summary_minute_quarter AS
SELECT
    p.id AS player_id,
    p.name AS player_name,
    ly.id AS league_year_id,
    l.id AS league_id,
    l.name AS league_name,
    FLOOR((pl.seconds_start % 600) / 60) AS minute_in_quarter,
    COUNT(sp.id) AS total_sub_plays,

    -- Shot types aggregation
    SUM(CASE WHEN sp.shot_id IS NOT NULL THEN 1 ELSE 0 END) AS total_shots,
    SUM(CASE WHEN ds.point = 1 AND ds.made_01 = '1' THEN 1 ELSE 0 END) AS one_point_shots_made,
    SUM(CASE WHEN ds.point = 1 AND ds.made_01 = '0' THEN 1 ELSE 0 END) AS one_point_shots_miss,
    SUM(CASE WHEN ds.point = 2 AND ds.made_01 = '1' THEN 1 ELSE 0 END) AS two_point_shots_made,
    SUM(CASE WHEN ds.point = 2 AND ds.made_01 = '0' THEN 1 ELSE 0 END) AS two_point_shots_miss,
    SUM(CASE WHEN ds.point = 3 AND ds.made_01 = '1' THEN 1 ELSE 0 END) AS three_point_shots_made,
    SUM(CASE WHEN ds.point = 3 AND ds.made_01 = '0' THEN 1 ELSE 0 END) AS three_point_shots_miss,

    -- Shot ratios
    CASE
        WHEN SUM(CASE WHEN ds.point = 1 THEN 1 ELSE 0 END) > 0
        THEN SUM(CASE WHEN ds.point = 1 AND ds.made_01 = '1' THEN 1 ELSE 0 END) / SUM(CASE WHEN ds.point = 1 THEN 1 ELSE 0 END)
        ELSE 0
    END AS one_point_shot_ratio,
    CASE
        WHEN SUM(CASE WHEN ds.point = 2 THEN 1 ELSE 0 END) > 0
        THEN SUM(CASE WHEN ds.point = 2 AND ds.made_01 = '1' THEN 1 ELSE 0 END) / SUM(CASE WHEN ds.point = 2 THEN 1 ELSE 0 END)
        ELSE 0
    END AS two_point_shot_ratio,
    CASE
        WHEN SUM(CASE WHEN ds.point = 3 THEN 1 ELSE 0 END) > 0
        THEN SUM(CASE WHEN ds.point = 3 AND ds.made_01 = '1' THEN 1 ELSE 0 END) / SUM(CASE WHEN ds.point = 3 THEN 1 ELSE 0 END)
        ELSE 0
    END AS three_point_shot_ratio,

    -- Fouls aggregation
    SUM(CASE WHEN sp.foul_id IS NOT NULL THEN 1 ELSE 0 END) AS total_fouls,

    -- Infractions aggregation
    SUM(CASE WHEN sp.infraction_id IS NOT NULL THEN 1 ELSE 0 END) AS total_infractions,

    -- Turnovers aggregation
    SUM(CASE WHEN sp.turnover_id IS NOT NULL THEN 1 ELSE 0 END) AS total_turnovers,

    -- Boolean values aggregation
    SUM(CASE WHEN sp.rebound_defensive_01 = '1' THEN 1 ELSE 0 END) AS total_defensive_rebounds,
    SUM(CASE WHEN sp.rebound_offensive_01 = '1' THEN 1 ELSE 0 END) AS total_offensive_rebounds,
    SUM(CASE WHEN sp.assist_01 = '1' THEN 1 ELSE 0 END) AS total_assists,
    SUM(CASE WHEN sp.blocks_01 = '1' THEN 1 ELSE 0 END) AS total_blocks,
    SUM(CASE WHEN sp.time_out_01 = '1' THEN 1 ELSE 0 END) AS total_timeouts

FROM game g
JOIN league_year ly ON g.league_year_id = ly.id
JOIN league l ON ly.league_id = l.id
JOIN play pl ON g.id = pl.game_id
JOIN sub_play sp ON pl.id = sp.play_id
LEFT JOIN dz_shot ds ON sp.shot_id = ds.id
LEFT JOIN dz_foul df ON sp.foul_id = df.id
LEFT JOIN dz_infraction di ON sp.infraction_id = di.id
LEFT JOIN dz_turnover dt ON sp.turnover_id = dt.id
JOIN player p ON p.id = sp.player_made_id
GROUP BY p.id, ly.id, l.id, minute_in_quarter;



CREATE VIEW v_player_year_league_summary_minute_game AS
SELECT
    p.id AS player_id,
    p.name AS player_name,
    ly.id AS league_year_id,
    l.id AS league_id,
    l.name AS league_name,
    FLOOR(pl.seconds_start / 60) AS minute_in_game,
    COUNT(sp.id) AS total_sub_plays,

    -- Shot types aggregation
    SUM(CASE WHEN sp.shot_id IS NOT NULL THEN 1 ELSE 0 END) AS total_shots,
    SUM(CASE WHEN ds.point = 1 AND ds.made_01 = '1' THEN 1 ELSE 0 END) AS one_point_shots_made,
    SUM(CASE WHEN ds.point = 1 AND ds.made_01 = '0' THEN 1 ELSE 0 END) AS one_point_shots_miss,
    SUM(CASE WHEN ds.point = 2 AND ds.made_01 = '1' THEN 1 ELSE 0 END) AS two_point_shots_made,
    SUM(CASE WHEN ds.point = 2 AND ds.made_01 = '0' THEN 1 ELSE 0 END) AS two_point_shots_miss,
    SUM(CASE WHEN ds.point = 3 AND ds.made_01 = '1' THEN 1 ELSE 0 END) AS three_point_shots_made,
    SUM(CASE WHEN ds.point = 3 AND ds.made_01 = '0' THEN 1 ELSE 0 END) AS three_point_shots_miss,

    -- Shot ratios
    CASE
        WHEN SUM(CASE WHEN ds.point = 1 THEN 1 ELSE 0 END) > 0
        THEN SUM(CASE WHEN ds.point = 1 AND ds.made_01 = '1' THEN 1 ELSE 0 END) / SUM(CASE WHEN ds.point = 1 THEN 1 ELSE 0 END)
        ELSE 0
    END AS one_point_shot_ratio,
    CASE
        WHEN SUM(CASE WHEN ds.point = 2 THEN 1 ELSE 0 END) > 0
        THEN SUM(CASE WHEN ds.point = 2 AND ds.made_01 = '1' THEN 1 ELSE 0 END) / SUM(CASE WHEN ds.point = 2 THEN 1 ELSE 0 END)
        ELSE 0
    END AS two_point_shot_ratio,
    CASE
        WHEN SUM(CASE WHEN ds.point = 3 THEN 1 ELSE 0 END) > 0
        THEN SUM(CASE WHEN ds.point = 3 AND ds.made_01 = '1' THEN 1 ELSE 0 END) / SUM(CASE WHEN ds.point = 3 THEN 1 ELSE 0 END)
        ELSE 0
    END AS three_point_shot_ratio,

    -- Fouls aggregation
    SUM(CASE WHEN sp.foul_id IS NOT NULL THEN 1 ELSE 0 END) AS total_fouls,

    -- Infractions aggregation
    SUM(CASE WHEN sp.infraction_id IS NOT NULL THEN 1 ELSE 0 END) AS total_infractions,

    -- Turnovers aggregation
    SUM(CASE WHEN sp.turnover_id IS NOT NULL THEN 1 ELSE 0 END) AS total_turnovers,

    -- Boolean values aggregation
    SUM(CASE WHEN sp.rebound_defensive_01 = '1' THEN 1 ELSE 0 END) AS total_defensive_rebounds,
    SUM(CASE WHEN sp.rebound_offensive_01 = '1' THEN 1 ELSE 0 END) AS total_offensive_rebounds,
    SUM(CASE WHEN sp.assist_01 = '1' THEN 1 ELSE 0 END) AS total_assists,
    SUM(CASE WHEN sp.blocks_01 = '1' THEN 1 ELSE 0 END) AS total_blocks,
    SUM(CASE WHEN sp.time_out_01 = '1' THEN 1 ELSE 0 END) AS total_timeouts

FROM game g
JOIN league_year ly ON g.league_year_id = ly.id
JOIN league l ON ly.league_id = l.id
JOIN play pl ON g.id = pl.game_id
JOIN sub_play sp ON pl.id = sp.play_id
LEFT JOIN dz_shot ds ON sp.shot_id = ds.id
LEFT JOIN dz_foul df ON sp.foul_id = df.id
LEFT JOIN dz_infraction di ON sp.infraction_id = di.id
LEFT JOIN dz_turnover dt ON sp.turnover_id = dt.id
JOIN player p ON p.id = sp.player_made_id
GROUP BY p.id, ly.id, l.id, minute_in_game;
