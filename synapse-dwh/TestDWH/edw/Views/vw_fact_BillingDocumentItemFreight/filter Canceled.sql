-- Test for Canceled document filtration in [edw].[vw_fact_BillingDocumentItemFreight]
CREATE PROCEDURE [tc.edw.vw_fact_BillingDocumentItemFreight].[test filter Canceled]
AS
BEGIN
  DECLARE @actual INT;
  DECLARE @expected INT;

  SET @expected = 1;
  
   -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_BillingDocumentItem]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_BillingDocumentItemPrcgElmnt]';
  
  INSERT INTO edw.fact_BillingDocumentItem
    (ReferenceSDDocument, ReferenceSDDocumentItem, BillingDocument, BillingDocumentItem, CurrencyTypeID, BillingDocumentIsCancelled, CancelledBillingDocument)
  VALUES
    (1, 1, 1, 1, '10', NULL, NULL)
    ,(2, 2, 1, 1, '10', '1', NULL)
    ,(3, 3, 1, 1, '10', NULL, '1')
    ,(4, 4, 1, 1, '10', '1', '1');

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
