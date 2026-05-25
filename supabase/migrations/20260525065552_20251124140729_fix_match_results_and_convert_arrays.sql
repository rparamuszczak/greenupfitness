/*
  # Fix Match Results and Convert Arrays

  1. Ensure match_results has correct column names (reason_1, reason_2)
  2. Add upsert conflict handling for (client_profile_id, expert_id)
*/

DO $$
BEGIN
  -- Ensure columns are named correctly
  IF EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'match_results' AND column_name = 'reason1'
  ) THEN
    ALTER TABLE match_results RENAME COLUMN reason1 TO reason_1;
  END IF;

  IF EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'match_results' AND column_name = 'reason2'
  ) THEN
    ALTER TABLE match_results RENAME COLUMN reason2 TO reason_2;
  END IF;
  
  -- Add unique constraint for upsert operations
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint 
    WHERE conname = 'match_results_client_expert_unique'
  ) THEN
    ALTER TABLE match_results ADD CONSTRAINT match_results_client_expert_unique UNIQUE (client_profile_id, expert_id);
  END IF;
END $$;