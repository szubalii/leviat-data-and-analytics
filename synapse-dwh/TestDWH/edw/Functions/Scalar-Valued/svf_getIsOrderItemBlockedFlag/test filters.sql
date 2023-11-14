CREATE PROCEDURE [tc.edw.svf_getIsOrderItemBlockedFlag].[test non empty DeliveryBlockReasonID]
AS
BEGIN

  DECLARE @actual INT = ( 
    SELECT [edw].[svf_getIsOrderItemBlockedFlag](1, NULL, NULL, NULL, NULL)
  );

  EXEC tSQLt.AssertEquals 1, @actual;
END;


CREATE PROCEDURE [tc.edw.svf_getIsOrderItemBlockedFlag].[test non empty BillingBlockStatusID]
AS
BEGIN

  DECLARE @actual INT = ( 
    SELECT [edw].[svf_getIsOrderItemBlockedFlag](NULL, 1, NULL, NULL, NULL)
  );

  EXEC tSQLt.AssertEquals 1, @actual;
END;


CREATE PROCEDURE [tc.edw.svf_getIsOrderItemBlockedFlag].[test non empty HeaderBillingBlockReasonID]
AS
BEGIN

  DECLARE @actual INT = ( 
    SELECT [edw].[svf_getIsOrderItemBlockedFlag](NULL, NULL, 1, NULL, NULL)
  );

  EXEC tSQLt.AssertEquals 1, @actual;
END;


CREATE PROCEDURE [tc.edw.svf_getIsOrderItemBlockedFlag].[test non empty ItemBillingBlockReasonID]
AS
BEGIN

  DECLARE @actual INT = ( 
    SELECT [edw].[svf_getIsOrderItemBlockedFlag](NULL, NULL, NULL, 1, NULL)
  );

  EXEC tSQLt.AssertEquals 1, @actual;
END;


CREATE PROCEDURE [tc.edw.svf_getIsOrderItemBlockedFlag].[test non empty HDR_DeliveryBlockReason]
AS
BEGIN

  DECLARE @actual INT = ( 
    SELECT [edw].[svf_getIsOrderItemBlockedFlag](NULL, NULL, NULL, NULL, 1)
  );

  EXEC tSQLt.AssertEquals 0, @actual;
END;


CREATE PROCEDURE [tc.edw.svf_getIsOrderItemBlockedFlag].[test all empty reasons]
AS
BEGIN

  DECLARE @actual INT = ( 
    SELECT [edw].[svf_getIsOrderItemBlockedFlag](NULL, NULL, NULL, NULL, NULL)
  );

  EXEC tSQLt.AssertEquals 0, @actual;
END;


CREATE PROCEDURE [tc.edw.svf_getIsOrderItemBlockedFlag].[test all blank reasons]
AS
BEGIN

  DECLARE @actual INT = ( 
    SELECT [edw].[svf_getIsOrderItemBlockedFlag]('', '', '', '', '')
  );

  EXEC tSQLt.AssertEquals 0, @actual;
END;