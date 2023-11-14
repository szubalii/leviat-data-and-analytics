CREATE PROCEDURE [tc.edw.svf_getIsOrderItemBlockedFlag].[test all blank reasons]
AS
BEGIN

  DECLARE @actual INT = ( 
    SELECT [edw].[svf_getIsOrderItemBlockedFlag]('', '', '', '', '')
  );

  EXEC tSQLt.AssertEquals 0, @actual;
END;