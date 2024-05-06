CREATE PROCEDURE [tc.dbo.exception].[test FK_exception_pipeline_log]
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
