/*
  # Fix anonymous access for selected_trainers DELETE and match_results upsert

  ## Summary
  - Add DELETE policy for anon on selected_trainers (needed for trainer re-selection)
  - Add UPDATE policy for anon on match_results (needed for upsert operations)
*/

CREATE POLICY "Public can delete selected trainers"
  ON selected_trainers FOR DELETE
  TO anon
  USING (true);

CREATE POLICY "Public can update match results"
  ON match_results FOR UPDATE
  TO anon
  USING (true)
  WITH CHECK (true);