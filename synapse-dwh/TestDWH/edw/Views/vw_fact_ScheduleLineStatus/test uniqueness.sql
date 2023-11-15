CREATE PROCEDURE [tc.edw.vw_fact_ScheduleLineStatus].[test uniqueness]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('tempdb..#vw_BillingDocumentItem_for_SalesDocumentItem') IS NOT NULL DROP TABLE #vw_BillingDocumentItem_for_SalesDocumentItem;
  IF OBJECT_ID('tempdb..#vw_fact_SalesDocumentItem') IS NOT NULL DROP TABLE #vw_fact_SalesDocumentItem;
  -- IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_OutboundDeliveryItem]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_SalesDocumentScheduleLine]';
  EXEC tSQLt.FakeTable '[edw]', '[vw_BillingDocumentItem_for_SalesDocumentItem]';
  EXEC tSQLt.FakeTable '[edw]', '[vw_fact_SalesDocumentItem]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_SalesOrganization]';
  EXEC tSQLt.FakeTable '[base_ff]', '[SalesDocumentStatuses]';

  INSERT INTO edw.fact_OutboundDeliveryItem (
    OutboundDelivery,
    OutboundDeliveryItem,
    ReferenceSDDocument,
    ReferenceSDDocumentItem,
    HDR_ActualGoodsMovementDate,
    ActualDeliveryQuantity
  )
  VALUES
    (1, 1, 1, 1, '2020-01-01', 10)
  , (1, 2, 1, 2, '2020-01-01', 20)
  , (2, 1, 1, 1, '2020-01-10', 30)
  , (2, 2, 1, 2, '2020-01-10', 40);

  INSERT INTO edw.dim_SalesDocumentScheduleLine (
    SalesDocumentID,
    SalesDocumentItem,
    ScheduleLine,
    ConfdOrderQtyByMatlAvailCheck,
    ConfirmedDeliveryDate
  )
  VALUES
   (1, 1, 1, 10, '2020-01-01'), 
   (1, 1, 2, 20, '2020-01-01'), 
   (1, 2, 1, 30, '2020-01-01'), 
   (1, 2, 2, 40, '2020-01-01'), 
   (2, 1, 1, 10, '2020-01-10'), 
   (2, 1, 2, 20, '2020-01-10'), 
   (2, 2, 1, 30, '2020-01-10'), 
   (2, 2, 2, 40, '2020-01-10');

  SELECT TOP(0) *
  INTO #vw_BillingDocumentItem_for_SalesDocumentItem
  FROM edw.vw_BillingDocumentItem_for_SalesDocumentItem;

  -- #2
  INSERT INTO #vw_BillingDocumentItem_for_SalesDocumentItem (ReferenceSDDocument, ReferenceSDDocumentItem, BillingQuantity)
  VALUES
    (1, 1, 10),
    (1, 2, 20),
    (2, 1, 30),
    (2, 2, 40);

  EXEC ('INSERT INTO edw.vw_BillingDocumentItem_for_SalesDocumentItem SELECT * FROM #vw_BillingDocumentItem_for_SalesDocumentItem');

  SELECT TOP(0) *
  INTO #vw_fact_SalesDocumentItem
  FROM edw.vw_fact_SalesDocumentItem;

  -- #2
  INSERT INTO #vw_fact_SalesDocumentItem (
    sk_fact_SalesDocumentItem,
    SalesDocument,
    SalesDocumentItem,
    CurrencyTypeID,
    SalesOrganizationID,
    OrderType
  )
  VALUES
    ( 0, 1, 1, 10, 1, 'Collection'),
    ( 1, 1, 1, 20, 1, 'Collection'),
    ( 2, 1, 1, 30, 1, 'Collection'),
    ( 3, 1, 2, 10, 2, 'Delivery'),
    ( 4, 1, 2, 20, 2, 'Delivery'),
    ( 5, 1, 2, 30, 2, 'Delivery'),
    ( 6, 2, 1, 10, 1, 'Drop Shipmen'),
    ( 7, 2, 1, 20, 1, 'Drop Shipmen'),
    ( 8, 2, 1, 30, 1, 'Drop Shipmen'),
    ( 9, 2, 2, 10, 2, 'Collection'),
    (10, 2, 2, 20, 2, 'Collection'),
    (11, 2, 2, 30, 2, 'Collection');

  EXEC ('INSERT INTO edw.vw_fact_SalesDocumentItem SELECT * FROM #vw_fact_SalesDocumentItem');

  INSERT INTO[edw].[dim_SalesOrganization](SalesOrganizationID)
  VALUES (1), (2)

  INSERT INTO base_ff.SalesDocumentStatuses (
    OrderTypeText,
    DeliveryStatus,
    InvoiceStatus
  )
  VALUES
    ('Collection', 'A', 'F'),
    ('Delivery', 'B', 'N'),
    ('Drop Shipment', 'C', 'P');


-- Act: 
  SELECT
    sk_fact_SalesDocumentItem
  INTO actual
  FROM [edw].[vw_fact_ScheduleLineStatus]
  GROUP BY
    sk_fact_SalesDocumentItem
  HAVING COUNT(*) > 1

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
