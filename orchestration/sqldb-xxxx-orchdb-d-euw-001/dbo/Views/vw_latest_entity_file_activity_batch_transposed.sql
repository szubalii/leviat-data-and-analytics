CREATE VIEW [dbo].[vw_latest_entity_file_activity_batch_transposed]
AS

SELECT
  entity_id,
  file_name,
  activity_id,
  activity_nk,
  activity_order,
  batch_id,
  status_id,
  start_date_time,
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
  [vw_latest_entity_file_activity_batch] f
GROUP BY
  entity_id,
  file_name,
  activity_id,
  activity_nk,
  activity_order,
  batch_id,
  status_id,
  start_date_time,
  [output],
  isRequired
