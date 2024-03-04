CREATE PROCEDURE [tc.dbo.svf_get_isRequired_delta_batch_activity].[test activity>=400 for file after failure]
AS
BEGIN  
  -- Act: 
  DECLARE @actual INT = ( SELECT dbo.svf_get_isRequired_delta_batch_activity(
    'test2', 'test1', 400, 300
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 1, @actual;
END;
GO
