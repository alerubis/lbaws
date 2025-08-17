-- STEP 1: Ordina e calcola i secondi giocati
WITH ordered AS (
  SELECT 
    ptgp.player_id,
    ptgp.team_id,
    ptgp.game_id,
    ptgp.play_id,
    ptgp.seconds_start,
    ptgp.seconds_end,
    (ptgp.seconds_end - ptgp.seconds_start) AS seconds_played,
    LAG(ptgp.seconds_end) OVER (
      PARTITION BY ptgp.player_id, ptgp.team_id, ptgp.game_id
      ORDER BY ptgp.play_id
    ) AS previous_end
  FROM player_team_game_play ptgp
),

-- STEP 2: Calcola total_seconds_precedenti
running_totals AS (
  SELECT 
    *,
    SUM(seconds_played) OVER (
      PARTITION BY player_id, team_id, game_id
      ORDER BY play_id
      ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING
    ) AS total_before_calc
  FROM ordered
),

-- STEP 3: Individua le interruzioni di continuità
consecutive_flagged AS (
  SELECT *,
    CASE
      WHEN previous_end IS NULL OR previous_end != seconds_start THEN 1
      ELSE 0
    END AS is_new_streak
  FROM running_totals
),

-- STEP 4: Raggruppa le sequenze consecutive
grouped_consecutives AS (
  SELECT *,
    SUM(is_new_streak) OVER (
      PARTITION BY player_id, team_id, game_id
      ORDER BY play_id
      ROWS UNBOUNDED PRECEDING
    ) AS streak_group
  FROM consecutive_flagged
),

-- STEP 5: Calcola la somma consecutiva per ogni blocco
consecutive_sums AS (
  SELECT 
    player_id,
    team_id,
    game_id,
    play_id,
    IFNULL(total_before_calc, 0) AS total_seconds_played_before,
    SUM(seconds_played) OVER (
      PARTITION BY player_id, team_id, game_id, streak_group
      ORDER BY play_id
    ) AS consecutive_seconds_playing
  FROM grouped_consecutives
)

-- STEP 6: Aggiorna la tabella principale
UPDATE player_team_game_play ptgp
JOIN consecutive_sums cs
  ON ptgp.player_id = cs.player_id
  AND ptgp.team_id = cs.team_id
  AND ptgp.game_id = cs.game_id
  AND ptgp.play_id = cs.play_id
SET 
  ptgp.total_seconds_played_before = cs.total_seconds_played_before,
  ptgp.consecutive_seconds_playing = cs.consecutive_seconds_playing;
