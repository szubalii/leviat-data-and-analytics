/*
  Returns the required and skippable activities for 
  each entity file on a single record
*/
CREATE VIEW [dbo].[vw_entity_file_requirement]
AS

WITH transposed AS (
  SELECT
    entity_id,
    file_name,
    CONCAT(
      '[',
      CASE
        WHEN isRequired = 1
        THEN CONCAT(
          '"',
          STRING_AGG(activity_nk, '","') WITHIN GROUP (ORDER BY activity_order ASC),
          '"'
        )
      END,
      ']'
    ) AS required_activities,
    CONCAT(
      '{',
      CASE
        WHEN isRequired = 0
        THEN STRING_AGG(
          CONCAT(
            '"',
            activity_nk,
            '": {"batch_id":"',
            batch_id,
            '", "output":',
            [output],
            '}'
          ),
          ','
        ) WITHIN GROUP (ORDER BY activity_order ASC)
      END,
      '}'
    ) AS skipped_activities
  FROM
    [vw_entity_file_required_activity] f
  GROUP BY
    entity_id,
    file_name,
    isRequired
)

-- aggregate to make sure required_activities and skipped_activities
-- are on a single line for a single file_name
SELECT
  entity_id,
  file_name,
  MIN(required_activities) AS required_activities,
  MIN(skipped_activities) AS skipped_activities
FROM transposed
GROUP BY
  entity_id,
  file_name
