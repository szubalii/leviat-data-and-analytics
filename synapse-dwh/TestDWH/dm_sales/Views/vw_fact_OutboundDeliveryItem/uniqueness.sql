CREATE PROCEDURE [tc.dm_sales.vw_fact_OutboundDeliveryItem].[test uniqueness]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
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
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_TransportationOrderItem]';
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_FrtCostDistrItm]';
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
    OutboundDeliveryItem
  )
  VALUES
    (0, 1, 1, 1, 1, 1, 1, 1, 1, 1),
    (1, 1, 1, 1, 1, 1, 1, 1, 2, 2),
    (2, 2, 2, 2, 2, 2, 2, 2, 3, 3),
    (3, 2, 2, 2, 2, 2, 2, 2, 4, 4);

  INSERT INTO base_s4h_cax.I_TransportationOrderItem
    (MANDT, TransportationOrderItemUUID, TranspOrdDocReferenceID, TranspOrdDocReferenceItmID)
  VALUES
    (200, CONVERT(BINARY(16),0x000D3A2775B31EECA598CFA2549EA269), 1, 1)
    ,(200, CONVERT(BINARY(16),0x000D3A2775B31EECA598CFA2549DA269), 2, 2);
  
  INSERT INTO base_s4h_cax.I_FrtCostDistrItm
    (FrtCostDistrItmRefUUID, FrtCostDistrItemAmount, FrtCostDistrItemAmtCrcy)
  VALUES
    (CONVERT(BINARY(16),0x000D3A2775B31EECA598CFA2549EA269), 120, 'CHF')
    ,(CONVERT(BINARY(16),0x000D3A2775B31EECA598CFA2549EA269), 140, 'CHF')
    ,(CONVERT(BINARY(16),0x000D3A2775B31EECA598CFA2549DA269), 100, 'CHF');

  INSERT INTO edw.fact_BillingDocumentItem
    (ReferenceSDDocument, ReferenceSDDocumentItem, BillingDocument, BillingDocumentItem, CurrencyTypeID)
  VALUES
    (1, 1, 1, 1, '10')
    ,(2, 2, 1, 2, '10');

  INSERT INTO edw.fact_BillingDocumentItemPrcgElmnt
    (BillingDocument, BillingDocumentItem, ConditionType, CurrencyTypeID, CurrencyID, ConditionAmount)
  VALUES
    (1, 1, 'ZF10', '10', 'CHF', 20)
    ,(1, 1, 'ZF20', '10', 'CHF', 15)
    ,(1, 2, 'ZF20', '10', 'CHF', 10);

  INSERT INTO edw.dim_ExchangeRates
    (SourceCurrency, TargetCurrency, ExchangeRate, ExchangeRateType, ExchangeRateEffectiveDate)
  VALUES
    ('CHF','EUR', 1.2, 'P', '2000-01-01');

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
