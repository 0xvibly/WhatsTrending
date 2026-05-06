CREATE TABLE IF NOT EXISTS models (
  model_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  provider TEXT NOT NULL,
  category TEXT NOT NULL DEFAULT 'Proprietary',
  elo_score REAL DEFAULT 0,
  elo_rank INTEGER DEFAULT 0,
  context_window TEXT DEFAULT '',
  pricing TEXT DEFAULT '',
  downloads INTEGER DEFAULT 0,
  change TEXT DEFAULT '0',
  description TEXT DEFAULT '',
  created_at TEXT DEFAULT (datetime('now')),
  updated_at TEXT DEFAULT (datetime('now'))
);

CREATE INDEX idx_models_elo_rank ON models(elo_rank);
CREATE INDEX idx_models_category ON models(category);
CREATE INDEX idx_models_provider ON models(provider);

-- Seed initial data from current leaderboard
INSERT INTO models (model_id, name, provider, category, elo_score, elo_rank, context_window, pricing, change) VALUES
  ('gpt-5', 'GPT-5', 'OpenAI', 'Proprietary', 94, 1, '256K', '$15/$60', '+2'),
  ('claude-opus-4', 'Claude Opus 4', 'Anthropic', 'Proprietary', 92, 2, '1M', '$15/$75', '0'),
  ('gemini-ultra-2', 'Gemini Ultra 2', 'Google', 'Proprietary', 90, 3, '2M', '$7/$21', '+1'),
  ('llama-4-405b', 'Llama 4 405B', 'Meta', 'Open Source', 87, 4, '128K', 'Free', '-1'),
  ('mistral-large-3', 'Mistral Large 3', 'Mistral', 'Proprietary', 85, 5, '128K', '$4/$12', '0'),
  ('deepseek-v3', 'DeepSeek V3', 'DeepSeek', 'Open Source', 84, 6, '128K', '$1/$2', '+3'),
  ('grok-3', 'Grok 3', 'xAI', 'Proprietary', 83, 7, '128K', '$5/$15', '-1'),
  ('command-r-plus', 'Command R+', 'Cohere', 'Proprietary', 81, 8, '128K', '$3/$15', '0'),
  ('qwen-3-72b', 'Qwen 3 72B', 'Alibaba', 'Open Source', 80, 9, '128K', 'Free', '+2'),
  ('phi-4', 'Phi-4', 'Microsoft', 'Open Source', 78, 10, '16K', 'Free', '0');
