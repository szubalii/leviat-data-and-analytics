-- Write your own SQL object definition here, and it'll be included in your package.
EXEC tSQLt.NewTestClass 'StoredProcedures';
GO

CREATE PROCEDURE [StoredProcedures].[test log_exception: existing category]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[error_category]';
  EXEC tSQLt.FakeTable '[dbo]', '[exception]';

  DECLARE
    @batch_guid UNIQUEIDENTIFIER = NEWID(),
    @run_guid UNIQUEIDENTIFIER = NEWID();

  INSERT INTO dbo.error_category (
    error_category_id,
    category_nk
  )
  VALUES (1, 'InternalError');

  -- Act:
  EXEC dbo.log_exception
    @run_guid,
    'InternalError',
    1,
    @batch_guid,
    'test error message',
    NULL;

  SELECT
    run_id,
    error_category_id,
    entity_id,
    batch_id,
    error_message,
    pbi_dataset_id
  INTO actual
  FROM dbo.exception;

  -- Assert:
  CREATE TABLE expected (
    run_id UNIQUEIDENTIFIER,
    error_category_id BIGINT,
    entity_id BIGINT,
    batch_id UNIQUEIDENTIFIER,
    error_message NVARCHAR(MAX),
    pbi_dataset_id BIGINT
  );

  INSERT INTO expected(
    run_id,
    error_category_id,
    entity_id,
    batch_id,
    error_message,
    pbi_dataset_id
  )
  SELECT
    @run_guid,
    1,
    1,
    @batch_guid,
    'test error message',
    NULL
  ;

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO


CREATE PROCEDURE [StoredProcedures].[test log_exception: missing category]
AS
BEGIN

  DECLARE
    @expected_error_number INT = 51001,
    @actual_error_number INT,
    @batch_guid UNIQUEIDENTIFIER = NEWID(),
    @run_guid UNIQUEIDENTIFIER = NEWID();

  -- Act:
  BEGIN TRY
    EXEC dbo.log_exception
      @run_guid,
      'InternalError',
      1,
      @batch_guid,
      'test error message',
      NULL;
  END TRY
  BEGIN CATCH
    SET @actual_error_number = ERROR_NUMBER();
  END CATCH;

  EXEC tSQLt.AssertEquals @expected_error_number, @actual_error_number;
END;
GO


CREATE PROCEDURE [StoredProcedures].[test set_batch: existing natural keys]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[batch_execution_status]';
  EXEC tSQLt.FakeTable '[dbo]', '[batch_activity]';
  EXEC tSQLt.FakeTable '[dbo]', '[layer]';
  EXEC tSQLt.FakeTable '[dbo]', '[batch]';

  DECLARE
    @batch_guid UNIQUEIDENTIFIER = NEWID(),
    @run_guid UNIQUEIDENTIFIER = NEWID();

  INSERT INTO dbo.batch_execution_status (
    status_id,
    status_nk
  )
  VALUES (1, 'TestState');

  
  INSERT INTO dbo.batch_activity (
    activity_id,
    activity_nk
  )
  VALUES (1, 'TestActivity');

  
  INSERT INTO dbo.layer (
    layer_id,
    layer_nk
  )
  VALUES (1, 'SourceLayer'), (2, 'TargetLayer');

  -- Act:
  EXEC dbo.set_batch
    @batch_guid,
    @run_guid,
    '2023-08-07 12:00:00',
    1,
    'TestState',
    'TestActivity',
    'file_path',
    'directory_path',
    'file_name',
    'SourceLayer',
    'TargetLayer',
    NULL,
    'output';

  SELECT
    [batch_id],
    [run_id],
    [start_date_time],
    [entity_id],
    [status_id],
    [activity_id],
    [source_layer_id],
    [target_layer_id],
    [file_path],
    [directory_path],
    [file_name],
    [size_bytes],
    [output]
  INTO actual
  FROM dbo.batch;

  -- Assert:
  CREATE TABLE expected (
    batch_id UNIQUEIDENTIFIER,
    run_id UNIQUEIDENTIFIER,
    start_date_time datetime,
    entity_id BIGINT,
    status_id INT,
    activity_id INT,
    file_path nvarchar(250),
    directory_path nvarchar(250),
    file_name nvarchar(250),
    source_layer_id INT,
    target_layer_id INT,
    size_bytes BIGINT,
	  output NVARCHAR(MAX)
  );

  INSERT INTO expected(
    [batch_id],
    [run_id],
    [start_date_time],
    [entity_id],
    [status_id],
    [activity_id],
    [source_layer_id],
    [target_layer_id],
    [file_path],
    [directory_path],
    [file_name],
    [size_bytes],
    [output]
  )
  SELECT
    @batch_guid,
    @run_guid,
    '2023-08-07 12:00:00',
    1,
    1,
    1,
    1,
    2,
    'file_path',
    'directory_path',
    'file_name',
    NULL,
    'output';

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO



