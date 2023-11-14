CREATE PROCEDURE [tc.edw.svf_getIsOrderItemBlockedFlag].[test non empty DeliveryBlockReasonID]
AS
BEGIN

  DECLARE @actual INT = ( 
    SELECT [edw].[svf_getIsOrderItemBlockedFlag](1, NULL, NULL, NULL, NULL)
  );

  EXEC tSQLt.AssertEquals 1, @actual;
END;