CREATE PROCEDURE [tc.edw.svf_getIsOrderItemBlockedFlag].[test non empty HDR_DeliveryBlockReason]
AS
BEGIN

  DECLARE @actual INT = ( 
    SELECT [edw].[svf_getIsOrderItemBlockedFlag](NULL, NULL, NULL, NULL, 1)
  );

  EXEC tSQLt.AssertEquals 0, @actual;
END;