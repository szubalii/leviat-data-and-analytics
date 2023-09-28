-- Test for ConditionType filtration in [edw].[vw_fact_BillingDocumentItemFreight]
CREATE PROCEDURE [tc.edw.vw_fact_BillingDocumentItemFreight].[test filter ConditionType]
AS
BEGIN
  DECLARE @actual INT;
  DECLARE @expected INT;

  SET @expected = 100;
  
   -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_BillingDocumentItem]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_BillingDocumentItemPrcgElmnt]';
  
  INSERT INTO edw.fact_BillingDocumentItem
    (ReferenceSDDocument, ReferenceSDDocumentItem, BillingDocument, BillingDocumentItem, CurrencyTypeID)
  VALUES
    (1, 1, 1, 1, '10');

  INSERT INTO edw.fact_BillingDocumentItemPrcgElmnt
    (BillingDocument, BillingDocumentItem, ConditionType, CurrencyTypeID, CurrencyID, ConditionAmount)
  VALUES
    (1, 1, 'ZF10', '10', 'CHF', 20)
    ,(1, 1, 'ZF20', '10', 'CHF', 20)
    ,(1, 1, 'ZF40', '10', 'CHF', 20)
    ,(1, 1, 'ZF60', '10', 'CHF', 20)
    ,(1, 1, 'ZTMF', '10', 'CHF', 20)
    ,(1, 1, 'ZF99', '10', 'CHF', 20)
    ,(1, 1, 'ZF01', '10', 'CHF', 20);
  
  -- Act: 
  SELECT
    @actual = InvoicedFreightValue_LC
  FROM 
    [edw].[vw_fact_BillingDocumentItemFreight]
  WHERE
    ReferenceSDDocument = 1
    AND ReferenceSDDocumentItem = 1
    AND LocalCurrencyID='CHF';
  
  -- Assert:

  EXEC tSQLt.AssertEquals @expected, @actual;
END;
