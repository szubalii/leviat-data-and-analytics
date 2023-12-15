CREATE FUNCTION EntityFile.Fake_tvf_entity_file_required_activities (@rerunSuccessfulFullEntities BIT = 0)

  RETURNS TABLE
  AS
  RETURN
    SELECT mock.*
    FROM ( VALUES
      (0, NULL, '2023-07-22', '2023-07-22', '["TestDuplicates"]', NULL),
      (0, NULL, '2023-07-23', '2023-07-23', '["TestDuplicates"]', NULL),
      (1, NULL, '2023-07-22', '2023-07-22', '["TestDuplicates"]', NULL),
      (1, NULL, '2023-07-23', '2023-07-23', '["TestDuplicates"]', NULL),
      (2, NULL, '2023-07-22', '2023-07-22', '["TestDuplicates"]', NULL),
      (2, NULL, '2023-07-23', '2023-07-23', '["TestDuplicates"]', NULL),
      (3, NULL, NULL, NULL, '["TestDuplicates"]', NULL)
    ) AS mock (
      entity_id,
      layer_id,
      file_name,
      trigger_date,
      required_activities,
      skipped_activities
    );
GO

CREATE PROCEDURE [tc.dbo.tvf_entity_file_activities_by_date].[test date and update_mode filter]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  EXEC tSQLt.FakeTable 'dbo.entity';
  EXEC tSQLt.FakeFunction 'dbo.tvf_entity_file_required_activities', 'EntityFile.Fake_tvf_entity_file_required_activities';


  INSERT INTO entity (entity_id, update_mode)
  VALUES
    (0, 'Full'),
    (1, NULL),
    (2, 'Delta'),
    (3, 'Full');

  -- Act: 
  SELECT
    entity_id, file_name
  INTO actual
  FROM dbo.tvf_entity_file_activities_by_date('2023-07-23', 0);

  -- Assert:
  CREATE TABLE expected (
    entity_id INT,
    file_name VARCHAR(100)
  );

  INSERT INTO expected(
    entity_id,
    file_name
  )
  VALUES
    (0, '2023-07-23'),
    (1, '2023-07-23'),
    (2, '2023-07-22'),
    (2, '2023-07-23'),
    (3, NULL);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO

