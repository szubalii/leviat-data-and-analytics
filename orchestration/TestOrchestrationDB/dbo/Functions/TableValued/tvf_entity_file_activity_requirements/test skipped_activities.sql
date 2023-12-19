CREATE PROCEDURE [tc.dbo.tvf_entity_file_activity_requirements].[test skipped_activities]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  EXEC tSQLt.FakeFunction 'dbo.tvf_entity_file_activity_isRequired', 'EntityFile.Fake_tvf_entity_file_activity_isRequired';

  -- Act: 
  SELECT
    entity_id,
    file_name,
    skipped_activities
  INTO actual
  FROM dbo.tvf_entity_file_activity_requirements(0);

  -- Assert:
  CREATE TABLE expected (
    entity_id INT,
    file_name VARCHAR(10),
    skipped_activities NVARCHAR(MAX)
  );

  INSERT INTO expected(
    entity_id,
    file_name,
    skipped_activities
  )
  VALUES
    (1, 'Test1.1', '{"Extract": {"batch_id":"00000000-0000-0000-0000-000000000001", "output":{"timestamp":"2023-07-18_00:00:00"}}}'),
    (1, 'Test1.2', '{"Extract": {"batch_id":"00000000-0000-0000-0000-000000000004", "output":{"timestamp":"2023-07-18_00:00:00"}},"Status": {"batch_id":"00000000-0000-0000-0000-000000000005", "output":{"status":"FinishedNoErrors"}}}'),
    (2, 'Test2.1', '{"Extract": {"batch_id":"00000000-0000-0000-0000-000000000006", "output":{"timestamp":"2023-07-18_00:00:00"}}}'),
    (3, 'Test3.1', '{}');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO
