-- drop function [dbo].[get_scheduled_entity_batch_activities]
CREATE FUNCTION [dbo].[get_scheduled_entity_batch_activities](
  @adhoc BIT = 0,
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
      e.entity_name,
      l.layer_nk,
      e.update_mode,
      e.client_field,
      e.extraction_type,
      e.pk_field_names,
      e.axbi_database_name,
      e.axbi_schema_name,
      e.base_table_name,
      e.axbi_date_field_name,
      e.adls_container_name,
      efr.adls_directory_path_In,
      efr.adls_directory_path_Out,
      e.base_schema_name,
      e.base_sproc_name,
      efr.file_name,
      efr.required_activities,
      efr.skipped_activities
    FROM
      dbo.[tvf_entity_file_activities_by_date](
        @adhoc,
        @date,
        @rerunSuccessfulFullEntities
      ) efr
    LEFT JOIN
      entity e
      ON
        e.entity_id = efr.entity_id
    LEFT JOIN
      layer l
      ON
        l.layer_id = efr.layer_id
    WHERE (
    -- Daily load is only executed on workdays.

    -- Account for situations where entities need to run at beginning or end of the month
    -- and these days are in the weekend.
        e.[schedule_recurrence] = 'D'
        OR
        (
          e.[schedule_recurrence] = 'A'
          AND
          @adhoc = 1
        )
        OR (
          e.[schedule_recurrence] = 'W'
          AND
          e.[schedule_day] = @day_of_week
        )
        OR (
          e.[schedule_recurrence] = 'M'
          AND (
            e.[schedule_day] = @day_of_month
            -- Beginning of month (schedule_day = 1) and
            -- first day of month falls in weekend
            OR (
              e.[schedule_day] = 1
              AND
              @day_of_month IN (2, 3)
              AND
              @day_of_week = 2 --Monday
            )
            -- End of month (schedule_day = 0) and
            -- last day of month falls in weekend
            OR (
              e.[schedule_day] = 0
              AND (
                @day_of_month = DAY(EOMONTH(@date))
                OR (
                  @day_of_week = 2 --Monday
                  AND
                  @day_of_month IN (1, 2)
                )
                OR (
                  @day_of_week = 6 --Friday
                  AND
                  -- last day of month falls in weekend
                  DATEPART(dw, (EOMONTH(@date))) IN (1, 7)
                )
              )
            )
          )
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
    se.adls_directory_path_In,
    se.adls_directory_path_Out,
    se.base_schema_name,
    se.base_sproc_name,
    se.file_name,
    se.required_activities,
    se.skipped_activities
  FROM scheduled_entities se

  RETURN;
END
GO
