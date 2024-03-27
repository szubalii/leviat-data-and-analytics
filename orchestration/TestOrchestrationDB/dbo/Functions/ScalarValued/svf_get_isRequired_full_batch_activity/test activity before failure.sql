CREATE PROCEDURE [tc.dbo.svf_get_isRequired_full_batch_activity].[test activity before failure]
AS
BEGIN  
  -- Act: 
  DECLARE @actual INT = ( SELECT dbo.svf_get_isRequired_full_batch_activity(
    'test_file', 100, 200, 0
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 0, @actual;
END;
GO
