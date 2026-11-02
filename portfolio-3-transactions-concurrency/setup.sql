CREATE TABLE IF NOT EXISTS player_stats (
  player_id    INT PRIMARY KEY REFERENCES players(player_id),
  total_points INT NOT NULL DEFAULT 0 CHECK (total_points >= 0),
  games_played INT NOT NULL DEFAULT 0
);

INSERT INTO player_stats (player_id)
SELECT player_id FROM players
ON CONFLICT DO NOTHING;