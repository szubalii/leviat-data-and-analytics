CREATE PROCEDURE [tc.edw.vw_OutboundDeliveryItem_s4h].[test SL_OriginalConfirmedDeliveryDate]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
  IF OBJECT_ID('tempdb..#vw_fact_SalesDocumentItem_LC_EUR') IS NOT NULL DROP TABLE #vw_fact_SalesDocumentItem_LC_EUR;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_OutboundDeliveryItem]';
  EXEC tSQLt.FakeTable '[edw]', '[vw_fact_SalesDocumentItem_LC_EUR]';
  EXEC tSQLt.FakeTable '[intm_s4h]', '[vw_SalesDocumentEarliestConfirmedDeliveryDate]';
  EXEC tSQLt.FakeTable '[intm_s4h]', '[vw_OriginalConfirmedScheduleLineDeliveryDate]';


  INSERT INTO [base_s4h_cax].[I_OutboundDeliveryItem] ([ReferenceSDDocument], [ReferenceSDDocumentItem], [ActualDeliveryQuantity])
  VALUES (1, 1, 100), (2, 2, 200);

  SELECT TOP(0) *
  INTO #vw_fact_SalesDocumentItem_LC_EUR
  FROM edw.vw_fact_SalesDocumentItem_LC_EUR;

  INSERT INTO #vw_fact_SalesDocumentItem_LC_EUR ([SalesDocument], [SalesDocumentItem], [SDI_ConfdDelivQtyInOrderQtyUnit])
  VALUES
    (1, 1, 110),
    (2, 2, 200);

  EXEC ('INSERT INTO edw.vw_fact_SalesDocumentItem_LC_EUR SELECT * FROM #vw_fact_SalesDocumentItem_LC_EUR');
  
  INSERT INTO [intm_s4h].[vw_SalesDocumentEarliestConfirmedDeliveryDate] ([SalesDocument], [SalesDocumentItem], [ConfirmedDeliveryDate], [ScheduleLine])
  VALUES
    (1, 1, '2024-01-01', 1),
    (1, 1, '2023-12-01', 2),
    (2, 2, '2023-01-01', 3),
    (2, 2, '2023-06-01', 4);
  
  INSERT INTO [intm_s4h].[vw_OriginalConfirmedScheduleLineDeliveryDate] ([SalesDocumentID], [SalesDocumentItemID], [OriginalConfirmedDeliveryDate], [ScheduleLine])
  VALUES
    (1, 1, '2024-01-01', 1),
    (1, 1, '2023-11-01', 2),
    (2, 2, '2023-02-01', 3),
    (2, 2, '2023-07-01', 4);

  -- Act: 
  SELECT
    [ReferenceSDDocument],
    [ReferenceSDDocumentItem],
    [SL_OriginalConfirmedDeliveryDate]
  INTO actual
  FROM [edw].[vw_OutboundDeliveryItem_s4h]

  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected(
    [ReferenceSDDocument],
    [ReferenceSDDocumentItem],
    [SL_FirstCustomerRequestedDeliveryDate])
  VALUES
    (1, 1,'2023-11-01')
    ,(1, 1,'2023-11-01')
    ,(2, 2,'2023-01-01')
    ,(2, 2,'2023-06-01');

  -- Assert:
  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
