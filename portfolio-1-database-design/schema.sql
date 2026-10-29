CREATE TABLE players (
  player_id    SERIAL PRIMARY KEY,
  username     VARCHAR(30) NOT NULL UNIQUE,
  email        VARCHAR(100) NOT NULL UNIQUE,
  country_code CHAR(2),
  created_at   TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE games (
  game_id     SERIAL PRIMARY KEY,
  title       VARCHAR(80) NOT NULL UNIQUE,
  genre       VARCHAR(40),
  released_at DATE
);

CREATE TABLE sessions (
  session_id BIGSERIAL PRIMARY KEY,
  player_id  INT NOT NULL REFERENCES players(player_id),
  game_id    INT NOT NULL REFERENCES games(game_id),
  started_at TIMESTAMP NOT NULL DEFAULT now(),
  ended_at   TIMESTAMP,
  CHECK (ended_at IS NULL OR ended_at >= started_at)
);

CREATE TABLE scores (
  score_id    BIGSERIAL PRIMARY KEY,
  session_id  BIGINT NOT NULL REFERENCES sessions(session_id),
  points      INT NOT NULL CHECK (points >= 0),
  achieved_at TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE achievements (
  achievement_id  SERIAL PRIMARY KEY,
  game_id         INT NOT NULL REFERENCES games(game_id),
  name            VARCHAR(60) NOT NULL,
  points_required INT NOT NULL CHECK (points_required > 0),
  UNIQUE (game_id, name)
);

CREATE TABLE player_achievements (
  player_id      INT REFERENCES players(player_id),
  achievement_id INT REFERENCES achievements(achievement_id),
  unlocked_at    TIMESTAMP NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, achievement_id)
);