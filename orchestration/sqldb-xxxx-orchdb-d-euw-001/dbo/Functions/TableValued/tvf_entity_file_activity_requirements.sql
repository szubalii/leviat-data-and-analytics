/*
  Returns the required and skippable activities for 
  each entity file on a single record
*/
CREATE FUNCTION [dbo].[tvf_entity_file_activity_requirements](
  @adhoc BIT = 0,
  @date DATE,
  @rerunSuccessfulFullEntities BIT = 0
)
RETURNS TABLE
AS
RETURN

  WITH combined_activities AS (
    SELECT                -- activities based on batch
      [entity_id],
      [layer_id],
      [file_name],
      [isRequired],
      [activity_nk],
      [activity_order],
      [batch_id],
      [output]
    FROM
      [dbo].[tvf_entity_file_activity_isRequired](@rerunSuccessfulFullEntities)

              UNION ALL

    SELECT                -- activities based on schedule
      [entity_id],
      [layer_id],
      NULL            AS [file_name],
      1               AS [isRequired],
      [activity_nk],
      [activity_order],
      NULL            AS [batch_id],
      '{}'            AS [output]
    FROM  
      [dbo].[tvf_entity_scheduled](@adhoc, @date, @rerunSuccessfulFullEntities)
  )
  ,transposed AS (
    SELECT
      entity_id,
      layer_id,
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
      combined_activities f
    GROUP BY
      entity_id,
      layer_id,
      file_name,
      isRequired
  )

  -- aggregate to make sure required_activities and skipped_activities
  -- are on a single line for a single file_name
  SELECT
    entity_id,
    layer_id,
    file_name,
    dbo.[svf_get_triggerDate](file_name) AS trigger_date,
    MIN(required_activities) AS required_activities,
    MIN(skipped_activities) AS skipped_activities
  FROM transposed
  GROUP BY
    entity_id,
    layer_id,
    file_name
