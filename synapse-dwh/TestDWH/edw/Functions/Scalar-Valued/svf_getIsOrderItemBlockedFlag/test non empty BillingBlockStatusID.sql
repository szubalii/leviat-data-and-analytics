CREATE PROCEDURE [tc.edw.svf_getIsOrderItemBlockedFlag].[test non empty BillingBlockStatusID]
AS
BEGIN

  DECLARE @actual INT = ( 
    SELECT [edw].[svf_getIsOrderItemBlockedFlag](NULL, 1, NULL, NULL, NULL)
  );

  EXEC tSQLt.AssertEquals 1, @actual;
END;