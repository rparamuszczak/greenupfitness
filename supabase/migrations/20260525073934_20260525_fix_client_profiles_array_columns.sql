/*
  # Fix client_profiles array columns

  ## Summary
  The app stores living_area, monthly_budget, availability, and cooperation
  as string arrays (text[]) but the original schema defined them as text.
  This migration converts them to the correct array type.

  ## Changes
  - `living_area`: text → text[]
  - `monthly_budget`: text → text[]
  - `availability`: text → text[]
  - `cooperation`: text → text[]
*/

ALTER TABLE client_profiles
  ALTER COLUMN living_area TYPE text[] USING
    CASE WHEN living_area IS NULL THEN NULL
         WHEN living_area = '' THEN '{}'::text[]
         ELSE ARRAY[living_area]
    END,
  ALTER COLUMN monthly_budget TYPE text[] USING
    CASE WHEN monthly_budget IS NULL THEN NULL
         WHEN monthly_budget = '' THEN '{}'::text[]
         ELSE ARRAY[monthly_budget]
    END,
  ALTER COLUMN availability TYPE text[] USING
    CASE WHEN availability IS NULL THEN NULL
         WHEN availability = '' THEN '{}'::text[]
         ELSE ARRAY[availability]
    END,
  ALTER COLUMN cooperation TYPE text[] USING
    CASE WHEN cooperation IS NULL THEN NULL
         WHEN cooperation = '' THEN '{}'::text[]
         ELSE ARRAY[cooperation]
    END;