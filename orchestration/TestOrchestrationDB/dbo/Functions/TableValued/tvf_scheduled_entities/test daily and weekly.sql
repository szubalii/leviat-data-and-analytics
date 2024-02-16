CREATE PROCEDURE [tvf_scheduled_entities].[test daily and weekly]
AS
BEGIN
  -- Check if all daily, weekly, monthly, adhoc scheduled entities exist in output of get_scheduled_entity_batch_activities
  -- and if not, these entities are also not returned by entity_file_requirement
  
  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  EXEC tSQLt.FakeTable '[dbo]', '[entity]';

  /*
    Workaround to ingest mock data into a view
    https://stackoverflow.com/questions/14965427/tsqlt-faketable-doesnt-seem-to-work-with-views-that-have-constants-derived-field
  */

  INSERT INTO entity (entity_id, schedule_recurrence, schedule_day)
  VALUES
    (0, NULL, NULL),
    (1, 'D', NULL),
    (2, 'A', NULL),
    (3, 'W', 1),
    (4, 'W', 4),
    (5, 'M', 1);

  -- Act: 
  SELECT
    entity_id
  INTO actual
  FROM dbo.tvf_get_scheduled_entities(
    0, '2023-07-23' -- First day of week is on a Sunday
  );

  -- Assert:
  CREATE TABLE expected (
    entity_id INT
  );

  INSERT INTO expected(
    entity_id
  )
  VALUES
    (1),
    (3);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';

END;
GO

