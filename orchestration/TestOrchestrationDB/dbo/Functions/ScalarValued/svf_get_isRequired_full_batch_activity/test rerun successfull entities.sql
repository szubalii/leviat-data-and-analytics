CREATE PROCEDURE [tc.dbo.svf_get_isRequired_full_batch_activity].[test rerun successfull entities]
AS
BEGIN  
  -- Act: 
  DECLARE @actual INT = ( SELECT dbo.svf_get_isRequired_full_batch_activity(
    200, NULL, 1
  ));

  -- Assert:
  EXEC tSQLt.AssertEquals 1, @actual;
END;
GO
