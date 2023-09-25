-- Write your own SQL object definition here, and it'll be included in your package.
EXEC [tSQLt].[SetFakeViewOn] 'edw';
GO

EXEC tSQLt.NewTestClass 'Uniqueness';
GO


CREATE PROCEDURE [Uniqueness].[test edw.vw_fact_ACDOCA_EPM_Base: uniqueness]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('tempdb..#vw_entity_file') IS NOT NULL DROP TABLE #vw_entity_file;
  -- IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_CustomerSalesArea]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_ZE_EXQLMAP_DT]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_BillingDocumentType]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_ProductSalesDelivery]';
  EXEC tSQLt.FakeTable '[edw]', '[vw_CurrencyConversionRate]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_CurrencyType]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_Brand]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_CustomerGroup]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_ACDOCA]';

  
  INSERT INTO base_s4h_cax.I_CustomerSalesArea (Customer, SalesOrganization, DistributionChannel, Division)
  VALUES
    (1, 1, 1, 1),
    (1, 1, 1, 2),
    (1, 2, 2, 1);
  INSERT INTO edw.dim_ZE_EXQLMAP_DT (GLAccountID, FunctionalAreaID)
  VALUES (1, 1), (1, 2);
  INSERT INTO edw.dim_BillingDocumentType (BillingDocumentTypeID)
  VALUES (1);
  INSERT INTO edw.dim_ProductSalesDelivery (ProductID, SalesOrganizationID, DistributionChannelID)
  VALUES (1, 1, 1), (1, 1, 2), (1, 2, 1);
  -- INSERT INTO edw.vw_CurrencyConversionRate (SourceCurrency)
  -- VALUES (?);
  INSERT INTO edw.dim_CurrencyType (CurrencyTypeID)
  VALUES (1);
  INSERT INTO edw.dim_Brand (BrandID)
  VALUES (1);
  INSERT INTO edw.dim_CustomerGroup (CustomerGroupID)
  VALUES (1);

  INSERT INTO edw.fact_ACDOCA (
    SourceLedgerID,
    CompanyCodeID,
    FiscalYear,
    AccountingDocument,
    LedgerGLLineItem,
    GLAccountID,
    FunctionalAreaID,
    BillingDocumentTypeID,
    ProductID,
    SalesOrganizationID,
    DistributionChannelID,
    CustomerID,
    CompanyCodeCurrency
  )
  VALUES
    (1, 1, 2023, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'EUR'),
    (1, 1, 2023, 1, 2, 1, 1, 1, 1, 1, 1, 1, 'EUR'),
    (1, 1, 2023, 2, 1, 1, 1, 1, 1, 1, 1, 1, 'EUR'),
    (1, 1, 2023, 2, 2, 1, 2, 1, 2, 2, 1, 1, 'EUR');
    
  SELECT TOP(0) *
  INTO #vw_CurrencyConversionRate
  FROM edw.vw_CurrencyConversionRate;

  -- #2
  INSERT INTO #vw_CurrencyConversionRate (
    SourceCurrency,
    TargetCurrency,
    ExchangeRate,
    CurrencyTypeID
  )
  VALUES
    ('EUR', 'EUR', 1.0, '30'),
    ('EUR', 'USD', 1.1, '40');

  EXEC ('INSERT INTO edw.vw_CurrencyConversionRate SELECT * FROM #vw_CurrencyConversionRate');

  -- Act: 
  SELECT
    SourceLedgerID,
    CompanyCodeID,
    FiscalYear,
    AccountingDocument,
    LedgerGLLineItem,
    CurrencyTypeID
  INTO actual
  FROM [edw].[vw_fact_ACDOCA_EPM_Base]
  GROUP BY
    SourceLedgerID,
    CompanyCodeID,
    FiscalYear,
    AccountingDocument,
    LedgerGLLineItem,
    CurrencyTypeID
  HAVING COUNT(*) > 1

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
GO

-- CREATE PROCEDURE [EntityFile].[test vw_entity_file_activity]
-- AS
-- BEGIN

--   IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
--   IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
--   IF OBJECT_ID('tempdb..#vw_entity_file') IS NOT NULL DROP TABLE #vw_entity_file;

--   -- Assemble: Fake Table
--   EXEC tSQLt.FakeTable '[dbo]', '[layer_activity]';
--   EXEC tSQLt.FakeTable '[dbo]', '[vw_entity_file]';

--   SELECT TOP(0) *
--   INTO #vw_entity_file
--   FROM dbo.vw_entity_file;

--   -- #2
--   INSERT INTO #vw_entity_file (
--     entity_id,
--     layer_id,
--     file_name
--   )
--   VALUES
--     (1, 1, 'Test1'),
--     (2, 1, NULL);

--   EXEC ('INSERT INTO dbo.vw_entity_file SELECT * FROM #vw_entity_file');

--   INSERT INTO dbo.layer_activity (layer_id, activity_id)
--   VALUES
--     (1, 1),
--     (1, 2),
--     (1, 3),
--     (2, 4),
--     (2, 5);

--   -- Act: 
--   SELECT entity_id, file_name, expected_activity_id
--   INTO actual
--   FROM vw_entity_file_activity;

--   -- Assert:
--   CREATE TABLE expected (
--     entity_id BIGINT,
--     file_name VARCHAR(20),
--     expected_activity_id INT
--   );

--   INSERT INTO expected(entity_id, file_name, expected_activity_id)
--   VALUES
--     (1, 'Test1', 1),
--     (1, 'Test1', 2),
--     (1, 'Test1', 3),
--     (2, NULL, 1),
--     (2, NULL, 2),
--     (2, NULL, 3);

--   EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
-- END;
-- GO


-- CREATE PROCEDURE [EntityFile].[test vw_entity_file_activity_latest_run]
-- AS
-- BEGIN

--   IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
--   IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
--   IF OBJECT_ID('tempdb..#vw_entity_file_activity') IS NOT NULL DROP TABLE #vw_entity_file_activity;

--   -- Assemble: Fake Table
--   EXEC tSQLt.FakeTable '[dbo]', '[batch]';
--   EXEC tSQLt.FakeTable '[dbo]', '[vw_entity_file_activity]';

--   SELECT TOP(0) *
--   INTO #vw_entity_file_activity
--   FROM dbo.vw_entity_file_activity;

--   -- #2
--   INSERT INTO #vw_entity_file_activity (
--     entity_id,
--     file_name,
--     expected_activity_id
--   )
--   VALUES
--     (1, 'Test1', 21),
--     (1, 'Test1', 19),
--     (1, 'Test1', 2),
--     (2, NULL, 21),
--     (2, NULL, 19),
--     (2, NULL, 2);

--   EXEC ('INSERT INTO dbo.vw_entity_file_activity SELECT * FROM #vw_entity_file_activity');

--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name, start_date_time)
--   VALUES
--     (NEWID(), 1, NEWID(), 2, 21, 'Test1', '2023-07-20 12:00'), -- entity 1: EXTRACT successful
--     (NEWID(), 1, NEWID(), 2, 19, 'Test1', '2023-07-20 12:30'), -- entity 1: Test Duplicates earlier
--     (NEWID(), 1, NEWID(), 2, 19, 'Test1', '2023-07-20 13:00'); -- entity 1: Test Duplicates later

--   -- Act: 
--   SELECT entity_id, file_name, expected_activity_id, latest_start_date_time
--   INTO actual
--   FROM vw_entity_file_activity_latest_run;

--   -- Assert:
--   CREATE TABLE expected (
--     entity_id INT,
--     file_name VARCHAR(20),
--     expected_activity_id INT,
--     latest_start_date_time DATETIME
--   );

--   INSERT INTO expected(entity_id, file_name, expected_activity_id, latest_start_date_time)
--   VALUES
--     (1, 'Test1', 21, '2023-07-20 12:00'),
--     (1, 'Test1', 19, '2023-07-20 13:00'),
--     (1, 'Test1', 2, NULL),
--     (2, NULL, 21, NULL),
--     (2, NULL, 19, NULL),
--     (2, NULL, 2, NULL);

--   EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
-- END;
-- GO


-- CREATE PROCEDURE [EntityFile].[test vw_entity_file_activity_latest_batch]
-- AS
-- BEGIN

--   IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
--   IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
--   IF OBJECT_ID('tempdb..#vw_entity_file_activity_latest_run') IS NOT NULL DROP TABLE #vw_entity_file_activity_latest_run;

--   -- Assemble: Fake Table
--   EXEC tSQLt.FakeTable '[dbo]', '[batch]';
--   EXEC tSQLt.FakeTable '[dbo]', '[batch_activity]';
--   EXEC tSQLt.FakeTable '[dbo]', '[vw_entity_file_activity_latest_run]';

--   SELECT TOP(0) *
--   INTO #vw_entity_file_activity_latest_run
--   FROM dbo.vw_entity_file_activity_latest_run;

--   -- #2
--   INSERT INTO #vw_entity_file_activity_latest_run (
--     entity_id,
--     file_name,
--     expected_activity_id,
--     run_activity_id,
--     latest_start_date_time
--   )
--   VALUES
--     (1, 'Test1', 21, 21, '2023-07-20 12:00:00.000'),
--     (1, 'Test1', 19, 19, '2023-07-20 13:00:00.000'),
--     (1, 'Test1', 2, NULL, NULL),
--     (2, NULL, 21, NULL, NULL),
--     (2, NULL, 19, NULL, NULL),
--     (2, NULL, 2, NULL, NULL);

--   EXEC ('INSERT INTO dbo.vw_entity_file_activity_latest_run SELECT * FROM #vw_entity_file_activity_latest_run');

--   INSERT INTO dbo.batch (batch_id, entity_id, run_id, status_id, activity_id, file_name, start_date_time, [output])
--   VALUES
--     (NEWID(), 0, NEWID(), 2, 21, 'Test0', '2023-07-20 12:00:00.000', '{"timestamp":"2023-07-20 12:00"}'),
--     (NEWID(), 1, NEWID(), 2, 21, 'Test1', '2023-07-20 11:00:00.000', '{"timestamp":"2023-07-20 11:00"}'),
--     (NEWID(), 1, NEWID(), 2, 21, 'Test1', '2023-07-20 12:00:00.000', '{"timestamp":"2023-07-20 12:00"}'), -- entity 1: EXTRACT successful
--     (NEWID(), 1, NEWID(), 2, 19, 'Test1', '2023-07-20 12:30:00.000', '{"timestamp":"2023-07-20 12:30"}'), -- entity 1: Test Duplicates earlier
--     (NEWID(), 1, NEWID(), 2, 19, 'Test1', '2023-07-20 13:00:00.000', '{"timestamp":"2023-07-20 13:00"}'); -- entity 1: Test Duplicates later

--   INSERT INTO dbo.batch_activity (activity_id, activity_nk, activity_order)
--   VALUES
--     (21, 'Extract', 100),
--     (19, 'GetStatus', 150),
--     ( 2, 'TestDuplicates', 200),
--     (10, 'DUMMY', NULL);

--   -- Act: 
--   SELECT entity_id, file_name, expected_activity_id, activity_nk, activity_order, latest_start_date_time, status_id, [output]
--   INTO actual
--   FROM vw_entity_file_activity_latest_batch;

--   -- Assert:
--   CREATE TABLE expected (
--     entity_id INT,
--     file_name VARCHAR(20),
--     expected_activity_id INT,
--     activity_nk VARCHAR(100),
--     activity_order INT,
--     latest_start_date_time DATETIME,
--     status_id INT,
--     [output] VARCHAR(100)
--   );

--   INSERT INTO expected(entity_id, file_name, expected_activity_id, activity_nk, activity_order, latest_start_date_time, status_id, [output])
--   VALUES
--     (1, 'Test1', 21, 'Extract',   100, '2023-07-20 12:00:00.000', 2, '{"timestamp":"2023-07-20 12:00"}'),
--     (1, 'Test1', 19, 'GetStatus', 150, '2023-07-20 13:00:00.000', 2, '{"timestamp":"2023-07-20 13:00"}'),
--     (1, 'Test1', 2, 'TestDuplicates', 200, NULL, NULL, NULL),
--     (2, NULL, 21, 'Extract',   100, NULL, NULL, NULL),
--     (2, NULL, 19, 'GetStatus', 150, NULL, NULL, NULL),
--     (2, NULL,  2, 'TestDuplicates', 200, NULL, NULL, NULL);

--   EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
-- END;
-- GO


-- CREATE PROCEDURE [EntityFile].[test vw_entity_first_failed_file]
-- AS
-- BEGIN

--   IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
--   IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
--   IF OBJECT_ID('tempdb..#vw_entity_file_activity_latest_batch') IS NOT NULL DROP TABLE #vw_entity_file_activity_latest_batch;

--   -- Assemble: Fake Table
--   EXEC tSQLt.FakeTable '[dbo]', '[vw_entity_file_activity_latest_batch]';

--   SELECT TOP(0) *
--   INTO #vw_entity_file_activity_latest_batch
--   FROM dbo.vw_entity_file_activity_latest_batch;

--   -- #2
--   INSERT INTO #vw_entity_file_activity_latest_batch (
--     entity_id,
--     file_name,
--     run_activity_id,
--     status_id
--   )
--   VALUES
--     (1, 'Test1', 21, 2),
--     (1, 'Test2', 19, 4);

--   EXEC ('INSERT INTO dbo.vw_entity_file_activity_latest_batch SELECT * FROM #vw_entity_file_activity_latest_batch');

--   -- Act: 
--   SELECT entity_id, first_failed_file_name
--   INTO actual
--   FROM vw_entity_first_failed_file;

--   -- Assert:
--   CREATE TABLE expected (
--     entity_id INT,
--     first_failed_file_name VARCHAR(20)
--   );

--   INSERT INTO expected(entity_id, first_failed_file_name)
--   VALUES
--     (1, 'Test2');

--   EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
-- END;
-- GO




-- CREATE PROCEDURE [EntityFile].[test vw_entity_file_first_failed_activity]
-- AS
-- BEGIN

--   IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
--   IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
--   IF OBJECT_ID('tempdb..#vw_entity_file_activity_latest_batch') IS NOT NULL DROP TABLE #vw_entity_file_activity_latest_batch;

--   -- Assemble: Fake Table
--   EXEC tSQLt.FakeTable '[dbo]', '[vw_entity_file_activity_latest_batch]';

--   SELECT TOP(0) *
--   INTO #vw_entity_file_activity_latest_batch
--   FROM dbo.vw_entity_file_activity_latest_batch;

--   -- #2
--   INSERT INTO #vw_entity_file_activity_latest_batch (
--     entity_id,
--     file_name,
--     run_activity_id,
--     activity_order,
--     status_id
--   )
--   VALUES
--     (1, 'Test1.1', 21, 100, 2), -- entity 1: successful extraction
--     (1, 'Test1.1', 19, 200, 4), -- entity 1: failed test duplicates
--     (1, 'Test1.1', 10, 300, 2), -- entity 1: successful base ingestion
--     (2, 'Test2.1', 21, 100, 1), -- entity 2: extraction in progress 
--     (2, 'Test2.1', 19, 200, NULL), -- entity 2: no status for test duplicates
--     (2, 'Test2.2', 21, 100, 2); -- entity 2 file 2: no failed activities 

--   EXEC ('INSERT INTO dbo.vw_entity_file_activity_latest_batch SELECT * FROM #vw_entity_file_activity_latest_batch');

--   -- Act: 
--   SELECT entity_id, file_name, first_failed_activity_order
--   INTO actual
--   FROM vw_entity_file_first_failed_activity;

--   -- Assert:
--   CREATE TABLE expected (
--     entity_id INT,
--     file_name VARCHAR(20),
--     first_failed_activity_order INT
--   );

--   INSERT INTO expected(entity_id, file_name, first_failed_activity_order)
--   VALUES
--     (1, 'Test1.1', 200),
--     (2, 'Test2.1', 200);

--   EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
-- END;
-- GO


-- CREATE PROCEDURE [EntityFile].[test tvf_entity_file_activity_isRequired: output]
-- AS
-- BEGIN

--   IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
--   IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
--   IF OBJECT_ID('tempdb..#vw_entity_file_activity_latest_batch') IS NOT NULL DROP TABLE #vw_entity_file_activity_latest_batch;

--   -- Assemble: Fake Table
--   EXEC tSQLt.FakeTable '[dbo]', '[vw_entity_file_activity_latest_batch]';

--   --vw_entity_file_activity_latest_batch
--   SELECT TOP(0) *
--   INTO #vw_entity_file_activity_latest_batch
--   FROM dbo.vw_entity_file_activity_latest_batch;

--   -- #2
--   INSERT INTO #vw_entity_file_activity_latest_batch (
--     [output]
--   )
--   VALUES
--     (NULL), -- no output
--     ('{}'), -- empty output
--     ('{test}') -- non empty output;

--   EXEC ('INSERT INTO dbo.vw_entity_file_activity_latest_batch SELECT * FROM #vw_entity_file_activity_latest_batch');

--   --Act
--   SELECT [output]
--   INTO actual
--   FROM dbo.tvf_entity_file_activity_isRequired(0);

--   -- Assert:
--   CREATE TABLE expected (
--     [output] VARCHAR(10)
--   );

--   INSERT INTO expected([output])
--   VALUES
--     ('{}'),
--     ('{}'),
--     ('{test}');

--   EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
-- END;
-- GO


-- CREATE PROCEDURE [EntityFile].[test tvf_entity_file_activity_requirements: required_activities]
-- AS
-- BEGIN

--   IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
--   IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
--   -- IF OBJECT_ID('tempdb..#vw_entity_file_required_activity') IS NOT NULL DROP TABLE #vw_entity_file_required_activity;

--   -- Assemble: Fake Table
--   EXEC tSQLt.FakeFunction '[dbo].[tvf_entity_file_activity_isRequired]', 'EntityFile.Fake_tvf_entity_file_activity_isRequired';

--   -- Act: 
--   SELECT
--     entity_id,
--     file_name,
--     required_activities
--   INTO actual
--   FROM tvf_entity_file_activity_requirements(0);

--   -- Assert:
--   CREATE TABLE expected (
--     entity_id INT,
--     file_name VARCHAR(10),
--     required_activities NVARCHAR(MAX)
--   );

--   INSERT INTO expected(
--     entity_id,
--     file_name,
--     required_activities
--   )
--   VALUES
--     (1, 'Test1.1', '["Status","Test"]'),
--     (1, 'Test1.2', '[]'),
--     (2, 'Test2.1', '["Status"]'),
--     (3, 'Test3.1', '["Extract","Status"]');

--   EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
-- END;
-- GO


-- CREATE PROCEDURE [EntityFile].[test tvf_entity_file_activity_requirements: skipped_activities]
-- AS
-- BEGIN

--   IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
--   IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

--   EXEC tSQLt.FakeFunction 'dbo.tvf_entity_file_activity_isRequired', 'EntityFile.Fake_tvf_entity_file_activity_isRequired';

--   -- Act: 
--   SELECT
--     entity_id,
--     file_name,
--     skipped_activities
--   INTO actual
--   FROM dbo.tvf_entity_file_activity_requirements(0);

--   -- Assert:
--   CREATE TABLE expected (
--     entity_id INT,
--     file_name VARCHAR(10),
--     skipped_activities NVARCHAR(MAX)
--   );

--   INSERT INTO expected(
--     entity_id,
--     file_name,
--     skipped_activities
--   )
--   VALUES
--     (1, 'Test1.1', '{"Extract": {"batch_id":"00000000-0000-0000-0000-000000000001", "output":{"timestamp":"2023-07-18_00:00:00"}}}'),
--     (1, 'Test1.2', '{"Extract": {"batch_id":"00000000-0000-0000-0000-000000000004", "output":{"timestamp":"2023-07-18_00:00:00"}},"Status": {"batch_id":"00000000-0000-0000-0000-000000000005", "output":{"status":"FinishedNoErrors"}}}'),
--     (2, 'Test2.1', '{"Extract": {"batch_id":"00000000-0000-0000-0000-000000000006", "output":{"timestamp":"2023-07-18_00:00:00"}}}'),
--     (3, 'Test3.1', '{}');

--   EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
-- END;
-- GO

-- CREATE FUNCTION EntityFile.Fake_tvf_entity_file_required_activity_requirements (@rerunSuccessfulFullEntities BIT = 0)

--   RETURNS TABLE
--   AS
--   RETURN
--     SELECT mock.*
--     FROM ( VALUES
--       (0, 1, NULL, NULL, NULL, NULL),
--       (1, 1, NULL, NULL, NULL, '[]'),
--       (2, 1, NULL, NULL, NULL, '["TestDuplicates"]')
--     ) AS mock (
--       entity_id,
--       layer_id,
--       file_name,
--       trigger_date,
--       skipped_activities,
--       required_activities
--     );
-- GO

-- CREATE PROCEDURE [EntityFile].[test tvf_entity_file_required_activities]
-- AS
-- BEGIN

--   IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
--   IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

--   EXEC tSQLt.FakeFunction 'dbo.tvf_entity_file_activity_requirements', 'EntityFile.Fake_tvf_entity_file_required_activity_requirements';

--   -- Act: 
--   SELECT
--     entity_id
--   INTO actual
--   FROM dbo.tvf_entity_file_required_activities(0);

--   -- Assert:
--   CREATE TABLE expected (
--     entity_id INT
--   );

--   INSERT INTO expected(
--     entity_id
--   )
--   VALUES
--     (2);

--   EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
-- END;
-- GO


-- CREATE FUNCTION EntityFile.Fake_tvf_entity_file_required_activities (@rerunSuccessfulFullEntities BIT = 0)

--   RETURNS TABLE
--   AS
--   RETURN
--     SELECT mock.*
--     FROM ( VALUES
--       (0, NULL, '2023-07-22', '2023-07-22', '["TestDuplicates"]', NULL),
--       (0, NULL, '2023-07-23', '2023-07-23', '["TestDuplicates"]', NULL),
--       (1, NULL, '2023-07-22', '2023-07-22', '["TestDuplicates"]', NULL),
--       (1, NULL, '2023-07-23', '2023-07-23', '["TestDuplicates"]', NULL),
--       (2, NULL, '2023-07-22', '2023-07-22', '["TestDuplicates"]', NULL),
--       (2, NULL, '2023-07-23', '2023-07-23', '["TestDuplicates"]', NULL),
--       (3, NULL, NULL, NULL, '["TestDuplicates"]', NULL)
--     ) AS mock (
--       entity_id,
--       layer_id,
--       file_name,
--       trigger_date,
--       required_activities,
--       skipped_activities
--     );
-- GO

-- CREATE PROCEDURE [EntityFile].[test tvf_entity_file_activities_by_date: date and update_mode filter]
-- AS
-- BEGIN

--   IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
--   IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

--   EXEC tSQLt.FakeTable 'dbo.entity';
--   EXEC tSQLt.FakeFunction 'dbo.tvf_entity_file_required_activities', 'EntityFile.Fake_tvf_entity_file_required_activities';


--   INSERT INTO entity (entity_id, update_mode)
--   VALUES
--     (0, 'Full'),
--     (1, NULL),
--     (2, 'Delta'),
--     (3, 'Full');

--   -- Act: 
--   SELECT
--     entity_id, file_name
--   INTO actual
--   FROM dbo.tvf_entity_file_activities_by_date('2023-07-23', 0);

--   -- Assert:
--   CREATE TABLE expected (
--     entity_id INT,
--     file_name VARCHAR(100)
--   );

--   INSERT INTO expected(
--     entity_id,
--     file_name
--   )
--   VALUES
--     (0, '2023-07-23'),
--     (1, '2023-07-23'),
--     (2, '2023-07-22'),
--     (2, '2023-07-23'),
--     (3, NULL);

--   EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
-- END;
-- GO


-- CREATE PROCEDURE [EntityFile].[test tvf_entity_file_activities_by_date: In Out ADLS Path]
-- AS
-- BEGIN

--   IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
--   IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
--   IF OBJECT_ID('tempdb..#vw_adls_base_directory_path') IS NOT NULL DROP TABLE #vw_adls_base_directory_path;

--   -- Assemble: Fake Table
--   EXEC tSQLt.FakeTable 'dbo.entity';
--   EXEC tSQLt.FakeTable '[dbo]', '[vw_adls_base_directory_path]';
--   EXEC tSQLt.FakeFunction 'dbo.tvf_entity_file_required_activities', 'EntityFile.Fake_tvf_entity_file_required_activities';

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
--     (0, 'FULL');

--   EXEC ('INSERT INTO dbo.vw_adls_base_directory_path SELECT * FROM #vw_adls_base_directory_path');

--   INSERT INTO entity (entity_id, update_mode)
--   VALUES
--     (0, 'Full');

--   -- Act: 
--   SELECT
--     entity_id, adls_directory_path_In, adls_directory_path_Out
--   INTO actual
--   FROM dbo.tvf_entity_file_activities_by_date('2023-07-23', 0);

--   -- Assert:
--   CREATE TABLE expected (
--     entity_id INT,
--     adls_directory_path_In VARCHAR(100),
--     adls_directory_path_Out VARCHAR(100)
--   );

--   INSERT INTO expected(
--     entity_id,
--     adls_directory_path_In,
--     adls_directory_path_Out
--   )
--   VALUES
--     (0, 'FULL/In/2023/07/23', 'FULL/Out/2023/07/23');

--   EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
-- END;
-- GO


-- CREATE FUNCTION EntityFile.Fake_tvf_entity_file_activities_by_date (@date DATE, @rerunSuccessfulFullEntities BIT = 0)

--   RETURNS TABLE
--   AS
--   RETURN
--     SELECT mock.*
--     FROM ( VALUES
--       (0, 1, NULL, NULL, NULL, NULL, NULL),
--       (1, 1, NULL, NULL, NULL, NULL, NULL),
--       (2, 1, NULL, NULL, NULL, NULL, NULL),
--       (3, 1, NULL, NULL, NULL, NULL, NULL)
--     ) AS mock (
--       entity_id,
--       layer_id,
--       adls_directory_path_In,
--       adls_directory_path_Out,
--       file_name,
--       required_activities,
--       skipped_activities
--     );
-- GO


-- CREATE PROCEDURE [EntityFile].[test get_scheduled_entity_batch_activities: daily and weekly]
-- AS
-- BEGIN
--   -- Check if all daily, weekly, monthly, adhoc scheduled entities exist in output of get_scheduled_entity_batch_activities
--   -- and if not, these entities are also not returned by entity_file_requirement
  
--   IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
--   IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

--   EXEC tSQLt.FakeTable '[dbo]', '[entity]';
--   EXEC tSQLt.FakeFunction '[dbo].[tvf_entity_file_activities_by_date]', 'EntityFile.Fake_tvf_entity_file_activities_by_date';

--   /*
--     Workaround to ingest mock data into a view
--     https://stackoverflow.com/questions/14965427/tsqlt-faketable-doesnt-seem-to-work-with-views-that-have-constants-derived-field
--   */

--   INSERT INTO entity (entity_id, schedule_recurrence, schedule_day)
--   VALUES
--     (0, NULL, NULL),
--     (1, 'D', NULL),
--     (2, 'A', NULL),
--     (3, 'W', 1),
--     (4, 'W', 4),
--     (5, 'M', 1);

--   -- Act: 
--   SELECT
--     entity_id
--   INTO actual
--   FROM dbo.get_scheduled_entity_batch_activities(
--     0, '2023-07-23', 0 -- First day of week is on a Sunday
--   );

--   -- Assert:
--   CREATE TABLE expected (
--     entity_id INT
--   );

--   INSERT INTO expected(
--     entity_id
--   )
--   VALUES
--     (1),
--     (3);

--   EXEC tSQLt.AssertEqualsTable 'expected', 'actual';

-- END;
-- GO


-- CREATE PROCEDURE [EntityFile].[test get_scheduled_entity_batch_activities: monthly]
-- AS
-- BEGIN
--   -- Check if all daily, weekly, monthly, adhoc scheduled entities exist in output of get_scheduled_entity_batch_activities
--   -- and if not, these entities are also not returned by entity_file_requirement
  
--   IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
--   IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

--   -- Assemble: Fake Table
--   EXEC tSQLt.FakeTable '[dbo]', '[entity]';
--   EXEC tSQLt.FakeFunction '[dbo].[tvf_entity_file_activities_by_date]', 'EntityFile.Fake_tvf_entity_file_activities_by_date';
  
--   INSERT INTO dbo.entity (entity_id, schedule_recurrence, schedule_day)
--   VALUES
--     (1, NULL, NULL),
--     (2, 'M', 1),
--     (3, 'M', 2);

--   -- Act: 
--   SELECT entity_id
--   INTO actual
--   FROM dbo.get_scheduled_entity_batch_activities(
--     0, '2023-06-01', 0
--   );

--   -- Assert:
--   CREATE TABLE expected (entity_id INT);
--   INSERT INTO expected (entity_id) VALUES (2);

--   EXEC tSQLt.AssertEqualsTable 'expected', 'actual';

-- END;
-- GO


-- CREATE PROCEDURE [EntityFile].[test get_scheduled_entity_batch_activities: monthly: beginning weekend]
-- AS
-- BEGIN
--   -- Check if all daily, weekly, monthly, adhoc scheduled entities exist in output of get_scheduled_entity_batch_activities
--   -- and if not, these entities are also not returned by entity_file_requirement

--   IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
--   IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

--   -- Assemble: Fake Table
--   EXEC tSQLt.FakeTable '[dbo]', '[entity]';
--   EXEC tSQLt.FakeFunction '[dbo].[tvf_entity_file_activities_by_date]', 'EntityFile.Fake_tvf_entity_file_activities_by_date';


--   INSERT INTO dbo.entity (entity_id, schedule_recurrence, schedule_day)
--   VALUES
--     (0, NULL, NULL),
--     (1, 'M', 1),
--     (2, 'M', 2),
--     (3, 'M', 3),
--     (4, 'M', 4);

--   -- Act: 
--   SELECT entity_id
--   INTO actual
--   FROM dbo.get_scheduled_entity_batch_activities(
--     0, '2023-07-03', 0 -- First working day of month which is a Monday
--   );

--   -- Assert:
--   CREATE TABLE expected (entity_id INT);
--   INSERT INTO expected (entity_id) VALUES (1), (3);

--   EXEC tSQLt.AssertEqualsTable 'expected', 'actual';

-- END;
-- GO


-- CREATE PROCEDURE [EntityFile].[test get_scheduled_entity_batch_activities: monthly: ending weekend]
-- AS
-- BEGIN
--   -- Check if all daily, weekly, monthly, adhoc scheduled entities exist in output of get_scheduled_entity_batch_activities
--   -- and if not, these entities are also not returned by entity_file_requirement

--   IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
--   IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

--   -- Assemble: Fake Table
--   EXEC tSQLt.FakeTable '[dbo]', '[entity]';
--   EXEC tSQLt.FakeFunction '[dbo].[tvf_entity_file_activities_by_date]', 'EntityFile.Fake_tvf_entity_file_activities_by_date';


--   INSERT INTO dbo.entity (entity_id, schedule_recurrence, schedule_day)
--   VALUES
--     (1, NULL, NULL),
--     (2, 'M', 0),
--     (3, 'M', 1),
--     (4, 'M', 2),
--     (5, 'M', 3);

--   -- Act: 
--   SELECT entity_id
--   INTO actual
--   FROM dbo.get_scheduled_entity_batch_activities(
--     0, '2023-04-28', 0
--   );

--   -- Assert:
--   CREATE TABLE expected (entity_id INT);
--   INSERT INTO expected (entity_id) VALUES (2);

--   EXEC tSQLt.AssertEqualsTable 'expected', 'actual';

-- END;
-- GO

-- CREATE PROCEDURE [EntityFile].[test get_scheduled_entity_batch_activities: adhoc]
-- AS
-- BEGIN
--   -- Check if all daily, weekly, monthly, adhoc scheduled entities exist in output of get_scheduled_entity_batch_activities
--   -- and if not, these entities are also not returned by entity_file_requirement
  
--   IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
--   IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

--   -- Assemble: Fake Table
--   EXEC tSQLt.FakeTable '[dbo]', '[entity]';
--   EXEC tSQLt.FakeFunction '[dbo].[tvf_entity_file_activities_by_date]', 'EntityFile.Fake_tvf_entity_file_activities_by_date';

  
--   INSERT INTO dbo.entity (entity_id, schedule_recurrence, schedule_day)
--   VALUES
--     (1, NULL, NULL),
--     (2, 'A', NULL);

--   -- Act: 
--   SELECT entity_id
--   INTO actual
--   FROM dbo.get_scheduled_entity_batch_activities(
--     1, '2023-04-28', 0
--   );

--   -- Assert:
--   CREATE TABLE expected (entity_id INT);
--   INSERT INTO expected (entity_id) VALUES (2);

--   EXEC tSQLt.AssertEqualsTable 'expected', 'actual';

-- END;
-- GO


-- CREATE PROCEDURE [EntityFile].[test get_scheduled_entity_batch_activities: rerunSuccessfulFullEntities]
-- AS
-- BEGIN

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


EXEC [tSQLt].[SetFakeViewOff] 'edw';

GO
