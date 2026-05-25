/*
  # Rename Match Results Reason Columns

  Rename reason1 and reason2 to reason_1 and reason_2 for consistency
*/

DO $$
BEGIN
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
END $$;