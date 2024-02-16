CREATE PROCEDURE [tc.dbo.tvf_scheduled_entities].[test monthly: beginning weekend]
AS
BEGIN
  -- Check if all daily, weekly, monthly, adhoc scheduled entities exist in output of get_scheduled_entity_batch_activities
  -- and if not, these entities are also not returned by entity_file_requirement

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';

  INSERT INTO dbo.entity (entity_id, schedule_recurrence, schedule_day)
  VALUES
    (0, NULL, NULL),
    (1, 'M', 1),
    (2, 'M', 2),
    (3, 'M', 3),
    (4, 'M', 4);

  -- Act: 
  SELECT entity_id
  INTO actual
  FROM dbo.tvf_scheduled_entities(
    0, '2023-07-03' -- First working day of month which is a Monday
  );

  -- Assert:
  CREATE TABLE expected (entity_id INT);
  INSERT INTO expected (entity_id) VALUES (1), (3);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';

END;
GO

