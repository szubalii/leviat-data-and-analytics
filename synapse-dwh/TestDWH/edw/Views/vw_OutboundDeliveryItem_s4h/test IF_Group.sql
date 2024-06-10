CREATE PROCEDURE [tc.edw.vw_OutboundDeliveryItem_s4h].[test IF_Group]
AS
BEGIN

  IF OBJECT_ID('actual')    IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected')  IS NOT NULL DROP TABLE expected;
  IF OBJECT_ID('tempdb..#vw_fact_SalesDocumentItem_LC_EUR') IS NOT NULL DROP TABLE #vw_fact_SalesDocumentItem_LC_EUR;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_OutboundDeliveryItem]';
  EXEC tSQLt.FakeTable '[edw]', '[vw_fact_SalesDocumentItem_LC_EUR]';

  INSERT INTO [base_s4h_cax].[I_OutboundDeliveryItem] (
    [MANDT], 
    [OutboundDelivery], 
    [OutboundDeliveryItem], 
    [ActualDeliveryQuantity],
    [ReferenceSDDocument],
    [ReferenceSDDocumentItem]
    )
  VALUES
     (200, 1, 10, NULL, '11111', '10')
    ,(200, 3, 30, 0, '33333', '30')
    ,(200, 4, 901, 40, '44444', '40')
    ,(200, 4, 902, 50, '44444', '40')
    ,(200, 5, 903, 50, '55555', '50')
    ,(200, 5, 904, 80, '55555', '10')
    ,(200, 6, 10, 60, '66666', '60')
    ,(200, 7, 20, 350, '77777', '70')
    ,(200, 7, 10, 160, '88888', '80')
    ,(200, 8, 10, 200, '99999', '90')
    ,(200, 9, 30, 50, '99999', '90')
    ,(200, 10, 20, 250, '99999', '90');


  SELECT TOP(0) *
  INTO #vw_fact_SalesDocumentItem_LC_EUR
  FROM edw.vw_fact_SalesDocumentItem_LC_EUR;

  INSERT INTO #vw_fact_SalesDocumentItem_LC_EUR (SalesDocument, SalesDocumentItem, SDI_ConfdDelivQtyInOrderQtyUnit)
  VALUES 
    ('11111', '10', 10)
  , ('44444', '40', 90)
  , ('55555', '50', 70)
  , ('55555', '10', 30)
  , ('66666', '60', 60)
  , ('77777', '70', 770)
  , ('88888', '80', 80)
  , ('99999', '90', 200);

  EXEC ('INSERT INTO edw.vw_fact_SalesDocumentItem_LC_EUR SELECT * FROM #vw_fact_SalesDocumentItem_LC_EUR');
  -- Act: 
  SELECT
    [OutboundDelivery]
   ,[OutboundDeliveryItem]
   ,[ActualDeliveryQuantity]
   ,[SDI_ConfdDelivQtyInOrderQtyUnit]
   ,[ReferenceSDDocument]
   ,[ReferenceSDDocumentItem]
   ,[IF_Group]
   ,[IF_IsInFullFlag]
   ,[IF_IsInFull]
  INTO actual
  FROM [edw].[vw_OutboundDeliveryItem_s4h];

  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected(
    [OutboundDelivery]
   ,[OutboundDeliveryItem]
   ,[ActualDeliveryQuantity]
   ,[SDI_ConfdDelivQtyInOrderQtyUnit]
   ,[ReferenceSDDocument]
   ,[ReferenceSDDocumentItem]
   ,[IF_Group]
   ,[IF_IsInFullFlag]
   ,[IF_IsInFull]
    )
  VALUES
     (1, 10, NULL, 10, '11111', '10', NULL, NULL, 0)
    ,(3, 30, 0, NULL, '33333', '30', NULL, NULL, 0)
    ,(4, 901, 40, 90, '44444', '40', 'In Full Delivered', 'Y', 1)
    ,(4, 902, 50, 90, '44444', '40', 'In Full Delivered', 'Y', 1)
    ,(5, 903, 50, 70, '55555', '50', 'Under Delivered', 'N', 0)
    ,(5, 904, 80, 30, '55555', '10', 'Over Delivered', 'N', 0)
    ,(6, 10, 60, 60, '66666', '60', 'In Full Delivered', 'Y', 1)
    ,(7, 20, 350, 770, '77777', '70', 'Under Delivered', 'N', 0)
    ,(7, 10, 160, 80, '88888', '80', 'Over Delivered', 'N', 0)
    ,(8, 10, 200, 200, '99999', '90', 'In Full Delivered', 'Y', 1)
    ,(9, 30, 50, 200, '99999', '90', 'Under Delivered', 'N', 0)
    ,(10, 20, 250, 200, '99999', '90', 'Over Delivered', 'N', 0)

  -- Assert:
  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
