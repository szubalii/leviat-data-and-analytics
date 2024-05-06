CREATE PROCEDURE [tc.dbo.tvf_entity_file_required_activities].[test returning entities with required activities only]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  EXEC tSQLt.FakeFunction 'dbo.tvf_entity_file_activity_requirements', 'fake.tvf_entity_file_activity_requirements';

  -- Act: 
  SELECT
    entity_id
  INTO actual
  FROM dbo.tvf_entity_file_required_activities('2024-01-01', 0);

  -- Assert:
  CREATE TABLE expected (
    entity_id INT
  );

  INSERT INTO expected(
    entity_id
  )
  VALUES
    (2), (3);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO

