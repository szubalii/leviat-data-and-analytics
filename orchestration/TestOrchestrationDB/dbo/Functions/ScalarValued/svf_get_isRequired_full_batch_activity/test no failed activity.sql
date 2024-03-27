CREATE PROCEDURE [tc.dbo.svf_get_isRequired_full_batch_activity].[test no failed activity]
AS
BEGIN  
  -- Act: 
  DECLARE @actual INT = ( SELECT dbo.svf_get_isRequired_full_batch_activity(
    'test_file', 200, NULL, 0
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 0, @actual;
END;
GO
