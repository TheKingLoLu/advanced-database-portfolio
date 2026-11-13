INSERT INTO games (title, genre, released_at) VALUES
('Space Raiders','Shooter','2020-03-01'),
('Puzzle Quest','Puzzle','2019-06-15'),
('Speed Racer X','Racing','2021-09-10'),
('Castle Defence','Strategy','2018-11-20'),
('Word Wizards','Word','2022-02-05');

INSERT INTO players (username, email, country_code)
SELECT 'player' || g, 'player' || g || '@example.com',
       (ARRAY['NG','GH','KE','ZA','US','GB','IN','BR'])[1 + (random()*7)::int]
FROM generate_series(1, 1000) g;

INSERT INTO sessions (player_id, game_id, started_at, ended_at)
SELECT 1 + (random()*999)::int, 1 + (random()*4)::int, t, t + interval '20 minutes'
FROM (SELECT now() - random() * 30 * interval '1 day' AS t
      FROM generate_series(1, 20000)) s;

INSERT INTO scores (session_id, points, achieved_at)
SELECT session_id, (random()*10000)::int, started_at + interval '10 minutes'
FROM sessions;