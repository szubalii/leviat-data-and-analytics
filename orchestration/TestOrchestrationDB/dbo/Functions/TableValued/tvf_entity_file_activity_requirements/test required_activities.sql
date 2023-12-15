CREATE FUNCTION EntityFile.Fake_tvf_entity_file_activity_isRequired (@rerunSuccessfulFullEntities BIT = 0)
RETURNS TABLE
AS
RETURN
  SELECT mock.*
  FROM ( VALUES
    (1, NULL, 'Test1.1', 'Extract', 100, 0, '00000000-0000-0000-0000-000000000001', '{"timestamp":"2023-07-18_00:00:00"}'),
    (1, NULL, 'Test1.1', 'Status',  200, 1, '00000000-0000-0000-0000-000000000002', '{"status":"FinishedNoErrors"}'),
    (1, NULL, 'Test1.1', 'Test',    300, 1, '00000000-0000-0000-0000-000000000003', '{}'),
    (1, NULL, 'Test1.2', 'Extract', 100, 0, '00000000-0000-0000-0000-000000000004', '{"timestamp":"2023-07-18_00:00:00"}'),
    (1, NULL, 'Test1.2', 'Status',  200, 0, '00000000-0000-0000-0000-000000000005', '{"status":"FinishedNoErrors"}'),
    (2, NULL, 'Test2.1', 'Extract', 100, 0, '00000000-0000-0000-0000-000000000006', '{"timestamp":"2023-07-18_00:00:00"}'),
    (2, NULL, 'Test2.1', 'Status',  200, 1, '00000000-0000-0000-0000-000000000007', '{"status":"FinishedNoErrors"}'),
    (3, NULL, 'Test3.1', 'Extract', 100, 1, NULL, '{}'),
    (3, NULL, 'Test3.1', 'Status',  200, 1, NULL, '{}')
  ) AS mock (
    entity_id,
    layer_id,
    file_name,
    activity_nk,
    activity_order,
    isRequired,
    batch_id,
    [output]
  );
GO

CREATE PROCEDURE [tc.dbo.tvf_entity_file_activity_requirements].[test required_activities]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
  -- IF OBJECT_ID('tempdb..#vw_entity_file_required_activity') IS NOT NULL DROP TABLE #vw_entity_file_required_activity;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeFunction '[dbo].[tvf_entity_file_activity_isRequired]', 'EntityFile.Fake_tvf_entity_file_activity_isRequired';

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

