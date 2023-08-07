-- Write your own SQL object definition here, and it'll be included in your package.
EXEC tSQLt.NewTestClass 'StoredProcedures';
GO

CREATE PROCEDURE [StoredProcedures].[test log_exception: existing category]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[batch]';
  EXEC tSQLt.FakeTable '[dbo]', '[entity]';
  EXEC tSQLt.FakeTable '[dbo]', '[error_category]';
  EXEC tSQLt.FakeTable '[dbo]', '[pipeline_log]';

  INSERT INTO dbo.batch (batch_id)
  VALUES ('00000000-0000-0000-0000-000000000001');

  INSERT INTO dbo.entity (entity_id)
  VALUES (1);

  INSERT INTO dbo.error_category (
    error_category_id,
    category_nk
  )
  VALUES (1, 'InternalError');

  INSERT INTO dbo.pipeline_log (run_id)
  VALUES ('00000000-0000-0000-0000-000000000001');

  -- Act:
  EXEC dbo.log_exception
    '00000000-0000-0000-0000-000000000001',
    'InternalError',
    1,
    '00000000-0000-0000-0000-000000000001',
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
  FROM dbo.log_exception;

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
    '00000000-0000-0000-0000-000000000001',
    1,
    1,
    '00000000-0000-0000-0000-000000000001',
    'test error message',
    NULL
  ;

  EXEC tSQLt.AssertEqualsTable 'expected', 'exception';
END;
GO

