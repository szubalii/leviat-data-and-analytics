CREATE PROCEDURE [tc.dbo.tvf_entity_file_activity_requirements].[test required_activities]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
  -- IF OBJECT_ID('tempdb..#vw_entity_file_required_activity') IS NOT NULL DROP TABLE #vw_entity_file_required_activity;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeFunction '[dbo].[tvf_entity_file_activity_isRequired]', 'fake.tvf_entity_file_activity_isRequired';

  -- Act: 
  SELECT
    entity_id,
    file_name,
    required_activities
  INTO actual
  FROM tvf_entity_file_activity_requirements(0);

  -- Assert:
  CREATE TABLE expected (
    entity_id INT,
    file_name VARCHAR(10),
    required_activities NVARCHAR(MAX)
  );

  INSERT INTO expected(
    entity_id,
    file_name,
    required_activities
  )
  VALUES
    (1, 'Test1.1', '["Status","Test"]'),
    (1, 'Test1.2', '[]'),
    (2, 'Test2.1', '["Status"]'),
    (3, 'Test3.1', '["Extract","Status"]');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO

