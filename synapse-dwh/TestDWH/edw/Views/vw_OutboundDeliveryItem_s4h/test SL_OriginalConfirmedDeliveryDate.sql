CREATE PROCEDURE [tc.edw.vw_OutboundDeliveryItem_s4h].[test SL_OriginalConfirmedDeliveryDate]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
  IF OBJECT_ID('tempdb..#vw_fact_SalesDocumentItem_LC_EUR') IS NOT NULL DROP TABLE #vw_fact_SalesDocumentItem_LC_EUR;
  IF OBJECT_ID('tempdb..#vw_SalesDocumentEarliestConfirmedDeliveryDate') IS NOT NULL DROP TABLE #vw_SalesDocumentEarliestConfirmedDeliveryDate;
  IF OBJECT_ID('tempdb..#vw_OriginalConfirmedScheduleLineDeliveryDate') IS NOT NULL DROP TABLE #vw_OriginalConfirmedScheduleLineDeliveryDate;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_OutboundDeliveryItem]';
  EXEC tSQLt.FakeTable '[edw]', '[vw_fact_SalesDocumentItem_LC_EUR]';
  EXEC tSQLt.FakeTable '[intm_s4h]', '[vw_SalesDocumentEarliestConfirmedDeliveryDate]';
  EXEC tSQLt.FakeTable '[intm_s4h]', '[vw_OriginalConfirmedScheduleLineDeliveryDate]';


  INSERT INTO [base_s4h_cax].[I_OutboundDeliveryItem] ([ReferenceSDDocument], [ReferenceSDDocumentItem], [ActualDeliveryQuantity])
  VALUES
    (1, 1, 100),
    (1, 1,  10),
    (2, 2, 200);

  SELECT TOP(0) *
  INTO #vw_fact_SalesDocumentItem_LC_EUR
  FROM edw.vw_fact_SalesDocumentItem_LC_EUR;

  INSERT INTO #vw_fact_SalesDocumentItem_LC_EUR ([SalesDocument], [SalesDocumentItem], [SDI_ConfdDelivQtyInOrderQtyUnit])
  VALUES
    (1, 1, 110),
    (2, 2, 200);

  EXEC ('INSERT INTO edw.vw_fact_SalesDocumentItem_LC_EUR SELECT * FROM #vw_fact_SalesDocumentItem_LC_EUR');

  SELECT TOP(0) *
  INTO #vw_SalesDocumentEarliestConfirmedDeliveryDate
  FROM intm_s4h.vw_SalesDocumentEarliestConfirmedDeliveryDate;
  
  INSERT INTO #vw_SalesDocumentEarliestConfirmedDeliveryDate (
    [SalesDocument],
    [SalesDocumentItem],
    [ConfirmedDeliveryDate]
  )
  VALUES
    (1, 1, '2023-12-01'),
    (2, 2, '2023-02-01');

  EXEC ('INSERT INTO intm_s4h.vw_SalesDocumentEarliestConfirmedDeliveryDate SELECT * FROM #vw_SalesDocumentEarliestConfirmedDeliveryDate');

  SELECT TOP(0) *
  INTO #vw_OriginalConfirmedScheduleLineDeliveryDate
  FROM intm_s4h.vw_OriginalConfirmedScheduleLineDeliveryDate;
  
  INSERT INTO #vw_OriginalConfirmedScheduleLineDeliveryDate (
    [SalesDocumentID],
    [SalesDocumentItemID],
    [ScheduleLine],
    [OriginalConfirmedDeliveryDate]
  )
  VALUES
    (1, 1, 0, '2023-11-01'),
    (2, 2, 1, '2023-01-01');

  EXEC ('INSERT INTO intm_s4h.vw_OriginalConfirmedScheduleLineDeliveryDate SELECT * FROM #vw_OriginalConfirmedScheduleLineDeliveryDate');

  -- Act: 
  SELECT
    [ReferenceSDDocument],
    [ReferenceSDDocumentItem],
    [SL_ScheduleLine],
    [SL_OriginalConfirmedDeliveryDate]
  INTO actual
  FROM [edw].[vw_OutboundDeliveryItem_s4h]

  SELECT TOP(0) *
  INTO expected
  FROM actual;

  INSERT INTO expected(
    [ReferenceSDDocument],
    [ReferenceSDDocumentItem],
    [SL_ScheduleLine],
    [SL_OriginalConfirmedDeliveryDate])
  VALUES
     (1, 1, 1, '2023-11-01')
    ,(1, 1, 2, '2023-11-01')
    ,(2, 2, 1, '2023-01-01');

  -- Assert:
  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
