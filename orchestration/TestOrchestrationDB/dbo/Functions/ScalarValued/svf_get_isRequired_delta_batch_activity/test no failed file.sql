CREATE PROCEDURE [tc.dbo.svf_get_isRequired_delta_batch_activity].[test no failed file]
AS
BEGIN  
  -- Act: 
  DECLARE @actual INT = ( SELECT dbo.svf_get_isRequired_delta_batch_activity(
    'test1', NULL, 100, 200
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 0, @actual;
END;
GO

