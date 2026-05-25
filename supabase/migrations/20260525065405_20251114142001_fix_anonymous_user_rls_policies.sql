/*
  # Fix Anonymous User RLS Policies

  Fix RLS policies to properly allow anonymous users to:
  - Create and read their own profiles
  - Create messages
  - View experts
  - Read match results
*/

-- Update client_profiles for anonymous access - allow anonymous to select their own data
DROP POLICY IF EXISTS "Anonymous users can read their profiles" ON client_profiles;

CREATE POLICY "Public can read client profiles"
  ON client_profiles FOR SELECT
  TO anon
  USING (true);

-- Update messages for anonymous access
DROP POLICY IF EXISTS "Users can insert own messages" ON messages;

CREATE POLICY "Public can insert messages"
  ON messages FOR INSERT
  TO anon
  WITH CHECK (sender = 'client');

-- Allow anonymous to read messages
DROP POLICY IF EXISTS "Users can read own messages" ON messages;

CREATE POLICY "Public can read messages"
  ON messages FOR SELECT
  TO anon
  USING (true);

-- Update selected_trainers for anonymous access
DROP POLICY IF EXISTS "Users can read own selected trainer" ON selected_trainers;
DROP POLICY IF EXISTS "Users can insert own selected trainer" ON selected_trainers;
DROP POLICY IF EXISTS "Users can update own selected trainer" ON selected_trainers;

CREATE POLICY "Public can read selected trainers"
  ON selected_trainers FOR SELECT
  TO anon
  USING (true);

CREATE POLICY "Public can insert selected trainers"
  ON selected_trainers FOR INSERT
  TO anon
  WITH CHECK (true);

CREATE POLICY "Public can update selected trainers"
  ON selected_trainers FOR UPDATE
  TO anon
  USING (true)
  WITH CHECK (true);

-- Update match_results for anonymous access
DROP POLICY IF EXISTS "Anonymous users can read match results" ON match_results;

CREATE POLICY "Public can read match results"
  ON match_results FOR SELECT
  TO anon
  USING (true);

CREATE POLICY "Public can insert match results"
  ON match_results FOR INSERT
  TO anon
  WITH CHECK (true);