-- Write your own SQL object definition here, and it'll be included in your package.
EXEC [tSQLt].[SetFakeViewOn] 'dbo';
GO

EXEC tSQLt.NewTestClass 'EntityFile';
GO

CREATE PROCEDURE [EntityFile].[test vw_entity_file: get files that have successful or in progress extraction activity only]
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
    (4, 6);
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
    (4, 'EXTRACT');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO


CREATE PROCEDURE [EntityFile].[test vw_entity_file: unique entity-file]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;

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
    (4, 6);
  INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
  VALUES (6, 'S4H', 1);
  INSERT INTO dbo.location (location_id, location_nk)
  VALUES (1, 'S4H');
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
  VALUES
    (NEWID(), 1, NEWID(), 1, 21, 'Test', ),     -- entity 1: EXTRACT in progress
    (NEWID(), 2, NEWID(), 1, 1,  'NON-EXTRACT'), -- entity 2: NON-EXTRACT in progress
    (NEWID(), 3, NEWID(), 4, 21, 'EXTRACT'),     -- entity 3: EXTRACT failed
    (NEWID(), 4, NEWID(), 2, 21, 'EXTRACT');     -- entity 4: EXTRACT successful

  -- Act: 
  SELECT entity_id, file_name
  INTO actual
  FROM vw_entity_file
  GROUP BY entity_id, file_name
  HAVING COUNT(*) > 1;

  -- Assert:
  EXEC tSQLt.AssertEmptyTable actual;
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
    (1, 'Test1', 2);

  EXEC ('INSERT INTO dbo.vw_entity_file_activity SELECT * FROM #vw_entity_file_activity');

  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name, start_date_time)
  VALUES
    (NEWID(), 1, NEWID(), 2, 21, 'Test1', '2023-07-20 12:00'), -- entity 1: EXTRACT successful
    (NEWID(), 1, NEWID(), 2, 19, 'Test1', '2023-07-20 12:30'), -- entity 1: Test Duplicates earlier
    (NEWID(), 1, NEWID(), 2, 19, 'Test1', '2023-07-20 13:00'); -- entity 1: Test Duplicates later

  -- Act: 
  SELECT entity_id, file_name, expected_activity_id, start_date_time
  INTO actual
  FROM vw_entity_file_activity_latest_run;

  -- Assert:
  CREATE TABLE expected (
    entity_id INT,
    file_name VARCHAR(20),
    expected_activity_id INT,
    start_date_time DATETIME
  );

  INSERT INTO expected(entity_id, file_name, expected_activity_id, start_date_time)
  VALUES
    (1, 'Test1', 21, '2023-07-20 12:00'),
    (1, 'Test1', 19, '2023-07-20 13:00'),
    (1, 'Test1', 2, NULL);

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
  SELECT entity_id, file_name, activity_order
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
    (2, 'Test2.1', 200),
    (2, 'Test2.2', NULL);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO


CREATE PROCEDURE [EntityFile].[test vw_entity_file_required_activity: output]
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
  FROM dbo.vw_entity_file_required_activity;

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


CREATE PROCEDURE [EntityFile].[test vw_entity_file_requirement: required_activities]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
  IF OBJECT_ID('tempdb..#vw_entity_file_required_activity') IS NOT NULL DROP TABLE #vw_entity_file_required_activity;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[vw_entity_file_required_activity]';

  /*
    Workaround to ingest mock data into a view
    https://stackoverflow.com/questions/14965427/tsqlt-faketable-doesnt-seem-to-work-with-views-that-have-constants-derived-field
  */
  -- #1
  SELECT TOP(0) *
  INTO #vw_entity_file_required_activity
  FROM dbo.vw_entity_file_required_activity

  -- #2
  INSERT INTO #vw_entity_file_required_activity (
    entity_id,
    file_name,
    activity_nk,
    activity_order,
    isRequired
  )
  VALUES
    (1, 'Test1.1', 'Extract', 100, 0),
    (1, 'Test1.1', 'Status',  200, 1),
    (1, 'Test1.1', 'Test',    300, 1),
    (1, 'Test1.2', 'Extract', 100, 0),
    (1, 'Test1.2', 'Status',  200, 0),
    (2, 'Test2.1', 'Extract', 100, 0),
    (2, 'Test2.1', 'Status',  200, 1);

  -- #3
  EXEC tSQLt.FakeTable '[dbo]', '[vw_entity_file_required_activity]';
  EXEC ('INSERT INTO dbo.vw_entity_file_required_activity SELECT * FROM #vw_entity_file_required_activity')

  -- Act: 
  SELECT
    entity_id,
    file_name,
    required_activities
  INTO actual
  FROM vw_entity_file_requirement;

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
    (2, 'Test2.1', '["Status"]');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO


CREATE PROCEDURE [EntityFile].[test vw_entity_file_requirement: skipped_activities]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
  IF OBJECT_ID('tempdb..#vw_entity_file_required_activity') IS NOT NULL DROP TABLE #vw_entity_file_required_activity;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[vw_entity_file_required_activity]';

  /*
    Workaround to ingest mock data into a view
    https://stackoverflow.com/questions/14965427/tsqlt-faketable-doesnt-seem-to-work-with-views-that-have-constants-derived-field
  */
  -- #1
  SELECT TOP(0) *
  INTO #vw_entity_file_required_activity
  FROM dbo.vw_entity_file_required_activity

  -- #2
  INSERT INTO #vw_entity_file_required_activity (
    entity_id,
    file_name,
    activity_nk,
    activity_order,
    isRequired,
    batch_id,
    [output]
  )
  VALUES
    (1, 'Test1.1', 'Extract', 100, 0, '00000000-0000-0000-0000-000000000001', '{"timestamp":"2023-07-18_00:00:00"}'),
    (1, 'Test1.1', 'Status',  200, 1, '00000000-0000-0000-0000-000000000002', '{"status":"FinishedNoErrors"}'),
    (1, 'Test1.1', 'Test',    300, 1, '00000000-0000-0000-0000-000000000003', '{}'),
    (1, 'Test1.2', 'Extract', 100, 0, '00000000-0000-0000-0000-000000000004', '{"timestamp":"2023-07-18_00:00:00"}'),
    (1, 'Test1.2', 'Status',  200, 0, '00000000-0000-0000-0000-000000000005', '{"status":"FinishedNoErrors"}'),
    (2, 'Test2.1', 'Extract', 100, 0, '00000000-0000-0000-0000-000000000006', '{"timestamp":"2023-07-18_00:00:00"}'),
    (2, 'Test2.1', 'Status',  200, 1, '00000000-0000-0000-0000-000000000007', '{"status":"FinishedNoErrors"}');

  -- #3
  EXEC tSQLt.FakeTable '[dbo]', '[vw_entity_file_required_activity]';
  EXEC ('INSERT INTO dbo.vw_entity_file_required_activity SELECT * FROM #vw_entity_file_required_activity')

  -- Act: 
  SELECT
    entity_id,
    file_name,
    skipped_activities
  INTO actual
  FROM vw_entity_file_requirement;

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
    (2, 'Test2.1', '{"Extract": {"batch_id":"00000000-0000-0000-0000-000000000006", "output":{"timestamp":"2023-07-18_00:00:00"}}}');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO

CREATE PROCEDURE [EntityFile].[test get_scheduled_entity_batch_activities: adls_directory_path: In Out]
  -- Check that adls_directory_path_In includes /In/ and adls_directory_path_Out includes /Out/
AS
BEGIN

END;
GO

CREATE PROCEDURE [EntityFile].[test get_scheduled_entity_batch_activities: adls_directory_path: Date]
  -- Check that adls_directory_path_In and adls_directory_path_Out includes the correct date:
  -- For full load entities, the date is equal to the provided date
  -- For delta load entities, the date is equal to the date of the file 
AS
BEGIN

END;
GO

CREATE PROCEDURE [EntityFile].[test get_scheduled_entity_batch_activities: filtered on scheduled entities: daily]
AS
BEGIN
  -- Check if all daily scheduled entities exist in output of get_scheduled_entity_batch_activities
  -- and if not, these entities are also not returned by entity_file_requirement

END;
GO

CREATE PROCEDURE [EntityFile].[test get_scheduled_entity_batch_activities: filtered on scheduled entities: weekly]
AS
BEGIN

END;
GO

CREATE PROCEDURE [EntityFile].[test get_scheduled_entity_batch_activities: filtered on scheduled entities: monthly]
AS
BEGIN

END;
GO

CREATE PROCEDURE [EntityFile].[test get_scheduled_entity_batch_activities: filtered on scheduled entities: adhoc]
AS
BEGIN

END;
GO

CREATE PROCEDURE [EntityFile].[test get_scheduled_entity_batch_activities: filter on entities with required activities]
AS
BEGIN

END;
GO

CREATE PROCEDURE [EntityFile].[test get_scheduled_entity_batch_activities: uniqueness]
AS
BEGIN

END;
GO

CREATE PROCEDURE [EntityFile].[test get_scheduled_entity_batch_activities: default current date]
AS
BEGIN
  
END;
GO


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
