CREATE PROCEDURE [tc.edw.svf_getIsOrderItemBlockedFlag].[test all empty reasons]
AS
BEGIN

  DECLARE @actual INT = ( 
    SELECT [edw].[svf_getIsOrderItemBlockedFlag](NULL, NULL, NULL, NULL, NULL)
  );

  EXEC tSQLt.AssertEquals 0, @actual;
END;