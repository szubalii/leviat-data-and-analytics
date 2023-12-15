/*
  Return the latest batch activities of those files
  corresponding to the latest non-failed extractions
*/

CREATE VIEW [dbo].[vw_latest_entity_file_activity] AS

-- Get the most recent start dates for each entity activity
-- and file name
WITH

full_and_delta AS (
  SELECT
    ef.entity_id,
    ef.file_name
  FROM
    vw_latest_non_failed_extracted_entity_file ef
  INNER JOIN
    vw_full_load_entities f
    ON f.entity_id = ef.entity_id

  UNION ALL

  SELECT
    ef.entity_id,
    ef.file_name
  FROM
    vw_non_failed_extracted_entity_file ef
  INNER JOIN
    vw_delta_load_entities d
    ON d.entity_id = ef.entity_id
)

-- get the latest batch in case of multiple batch activities of the same activity_id
-- , latest_batch_activity AS (
SELECT
  b.entity_id,
  b.file_name,
  b.activity_id,
  ba.activity_nk,
  ba.activity_order,
  MAX(b.start_date_time) AS start_date_time
FROM
  full_and_delta
INNER JOIN
  dbo.batch b
  ON
    b.entity_id = full_and_delta.entity_id
    AND
    b.file_name = full_and_delta.file_name
LEFT JOIN
  dbo.batch_activity ba
    ON ba.activity_id = b.activity_id
GROUP BY
  b.entity_id,
  b.file_name,
  b.activity_id,
  ba.activity_nk,
  ba.activity_order
-- )

-- Return the attributes related to the most recent entity activity
-- SELECT
--   b.entity_id,
--   b.activity_id,
--   ba.activity_order,
--   b.run_id,
--   b.batch_id,
--   b.start_date_time,
--   b.status_id,
--   b.file_name,
--   b.output
-- FROM
--   latest_batch_activity lba
-- INNER JOIN
--   dbo.batch b
--   ON
--     b.entity_id = lba.entity_id
--     AND
--     b.file_name = lba.file_name
--     AND
--     b.activity_id = lba.activity_id
--     AND
--     b.start_date_time = lba.start_date_time
-- LEFT JOIN dbo.batch_activity ba
--   ON ba.activity_id = b.activity_id
