-- drop function [dbo].[get_scheduled_entity_batch_activities]
CREATE FUNCTION [dbo].[get_scheduled_entity_batch_activities](
  @adhoc bit = 0,
  @date DATE,
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

  DECLARE @day_of_month INT = DAY(@date);
  DECLARE @day_of_week INT = DATEPART(dw, @date);

  WITH
  scheduled_entities AS (
  SELECT
    e.entity_id,
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
    dir.base_dir_path + '/In/' + FORMAT(trans.start_date_time, 'yyyy/MM/dd', 'en-US') AS adls_directory_path_In,
    dir.base_dir_path + '/Out/' + FORMAT(trans.start_date_time, 'yyyy/MM/dd', 'en-US') AS adls_directory_path_Out,
    e.base_schema_name,
    e.base_sproc_name,
    trans.file_name,
    trans.required_activities,
    trans.skipped_activities
  FROM
    entity e
  LEFT JOIN
    layer l
    ON
      l.layer_id = e.layer_id
  LEFT JOIN
    dbo.vw_adls_base_directory_path dir
    ON
      dir.entity_id = e.entity_id
  LEFT JOIN
    vw_latest_entity_file_activity_batch_transposed trans
    ON
      trans.entity_id = e.entity_id
  WHERE
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
      [schedule_day] = @day_of_week
    )
    OR (
      e.[schedule_recurrence] = 'M'
      AND (
        [schedule_day] = @day_of_month
        -- Beginning of month (schedule_day = 1) and
        -- first day of month falls in weekend
        OR (
          [schedule_day] = 1
          AND
          @day_of_month IN (2, 3)
          AND
          @day_of_week = 2 --Monday
        )
        -- End of month (schedule_day = 0) and
        -- last day of month falls in weekend
        OR (
          [schedule_day] = 0
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
    AND
      required_activities <> '[]'
  )



  INSERT INTO @scheduled_entity_batch_activities
  SELECT
      entity_id,
      entity_name,
      layer_nk,
      update_mode,
      client_field,
      extraction_type,
      pk_field_names,
      axbi_database_name,
      axbi_schema_name,
      base_table_name,
      axbi_date_field_name,
      adls_container_name,
      adls_directory_path_In,
      adls_directory_path_Out,
      base_schema_name,
      base_sproc_name,
      file_name,
      required_activities,
      skipped_activities
  FROM scheduled_entities

  RETURN;
END
GO
