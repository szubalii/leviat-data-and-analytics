-- Write your own SQL object definition here, and it'll be included in your package.
EXEC tSQLt.NewTestClass 'ForeignKeys';
GO

CREATE PROCEDURE [ForeignKeys].[test exception: FK_exception_batch]
AS
BEGIN
  DECLARE @errorThrown BIT = 0;

  -- Assemble: Fake Table
  DECLARE
    @test_guid UNIQUEIDENTIFIER = NEWID();
  EXEC tSQLt.FakeTable '[dbo]', '[exception]';
  EXEC tSQLt.ApplyConstraint 'dbo', 'exception', 'FK_exception_batch';

  BEGIN TRY
    INSERT INTO exception (batch_id)
    VALUES(@test_guid);
  END TRY
  BEGIN CATCH
    SET @errorThrown = 1;
  END CATCH;

  IF (@errorThrown = 0 OR (EXISTS (SELECT 1 FROM exception)))
  BEGIN
    EXEC tSQLt.Fail 'Exception table should include only available batches from Batch table';
  END
END;
GO

CREATE PROCEDURE [ForeignKeys].[test exception: FK_exception_entity]
AS
BEGIN
  DECLARE @errorThrown BIT = 0;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[exception]';
  EXEC tSQLt.ApplyConstraint 'dbo', 'exception', 'FK_exception_entity';

  BEGIN TRY
    INSERT INTO exception (entity_id)
    VALUES(1);
  END TRY
  BEGIN CATCH
    SET @errorThrown = 1;
  END CATCH;

  IF (@errorThrown = 0 OR (EXISTS (SELECT 1 FROM exception)))
  BEGIN
    EXEC tSQLt.Fail 'Exception table should include only available entities from Entity table';
  END
END;
GO

CREATE PROCEDURE [ForeignKeys].[test exception: FK_exception_error_category]
AS
BEGIN
  DECLARE @errorThrown BIT = 0;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[exception]';
  EXEC tSQLt.ApplyConstraint 'dbo', 'exception', 'FK_exception_error_category';

  BEGIN TRY
    INSERT INTO exception (error_category_id)
    VALUES(1);
  END TRY
  BEGIN CATCH
    SET @errorThrown = 1;
  END CATCH;

  IF (@errorThrown = 0 OR (EXISTS (SELECT 1 FROM exception)))
  BEGIN
    EXEC tSQLt.Fail 'Exception table should include only available error categories from error_category table';
  END
END;
GO

CREATE PROCEDURE [ForeignKeys].[test exception: FK_exception_pipeline_log]
AS
BEGIN
  DECLARE @errorThrown BIT = 0;

  -- Assemble: Fake Table
  DECLARE
    @test_guid UNIQUEIDENTIFIER = NEWID();
  EXEC tSQLt.FakeTable '[dbo]', '[exception]';
  EXEC tSQLt.ApplyConstraint 'dbo', 'exception', 'FK_exception_pipeline_log';

  BEGIN TRY
    INSERT INTO exception (run_id)
    VALUES(@test_guid);
  END TRY
  BEGIN CATCH
    SET @errorThrown = 1;
  END CATCH;

  IF (@errorThrown = 0 OR (EXISTS (SELECT 1 FROM exception)))
  BEGIN
    EXEC tSQLt.Fail 'Exception table should include only available run ids from pipeline log table';
  END
END;
GO

CREATE PROCEDURE [ForeignKeys].[test exception: FK_exception_pbi_dataset]
AS
BEGIN
  DECLARE @errorThrown BIT = 0;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[dbo]', '[exception]';
  EXEC tSQLt.ApplyConstraint 'dbo', 'exception', 'FK_exception_pbi_dataset';

  BEGIN TRY
    INSERT INTO exception (pbi_dataset_id)
    VALUES(1);
  END TRY
  BEGIN CATCH
    SET @errorThrown = 1;
  END CATCH;

  IF (@errorThrown = 0 OR (EXISTS (SELECT 1 FROM exception)))
  BEGIN
    EXEC tSQLt.Fail 'Exception table should include only available pbi dataset ids from pbi_dataset table';
  END
END;
GO
