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

CREATE PROCEDURE [ScalarValuedFunction].[test svf_get_adls_directory_path returns correct output]
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


CREATE PROCEDURE [ScalarValuedFunction].[test svf_get_triggerDate returns correct output]
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



