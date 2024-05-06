CREATE PROCEDURE [tc.dbo.svf_get_isRequired_full_batch_activity].[test empty file name]
AS
BEGIN  
  -- Act: 
  DECLARE @actual INT = ( SELECT dbo.svf_get_isRequired_full_batch_activity(
    NULL, 200, 100, 0
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 1, @actual;
END;
GO
