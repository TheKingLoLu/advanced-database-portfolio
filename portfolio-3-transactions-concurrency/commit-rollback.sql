\echo '--- Starting values for player 1 ---'
SELECT * FROM player_stats WHERE player_id = 1;

\echo '--- Transaction 1: ROLLBACK ---'
BEGIN;
WITH new_session AS (
  INSERT INTO sessions (player_id, game_id) VALUES (1, 1) RETURNING session_id
)
INSERT INTO scores (session_id, points) SELECT session_id, 500 FROM new_session;
UPDATE player_stats SET total_points = total_points + 500, games_played = games_played + 1
WHERE player_id = 1;
\echo 'Inside the transaction (change visible to me only):'
SELECT * FROM player_stats WHERE player_id = 1;
ROLLBACK;
\echo 'After ROLLBACK (change undone):'
SELECT * FROM player_stats WHERE player_id = 1;

\echo '--- Transaction 2: COMMIT ---'
BEGIN;
WITH new_session AS (
  INSERT INTO sessions (player_id, game_id) VALUES (1, 1) RETURNING session_id
)
INSERT INTO scores (session_id, points) SELECT session_id, 500 FROM new_session;
UPDATE player_stats SET total_points = total_points + 500, games_played = games_played + 1
WHERE player_id = 1;
COMMIT;
\echo 'After COMMIT (change is permanent):'
SELECT * FROM player_stats WHERE player_id = 1;

\echo '--- Transaction 3: failure causes rollback of everything ---'
BEGIN;
UPDATE player_stats SET total_points = total_points + 100 WHERE player_id = 2;
UPDATE player_stats SET total_points = total_points - 999999 WHERE player_id = 2;
ROLLBACK;
\echo 'Player 2 is unchanged:'
SELECT * FROM player_stats WHERE player_id = 2;