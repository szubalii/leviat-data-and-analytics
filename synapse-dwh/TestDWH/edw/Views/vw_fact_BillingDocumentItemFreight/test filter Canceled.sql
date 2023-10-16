-- Test for Canceled document filtration in [edw].[vw_fact_BillingDocumentItemFreight]
CREATE PROCEDURE [tc.edw.vw_fact_BillingDocumentItemFreight].[test filter Canceled Billing Documents]
AS
BEGIN
  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
  
   -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_BillingDocumentItem]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_BillingDocumentItemPrcgElmnt]';
  
  INSERT INTO edw.fact_BillingDocumentItem (
    ReferenceSDDocument,
    ReferenceSDDocumentItem,
    BillingDocument,
    BillingDocumentItem,
    CurrencyTypeID,
    BillingDocumentIsCancelled,
    CancelledBillingDocument
  )
  VALUES
     (1, 1, 1, 1, '10', NULL, NULL)
    ,(2, 2, 1, 1, '10', '1', NULL)
    ,(3, 3, 1, 1, '10', NULL, '1')
    ,(4, 4, 1, 1, '10', '1', '1')
    ,(5, 5, 1, 1, '10', NULL, '')
    ,(6, 6, 1, 1, '10', '', NULL)
    ,(7, 7, 1, 1, '10', '', '');

  INSERT INTO edw.fact_BillingDocumentItemPrcgElmnt
    (BillingDocument, BillingDocumentItem, CurrencyTypeID, ConditionType)
  VALUES
    (1, 1, '10', 'ZF10');
  
  -- Act: 
  SELECT
    ReferenceSDDocument,
    ReferenceSDDocumentItem
  INTO actual
  FROM [edw].[vw_fact_BillingDocumentItemFreight]
  
  -- Assert:
  CREATE TABLE expected (
    ReferenceSDDocument INT,
    ReferenceSDDocumentItem INT
  );
  INSERT INTO expected (
    ReferenceSDDocument,
    ReferenceSDDocumentItem
  )
  VALUES
    (1,1),
    (5,5),
    (6,6),
    (7,7);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
