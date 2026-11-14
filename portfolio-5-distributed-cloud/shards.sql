CREATE TABLE player_scores_sharded (
  player_id   INT NOT NULL,
  game_id     INT NOT NULL,
  points      INT NOT NULL,
  achieved_at TIMESTAMP NOT NULL
) PARTITION BY HASH (player_id);

CREATE TABLE player_scores_shard0 PARTITION OF player_scores_sharded FOR VALUES WITH (MODULUS 4, REMAINDER 0);
CREATE TABLE player_scores_shard1 PARTITION OF player_scores_sharded FOR VALUES WITH (MODULUS 4, REMAINDER 1);
CREATE TABLE player_scores_shard2 PARTITION OF player_scores_sharded FOR VALUES WITH (MODULUS 4, REMAINDER 2);
CREATE TABLE player_scores_shard3 PARTITION OF player_scores_sharded FOR VALUES WITH (MODULUS 4, REMAINDER 3);

INSERT INTO player_scores_sharded (player_id, game_id, points, achieved_at)
SELECT s.player_id, s.game_id, sc.points, sc.achieved_at
FROM scores sc JOIN sessions s ON s.session_id = sc.session_id;

\echo '--- Rows per shard ---'
SELECT tableoid::regclass AS shard, count(*) AS row_count
FROM player_scores_sharded GROUP BY 1 ORDER BY 1;

\echo '--- Query for one player: which shards are scanned? ---'
EXPLAIN SELECT * FROM player_scores_sharded WHERE player_id = 42;

\echo '--- Query across all players: which shards are scanned? ---'
EXPLAIN SELECT game_id, avg(points) FROM player_scores_sharded GROUP BY game_id;