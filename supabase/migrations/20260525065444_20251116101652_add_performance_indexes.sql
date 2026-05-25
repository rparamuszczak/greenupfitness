/*
  # Add Performance Indexes

  Add additional indexes for common query patterns to improve database performance
*/

CREATE INDEX IF NOT EXISTS idx_match_results_score ON match_results(match_score DESC);
CREATE INDEX IF NOT EXISTS idx_match_results_client_expert ON match_results(client_profile_id, expert_id);
CREATE INDEX IF NOT EXISTS idx_selected_trainers_expert ON selected_trainers(expert_id);
CREATE INDEX IF NOT EXISTS idx_messages_created_at ON messages(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_messages_sender ON messages(sender);
CREATE INDEX IF NOT EXISTS idx_messages_client_expert ON messages(client_profile_id, expert_id);