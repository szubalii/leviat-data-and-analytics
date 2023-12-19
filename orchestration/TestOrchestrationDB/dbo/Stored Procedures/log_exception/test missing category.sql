CREATE PROCEDURE [tc.dbo.log_exception].[test missing category]
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

