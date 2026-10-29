-- Q1: Top 10 players in game 1
EXPLAIN ANALYZE
SELECT p.username, MAX(sc.points) AS best
FROM scores sc
JOIN sessions s ON s.session_id = sc.session_id
JOIN players p ON p.player_id = s.player_id
WHERE s.game_id = 1
GROUP BY p.username
ORDER BY best DESC
LIMIT 10;

-- Q2: Rank of player 42 in game 1
EXPLAIN ANALYZE
WITH best AS (
  SELECT s.player_id, MAX(sc.points) AS best
  FROM scores sc JOIN sessions s ON s.session_id = sc.session_id
  WHERE s.game_id = 1
  GROUP BY s.player_id
), ranked AS (
  SELECT player_id, best, RANK() OVER (ORDER BY best DESC) AS rnk FROM best
)
SELECT * FROM ranked WHERE player_id = 42;

-- Q3: Score history of player 42
EXPLAIN ANALYZE
SELECT g.title, sc.points, sc.achieved_at
FROM scores sc
JOIN sessions s ON s.session_id = sc.session_id
JOIN games g ON g.game_id = s.game_id
WHERE s.player_id = 42
ORDER BY sc.achieved_at DESC;

-- Q4: Average score per country
EXPLAIN ANALYZE
SELECT p.country_code, ROUND(AVG(sc.points)) AS avg_points
FROM scores sc
JOIN sessions s ON s.session_id = sc.session_id
JOIN players p ON p.player_id = s.player_id
GROUP BY p.country_code
ORDER BY avg_points DESC;

-- Q5: Top 10 scores in the last 7 days
EXPLAIN ANALYZE
SELECT sc.score_id, sc.points, sc.achieved_at
FROM scores sc
WHERE sc.achieved_at > now() - interval '7 days'
ORDER BY sc.points DESC
LIMIT 10;