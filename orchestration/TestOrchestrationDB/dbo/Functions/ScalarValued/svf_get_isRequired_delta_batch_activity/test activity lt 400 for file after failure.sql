CREATE PROCEDURE [tc.dbo.svf_get_isRequired_delta_batch_activity].[test activity lt 400 for file after failure]
AS
BEGIN  
  -- Act: 
  DECLARE @actual INT = ( SELECT dbo.svf_get_isRequired_delta_batch_activity(
    'test2', 'test1', 300, 400
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 0, @actual;
END;
GO
