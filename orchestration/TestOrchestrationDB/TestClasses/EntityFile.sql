-- Write your own SQL object definition here, and it'll be included in your package.
EXEC tSQLt.NewTestClass 'EntityFile';
GO

CREATE PROCEDURE [EntityFile].[test vw_non_failed_extracted_entity_file: filtered for EXTRACT activity only]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';
  EXEC tSQLt.FakeTable '[dbo]', '[layer]';
  EXEC tSQLt.FakeTable '[dbo]', '[location]';
  EXEC tSQLt.FakeTable '[dbo]', '[batch]';

  INSERT INTO dbo.entity (entity_id, layer_id)
  VALUES (1, 6);
  INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
  VALUES (6, 'S4H', 1);
  INSERT INTO dbo.location (location_id, location_nk)
  VALUES (1, 'S4H');
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
  VALUES (NEWID(), 1, NEWID(), 1, 21, 'EXTRACT'); -- S4H EXTRACT in progress
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
  VALUES (NEWID(), 1, NEWID(), 1, 1, 'NON-EXTRACT'); -- S4H NON-EXTRACT in progress

  -- Act: 
  SELECT entity_id, file_name
  INTO actual
  FROM vw_non_failed_extracted_entity_file
  WHERE file_name <> 'EXTRACT';

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
GO

CREATE PROCEDURE [EntityFile].[test vw_non_failed_extracted_entity_file: filtered for S4H successful or in-progress, or non-S4H successful]
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
  VALUES (1, 5);
  INSERT INTO dbo.entity (entity_id, layer_id)
  VALUES (2, 6);
  INSERT INTO dbo.entity (entity_id, layer_id)
  VALUES (3, 7);
  INSERT INTO dbo.entity (entity_id, layer_id)
  VALUES (4, 8);
  INSERT INTO dbo.entity (entity_id, layer_id)
  VALUES (5, 0);
  INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
  VALUES (5, 'AXBI', 1);
  INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
  VALUES (6, 'S4H', 1);
  INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
  VALUES (7, 'USA', 1);
  INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
  VALUES (8, 'C4C', 1);
  INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
  VALUES (0, 'OTHER', 1);
  INSERT INTO dbo.location (location_id, location_nk)
  VALUES (1, 'DUMMY');
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
  VALUES (NEWID(), 1, NEWID(), 1, 21, 'in progress'); -- AXBI in progress
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
  VALUES (NEWID(), 1, NEWID(), 2, 21, 'successful'); -- AXBI successful
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
  VALUES (NEWID(), 2, NEWID(), 1, 21, 'in progress'); -- S4H in progress
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
  VALUES (NEWID(), 2, NEWID(), 2, 21, 'successful'); -- S4H successful
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
  VALUES (NEWID(), 2, NEWID(), 4, 21, 'failed'); -- S4H failed
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
  VALUES (NEWID(), 3, NEWID(), 1, 21, 'in progress'); -- USA in progress
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
  VALUES (NEWID(), 3, NEWID(), 2, 21, 'successful'); -- USA successful
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
  VALUES (NEWID(), 4, NEWID(), 1, 21, 'in progress'); -- C4C in progress
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
  VALUES (NEWID(), 4, NEWID(), 2, 21, 'successful'); -- C4C successful
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
  VALUES (NEWID(), 5, NEWID(), 1, 21, 'in progress'); -- OTHER in progress
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
  VALUES (NEWID(), 5, NEWID(), 2, 21, 'successful'); -- OTHER successful

  -- Act: 
  SELECT entity_id, file_name
  INTO actual
  FROM vw_non_failed_extracted_entity_file

  -- Assert:
  CREATE TABLE expected (
    entity_id BIGINT,
    file_name VARCHAR(20)
  );

  INSERT INTO expected(entity_id, file_name) SELECT 1, 'successful';
  INSERT INTO expected(entity_id, file_name) SELECT 2, 'in progress';
  INSERT INTO expected(entity_id, file_name) SELECT 2, 'successful';
  INSERT INTO expected(entity_id, file_name) SELECT 3, 'successful';
  INSERT INTO expected(entity_id, file_name) SELECT 4, 'successful';

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO



CREATE PROCEDURE [EntityFile].[test vw_latest_non_failed_extracted_entity_file]
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
  VALUES (1, 5);
  INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
  VALUES (5, 'AXBI', 1);
  INSERT INTO dbo.location (location_id, location_nk)
  VALUES (1, 'DUMMY');
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
  VALUES (NEWID(), 1, NEWID(), 2, 21, 'test_2023_01_01_12:00:00'); -- earlier
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name)
  VALUES (NEWID(), 1, NEWID(), 2, 21, 'test_2023_01_01_13:00:00'); -- later

  -- Act: 
  SELECT entity_id, file_name
  INTO actual
  FROM vw_latest_non_failed_extracted_entity_file

  -- Assert:
  CREATE TABLE expected (
    entity_id BIGINT,
    file_name VARCHAR(50)
  );

  INSERT INTO expected(entity_id, file_name) SELECT 1, 'test_2023_01_01_13:00:00';

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO



CREATE PROCEDURE [EntityFile].[test vw_latest_entity_file_activity]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';
  EXEC tSQLt.FakeTable '[dbo]', '[layer]';
  EXEC tSQLt.FakeTable '[dbo]', '[location]';
  EXEC tSQLt.FakeTable '[dbo]', '[batch]';


  INSERT INTO dbo.entity (entity_id, update_mode, layer_id)
  VALUES (1, 'Full', 5);
  INSERT INTO dbo.entity (entity_id, update_mode, layer_id)
  VALUES (2, 'Delta', 5);
  INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
  VALUES (5, 'AXBI', 1);
  INSERT INTO dbo.location (location_id, location_nk)
  VALUES (1, 'DUMMY');
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
  VALUES (NEWID(), 1, NEWID(), 2, 21, '2023-01-01 12:00:00', 'test'); -- earlier full activity 1
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
  VALUES (NEWID(), 1, NEWID(), 2, 21, '2023-01-01 13:00:00', 'test'); -- later full activity 1
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
  VALUES (NEWID(), 1, NEWID(), 2, 22, '2023-01-01 12:00:00', 'test'); -- earlier full activity 2
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
  VALUES (NEWID(), 1, NEWID(), 2, 22, '2023-01-01 13:00:00', 'test'); -- later full activity 2
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
  VALUES (NEWID(), 2, NEWID(), 2, 21, '2023-01-01 12:00:00', 'test'); -- earlier delta activity 1
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
  VALUES (NEWID(), 2, NEWID(), 2, 21, '2023-01-01 13:00:00', 'test'); -- later delta activity 1

  -- Act: 
  SELECT entity_id, activity_id, start_date_time
  INTO actual
  FROM vw_latest_entity_file_activity

  -- Assert:
  CREATE TABLE expected (
    entity_id BIGINT,
    activity_id BIGINT,
    start_date_time DATETIME
  );

  INSERT INTO expected(entity_id, activity_id, start_date_time) SELECT 1, 21, '2023-01-01 13:00:00';
  INSERT INTO expected(entity_id, activity_id, start_date_time) SELECT 1, 22, '2023-01-01 13:00:00';
  INSERT INTO expected(entity_id, activity_id, start_date_time) SELECT 2, 21, '2023-01-01 13:00:00';

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO



CREATE PROCEDURE [EntityFile].[test vw_first_failed_activity_order]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';
  EXEC tSQLt.FakeTable '[dbo]', '[layer]';
  EXEC tSQLt.FakeTable '[dbo]', '[location]';
  EXEC tSQLt.FakeTable '[dbo]', '[batch]';
  EXEC tSQLt.FakeTable '[dbo]', '[batch_activity]';


  INSERT INTO dbo.entity (entity_id, update_mode, layer_id)
  VALUES (1, 'Full', 5);
  INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
  VALUES (5, 'AXBI', 1);
  INSERT INTO dbo.location (location_id, location_nk)
  VALUES (1, 'DUMMY');
  INSERT INTO dbo.batch_activity (activity_id, activity_nk, activity_order)
  VALUES (21, '1', 100);
  INSERT INTO dbo.batch_activity (activity_id, activity_nk, activity_order)
  VALUES (22, '2', 200);
  INSERT INTO dbo.batch_activity (activity_id, activity_nk, activity_order)
  VALUES (23, '3', 300);
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
  VALUES (NEWID(), 1, NEWID(), 2, 21, '2023-01-01 12:00:00', 'test'); -- activity 1: success
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
  VALUES (NEWID(), 1, NEWID(), 1, 22, '2023-01-01 12:00:00', 'test'); -- activity 2: fail
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
  VALUES (NEWID(), 1, NEWID(), 2, 23, '2023-01-01 12:00:00', 'test'); -- activity 3: success

  -- Act: 
  SELECT entity_id, activity_order
  INTO actual
  FROM vw_first_failed_activity_order

  -- Assert:
  CREATE TABLE expected (
    entity_id BIGINT,
    activity_order INT
  );

  INSERT INTO expected(entity_id, activity_order) SELECT 1, 200;

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO


CREATE PROCEDURE [EntityFile].[test vw_first_failed_file]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';
  EXEC tSQLt.FakeTable '[dbo]', '[layer]';
  EXEC tSQLt.FakeTable '[dbo]', '[location]';
  EXEC tSQLt.FakeTable '[dbo]', '[batch]';
  EXEC tSQLt.FakeTable '[dbo]', '[batch_activity]';


  INSERT INTO dbo.entity (entity_id, update_mode, layer_id)
  VALUES (1, 'Full', 5);
  INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
  VALUES (5, 'AXBI', 1);
  INSERT INTO dbo.location (location_id, location_nk)
  VALUES (1, 'DUMMY');
  INSERT INTO dbo.batch_activity (activity_id, activity_nk, activity_order)
  VALUES (21, '1', 100);
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
  VALUES (NEWID(), 1, NEWID(), 2, 21, '2023-01-01 12:00:00', 'test_2023_01_01_12_00_00'); -- file 1: success
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
  VALUES (NEWID(), 1, NEWID(), 1, 21, '2023-01-02 12:00:00', 'test_2023_01_02_12_00_00'); -- file 2: fail
  -- INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
  -- VALUES (NEWID(), 1, NEWID(), 2, 21, '2023-01-02 13:00:00', 'test_2023_01_02_12_00_00'); -- file 2: success
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
  VALUES (NEWID(), 1, NEWID(), 2, 21, '2023-01-03 12:00:00', 'test_2023_01_03_12_00_00'); -- file 3: success

  -- Act: 
  SELECT entity_id, file_name
  INTO actual
  FROM vw_first_failed_file

  -- Assert:
  CREATE TABLE expected (
    entity_id BIGINT,
    file_name VARCHAR(100)
  );

  INSERT INTO expected(entity_id, file_name) SELECT 1, 'test_2023_01_02_12_00_00';

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO

CREATE PROCEDURE [EntityFile].[test vw_successful_file_activity_before_first_failure]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';
  EXEC tSQLt.FakeTable '[dbo]', '[layer]';
  EXEC tSQLt.FakeTable '[dbo]', '[location]';
  EXEC tSQLt.FakeTable '[dbo]', '[batch]';
  EXEC tSQLt.FakeTable '[dbo]', '[batch_activity]';


  INSERT INTO dbo.entity (entity_id, update_mode, layer_id)
  VALUES (1, 'Full', 5);
  INSERT INTO dbo.layer (layer_id, layer_nk, location_id)
  VALUES (5, 'AXBI', 1);
  INSERT INTO dbo.location (location_id, location_nk)
  VALUES (1, 'DUMMY');
  INSERT INTO dbo.batch_activity (activity_id, activity_nk, activity_order)
  VALUES (21, '1', 100);
  INSERT INTO dbo.batch_activity (activity_id, activity_nk, activity_order)
  VALUES (22, '2', 200);
  INSERT INTO dbo.batch_activity (activity_id, activity_nk, activity_order)
  VALUES (23, '3', 300);
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
  VALUES (NEWID(), 1, NEWID(), 2, 21, '2023-01-01 12:00:00', 'test'); -- activity 1: success
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
  VALUES (NEWID(), 1, NEWID(), 1, 22, '2023-01-01 12:00:00', 'test'); -- activity 2: fail
  INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, start_date_time, file_name)
  VALUES (NEWID(), 1, NEWID(), 2, 23, '2023-01-01 12:00:00', 'test'); -- activity 3: success

  -- Act: 
  SELECT entity_id, activity_id
  INTO actual
  FROM vw_successful_file_activity_before_first_failure

  -- Assert:
  CREATE TABLE expected (
    entity_id BIGINT,
    activity_id INT
  );

  INSERT INTO expected(entity_id, activity_id) SELECT 1, 21;

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO
