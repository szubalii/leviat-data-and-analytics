/*
  Returns the required and skippable activities for 
  each entity file on a single line
*/
CREATE FUNCTION [dbo].[tvf_entity_file_activity_requirements](
  @date DATE, -- set default to current date
  @rerunSuccessfulFullEntities BIT = 0
)
RETURNS TABLE
AS
RETURN

  WITH 
  -- combined_activities AS (
  --   SELECT                -- activities based on batch
  --     [entity_id],
  --     [layer_id],
  --     [file_name],
  --     [isRequired],
  --     [activity_nk],
  --     [activity_order],
  --     [batch_id],
  --     [output]
  --   FROM
  --     [dbo].[tvf_entity_file_activity_isRequired](@rerunSuccessfulFullEntities)

              -- UNION ALL

    -- SELECT                -- activities based on schedule
    --   [entity_id],
    --   [layer_id],
    --   NULL            AS [file_name],
    --   1               AS [isRequired],
    --   [activity_nk],
    --   [activity_order],
    --   NULL            AS [batch_id],
    --   '{}'            AS [output]
    -- FROM  
    --   [dbo].[tvf_entity_scheduled]()
  -- )
  -- ,
  transposed AS (
    SELECT
      entity_id,
      layer_id,
      file_name,
      trigger_date,
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
      [dbo].[tvf_entity_file_activity_by_date](
        @date,
        @rerunSuccessfulFullEntities
      ) f
    GROUP BY
      entity_id,
      layer_id,
      file_name,
      trigger_date,
      isRequired
  )

  -- aggregate to make sure required_activities and skipped_activities
  -- are on a single line for a single file_name
  SELECT
    entity_id,
    layer_id,
    file_name,
    trigger_date,
    MIN(required_activities) AS required_activities,
    MIN(skipped_activities) AS skipped_activities
  FROM transposed
  GROUP BY
    entity_id,
    layer_id,
    file_name,
    trigger_date
