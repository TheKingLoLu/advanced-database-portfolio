CREATE INDEX idx_sessions_player ON sessions(player_id);
CREATE INDEX idx_sessions_game_player ON sessions(game_id, player_id);
CREATE INDEX idx_scores_session ON scores(session_id);
CREATE INDEX idx_scores_achieved ON scores(achieved_at);
CREATE INDEX idx_scores_points ON scores(points DESC);
ANALYZE;