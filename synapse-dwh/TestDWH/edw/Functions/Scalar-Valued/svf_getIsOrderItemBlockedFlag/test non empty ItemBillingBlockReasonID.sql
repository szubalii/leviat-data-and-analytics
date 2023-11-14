CREATE PROCEDURE [tc.edw.svf_getIsOrderItemBlockedFlag].[test non empty ItemBillingBlockReasonID]
AS
BEGIN

  DECLARE @actual INT = ( 
    SELECT [edw].[svf_getIsOrderItemBlockedFlag](NULL, NULL, NULL, 1, NULL)
  );

  EXEC tSQLt.AssertEquals 1, @actual;
END;