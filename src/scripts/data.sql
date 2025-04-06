
-- Pulisce tabelle temporanee precedenti se presenti
DROP TEMPORARY TABLE IF EXISTS tmp_play_times;
DROP TEMPORARY TABLE IF EXISTS tmp_computed;

-- Crea tabella temporanea ordinata
CREATE TEMPORARY TABLE tmp_play_times
SELECT 
  player_id,
  game_id,
  team_id,
  play_id,
  seconds_start,
  seconds_end
FROM player_team_game_play
ORDER BY player_id, game_id, seconds_start;

-- Crea nuova tabella con i campi calcolati usando variabili
SET @prev_player := NULL;
SET @prev_game := NULL;
SET @prev_end := NULL;
SET @total := 0;
SET @consec := 0;

CREATE TEMPORARY TABLE tmp_computed AS
SELECT 
  player_id,
  game_id,
  team_id,
  play_id,
  @total := IF(@prev_player = player_id AND @prev_game = game_id,
               @total + IFNULL(seconds_end,0) - IFNULL(seconds_start,0),
               IFNULL(seconds_end,0) - IFNULL(seconds_start,0)
  ) AS total_seconds_before,

  @consec := IF(@prev_player = player_id AND @prev_game = game_id AND seconds_start = @prev_end,
                @consec + IFNULL(seconds_end,0) - IFNULL(seconds_start,0),
                IFNULL(seconds_end,0) - IFNULL(seconds_start,0)
  ) AS consecutive_seconds,

  @prev_end := seconds_end,
  @prev_player := player_id,
  @prev_game := game_id

FROM tmp_play_times
ORDER BY player_id, game_id, seconds_start;

-- Aggiunge indice per JOIN
ALTER TABLE tmp_computed ADD PRIMARY KEY (player_id, game_id, team_id, play_id);

-- Applica i valori alla tabella originale
UPDATE player_team_game_play AS orig
JOIN tmp_computed AS comp
  ON orig.player_id = comp.player_id
 AND orig.game_id = comp.game_id
 AND orig.team_id = comp.team_id
 AND orig.play_id = comp.play_id
SET 
  orig.total_seconds_played_before = comp.total_seconds_before,
  orig.consecutive_seconds_playing = comp.consecutive_seconds;

-- Pulisce (opzionale)
DROP TEMPORARY TABLE tmp_play_times;
DROP TEMPORARY TABLE tmp_computed;

INSERT INTO user (`username`, `password`, `team_id`) VALUES('ale', 'ale', 1649);
INSERT INTO user (`username`, `password`, `team_id`) VALUES('test', 'test', 1649);
