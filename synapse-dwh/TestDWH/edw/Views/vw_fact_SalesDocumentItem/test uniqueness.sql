CREATE PROCEDURE [tc.edw.vw_fact_SalesDocumentItem].[test uniqueness]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('tempdb..#vw_LatestOutboundDeliveryItem') IS NOT NULL DROP TABLE #vw_LatestOutboundDeliveryItem;
  -- IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_SalesDocumentItem]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_BillingBlockStatus]';
  EXEC tSQLt.FakeTable '[edw]', '[vw_LatestOutboundDeliveryItem]';

  INSERT INTO edw.fact_SalesDocumentItem (
    sk_fact_SalesDocumentItem,
    SalesDocument,
    SalesDocumentItem,
    CurrencyTypeID
  )
  VALUES
    ( 0, 1, 1, 10),
    ( 1, 1, 1, 20),
    ( 2, 1, 1, 30),
    ( 3, 1, 2, 10),
    ( 4, 1, 2, 20),
    ( 5, 1, 2, 30),
    ( 6, 2, 1, 10),
    ( 7, 2, 1, 20),
    ( 8, 2, 1, 30),
    ( 9, 2, 2, 10),
    (10, 2, 2, 20),
    (11, 2, 2, 30);

  SELECT TOP(0) *
  INTO #vw_LatestOutboundDeliveryItem
  FROM edw.vw_LatestOutboundDeliveryItem;

  -- #2
  INSERT INTO #vw_LatestOutboundDeliveryItem (ReferenceSDDocument, ReferenceSDDocumentItem)
  VALUES
    ( 1, 1),
    ( 1, 2),
    ( 2, 1),
    ( 2, 2);

  EXEC ('INSERT INTO edw.vw_LatestOutboundDeliveryItem SELECT * FROM #vw_LatestOutboundDeliveryItem');

  INSERT INTO edw.BillingBlockStatusID (BillingBlockStatusID)
  VALUES (1), (2);

-- Act: 
  SELECT
    sk_fact_SalesDocumentItem
  INTO actual
  FROM [edw].[vw_fact_SalesDocumentItem]
  GROUP BY
    sk_fact_SalesDocumentItem
  HAVING COUNT(*) > 1

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
