CREATE PROCEDURE [tc.dbo.get_scheduled_entity_batch_activities].[test adhoc]
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
    (2, 'A', NULL);

  -- Act: 
  SELECT entity_id
  INTO actual
  FROM dbo.get_scheduled_entity_batch_activities(
    1, '2023-04-28', 0
  );

  -- Assert:
  CREATE TABLE expected (entity_id INT);
  INSERT INTO expected (entity_id) VALUES (2);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';

END;
GO

