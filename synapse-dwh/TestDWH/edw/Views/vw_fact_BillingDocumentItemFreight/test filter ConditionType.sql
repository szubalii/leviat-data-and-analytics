-- Test for ConditionType filtration in [edw].[vw_fact_BillingDocumentItemFreight]
CREATE PROCEDURE [tc.edw.vw_fact_BillingDocumentItemFreight].[test filter ConditionType]
AS
BEGIN
  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
  
   -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_BillingDocumentItem]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_BillingDocumentItemPrcgElmnt]';
  
  INSERT INTO edw.fact_BillingDocumentItem
    (ReferenceSDDocument, ReferenceSDDocumentItem, BillingDocument, BillingDocumentItem, CurrencyTypeID)
  VALUES
    (1, 1, 1, 1, '10'),
    (1, 2, 1, 2, '10'),
    (1, 3, 1, 3, '10'),
    (1, 4, 1, 4, '10'),
    (1, 5, 1, 5, '10'),
    (1, 6, 1, 6, '10'),
    (1, 7, 1, 7, '10');

  INSERT INTO edw.fact_BillingDocumentItemPrcgElmnt
    (BillingDocument, BillingDocumentItem, ConditionType, CurrencyTypeID)
  VALUES
     (1, 1, 'ZF10', '10')
    ,(1, 2, 'ZF20', '10')
    ,(1, 3, 'ZF40', '10')
    ,(1, 4, 'ZF60', '10')
    ,(1, 5, 'ZTMF', '10')
    ,(1, 6, 'ZF99', '10')
    ,(1, 7, 'ZF01', '10');

  -- Act: 
  SELECT ReferenceSDDocument, ReferenceSDDocumentItem
  INTO actual
  FROM [edw].[vw_fact_BillingDocumentItemFreight];

  -- Assert:
  CREATE TABLE expected (
    ReferenceSDDocument INT,
    ReferenceSDDocumentItem INT
  );
  INSERT INTO expected (
    ReferenceSDDocument, ReferenceSDDocumentItem
  )
  VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (1, 4),
    (1, 5);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
