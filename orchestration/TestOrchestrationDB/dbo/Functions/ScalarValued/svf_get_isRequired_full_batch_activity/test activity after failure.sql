CREATE PROCEDURE [tc.dbo.svf_get_isRequired_full_batch_activity].[test activity after failure]
AS
BEGIN  
  -- Act: 
  DECLARE @actual INT = ( SELECT dbo.svf_get_isRequired_full_batch_activity(
    'test_file', 200, 100, 0
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 1, @actual;
END;
GO
