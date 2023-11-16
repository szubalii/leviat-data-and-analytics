CREATE PROCEDURE [tc.dm_sales.vw_fact_OutboundDeliveryItem].[test uniqueness]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('tempdb..#vw_TransportationOrderItemFreightCost') IS NOT NULL DROP TABLE #vw_TransportationOrderItemFreightCost;
  IF OBJECT_ID('tempdb..#vw_fact_BillingDocumentItemFreight') IS NOT NULL DROP TABLE #vw_fact_BillingDocumentItemFreight;
  IF OBJECT_ID('tempdb..#vw_CurrencyConversionRate') IS NOT NULL DROP TABLE #vw_CurrencyConversionRate;
  -- IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_OutboundDeliveryItem]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_SDDocumentCategory]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_MaterialGroup]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_SalesDocumentItemCategory]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_DeliveryDocumentType]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_SalesDocumentItemType]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_DistributionChannel]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_SDProcessStatus]';
  EXEC tSQLt.FakeTable '[edw]', '[vw_TransportationOrderItemFreightCost]';
  EXEC tSQLt.FakeTable '[edw]', '[vw_fact_BillingDocumentItemFreight]';
  EXEC tSQLt.FakeTable '[edw]', '[vw_CurrencyConversionRate]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_BillingDocumentItem]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_BillingDocumentItemPrcgElmnt]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_ExchangeRates]';

  INSERT INTO edw.dim_SDDocumentCategory (SDDocumentCategoryID, SDDocumentCategory)
  VALUES (1, 'text1'), (2, 'text2');

  INSERT INTO edw.dim_MaterialGroup (MaterialGroupID, MaterialGroup)
  VALUES (1, 'text1'), (2, 'text2');

  INSERT INTO edw.dim_SalesDocumentItemCategory (SalesDocumentItemCategoryID, SalesDocumentItemCategory)
  VALUES (1, 'text1'), (2, 'text2');

  INSERT INTO edw.dim_DeliveryDocumentType (DeliveryDocumentTypeID, DeliveryDocumentType)
  VALUES (1, 'text1'), (2, 'text2');

  INSERT INTO edw.dim_SalesDocumentItemType (SalesDocumentItemTypeID, SalesDocumentItemType)
  VALUES (1, 'text1'), (2, 'text2');

  INSERT INTO edw.dim_DistributionChannel (DistributionChannelID, DistributionChannel)
  VALUES (1, 'text1'), (2, 'text2');

  INSERT INTO edw.dim_SDProcessStatus (SDProcessStatusID, SDProcessStatus)
  VALUES (1, 'text1'), (2, 'text2');

  INSERT INTO edw.fact_OutboundDeliveryItem (
    sk_fact_OutboundDeliveryItem,
    ReferenceSDDocumentCategoryID,
    ProductGroupID,
    DeliveryDocumentItemCategoryID,
    HDR_DeliveryDocumentTypeID,
    SalesDocumentItemTypeID,
    DistributionChannelID,
    SDProcessStatusID,
    OutboundDelivery,
    OutboundDeliveryItem,
    SDI_LocalCurrency
  )
  VALUES
    (0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'PLN'),
    (1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 'PLN'),
    (2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 'EUR'),
    (3, 2, 2, 2, 2, 2, 2, 2, 4, 4, 'PLN');

  SELECT TOP(0) *
  INTO #vw_TransportationOrderItemFreightCost
  FROM edw.vw_TransportationOrderItemFreightCost;

  INSERT INTO #vw_TransportationOrderItemFreightCost (
    TranspOrdDocReferenceID,
    TranspOrdDocReferenceItmID,
    FrtCostDistrItemAmtCrcy
  )
  VALUES
    (1, 1, 'EUR'),
    (1, 2, 'USD'),
    (3, 3, 'PLN'),
    (4, 4, 'EUR');

  EXEC ('INSERT INTO edw.vw_TransportationOrderItemFreightCost SELECT * FROM #vw_TransportationOrderItemFreightCost');

  SELECT TOP(0) *
  INTO #vw_fact_BillingDocumentItemFreight
  FROM edw.vw_fact_BillingDocumentItemFreight;

  INSERT INTO #vw_fact_BillingDocumentItemFreight (
    ReferenceSDDocument,
    ReferenceSDDocumentItem,
    LocalCurrencyID
  )
  VALUES
    (1, 1, 'PLN'),
    (1, 2, 'EUR'),
    (3, 3, 'USD'),
    (4, 4, 'EUR');

  EXEC ('INSERT INTO edw.vw_fact_BillingDocumentItemFreight SELECT * FROM #vw_fact_BillingDocumentItemFreight');

  SELECT TOP(0) *
  INTO #vw_CurrencyConversionRate
  FROM edw.vw_CurrencyConversionRate;

  INSERT INTO #vw_CurrencyConversionRate (
    SourceCurrency,
    TargetCurrency,
    CurrencyTypeID
  )
  VALUES
    ('PLN', 'EUR', '30'),
    ('EUR', 'USD', '40');

  EXEC ('INSERT INTO edw.vw_CurrencyConversionRate SELECT * FROM #vw_CurrencyConversionRate');


  INSERT INTO edw.fact_BillingDocumentItem
    (ReferenceSDDocument, ReferenceSDDocumentItem, BillingDocument, BillingDocumentItem, CurrencyTypeID)
  VALUES
    (1, 1, 1, 1, '10'),
    (2, 2, 1, 2, '10');

  INSERT INTO edw.fact_BillingDocumentItemPrcgElmnt
    (BillingDocument, BillingDocumentItem, ConditionType, CurrencyTypeID, CurrencyID, ConditionAmount)
  VALUES
    (1, 1, 'ZF10', '10', 'CHF', 20),
    (1, 1, 'ZF20', '10', 'CHF', 15),
    (1, 2, 'ZF20', '10', 'CHF', 10);

  INSERT INTO edw.dim_ExchangeRates
    (SourceCurrency, TargetCurrency, ExchangeRate, ExchangeRateType, ExchangeRateEffectiveDate)
  VALUES
    ('CHF', 'EUR', 1.2, 'P', '2000-01-01');

  -- Act: 
  SELECT
    sk_fact_OutboundDeliveryItem
  INTO actual
  FROM [dm_sales].[vw_fact_OutboundDeliveryItem]
  GROUP BY
    sk_fact_OutboundDeliveryItem
  HAVING COUNT(*) > 1

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
