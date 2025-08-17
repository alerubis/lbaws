
    SELECT COUNT(DISTINCT FLOOR(event_second / 60)) AS total_minutes
    FROM (
    SELECT sp.*, (p.seconds_start + sp.seconds_da_start) AS event_second
    FROM sub_play sp
    JOIN play p ON p.id = sp.play_id
  
    WHERE (
      SELECT COUNT(DISTINCT ptgp.player_id)
      FROM player_team_game_play ptgp
      WHERE ptgp.play_id = sp.play_id
        AND ptgp.player_id IN (5150,6138,7015,7405,7638)
        AND ptgp.seconds_start <= (p.seconds_start + sp.seconds_da_start)
        AND (p.seconds_start + sp.seconds_da_start) <= ptgp.seconds_end
    ) = 5
    ) AS filtered_sub_play
    WHERE filtered_sub_play.team_made_id = 1649
      AND filtered_sub_play.game_made_id IN (24658,24664,24674,24680,24688,24696,24705,24717,24721,24728,24740,24745,24753,24764,24768,24780,24785,24792,24799,24814,24817,24824,24833)
      AND filtered_sub_play.seconds_da_start IS NOT NULL
  