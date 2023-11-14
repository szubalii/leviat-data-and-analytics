CREATE PROCEDURE [tc.edw.svf_getIsOrderItemBlockedFlag].[test non empty HeaderBillingBlockReasonID]
AS
BEGIN

  DECLARE @actual INT = ( 
    SELECT [edw].[svf_getIsOrderItemBlockedFlag](NULL, NULL, 1, NULL, NULL)
  );

  EXEC tSQLt.AssertEquals 1, @actual;
END;