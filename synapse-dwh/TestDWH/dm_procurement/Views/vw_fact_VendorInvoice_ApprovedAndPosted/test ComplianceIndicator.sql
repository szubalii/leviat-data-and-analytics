CREATE PROCEDURE [tc.dm_procurement.vw_fact_VendorInvoice_ApprovedAndPosted].[test ComplianceIndicator]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('tempdb..#vw_fact_VendorInvoice_ApprovedAndPosted_CUR') IS NOT NULL DROP TABLE #vw_fact_VendorInvoice_ApprovedAndPosted_CUR;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;
    
  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_ff]', '[CompliantGLAccounts]';
  EXEC tSQLt.FakeTable '[edw]', '[vw_fact_VendorInvoice_ApprovedAndPosted_CUR]';
 

  INSERT INTO [base_ff].[CompliantGLAccounts] (
     [SAPAccount]
    ,[Status]
  )
  VALUES
  (0015310001, 'Compliant');

  SELECT TOP(0) *
  INTO #vw_fact_VendorInvoice_ApprovedAndPosted_CUR
  FROM edw.vw_fact_VendorInvoice_ApprovedAndPosted_CUR;

  INSERT INTO #vw_fact_VendorInvoice_ApprovedAndPosted_CUR (
     [sk_fact_PurchasingDocumentItem]
    ,[GLAccountID]
  )
  VALUES
    ('001', 0015310001),
    ('002', 0000000002);

 EXEC ('INSERT INTO edw.vw_fact_VendorInvoice_ApprovedAndPosted_CUR SELECT * FROM #vw_fact_VendorInvoice_ApprovedAndPosted_CUR');

 
-- Act: 
  SELECT
     sk_fact_PurchasingDocumentItem
    ,GLAccountID
    ,ComplianceIndicator 
  INTO actual
  FROM [dm_procurement].[vw_fact_VendorInvoice_ApprovedAndPosted];

  SELECT TOP 0 * INTO expected FROM actual;

  INSERT INTO expected (
     sk_fact_PurchasingDocumentItem
    ,GLAccountID
    ,ComplianceIndicator
  )
  VALUES
    ('001', 0015310001, 'Compliant'),
    ('002', 0000000002, 'Non-Compliant');

  
  -- Assert:
  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
