CREATE PROCEDURE [tc.dbo.exception].[test FK_exception_entity]
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
