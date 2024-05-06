CREATE PROCEDURE [tc.dbo.exception].[test FK_exception_pbi_dataset]
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
