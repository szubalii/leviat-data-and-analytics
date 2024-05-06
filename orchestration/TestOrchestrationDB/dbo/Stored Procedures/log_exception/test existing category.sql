CREATE PROCEDURE [tc.dbo.log_exception].[test existing category]
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
