-- This file contains SQL statements that will be executed after the build script.

-- Write your own SQL object definition here, and it'll be included in your package.
EXEC tSQLt.NewTestClass 'DirectoryPath';
GO

CREATE PROCEDURE [DirectoryPath].[test vw_adls_base_directory_path]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';
  EXEC tSQLt.FakeTable '[dbo]', '[layer]';
  EXEC tSQLt.FakeTable '[dbo]', '[location]';

  INSERT INTO dbo.entity (
    entity_id,
    entity_name,
    layer_id,
    data_category,
    tool_name,
    extraction_type,
    update_mode
  )
  VALUES (1, 's4h', 6, 'DIMENSION', 'Theobald', 'Table', 'Full');
  INSERT INTO dbo.entity (
    entity_id,
    entity_name,
    layer_id,
    data_category,
    tool_name,
    extraction_type,
    update_mode
  )
  VALUES (2, 'axbi', 5, NULL, NULL, NULL, 'Delta');
  INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
  VALUES (6, 'S4H', 1);
  INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
  VALUES (5, 'AXBI', 2);
  INSERT INTO dbo.location (location_id, location_nk)
  VALUES (1, 'S4H');
  INSERT INTO dbo.location (location_id, location_nk)
  VALUES (2, 'AXBI');

  -- Act: 
  SELECT entity_id, layer_nk, base_dir_path
  INTO actual
  FROM dbo.vw_adls_base_directory_path;

  -- Assert:
  CREATE TABLE expected (
    entity_id BIGINT,
    layer_nk VARCHAR(4),
    base_dir_path VARCHAR(120)
  );

  INSERT INTO expected(entity_id, layer_nk, base_dir_path) SELECT 1, 'S4H', 'DIMENSION/s4h/Theobald/Table/Full';
  INSERT INTO expected(entity_id, layer_nk, base_dir_path) SELECT 2, 'AXBI', 'axbi';

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO


-- Write your own SQL object definition here, and it'll be included in your package.
EXEC [tSQLt].[SetFakeViewOn] 'dbo';
GO

EXEC tSQLt.NewTestClass 'EntityFile';
GO


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

CREATE FUNCTION EntityFile.Fake_tvf_entity_file_activity_requirements (@rerunSuccessfulFullEntities BIT = 0)
RETURNS TABLE
AS
RETURN
  SELECT mock.*
  FROM ( VALUES
    (0, 1, 'FULL_2023_07_22_12_00_00_000', '2023-07-22', NULL, '{}'),
    (1, 1, 'FULL_2023_07_22_12_00_00_000', '2023-07-22', '["TestDuplicates"]', '{}'),
    (1, 1, 'FULL_2023_07_23_12_00_00_000', '2023-07-23', '["TestDuplicates"]', '{}'),
    (1, 1, 'FULL_2023_07_24_12_00_00_000', '2023-07-24', '["TestDuplicates"]', '{}'),
    (2, 1, 'DELTA_2023_07_22_12_00_00_000', '2023-07-22', '["TestDuplicates"]', '{}'),
    (2, 1, 'DELTA_2023_07_23_12_00_00_000', '2023-07-23', '["TestDuplicates"]', '{}'),
    (2, 1, 'DELTA_2023_07_24_12_00_00_000', '2023-07-24', '["TestDuplicates"]', '{}')
  ) AS mock (
    entity_id,
    layer_id,
    file_name,
    trigger_date,
    required_activities,
    skipped_activities
  );
GO


CREATE PROCEDURE [EntityFile].[test vw_entity_file]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';
  EXEC tSQLt.FakeTable '[dbo]', '[layer]';
  EXEC tSQLt.FakeTable '[dbo]', '[location]';
  EXEC tSQLt.FakeTable '[dbo]', '[batch]';

  INSERT INTO dbo.entity (entity_id, layer_id)
  VALUES
    (1, 6),
    (2, 6),
    (3, 6),
    (4, 6),
    (5, 6);
  INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
  VALUES (6, 'S4H', 1);
  INSERT INTO dbo.location (location_id, location_nk)
  VALUES (1, 'S4H');
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
  VALUES
    (NEWID(), 1, NEWID(), 1, 21, 'EXTRACT'),     -- entity 1: EXTRACT in progress
    (NEWID(), 2, NEWID(), 1, 1,  'NON-EXTRACT'), -- entity 2: NON-EXTRACT in progress
    (NEWID(), 3, NEWID(), 4, 21, 'EXTRACT'),     -- entity 3: EXTRACT failed
    (NEWID(), 4, NEWID(), 2, 21, 'EXTRACT');     -- entity 4: EXTRACT successful

  -- Act: 
  SELECT entity_id, file_name
  INTO actual
  FROM vw_entity_file;

  -- Assert:
  CREATE TABLE expected (
    entity_id BIGINT,
    file_name VARCHAR(20)
  );

  INSERT INTO expected(entity_id, file_name)
  VALUES
    (1, 'EXTRACT'),
    (2, NULL),
    (3, NULL),
    (4, 'EXTRACT'),
    (5, NULL);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO

CREATE PROCEDURE [EntityFile].[test vw_entity_file_activity]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
  IF OBJECT_ID('tempdb..#vw_entity_file') IS NOT NULL DROP TABLE #vw_entity_file;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[layer_activity]';
  EXEC tSQLt.FakeTable '[dbo]', '[vw_entity_file]';

  SELECT TOP(0) *
  INTO #vw_entity_file
  FROM dbo.vw_entity_file;

  -- #2
  INSERT INTO #vw_entity_file (
    entity_id,
    layer_id,
    file_name
  )
  VALUES
    (1, 1, 'Test1'),
    (2, 1, NULL);

  EXEC ('INSERT INTO dbo.vw_entity_file SELECT * FROM #vw_entity_file');

  INSERT INTO dbo.layer_activity (layer_id, activity_id)
  VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 4),
    (2, 5);

  -- Act: 
  SELECT entity_id, file_name, expected_activity_id
  INTO actual
  FROM vw_entity_file_activity;

  -- Assert:
  CREATE TABLE expected (
    entity_id BIGINT,
    file_name VARCHAR(20),
    expected_activity_id INT
  );

  INSERT INTO expected(entity_id, file_name, expected_activity_id)
  VALUES
    (1, 'Test1', 1),
    (1, 'Test1', 2),
    (1, 'Test1', 3),
    (2, NULL, 1),
    (2, NULL, 2),
    (2, NULL, 3);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO


CREATE PROCEDURE [EntityFile].[test vw_entity_file_activity_latest_run]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
  IF OBJECT_ID('tempdb..#vw_entity_file_activity') IS NOT NULL DROP TABLE #vw_entity_file_activity;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[batch]';
  EXEC tSQLt.FakeTable '[dbo]', '[vw_entity_file_activity]';

  SELECT TOP(0) *
  INTO #vw_entity_file_activity
  FROM dbo.vw_entity_file_activity;

  -- #2
  INSERT INTO #vw_entity_file_activity (
    entity_id,
    file_name,
    expected_activity_id
  )
  VALUES
    (1, 'Test1', 21),
    (1, 'Test1', 19),
    (1, 'Test1', 2),
    (2, NULL, 21),
    (2, NULL, 19),
    (2, NULL, 2);

  EXEC ('INSERT INTO dbo.vw_entity_file_activity SELECT * FROM #vw_entity_file_activity');

  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name, start_date_time)
  VALUES
    (NEWID(), 1, NEWID(), 2, 21, 'Test1', '2023-07-20 12:00'), -- entity 1: EXTRACT successful
    (NEWID(), 1, NEWID(), 2, 19, 'Test1', '2023-07-20 12:30'), -- entity 1: Test Duplicates earlier
    (NEWID(), 1, NEWID(), 2, 19, 'Test1', '2023-07-20 13:00'); -- entity 1: Test Duplicates later

  -- Act: 
  SELECT entity_id, file_name, expected_activity_id, latest_start_date_time
  INTO actual
  FROM vw_entity_file_activity_latest_run;

  -- Assert:
  CREATE TABLE expected (
    entity_id INT,
    file_name VARCHAR(20),
    expected_activity_id INT,
    latest_start_date_time DATETIME
  );

  INSERT INTO expected(entity_id, file_name, expected_activity_id, latest_start_date_time)
  VALUES
    (1, 'Test1', 21, '2023-07-20 12:00'),
    (1, 'Test1', 19, '2023-07-20 13:00'),
    (1, 'Test1', 2, NULL),
    (2, NULL, 21, NULL),
    (2, NULL, 19, NULL),
    (2, NULL, 2, NULL);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO


CREATE PROCEDURE [EntityFile].[test vw_entity_file_activity_latest_batch]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
  IF OBJECT_ID('tempdb..#vw_entity_file_activity_latest_run') IS NOT NULL DROP TABLE #vw_entity_file_activity_latest_run;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[batch]';
  EXEC tSQLt.FakeTable '[dbo]', '[batch_activity]';
  EXEC tSQLt.FakeTable '[dbo]', '[vw_entity_file_activity_latest_run]';

  SELECT TOP(0) *
  INTO #vw_entity_file_activity_latest_run
  FROM dbo.vw_entity_file_activity_latest_run;

  -- #2
  INSERT INTO #vw_entity_file_activity_latest_run (
    entity_id,
    file_name,
    expected_activity_id,
    latest_start_date_time
  )
  VALUES
    (1, 'Test1', 21, '2023-07-20 12:00:00.000'),
    (1, 'Test1', 19, '2023-07-20 13:00:00.000'),
    (1, 'Test1', 2, NULL),
    (2, NULL, 21, NULL),
    (2, NULL, 19, NULL),
    (2, NULL, 2, NULL);

  EXEC ('INSERT INTO dbo.vw_entity_file_activity_latest_run SELECT * FROM #vw_entity_file_activity_latest_run');

  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name, start_date_time, [output])
  VALUES
    (NEWID(), 0, NEWID(), 2, 21, 'Test0', '2023-07-20 12:00:00.000', '{"timestamp":"2023-07-20 12:00"}'),
    (NEWID(), 1, NEWID(), 2, 21, 'Test1', '2023-07-20 11:00:00.000', '{"timestamp":"2023-07-20 11:00"}'),
    (NEWID(), 1, NEWID(), 2, 21, 'Test1', '2023-07-20 12:00:00.000', '{"timestamp":"2023-07-20 12:00"}'), -- entity 1: EXTRACT successful
    (NEWID(), 1, NEWID(), 2, 19, 'Test1', '2023-07-20 12:30:00.000', '{"timestamp":"2023-07-20 12:30"}'), -- entity 1: Test Duplicates earlier
    (NEWID(), 1, NEWID(), 2, 19, 'Test1', '2023-07-20 13:00:00.000', '{"timestamp":"2023-07-20 13:00"}'); -- entity 1: Test Duplicates later

  INSERT INTO dbo.batch_activity (activity_id, activity_nk, activity_order)
  VALUES
    (21, 'Extract', 100),
    (19, 'GetStatus', 150),
    ( 2, 'TestDuplicates', 200),
    (10, 'DUMMY', NULL);

  -- Act: 
  SELECT entity_id, file_name, expected_activity_id, activity_nk, activity_order, latest_start_date_time, status_id, [output]
  INTO actual
  FROM vw_entity_file_activity_latest_batch;

  -- Assert:
  CREATE TABLE expected (
    entity_id INT,
    file_name VARCHAR(20),
    expected_activity_id INT,
    activity_nk VARCHAR(100),
    activity_order INT,
    latest_start_date_time DATETIME,
    status_id INT,
    [output] VARCHAR(100)
  );

  INSERT INTO expected(entity_id, file_name, expected_activity_id, activity_nk, activity_order, latest_start_date_time, status_id, [output])
  VALUES
    (1, 'Test1', 21, 'Extract',   100, '2023-07-20 12:00:00.000', 2, '{"timestamp":"2023-07-20 12:00"}'),
    (1, 'Test1', 19, 'GetStatus', 150, '2023-07-20 13:00:00.000', 2, '{"timestamp":"2023-07-20 13:00"}'),
    (1, 'Test1', 2, 'TestDuplicates', 200, NULL, NULL, NULL),
    (2, NULL, 21, 'Extract',   100, NULL, NULL, NULL),
    (2, NULL, 19, 'GetStatus', 150, NULL, NULL, NULL),
    (2, NULL,  2, 'TestDuplicates', 200, NULL, NULL, NULL);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO


CREATE PROCEDURE [EntityFile].[test vw_entity_first_failed_file]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
  IF OBJECT_ID('tempdb..#vw_entity_file_activity_latest_batch') IS NOT NULL DROP TABLE #vw_entity_file_activity_latest_batch;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[vw_entity_file_activity_latest_batch]';

  SELECT TOP(0) *
  INTO #vw_entity_file_activity_latest_batch
  FROM dbo.vw_entity_file_activity_latest_batch;

  -- #2
  INSERT INTO #vw_entity_file_activity_latest_batch (
    entity_id,
    file_name,
    run_activity_id,
    status_id
  )
  VALUES
    (1, 'Test1', 21, 2),
    (1, 'Test2', 19, 4);

  EXEC ('INSERT INTO dbo.vw_entity_file_activity_latest_batch SELECT * FROM #vw_entity_file_activity_latest_batch');

  -- Act: 
  SELECT entity_id, first_failed_file_name
  INTO actual
  FROM vw_entity_first_failed_file;

  -- Assert:
  CREATE TABLE expected (
    entity_id INT,
    first_failed_file_name VARCHAR(20)
  );

  INSERT INTO expected(entity_id, first_failed_file_name)
  VALUES
    (1, 'Test2');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO




CREATE PROCEDURE [EntityFile].[test vw_entity_file_first_failed_activity]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
  IF OBJECT_ID('tempdb..#vw_entity_file_activity_latest_batch') IS NOT NULL DROP TABLE #vw_entity_file_activity_latest_batch;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[vw_entity_file_activity_latest_batch]';

  SELECT TOP(0) *
  INTO #vw_entity_file_activity_latest_batch
  FROM dbo.vw_entity_file_activity_latest_batch;

  -- #2
  INSERT INTO #vw_entity_file_activity_latest_batch (
    entity_id,
    file_name,
    run_activity_id,
    activity_order,
    status_id
  )
  VALUES
    (1, 'Test1.1', 21, 100, 2), -- entity 1: successful extraction
    (1, 'Test1.1', 19, 200, 4), -- entity 1: failed test duplicates
    (1, 'Test1.1', 10, 300, 2), -- entity 1: successful base ingestion
    (2, 'Test2.1', 21, 100, 1), -- entity 2: extraction in progress 
    (2, 'Test2.1', 19, 200, NULL), -- entity 2: no status for test duplicates
    (2, 'Test2.2', 21, 100, 2); -- entity 2 file 2: no failed activities 

  EXEC ('INSERT INTO dbo.vw_entity_file_activity_latest_batch SELECT * FROM #vw_entity_file_activity_latest_batch');

  -- Act: 
  SELECT entity_id, file_name, first_failed_activity_order
  INTO actual
  FROM vw_entity_file_first_failed_activity;

  -- Assert:
  CREATE TABLE expected (
    entity_id INT,
    file_name VARCHAR(20),
    first_failed_activity_order INT
  );

  INSERT INTO expected(entity_id, file_name, first_failed_activity_order)
  VALUES
    (1, 'Test1.1', 200),
    (2, 'Test2.1', 200);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO


CREATE PROCEDURE [EntityFile].[test tvf_entity_file_activity_isRequired: output]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
  IF OBJECT_ID('tempdb..#vw_entity_file_activity_latest_batch') IS NOT NULL DROP TABLE #vw_entity_file_activity_latest_batch;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[vw_entity_file_activity_latest_batch]';

  --vw_entity_file_activity_latest_batch
  SELECT TOP(0) *
  INTO #vw_entity_file_activity_latest_batch
  FROM dbo.vw_entity_file_activity_latest_batch;

  -- #2
  INSERT INTO #vw_entity_file_activity_latest_batch (
    [output]
  )
  VALUES
    (NULL), -- no output
    ('{}'), -- empty output
    ('{test}') -- non empty output;

  EXEC ('INSERT INTO dbo.vw_entity_file_activity_latest_batch SELECT * FROM #vw_entity_file_activity_latest_batch');

  --Act
  SELECT [output]
  INTO actual
  FROM dbo.tvf_entity_file_activity_isRequired(0);

  -- Assert:
  CREATE TABLE expected (
    [output] VARCHAR(10)
  );

  INSERT INTO expected([output])
  VALUES
    ('{}'),
    ('{}'),
    ('{test}');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO


CREATE PROCEDURE [EntityFile].[test tvf_entity_file_activity_requirements: required_activities]
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


CREATE PROCEDURE [EntityFile].[test tvf_entity_file_activity_requirements: skipped_activities]
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

CREATE FUNCTION EntityFile.Fake_tvf_entity_file_required_activity_requirements (@rerunSuccessfulFullEntities BIT = 0)

  RETURNS TABLE
  AS
  RETURN
    SELECT mock.*
    FROM ( VALUES
      (0, 1, NULL, NULL, NULL, NULL),
      (1, 1, NULL, NULL, NULL, '[]'),
      (2, 1, NULL, NULL, NULL, '["TestDuplicates"]')
    ) AS mock (
      entity_id,
      layer_id,
      file_name,
      trigger_date,
      skipped_activities,
      required_activities
    );
GO

CREATE PROCEDURE [EntityFile].[test tvf_entity_file_required_activities]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  EXEC tSQLt.FakeFunction 'dbo.tvf_entity_file_activity_requirements', 'EntityFile.Fake_tvf_entity_file_required_activity_requirements';

  -- Act: 
  SELECT
    entity_id
  INTO actual
  FROM dbo.tvf_entity_file_required_activities(0);

  -- Assert:
  CREATE TABLE expected (
    entity_id INT
  );

  INSERT INTO expected(
    entity_id
  )
  VALUES
    (2);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO


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

CREATE PROCEDURE [EntityFile].[test tvf_entity_file_activities_by_date: date and update_mode filter]
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


CREATE PROCEDURE [EntityFile].[test tvf_entity_file_activities_by_date: In Out ADLS Path]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
  IF OBJECT_ID('tempdb..#vw_adls_base_directory_path') IS NOT NULL DROP TABLE #vw_adls_base_directory_path;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable 'dbo.entity';
  EXEC tSQLt.FakeTable '[dbo]', '[vw_adls_base_directory_path]';
  EXEC tSQLt.FakeFunction 'dbo.tvf_entity_file_required_activities', 'EntityFile.Fake_tvf_entity_file_required_activities';

  /*
    Workaround to ingest mock data into a view
    https://stackoverflow.com/questions/14965427/tsqlt-faketable-doesnt-seem-to-work-with-views-that-have-constants-derived-field
  */
  SELECT TOP(0) *
  INTO #vw_adls_base_directory_path
  FROM dbo.vw_adls_base_directory_path
   
  INSERT INTO #vw_adls_base_directory_path (
    entity_id,
    base_dir_path
  )
  VALUES
    (0, 'FULL');

  EXEC ('INSERT INTO dbo.vw_adls_base_directory_path SELECT * FROM #vw_adls_base_directory_path');

  INSERT INTO entity (entity_id, update_mode)
  VALUES
    (0, 'Full');

  -- Act: 
  SELECT
    entity_id, adls_directory_path_In, adls_directory_path_Out
  INTO actual
  FROM dbo.tvf_entity_file_activities_by_date('2023-07-23', 0);

  -- Assert:
  CREATE TABLE expected (
    entity_id INT,
    adls_directory_path_In VARCHAR(100),
    adls_directory_path_Out VARCHAR(100)
  );

  INSERT INTO expected(
    entity_id,
    adls_directory_path_In,
    adls_directory_path_Out
  )
  VALUES
    (0, 'FULL/In/2023/07/23', 'FULL/Out/2023/07/23');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO





-- CREATE PROCEDURE [EntityFile].[test get_scheduled_entity_batch_activities: adls_directory_path: In Out]
--   -- Check that adls_directory_path_In includes /In/ and adls_directory_path_Out includes /Out/
-- AS
-- BEGIN
--   IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
--   IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
--   -- IF OBJECT_ID('tempdb..#vw_entity_file_requirement') IS NOT NULL DROP TABLE #vw_entity_file_requirement;
--   IF OBJECT_ID('tempdb..#vw_adls_base_directory_path') IS NOT NULL DROP TABLE #vw_adls_base_directory_path;
--   -- IF OBJECT_ID('tempdb..#vw_full_load_entities') IS NOT NULL DROP TABLE #vw_full_load_entities;
--   -- IF OBJECT_ID('tempdb..#vw_delta_load_entities') IS NOT NULL DROP TABLE #vw_delta_load_entities;

--   -- Assemble: Fake Table
--   -- EXEC tSQLt.FakeTable '[dbo]', '[entity]';
--   EXEC tSQLt.FakeTable '[dbo]', '[entity]';
--   EXEC tSQLt.FakeTable '[dbo]', '[vw_adls_base_directory_path]';
--   -- EXEC tSQLt.FakeTable '[dbo]', '[vw_full_load_entities]';
--   -- EXEC tSQLt.FakeTable '[dbo]', '[vw_delta_load_entities]';
--   EXEC tSQLt.FakeFunction '[dbo].[tvf_entity_file_activity_requirements]', 'EntityFile.Fake_tvf_entity_file_activity_requirements';

--   /*
--     Workaround to ingest mock data into a view
--     https://stackoverflow.com/questions/14965427/tsqlt-faketable-doesnt-seem-to-work-with-views-that-have-constants-derived-field
--   */
--   SELECT TOP(0) *
--   INTO #vw_adls_base_directory_path
--   FROM dbo.vw_adls_base_directory_path
   
--   INSERT INTO #vw_adls_base_directory_path (
--     entity_id,
--     base_dir_path
--   )
--   VALUES
--     (1, 'FULL'),
--     (2, 'DELTA');

--   EXEC ('INSERT INTO dbo.vw_adls_base_directory_path SELECT * FROM #vw_adls_base_directory_path');

--   INSERT INTO entity (entity_id, update_mode, schedule_recurrence)
--   VALUES
--     (0, 'Full',  'D'),
--     (1, NULL,    'D'),
--     (2, 'Delta', 'D');

--   -- Act: 
--   SELECT
--     entity_id,
--     adls_directory_path_In,
--     adls_directory_path_Out
--   INTO actual
--   FROM dbo.get_scheduled_entity_batch_activities(
--     0, '2023-07-23', 0
--   );

--   -- Assert:
--   CREATE TABLE expected (
--     entity_id INT,
--     adls_directory_path_In  NVARCHAR(100),
--     adls_directory_path_Out NVARCHAR(100)
--   );

--   INSERT INTO expected(
--     entity_id,
--     adls_directory_path_In,
--     adls_directory_path_Out
--   )
--   VALUES
--     (1, 'FULL/In/2023/07/23', 'FULL/Out/2023/07/23'),
--     (2, 'DELTA/In/2023/07/22', 'DELTA/Out/2023/07/22'),
--     (2, 'DELTA/In/2023/07/23', 'DELTA/Out/2023/07/23');

--   EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
-- END;
-- GO

-- CREATE PROCEDURE [EntityFile].[test get_scheduled_entity_batch_activities: adls_directory_path: Date]
--   -- Check that adls_directory_path_In and adls_directory_path_Out includes the correct date:
--   -- For full load entities, the date is equal to the provided date
--   -- For delta load entities, the date is equal to the date of the file 
-- AS
-- BEGIN

-- END;
-- GO

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


CREATE PROCEDURE [EntityFile].[test get_scheduled_entity_batch_activities: filtered on scheduled entities]
AS
BEGIN
  -- Check if all daily, weekly, monthly, adhoc scheduled entities exist in output of get_scheduled_entity_batch_activities
  -- and if not, these entities are also not returned by entity_file_requirement
  
  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
  -- IF OBJECT_ID('tempdb..#vw_full_load_entities') IS NOT NULL DROP TABLE #vw_full_load_entities;
  -- IF OBJECT_ID('tempdb..#vw_delta_load_entities') IS NOT NULL DROP TABLE #vw_delta_load_entities;

  -- Assemble: Fake Table
  -- EXEC tSQLt.FakeTable '[dbo]', '[entity]';
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';
  -- EXEC tSQLt.FakeTable '[dbo]', '[vw_delta_load_entities]';
  EXEC tSQLt.FakeFunction '[dbo].[tvf_entity_file_activities_by_date]', 'EntityFile.Fake_tvf_entity_file_activities_by_date';

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
  FROM dbo.get_scheduled_entity_batch_activities(
    0, '2023-07-23', 0 -- First day of week is on a Sunday
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


CREATE PROCEDURE [EntityFile].[test get_scheduled_entity_batch_activities: filtered on scheduled entities: monthly]
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


CREATE PROCEDURE [EntityFile].[test get_scheduled_entity_batch_activities: filtered on scheduled entities: monthly: beginning weekend]
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
    (0, NULL, NULL),
    (1, 'M', 1),
    (2, 'M', 2),
    (3, 'M', 3),
    (4, 'M', 4);

  -- Act: 
  SELECT entity_id
  INTO actual
  FROM dbo.get_scheduled_entity_batch_activities(
    0, '2023-07-03', 0 -- First working day of month which is a Monday
  );

  -- Assert:
  CREATE TABLE expected (entity_id INT);
  INSERT INTO expected (entity_id) VALUES (1), (3);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';

END;
GO


CREATE PROCEDURE [EntityFile].[test get_scheduled_entity_batch_activities: filtered on scheduled entities: monthly: ending weekend]
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
    (2, 'M', 0),
    (3, 'M', 1),
    (4, 'M', 2),
    (5, 'M', 3);

  -- Act: 
  SELECT entity_id
  INTO actual
  FROM dbo.get_scheduled_entity_batch_activities(
    0, '2023-04-28', 0
  );

  -- Assert:
  CREATE TABLE expected (entity_id INT);
  INSERT INTO expected (entity_id) VALUES (2);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';

END;
GO

CREATE PROCEDURE [EntityFile].[test get_scheduled_entity_batch_activities: filtered on scheduled entities: adhoc]
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


-- CREATE PROCEDURE [EntityFile].[test get_scheduled_entity_batch_activities: rerunSuccessfulFullEntities]
-- AS
-- BEGIN

-- END;
-- GO


-- CREATE PROCEDURE [EntityFile].[test get_scheduled_entity_batch_activities: filter on entities with required activities]
-- AS
-- BEGIN
--   IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
--   IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
--   -- IF OBJECT_ID('tempdb..#vw_entity_file_requirement') IS NOT NULL DROP TABLE #vw_entity_file_requirement;

--   -- Assemble: Fake Table
--   EXEC tSQLt.FakeTable '[dbo]', '[entity]';
--   EXEC tSQLt.FakeFunction '[dbo].[tvf_entity_file_activities_by_date]', 'EntityFile.Fake_tvf_entity_file_activities_by_date';

--   /*
--     Workaround to ingest mock data into a view
--     https://stackoverflow.com/questions/14965427/tsqlt-faketable-doesnt-seem-to-work-with-views-that-have-constants-derived-field
--   */
--   -- #1
--   -- SELECT TOP(0) *
--   -- INTO #vw_entity_file_requirement
--   -- FROM dbo.vw_entity_file_requirement

--   --   -- #2
--   -- INSERT INTO #vw_entity_file_requirement (
--   --   entity_id,
--   --   file_name,
--   --   required_activities
--   -- )
--   -- VALUES
--   --   (1, '1_2023_07_23_12_00_00_000', '[]'),
--   --   (2, '2_2023_07_23_12_00_00_000', '["TestDuplicates"]');
    
  
--   INSERT INTO dbo.entity (entity_id, schedule_recurrence)
--   VALUES (1, 'D');

--   -- #3
--   -- EXEC ('INSERT INTO dbo.vw_entity_file_requirement SELECT * FROM #vw_entity_file_requirement');
 
--   -- Act: 
--   SELECT entity_id
--   INTO actual
--   FROM dbo.get_scheduled_entity_batch_activities(
--     0, '2023-07-22', 0
--   );

--   -- Assert:
--   CREATE TABLE expected (entity_id INT);
--   INSERT INTO expected (entity_id) VALUES (1);

--   EXEC tSQLt.AssertEqualsTable 'expected', 'actual';

-- END;
-- GO

-- CREATE PROCEDURE [EntityFile].[test get_scheduled_entity_batch_activities: uniqueness]
-- AS
-- BEGIN

-- END;
-- GO

-- CREATE PROCEDURE [EntityFile].[test get_scheduled_entity_batch_activities: default current date]
-- AS
-- BEGIN
  
-- END;
-- GO


EXEC [tSQLt].[SetFakeViewOff] 'dbo';

GO


-- CREATE PROCEDURE [EntityFile].[test vw_non_failed_extracted_entity_file: filtered for EXTRACT activity only]
-- AS
-- BEGIN

--   IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;

--   -- Assemble: Fake Table
--   EXEC tSQLt.FakeTable '[dbo]', '[entity]';
--   EXEC tSQLt.FakeTable '[dbo]', '[layer]';
--   EXEC tSQLt.FakeTable '[dbo]', '[location]';
--   EXEC tSQLt.FakeTable '[dbo]', '[batch]';

--   INSERT INTO dbo.entity (entity_id, layer_id)
--   VALUES (1, 6);
--   INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
--   VALUES (6, 'S4H', 1);
--   INSERT INTO dbo.location (location_id, location_nk)
--   VALUES (1, 'S4H');
--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
--   VALUES (NEWID(), 1, NEWID(), 1, 21, 'EXTRACT'); -- S4H EXTRACT in progress
--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
--   VALUES (NEWID(), 1, NEWID(), 1, 1, 'NON-EXTRACT'); -- S4H NON-EXTRACT in progress

--   -- Act: 
--   SELECT entity_id, file_name
--   INTO actual
--   FROM vw_non_failed_extracted_entity_file
--   WHERE file_name <> 'EXTRACT';

--   -- Assert:
--   EXEC tSQLt.AssertEmptyTable 'actual';
-- END;
-- GO

-- CREATE PROCEDURE [EntityFile].[test vw_non_failed_extracted_entity_file: filtered for S4H successful or in-progress, or non-S4H successful]
-- AS
-- BEGIN

--   IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
--   IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

--   -- Assemble: Fake Table
--   EXEC tSQLt.FakeTable '[dbo]', '[entity]';
--   EXEC tSQLt.FakeTable '[dbo]', '[layer]';
--   EXEC tSQLt.FakeTable '[dbo]', '[location]';
--   EXEC tSQLt.FakeTable '[dbo]', '[batch]';


--   INSERT INTO dbo.entity (entity_id, layer_id)
--   VALUES (1, 5);
--   INSERT INTO dbo.entity (entity_id, layer_id)
--   VALUES (2, 6);
--   INSERT INTO dbo.entity (entity_id, layer_id)
--   VALUES (3, 7);
--   INSERT INTO dbo.entity (entity_id, layer_id)
--   VALUES (4, 8);
--   INSERT INTO dbo.entity (entity_id, layer_id)
--   VALUES (5, 0);
--   INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
--   VALUES (5, 'AXBI', 1);
--   INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
--   VALUES (6, 'S4H', 1);
--   INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
--   VALUES (7, 'USA', 1);
--   INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
--   VALUES (8, 'C4C', 1);
--   INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
--   VALUES (0, 'OTHER', 1);
--   INSERT INTO dbo.location (location_id, location_nk)
--   VALUES (1, 'DUMMY');
--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
--   VALUES (NEWID(), 1, NEWID(), 1, 21, 'in progress'); -- AXBI in progress
--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
--   VALUES (NEWID(), 1, NEWID(), 2, 21, 'successful'); -- AXBI successful
--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
--   VALUES (NEWID(), 2, NEWID(), 1, 21, 'in progress'); -- S4H in progress
--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
--   VALUES (NEWID(), 2, NEWID(), 2, 21, 'successful'); -- S4H successful
--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
--   VALUES (NEWID(), 2, NEWID(), 4, 21, 'failed'); -- S4H failed
--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
--   VALUES (NEWID(), 3, NEWID(), 1, 21, 'in progress'); -- USA in progress
--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
--   VALUES (NEWID(), 3, NEWID(), 2, 21, 'successful'); -- USA successful
--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
--   VALUES (NEWID(), 4, NEWID(), 1, 21, 'in progress'); -- C4C in progress
--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
--   VALUES (NEWID(), 4, NEWID(), 2, 21, 'successful'); -- C4C successful
--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
--   VALUES (NEWID(), 5, NEWID(), 1, 21, 'in progress'); -- OTHER in progress
--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
--   VALUES (NEWID(), 5, NEWID(), 2, 21, 'successful'); -- OTHER successful

--   -- Act: 
--   SELECT entity_id, file_name
--   INTO actual
--   FROM vw_non_failed_extracted_entity_file

--   -- Assert:
--   CREATE TABLE expected (
--     entity_id BIGINT,
--     file_name VARCHAR(20)
--   );

--   INSERT INTO expected(entity_id, file_name) SELECT 1, 'successful';
--   INSERT INTO expected(entity_id, file_name) SELECT 2, 'in progress';
--   INSERT INTO expected(entity_id, file_name) SELECT 2, 'successful';
--   INSERT INTO expected(entity_id, file_name) SELECT 3, 'successful';
--   INSERT INTO expected(entity_id, file_name) SELECT 4, 'successful';

--   EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
-- END;
-- GO



-- CREATE PROCEDURE [EntityFile].[test vw_latest_non_failed_extracted_entity_file]
-- AS
-- BEGIN

--   IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
--   IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

--   -- Assemble: Fake Table
--   EXEC tSQLt.FakeTable '[dbo]', '[entity]';
--   EXEC tSQLt.FakeTable '[dbo]', '[layer]';
--   EXEC tSQLt.FakeTable '[dbo]', '[location]';
--   EXEC tSQLt.FakeTable '[dbo]', '[batch]';


--   INSERT INTO dbo.entity (entity_id, layer_id)
--   VALUES (1, 5);
--   INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
--   VALUES (5, 'AXBI', 1);
--   INSERT INTO dbo.location (location_id, location_nk)
--   VALUES (1, 'DUMMY');
--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
--   VALUES (NEWID(), 1, NEWID(), 2, 21, 'test_2023_01_01_12:00:00'); -- earlier
--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
--   VALUES (NEWID(), 1, NEWID(), 2, 21, 'test_2023_01_01_13:00:00'); -- later

--   -- Act: 
--   SELECT entity_id, file_name
--   INTO actual
--   FROM vw_latest_non_failed_extracted_entity_file

--   -- Assert:
--   CREATE TABLE expected (
--     entity_id BIGINT,
--     file_name VARCHAR(50)
--   );

--   INSERT INTO expected(entity_id, file_name) SELECT 1, 'test_2023_01_01_13:00:00';

--   EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
-- END;
-- GO



-- CREATE PROCEDURE [EntityFile].[test vw_latest_entity_file_activity]
-- AS
-- BEGIN

--   IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
--   IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

--   -- Assemble: Fake Table
--   EXEC tSQLt.FakeTable '[dbo]', '[entity]';
--   EXEC tSQLt.FakeTable '[dbo]', '[layer]';
--   EXEC tSQLt.FakeTable '[dbo]', '[location]';
--   EXEC tSQLt.FakeTable '[dbo]', '[batch]';


--   INSERT INTO dbo.entity (entity_id, update_mode, layer_id)
--   VALUES (1, 'Full', 5);
--   INSERT INTO dbo.entity (entity_id, update_mode, layer_id)
--   VALUES (2, 'Delta', 5);
--   INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
--   VALUES (5, 'AXBI', 1);
--   INSERT INTO dbo.location (location_id, location_nk)
--   VALUES (1, 'DUMMY');
--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
--   VALUES (NEWID(), 1, NEWID(), 2, 21, '2023-01-01 12:00:00', 'test'); -- earlier full activity 1
--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
--   VALUES (NEWID(), 1, NEWID(), 2, 21, '2023-01-01 13:00:00', 'test'); -- later full activity 1
--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
--   VALUES (NEWID(), 1, NEWID(), 2, 22, '2023-01-01 12:00:00', 'test'); -- earlier full activity 2
--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
--   VALUES (NEWID(), 1, NEWID(), 2, 22, '2023-01-01 13:00:00', 'test'); -- later full activity 2
--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
--   VALUES (NEWID(), 2, NEWID(), 2, 21, '2023-01-01 12:00:00', 'test'); -- earlier delta activity 1
--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
--   VALUES (NEWID(), 2, NEWID(), 2, 21, '2023-01-01 13:00:00', 'test'); -- later delta activity 1

--   -- Act: 
--   SELECT entity_id, activity_id, start_date_time
--   INTO actual
--   FROM vw_latest_entity_file_activity

--   -- Assert:
--   CREATE TABLE expected (
--     entity_id BIGINT,
--     activity_id BIGINT,
--     start_date_time DATETIME
--   );

--   INSERT INTO expected(entity_id, activity_id, start_date_time) SELECT 1, 21, '2023-01-01 13:00:00';
--   INSERT INTO expected(entity_id, activity_id, start_date_time) SELECT 1, 22, '2023-01-01 13:00:00';
--   INSERT INTO expected(entity_id, activity_id, start_date_time) SELECT 2, 21, '2023-01-01 13:00:00';

--   EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
-- END;
-- GO



-- CREATE PROCEDURE [EntityFile].[test vw_first_failed_activity_order]
-- AS
-- BEGIN

--   IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
--   IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

--   -- Assemble: Fake Table
--   EXEC tSQLt.FakeTable '[dbo]', '[entity]';
--   EXEC tSQLt.FakeTable '[dbo]', '[layer]';
--   EXEC tSQLt.FakeTable '[dbo]', '[location]';
--   EXEC tSQLt.FakeTable '[dbo]', '[batch]';
--   EXEC tSQLt.FakeTable '[dbo]', '[batch_activity]';


--   INSERT INTO dbo.entity (entity_id, update_mode, layer_id)
--   VALUES (1, 'Full', 5);
--   INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
--   VALUES (5, 'AXBI', 1);
--   INSERT INTO dbo.location (location_id, location_nk)
--   VALUES (1, 'DUMMY');
--   INSERT INTO dbo.batch_activity (activity_id, activity_nk, activity_order)
--   VALUES (21, '1', 100);
--   INSERT INTO dbo.batch_activity (activity_id, activity_nk, activity_order)
--   VALUES (22, '2', 200);
--   INSERT INTO dbo.batch_activity (activity_id, activity_nk, activity_order)
--   VALUES (23, '3', 300);
--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
--   VALUES (NEWID(), 1, NEWID(), 2, 21, '2023-01-01 12:00:00', 'test'); -- activity 1: success
--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
--   VALUES (NEWID(), 1, NEWID(), 1, 22, '2023-01-01 12:00:00', 'test'); -- activity 2: fail
--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
--   VALUES (NEWID(), 1, NEWID(), 2, 23, '2023-01-01 12:00:00', 'test'); -- activity 3: success

--   -- Act: 
--   SELECT entity_id, activity_order
--   INTO actual
--   FROM vw_first_failed_activity_order

--   -- Assert:
--   CREATE TABLE expected (
--     entity_id BIGINT,
--     activity_order INT
--   );

--   INSERT INTO expected(entity_id, activity_order) SELECT 1, 200;

--   EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
-- END;
-- GO


-- CREATE PROCEDURE [EntityFile].[test vw_first_failed_file]
-- AS
-- BEGIN

--   IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
--   IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

--   -- Assemble: Fake Table
--   EXEC tSQLt.FakeTable '[dbo]', '[entity]';
--   EXEC tSQLt.FakeTable '[dbo]', '[layer]';
--   EXEC tSQLt.FakeTable '[dbo]', '[location]';
--   EXEC tSQLt.FakeTable '[dbo]', '[batch]';
--   EXEC tSQLt.FakeTable '[dbo]', '[batch_activity]';


--   INSERT INTO dbo.entity (entity_id, update_mode, layer_id)
--   VALUES (1, 'Full', 5);
--   INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
--   VALUES (5, 'AXBI', 1);
--   INSERT INTO dbo.location (location_id, location_nk)
--   VALUES (1, 'DUMMY');
--   INSERT INTO dbo.batch_activity (activity_id, activity_nk, activity_order)
--   VALUES (21, '1', 100);
--   INSERT INTO dbo.batch_activity (activity_id, activity_nk, activity_order)
--   VALUES (22, '2', 200);
--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
--   VALUES (NEWID(), 1, NEWID(), 2, 21, '2023-01-01 11:00:00', 'test_2023_01_01_11_00_00'); -- file 1: success extract
--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
--   VALUES (NEWID(), 1, NEWID(), 1, 22, '2023-01-01 11:30:00', 'test_2023_01_01_11_00_00'); -- file 1: fail 22
--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
--   VALUES (NEWID(), 1, NEWID(), 2, 22, '2023-01-01 12:00:00', 'test_2023_01_01_11_00_00'); -- file 1: success 22
--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
--   VALUES (NEWID(), 1, NEWID(), 2, 21, '2023-01-02 11:00:00', 'test_2023_01_02_11_00_00'); -- file 2: success extract
--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
--   VALUES (NEWID(), 1, NEWID(), 1, 22, '2023-01-02 11:30:00', 'test_2023_01_02_11_00_00'); -- file 2: fail 22
--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
--   VALUES (NEWID(), 1, NEWID(), 2, 21, '2023-01-03 11:00:00', 'test_2023_01_02_11_00_00'); -- file 3: success extract
--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
--   VALUES (NEWID(), 1, NEWID(), 2, 22, '2023-01-03 12:00:00', 'test_2023_01_03_11_00_00'); -- file 3: success 22

--   -- Act: 
--   SELECT entity_id, file_name
--   INTO actual
--   FROM vw_first_failed_file

--   -- Assert:
--   CREATE TABLE expected (
--     entity_id BIGINT,
--     file_name VARCHAR(100)
--   );

--   INSERT INTO expected(entity_id, file_name) SELECT 1, 'test_2023_01_02_11_00_00';

--   EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
-- END;
-- GO

-- CREATE PROCEDURE [EntityFile].[test vw_successful_file_activity_before_first_failure]
-- AS
-- BEGIN

--   IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
--   IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

--   -- Assemble: Fake Table
--   EXEC tSQLt.FakeTable '[dbo]', '[entity]';
--   EXEC tSQLt.FakeTable '[dbo]', '[layer]';
--   EXEC tSQLt.FakeTable '[dbo]', '[location]';
--   EXEC tSQLt.FakeTable '[dbo]', '[batch]';
--   EXEC tSQLt.FakeTable '[dbo]', '[batch_activity]';


--   INSERT INTO dbo.entity (entity_id, update_mode, layer_id)
--   VALUES (1, 'Full', 5);
--   INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
--   VALUES (5, 'AXBI', 1);
--   INSERT INTO dbo.location (location_id, location_nk)
--   VALUES (1, 'DUMMY');
--   INSERT INTO dbo.batch_activity (activity_id, activity_nk, activity_order)
--   VALUES (21, '1', 100);
--   INSERT INTO dbo.batch_activity (activity_id, activity_nk, activity_order)
--   VALUES (22, '2', 200);
--   INSERT INTO dbo.batch_activity (activity_id, activity_nk, activity_order)
--   VALUES (23, '3', 300);
--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
--   VALUES (NEWID(), 1, NEWID(), 2, 21, '2023-01-01 12:00:00', 'test'); -- activity 1: success
--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
--   VALUES (NEWID(), 1, NEWID(), 1, 22, '2023-01-01 12:00:00', 'test'); -- activity 2: fail
--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
--   VALUES (NEWID(), 1, NEWID(), 2, 23, '2023-01-01 12:00:00', 'test'); -- activity 3: success

--   -- Act: 
--   SELECT entity_id, activity_id
--   INTO actual
--   FROM vw_successful_file_activity_before_first_failure

--   -- Assert:
--   CREATE TABLE expected (
--     entity_id BIGINT,
--     activity_id INT
--   );

--   INSERT INTO expected(entity_id, activity_id) SELECT 1, 21;

--   EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
-- END;
-- GO



-- CREATE PROCEDURE [EntityFile].[test vw_latest_entity_file_activity_batch]
-- AS
-- BEGIN

--   IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
--   IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

--   -- Assemble: Fake Table
--   EXEC tSQLt.FakeTable '[dbo]', '[vw_latest_entity_file_activity]';
--   EXEC tSQLt.FakeTable '[dbo]', '[batch]';


--   /*
--     Workaround to ingest mock data into a view
--     https://stackoverflow.com/questions/14965427/tsqlt-faketable-doesnt-seem-to-work-with-views-that-have-constants-derived-field
--   */
--   -- #1
--   SELECT TOP(0) *
--   INTO #tempView
--   FROM dbo.vw_latest_entity_file_activity

--   -- #2
--   INSERT INTO #tempView (entity_id, file_name, activity_id, start_date_time)
--   VALUES
--     (1, 'Test1.1', 1, '2023-07-17 16:00:00'),
--     (1, 'Test1.1', 2, '2023-07-17 16:00:00'),
--     (1, 'Test1.2', 1, '2023-07-17 16:00:00'),
--     (1, 'Test1.2', 2, '2023-07-17 16:00:00'),
--     (2, 'Test2.1', 1, '2023-07-17 16:00:00'),
--     (2, 'Test2.1', 2, '2023-07-17 16:00:00'),
--     (2, 'Test2.2', 1, '2023-07-17 16:00:00'),
--     (2, 'Test2.2', 2, '2023-07-17 16:00:00');

--   -- #3
--   EXEC ('INSERT INTO dbo.vw_latest_entity_file_activity SELECT * FROM #tempView')

--   INSERT INTO dbo.batch (
--     entity_id,
--     file_name,
--     activity_id,
--     start_date_time,
--     batch_id
--   )
--   VALUES
--     (0, 'Test0.1', 1, '2023-07-17 16:00:00', '00000000-0000-0000-0000-000000000001'),
--     (0, 'Test0.1', 2, '2023-07-17 16:00:00', '00000000-0000-0000-0000-000000000002'),
--     (0, 'Test0.2', 1, '2023-07-17 16:00:00', '00000000-0000-0000-0000-000000000003'),
--     (0, 'Test0.2', 2, '2023-07-17 16:00:00', '00000000-0000-0000-0000-000000000004'),
--     (1, 'Test1.1', 1, '2023-07-17 16:00:00', '00000000-0000-0000-0000-000000000005'),
--     (1, 'Test1.1', 2, '2023-07-17 16:00:00', '00000000-0000-0000-0000-000000000006'),
--     (1, 'Test1.2', 1, '2023-07-17 16:00:00', '00000000-0000-0000-0000-000000000007'),
--     (1, 'Test1.2', 2, '2023-07-17 16:00:00', '00000000-0000-0000-0000-000000000008');

--   -- Act: 
--   SELECT 
--     entity_id,
--     file_name,
--     activity_id,
--     start_date_time,
--     batch_id
--   INTO actual
--   FROM vw_latest_entity_file_activity_batch

--   -- Assert:
--   CREATE TABLE expected (
--     entity_id INT,
--     file_name VARCHAR(10),
--     activity_id INT,
--     start_date_time DATETIME,
--     batch_id UNIQUEIDENTIFIER
--   );

--   INSERT INTO expected(
--     entity_id,
--     file_name,
--     activity_id,
--     start_date_time,
--     batch_id
--   )
--   VALUES
--     (1, 'Test1.1', 1, '2023-07-17 16:00:00', '00000000-0000-0000-0000-000000000005'),
--     (1, 'Test1.1', 2, '2023-07-17 16:00:00', '00000000-0000-0000-0000-000000000006'),
--     (1, 'Test1.2', 1, '2023-07-17 16:00:00', '00000000-0000-0000-0000-000000000007'),
--     (1, 'Test1.2', 2, '2023-07-17 16:00:00', '00000000-0000-0000-0000-000000000008');

--   EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
-- END;
-- GO




-- CREATE PROCEDURE [EntityFile].[test vw_scheduled_entity_file_activities]
-- AS
-- BEGIN

--   IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
--   IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
--   IF OBJECT_ID('tempdb..#tempView') IS NOT NULL DROP TABLE #tempView;

--   -- Assemble: Fake Table
--   EXEC tSQLt.FakeTable '[dbo]', '[vw_latest_entity_file_activity_batch]';

--   /*
--     Workaround to ingest mock data into a view
--     https://stackoverflow.com/questions/14965427/tsqlt-faketable-doesnt-seem-to-work-with-views-that-have-constants-derived-field
--   */
--   -- #1
--   SELECT TOP(0) *
--   INTO #tempView
--   FROM dbo.vw_latest_entity_file_activity_batch

--   -- #2
--   INSERT INTO #tempView (
--     entity_id,
--     file_name,
--     activity_nk,
--     activity_order,
--     batch_id,
--     [output],
--     isRequired
--   )
--   VALUES
--     (1, 'Test1.1', 'Extract', 100, '00000000-0000-0000-0000-000000000001', '{"timestamp":"2023-07-18_00:00:00"}', 0),
--     (1, 'Test1.1', 'Status',  200, '00000000-0000-0000-0000-000000000002', '{"status":"FinishedNoErrors"}', 0),
--     (1, 'Test1.1', 'Test',    300, '00000000-0000-0000-0000-000000000003', NULL, 1),
--     (1, 'Test1.1', 'Ingest',  400, '00000000-0000-0000-0000-000000000004', NULL, 1);

--   -- #3
--   EXEC tSQLt.FakeTable '[dbo]', '[vw_latest_entity_file_activity_batch]';
--   EXEC ('INSERT INTO dbo.vw_latest_entity_file_activity_batch SELECT * FROM #tempView')

--   -- Act: 
--   SELECT 
--     entity_id,
--     file_name,
--     activity_id,
--     required_activities,
--     skipped_activities
--   INTO actual
--   FROM vw_scheduled_entity_file_activities

--   -- Assert:
--   CREATE TABLE expected (
--     entity_id INT,
--     file_name VARCHAR(10),
--     required_activities NVARCHAR(MAX),
--     skipped_activities NVARCHAR(MAX)
--   );

--   INSERT INTO expected(
--     entity_id,
--     file_name,
--     required_activities,
--     skipped_activities
--   )
--   VALUES (
--     1,
--     'Test1.1',
--     '["Test","Ingest"]',
--     '{
--       "Extract":{
--         "batch_id":"00000000-0000-0000-0000-000000000001",
--         "output":{"timestamp":"2023-07-18_00:00:00"}
--       },{
--       "Status": {
--         "batch_id":"00000000-0000-0000-0000-000000000002",
--         "output":{"status":"FinishedNoErrors"}
--       }
--     }'
--   );

--   EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
-- END;
-- GO

-- Write your own SQL object definition here, and it'll be included in your package.
EXEC tSQLt.NewTestClass 'LoadTypeEntities';
GO

CREATE PROCEDURE [LoadTypeEntities].[test vw_full_load_entities]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';
  EXEC tSQLt.FakeTable '[dbo]', '[layer]';
  EXEC tSQLt.FakeTable '[dbo]', '[location]';

  INSERT INTO dbo.entity (entity_id, entity_name, layer_id, update_mode)
  VALUES (1, 'full', 6, 'Full');
  INSERT INTO dbo.entity (entity_id, entity_name, layer_id, update_mode)
  VALUES (2, 'delta', 6, 'Delta');
  INSERT INTO dbo.entity (entity_id, entity_name, layer_id, update_mode)
  VALUES (3, 'null', 6, NULL);
  INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
  VALUES (6, 'S4H', 1);
  INSERT INTO dbo.location (location_id, location_nk)
  VALUES (1, 'S4H');

  -- Act: 
  SELECT le.entity_id, entity_name
  INTO actual
  FROM vw_full_load_entities le
  INNER JOIN entity e
    ON
      e.entity_id = le.entity_id
      AND (
        e.update_mode <> 'Full'
        AND
        e.update_mode IS NOT NULL
      );

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
GO

CREATE PROCEDURE [LoadTypeEntities].[test vw_delta_load_entities]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';
  EXEC tSQLt.FakeTable '[dbo]', '[layer]';
  EXEC tSQLt.FakeTable '[dbo]', '[location]';

  INSERT INTO dbo.entity (entity_id, entity_name, layer_id, update_mode)
  VALUES (1, 'full', 6, 'Full');
  INSERT INTO dbo.entity (entity_id, entity_name, layer_id, update_mode)
  VALUES (2, 'delta', 6, 'Delta');
  INSERT INTO dbo.entity (entity_id, entity_name, layer_id, update_mode)
  VALUES (3, 'null', 6, NULL);
  INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
  VALUES (6, 'S4H', 1);
  INSERT INTO dbo.location (location_id, location_nk)
  VALUES (1, 'S4H');

  -- Act: 
  SELECT le.entity_id, entity_name
  INTO actual
  FROM vw_delta_load_entities le
  INNER JOIN entity e
    ON
      e.entity_id = le.entity_id
      AND
      e.update_mode <> 'Delta';

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
GO

EXEC tSQLt.NewTestClass 'ScheduledEntities';
GO

CREATE PROCEDURE [ScheduledEntities].[test get adhoc scheduled entities]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';
  EXEC tSQLt.FakeTable '[dbo]', '[layer]';
  EXEC tSQLt.FakeTable '[dbo]', '[location]';

  INSERT INTO dbo.entity (entity_id, entity_name, layer_id, schedule_recurrence)
  VALUES (1, 'non-adhoc', 6, 'D');
  INSERT INTO dbo.entity (entity_id, entity_name, layer_id, schedule_recurrence)
  VALUES (2, 'adhoc', 6, 'A');
  INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
  VALUES (6, 'S4H', 1);
  INSERT INTO dbo.location (location_id, location_nk)
  VALUES (1, 'S4H');

  -- Act: 
  SELECT entity_id, entity_name, schedule_recurrence
  INTO actual
  FROM dbo.get_scheduled_entities(1, GETDATE());

  -- Assert:
  CREATE TABLE expected (
    entity_id BIGINT,
    entity_name VARCHAR(112),
    schedule_recurrence VARCHAR(5)
  );

  INSERT INTO expected(entity_id, entity_name, schedule_recurrence) SELECT 1, 'non-adhoc', 'D';
  INSERT INTO expected(entity_id, entity_name, schedule_recurrence) SELECT 2, 'adhoc', 'A';

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO


CREATE PROCEDURE [ScheduledEntities].[test get non-adhoc scheduled entities]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';
  EXEC tSQLt.FakeTable '[dbo]', '[layer]';
  EXEC tSQLt.FakeTable '[dbo]', '[location]';

  INSERT INTO dbo.entity (entity_id, entity_name, layer_id, schedule_recurrence)
  VALUES (1, 'non-adhoc', 6, 'D');
  INSERT INTO dbo.entity (entity_id, entity_name, layer_id, schedule_recurrence)
  VALUES (2, 'adhoc', 6, 'A');
  INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
  VALUES (6, 'S4H', 1);
  INSERT INTO dbo.location (location_id, location_nk)
  VALUES (1, 'S4H');

  -- Act: 
  SELECT entity_id, entity_name, schedule_recurrence
  INTO actual
  FROM dbo.get_scheduled_entities(0, GETDATE());

  -- Assert:
  CREATE TABLE expected (
    entity_id BIGINT,
    entity_name VARCHAR(112),
    schedule_recurrence VARCHAR(5)
  );

  INSERT INTO expected(entity_id, entity_name, schedule_recurrence) SELECT 1, 'non-adhoc', 'D';

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO
-- Write your own SQL object definition here, and it'll be included in your package.
EXEC tSQLt.NewTestClass 'ScalarValuedFunction';
GO


-- CREATE PROCEDURE [ScalarValuedFunction].[test svf_get_isRequired_batch_activity]
-- AS
-- BEGIN
  
--   IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
--   IF OBJECT_ID('dummy') IS NOT NULL DROP TABLE dummy;
--   IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
  
--    CREATE TABLE dummy (
--     activity_id BIGINT,
--     status_id BIGINT
--   );

--   INSERT INTO dummy (activity_id, status_id)
--   VALUES
--     (21, 1),
--     (21, 2),
--     (21, 3),
--     (22, 1),
--     (22, 2),
--     (22, 3);

--   -- Act: 
--   SELECT
--     activity_id,
--     status_id,
--     dbo.svf_get_isRequired_batch_activity(activity_id, status_id) AS isRequired
--   INTO actual
--   FROM dummy

--   -- Assert:
--   CREATE TABLE expected (
--     activity_id BIGINT,
--     status_id BIGINT,
--     isRequired TINYINT
--   );

--   INSERT INTO expected (activity_id, status_id, isRequired)
--   VALUES
--     (21, 1, 0),
--     (21, 2, 0),
--     (21, 3, 1),
--     (22, 1, 1),
--     (22, 2, 0),
--     (22, 3, 1);

--   EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
-- END;
-- GO


CREATE PROCEDURE [ScalarValuedFunction].[test svf_get_isRequired_full_batch_activity: activity before failure]
AS
BEGIN  
  -- Act: 
  DECLARE @actual INT = ( SELECT dbo.svf_get_isRequired_full_batch_activity(
    100, 200, 0
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 0, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunction].[test svf_get_isRequired_full_batch_activity: activity after failure]
AS
BEGIN  
  -- Act: 
  DECLARE @actual INT = ( SELECT dbo.svf_get_isRequired_full_batch_activity(
    200, 100, 0
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 1, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunction].[test svf_get_isRequired_full_batch_activity: no failed activity]
AS
BEGIN  
  -- Act: 
  DECLARE @actual INT = ( SELECT dbo.svf_get_isRequired_full_batch_activity(
    200, NULL, 0
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 0, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunction].[test svf_get_isRequired_full_batch_activity: rerun successfull entities]
AS
BEGIN  
  -- Act: 
  DECLARE @actual INT = ( SELECT dbo.svf_get_isRequired_full_batch_activity(
    200, NULL, 1
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 1, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunction].[test svf_get_isRequired_delta_batch_activity: activity_order 100]
AS
BEGIN  
  -- Act: 
  DECLARE @actual INT = ( SELECT dbo.svf_get_isRequired_delta_batch_activity(
    'test1', 'test2', 100, 200
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 0, @actual;
END;
GO


CREATE PROCEDURE [ScalarValuedFunction].[test svf_get_isRequired_delta_batch_activity: file before failure]
AS
BEGIN  
  -- Act: 
  DECLARE @actual INT = ( SELECT dbo.svf_get_isRequired_delta_batch_activity(
    'test1', 'test2', 100, 200
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 0, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunction].[test svf_get_isRequired_delta_batch_activity: file after failure]
AS
BEGIN  
  -- Act: 
  DECLARE @actual INT = ( SELECT dbo.svf_get_isRequired_delta_batch_activity(
    'test2', 'test1', 200, 300
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 1, @actual;
END;
GO

CREATE PROCEDURE [ScalarValuedFunction].[test svf_get_isRequired_delta_batch_activity: no failed file]
AS
BEGIN  
  -- Act: 
  DECLARE @actual INT = ( SELECT dbo.svf_get_isRequired_delta_batch_activity(
    'test1', NULL, 100, 200
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 0, @actual;
END;
GO


-- CREATE PROCEDURE [ScalarValuedFunction].[test svf_get_isRequired_batch_activity: Full update_mode]
-- AS
-- BEGIN  
--   -- Act: 
--   DECLARE @actual INT = ( SELECT dbo.svf_get_isRequired_batch_activity(
--     'Full', 'test1', NULL, 100, 200, 0
--   ));

--   -- Assert:
--   EXEC tSQLt.AssertEquals 0, @actual;
-- END;
-- GO

-- CREATE PROCEDURE [ScalarValuedFunction].[test svf_get_isRequired_batch_activity: NULL update_mode]
-- AS
-- BEGIN  
--   -- Act: 
--   DECLARE @actual INT = ( SELECT dbo.svf_get_isRequired_batch_activity(
--     NULL, 'test1', NULL, 100, 200, 0
--   ));

--   -- Assert:
--   EXEC tSQLt.AssertEquals 0, @actual;
-- END;
-- GO

-- CREATE PROCEDURE [ScalarValuedFunction].[test svf_get_isRequired_batch_activity: rerunSuccessfulFullEntities]
-- AS
-- BEGIN  
--   -- Act: 
--   DECLARE @actual INT = ( SELECT dbo.svf_get_isRequired_batch_activity(
--     'Full', 'test1', NULL, 100, 200, 1
--   ));

--   -- Assert:
--   EXEC tSQLt.AssertEquals 1, @actual;
-- END;
-- GO

-- CREATE PROCEDURE [ScalarValuedFunction].[test svf_get_isRequired_batch_activity: Delta update_mode]
-- AS
-- BEGIN  
--   -- Act: 
--   DECLARE @actual INT = ( SELECT dbo.svf_get_isRequired_batch_activity(
--     'Delta', 'test1', NULL, 100, 200, 0
--   ));

--   -- Assert:
--   EXEC tSQLt.AssertEquals 0, @actual;
-- END;
-- GO

CREATE PROCEDURE [ScalarValuedFunction].[test svf_get_adls_directory_path]
AS
BEGIN  
  -- Act: 
  DECLARE @actual VARCHAR(170) = ( SELECT dbo.svf_get_adls_directory_path(
    'FACT/C_BillingDocumentItemBasixDEX/Theobald/ODP/Full', 'In', '2023-07-20 12:00:00'
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 'FACT/C_BillingDocumentItemBasixDEX/Theobald/ODP/Full/In/2023/07/20', @actual;
END;
GO


CREATE PROCEDURE [ScalarValuedFunction].[test svf_get_triggerDate]
AS
BEGIN  
  -- Act: 
  DECLARE @actual CHAR(8) = ( SELECT CONVERT(
    CHAR(8),
    dbo.svf_get_triggerDate('ITEM_GROUPS_2022_07_08_04_03_19_356.parquet'),
    112
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals '20220708', @actual;
END;
GO




-- :r ..\..\TestClasses\FailTest.sql
GO
