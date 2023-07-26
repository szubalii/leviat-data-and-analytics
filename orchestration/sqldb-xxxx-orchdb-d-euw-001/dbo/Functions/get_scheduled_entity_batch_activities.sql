-- drop function [dbo].[get_scheduled_entity_batch_activities]
CREATE FUNCTION [dbo].[get_scheduled_entity_batch_activities](
  @adhoc bit = 0,
  @date DATE, -- set default to current date
  @rerunSuccessfulFullEntities BIT = 0 -- In case a new run is required
  -- for full entities that have a successful run for the day already, set it to 1
)
RETURNS @scheduled_entity_batch_activities TABLE (
  entity_id BIGINT NOT NULL,
  entity_name VARCHAR(122),
  layer_nk VARCHAR(50),
  update_mode VARCHAR(5),
  client_field VARCHAR(127),
  extraction_type VARCHAR(5),
  pk_field_names VARCHAR(MAX),
  axbi_database_name VARCHAR(128),
  axbi_schema_name VARCHAR(128),
  base_table_name VARCHAR(128),
  axbi_date_field_name VARCHAR(128),
  adls_container_name VARCHAR(63),
  adls_directory_path_In NVARCHAR(255),
  adls_directory_path_Out NVARCHAR(255),
  base_schema_name VARCHAR(128),
  base_sproc_name VARCHAR(128),
  file_name VARCHAR(250),
  required_activities VARCHAR(MAX),
  skipped_activities VARCHAR(MAX)
)
AS
BEGIN

  IF @date IS NULL
    SET @date = GETDATE();

  DECLARE @day_of_month INT = DAY(@date);
  DECLARE @day_of_week INT = DATEPART(dw, @date);


  WITH
  scheduled_entities AS (
    SELECT
      efr.entity_id,
      efr.entity_name,
      l.layer_nk,
      efr.update_mode,
      efr.client_field,
      efr.extraction_type,
      efr.pk_field_names,
      efr.axbi_database_name,
      efr.axbi_schema_name,
      efr.base_table_name,
      efr.axbi_date_field_name,
      efr.adls_container_name,
      efr.base_schema_name,
      efr.base_sproc_name,
      efr.file_name,
      COALESCE(efr.trigger_date, @date) AS trigger_date,
      efr.required_activities,
      efr.skipped_activities
    FROM
      dbo.[tvf_entity_file_requirement](@rerunSuccessfulFullEntities) efr
    LEFT JOIN
      layer l
      ON
        l.layer_id = efr.layer_id
    LEFT JOIN
      vw_full_load_entities fle
      ON
        fle.entity_id = efr.entity_id
    LEFT JOIN
      vw_delta_load_entities dle
      ON
        dle.entity_id = efr.entity_id
    WHERE (
    -- Daily load is only executed on workdays.

    -- Account for situations where entities need to run at beginning or end of the month
    -- and these days are in the weekend.
        efr.[schedule_recurrence] = 'D'
        OR
        (
          efr.[schedule_recurrence] = 'A'
          AND
          @adhoc = 1
        )
        OR (
          efr.[schedule_recurrence] = 'W'
          AND
          efr.[schedule_day] = @day_of_week
        )
        OR (
          efr.[schedule_recurrence] = 'M'
          AND (
            efr.[schedule_day] = @day_of_month
            -- Beginning of month (schedule_day = 1) and
            -- first day of month falls in weekend
            OR (
              efr.[schedule_day] = 1
              AND
              @day_of_month IN (2, 3)
              AND
              @day_of_week = 2 --Monday
            )
            -- End of month (schedule_day = 0) and
            -- last day of month falls in weekend
            OR (
              efr.[schedule_day] = 0
              AND (
                @day_of_month = DAY(EOMONTH(@date))
                OR (
                  @day_of_week = 2 --Monday
                  AND
                  @day_of_month IN (1, 2)
                )
              )
            )
          )
        )
      )
      AND (
        (
          -- If entity is full load and date is provided,
          -- we're only interested in activities that failed 
          -- that need to rerun
          fle.entity_id IS NOT NULL
          AND
          efr.trigger_date = @date
        )
        OR (
          -- for delta entities, we're interested in the activities
          -- of all delta files that need to rerun
          dle.entity_id IS NOT NULL
          AND
          efr.trigger_date <= @date
        )
      )
  )



  INSERT INTO @scheduled_entity_batch_activities
  SELECT
    se.entity_id,
    se.entity_name,
    se.layer_nk,
    se.update_mode,
    se.client_field,
    se.extraction_type,
    se.pk_field_names,
    se.axbi_database_name,
    se.axbi_schema_name,
    se.base_table_name,
    se.axbi_date_field_name,
    se.adls_container_name,
    dbo.[svf_get_adls_directory_path](dir.base_dir_path, 'In', se.trigger_date) AS adls_directory_path_In,
    dbo.[svf_get_adls_directory_path](dir.base_dir_path, 'Out', se.trigger_date) AS adls_directory_path_Out,
    se.base_schema_name,
    se.base_sproc_name,
    se.file_name,
    se.required_activities,
    se.skipped_activities
  FROM scheduled_entities se
  LEFT JOIN
    dbo.vw_adls_base_directory_path dir
    ON
      dir.entity_id = se.entity_id
  WHERE
    -- filter out entity files for which no required activities exist
    se.required_activities IS NOT NULL
    AND
    se.required_activities <> '[]'

  RETURN;
END
GO
