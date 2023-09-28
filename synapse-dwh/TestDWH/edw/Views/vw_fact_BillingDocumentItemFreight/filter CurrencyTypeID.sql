-- Test for CurrencyTypeID filtration in [edw].[vw_fact_BillingDocumentItemFreight]
CREATE PROCEDURE [tc.edw.vw_fact_BillingDocumentItemFreight].[test filter CurrencyTypeID]
AS
BEGIN
  DECLARE @actual INT;
  DECLARE @expected INT;

  SET @expected = 1;
  
   -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_BillingDocumentItem]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_BillingDocumentItemPrcgElmnt]';
  
  INSERT INTO edw.fact_BillingDocumentItem
    (ReferenceSDDocument, ReferenceSDDocumentItem, BillingDocument, BillingDocumentItem, CurrencyTypeID)
  VALUES
    (1, 1, 1, 1, '10')
    ,(2, 2, 1, 1, '00')
    ,(3, 3, 1, 1, '30')
    ,(4, 4, 1, 1, '40');

  INSERT INTO edw.fact_BillingDocumentItemPrcgElmnt
    (BillingDocument, BillingDocumentItem, CurrencyTypeID, ConditionType)
  VALUES
    (1, 1, '10', 'ZF10');
  
  -- Act: 
  SELECT
    @actual = COUNT(DISTINCT ReferenceSDDocument)
  FROM 
    [edw].[vw_fact_BillingDocumentItemFreight];
  
  -- Assert:

  EXEC tSQLt.AssertEquals @expected, @actual;
END;
