CREATE FUNCTION tc.dbo.FakeFunctions.Fake_tvf_entity_file_activities_by_date (@date DATE, @rerunSuccessfulFullEntities BIT = 0)

  RETURNS TABLE
  AS
  RETURN
    SELECT mock.*
    FROM ( VALUES
      (0, 1, NULL, NULL, NULL, NULL, NULL),
      (1, 1, NULL, NULL, NULL, NULL, NULL),
      (2, 1, NULL, NULL, NULL, NULL, NULL),
      (3, 1, NULL, NULL, NULL, NULL, NULL)
    ) AS mock (
      entity_id,
      layer_id,
      adls_directory_path_In,
      adls_directory_path_Out,
      file_name,
      required_activities,
      skipped_activities
    );
GO
