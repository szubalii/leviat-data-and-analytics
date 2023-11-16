
CREATE PROCEDURE [tc.edw.vw_fact_ACDOCA_EPM_Base].[test uniqueness]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('tempdb..#vw_entity_file') IS NOT NULL DROP TABLE #vw_entity_file;
  -- IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_CustomerSalesArea]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_ZE_EXQLMAP_DT]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_BillingDocumentType]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_ProductSalesDelivery]';
  EXEC tSQLt.FakeTable '[edw]', '[vw_CurrencyConversionRate]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_CurrencyType]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_Brand]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_CustomerGroup]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_ACDOCA]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_SalesDocumentItem]';

  
  INSERT INTO base_s4h_cax.I_CustomerSalesArea (Customer, SalesOrganization, DistributionChannel, Division)
  VALUES
    (1, 1, 1, 1),
    (1, 1, 1, 2),
    (1, 2, 2, 1);
  INSERT INTO edw.dim_ZE_EXQLMAP_DT (GLAccountID, FunctionalAreaID)
  VALUES (1, 1), (1, 2);
  INSERT INTO edw.dim_BillingDocumentType (BillingDocumentTypeID)
  VALUES (1);
  INSERT INTO edw.dim_ProductSalesDelivery (ProductID, SalesOrganizationID, DistributionChannelID)
  VALUES (1, 1, 1), (1, 1, 2), (1, 2, 1);
  -- INSERT INTO edw.vw_CurrencyConversionRate (SourceCurrency)
  -- VALUES (?);
  INSERT INTO edw.dim_CurrencyType (CurrencyTypeID)
  VALUES (1);
  INSERT INTO edw.dim_Brand (BrandID)
  VALUES (1);
  INSERT INTO edw.dim_CustomerGroup (CustomerGroupID)
  VALUES (1);

  INSERT INTO edw.fact_ACDOCA (
    SourceLedgerID,
    CompanyCodeID,
    FiscalYear,
    AccountingDocument,
    LedgerGLLineItem,
    GLAccountID,
    FunctionalAreaID,
    BillingDocumentTypeID,
    ProductID,
    SalesOrganizationID,
    DistributionChannelID,
    CustomerID,
    CompanyCodeCurrency,
    SalesReferenceDocumentCalculated,
    SalesReferenceDocumentItemCalculated
  )
  VALUES
    (1, 1, 2023, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'EUR', 1, 1),
    (1, 1, 2023, 1, 2, 1, 1, 1, 1, 1, 1, 1, 'EUR', 1, 2),
    (1, 1, 2023, 2, 1, 1, 1, 1, 1, 1, 1, 1, 'EUR', 2, 1),
    (1, 1, 2023, 2, 2, 1, 2, 1, 2, 2, 1, 1, 'EUR', 2, 2);

  INSERT INTO edw.fact_SalesDocumentItem (SalesDocument, SalesDocumentItem, CurrencyTypeID)
  VALUES 
    (1, 1, 10), (1, 1, 30), (1, 1, 40),
    (1, 2, 10), (1, 2, 30), (1, 2, 40),
    (2, 1, 10), (2, 1, 30), (2, 1, 40),
    (2, 2, 10), (2, 2, 30), (2, 2, 40);
  
    
  SELECT TOP(0) *
  INTO #vw_CurrencyConversionRate
  FROM edw.vw_CurrencyConversionRate;

  -- #2
  INSERT INTO #vw_CurrencyConversionRate (
    SourceCurrency,
    TargetCurrency,
    ExchangeRate,
    CurrencyTypeID
  )
  VALUES
    ('EUR', 'EUR', 1.0, '30'),
    ('EUR', 'USD', 1.1, '40');

  EXEC ('INSERT INTO edw.vw_CurrencyConversionRate SELECT * FROM #vw_CurrencyConversionRate');

  -- Act: 
  SELECT
    SourceLedgerID,
    CompanyCodeID,
    FiscalYear,
    AccountingDocument,
    LedgerGLLineItem,
    CurrencyTypeID
  INTO actual
  FROM [edw].[vw_fact_ACDOCA_EPM_Base]
  GROUP BY
    SourceLedgerID,
    CompanyCodeID,
    FiscalYear,
    AccountingDocument,
    LedgerGLLineItem,
    CurrencyTypeID
  HAVING COUNT(*) > 1

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
GO