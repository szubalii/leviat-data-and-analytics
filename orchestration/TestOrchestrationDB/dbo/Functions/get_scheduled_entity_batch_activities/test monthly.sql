CREATE FUNCTION EntityFile.Fake_tvf_entity_file_activities_by_date (@date DATE, @rerunSuccessfulFullEntities BIT = 0)

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

CREATE PROCEDURE [tc.dbo.get_scheduled_entity_batch_activities].[test monthly]
AS
BEGIN
  -- Check if all daily, weekly, monthly, adhoc scheduled entities exist in output of get_scheduled_entity_batch_activities
  -- and if not, these entities are also not returned by entity_file_requirement
  
  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';
  EXEC tSQLt.FakeFunction '[dbo].[tvf_entity_file_activities_by_date]', 'EntityFile.Fake_tvf_entity_file_activities_by_date';
  
  INSERT INTO dbo.entity (entity_id, schedule_recurrence, schedule_day)
  VALUES
    (1, NULL, NULL),
    (2, 'M', 1),
    (3, 'M', 2);

  -- Act: 
  SELECT entity_id
  INTO actual
  FROM dbo.get_scheduled_entity_batch_activities(
    0, '2023-06-01', 0
  );

  -- Assert:
  CREATE TABLE expected (entity_id INT);
  INSERT INTO expected (entity_id) VALUES (2);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';

END;
GO

