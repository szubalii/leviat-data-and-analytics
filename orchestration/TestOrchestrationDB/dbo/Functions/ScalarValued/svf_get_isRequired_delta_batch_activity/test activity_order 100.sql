CREATE PROCEDURE [tc.dbo.svf_get_isRequired_delta_batch_activity].[test activity_order 100]
AS
BEGIN  
  -- Act: 
  DECLARE @actual INT = ( SELECT dbo.svf_get_isRequired_delta_batch_activity(
    'test1', 'test2', 100, 200, 0
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 0, @actual;
END;
GO

