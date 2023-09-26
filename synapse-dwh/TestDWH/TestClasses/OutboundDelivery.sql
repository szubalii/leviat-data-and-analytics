EXEC [tSQLt].[SetFakeViewOn] 'edw';
GO
EXEC tSQLt.NewTestClass 'OutboundDelivery';
GO

-- Test for duplicates in [dm_sales].[vw_fact_OutboundDeliveryItem].[sk_fact_OutboundDeliveryItem]
CREATE PROCEDURE [OutboundDelivery].[test for sk duplicates]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;

   -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_OutboundDeliveryItem]';
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_TransportationOrderItem]';
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_FrtCostDistrItm]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_BillingDocumentItem]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_BillingDocumentItemPrcgElmnt]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_ExchangeRates]';
  

  INSERT INTO edw.fact_OutboundDeliveryItem
    (sk_fact_OutboundDeliveryItem, nk_fact_OutboundDeliveryItem, OutboundDelivery, OutboundDeliveryItem, SDI_LocalCurrency)
  VALUES (1, '1|1', 1, 1, 'CHF');

  INSERT INTO base_s4h_cax.I_TransportationOrderItem
    (MANDT, TransportationOrderItemUUID, TranspOrdDocReferenceID, TranspOrdDocReferenceItmID)
  VALUES (200, 'b94b6a2f-823b-4011-80e3-55b480211d03', 1, 1);
  
  INSERT INTO base_s4h_cax.I_FrtCostDistrItm
    (FrtCostDistrItmRefUUID, FrtCostDistrItemAmount, FrtCostDistrItemAmtCrcy)
  VALUES
    ('b94b6a2f-823b-4011-80e3-55b480211d03', 120, 'CHF')
    ,('b94b6a2f-823b-4011-80e3-55b480211d03', 140, 'CHF')
    ,('340fb1ff-69a5-4018-b1c2-468fd4b25628', 100, 'CHF');

  INSERT INTO edw.fact_BillingDocumentItem
    (ReferenceSDDocument, ReferenceSDDocumentItem, BillingDocument, BillingDocumentItem, CurrencyTypeID)
  VALUES
    (1, 1, 1, 1, '10');

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
    [sk_fact_OutboundDeliveryItem]
  INTO
    actual
  FROM 
    [dm_sales].[vw_fact_OutboundDeliveryItem]
  GROUP BY
    sk_fact_OutboundDeliveryItem
  HAVING
    COUNT(*)>1;
  
  -- Assert:

  EXEC tSQLt.AssertEmptyTable 'actual';
END;
GO


-- Test for duplicates in [dm_sales].[vw_fact_OutboundDeliveryItem].[nk_fact_OutboundDeliveryItem]
CREATE PROCEDURE [OutboundDelivery].[test for nk duplicates]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;

   -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_OutboundDeliveryItem]';
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_TransportationOrderItem]';
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_FrtCostDistrItm]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_BillingDocumentItem]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_BillingDocumentItemPrcgElmnt]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_ExchangeRates]';
  

  INSERT INTO edw.fact_OutboundDeliveryItem
    (sk_fact_OutboundDeliveryItem, nk_fact_OutboundDeliveryItem, OutboundDelivery, OutboundDeliveryItem, SDI_LocalCurrency)
  VALUES (1, '1|1', 1, 1, 'CHF');

  INSERT INTO base_s4h_cax.I_TransportationOrderItem
    (MANDT, TransportationOrderItemUUID, TranspOrdDocReferenceID, TranspOrdDocReferenceItmID)
  VALUES (200, 'b94b6a2f-823b-4011-80e3-55b480211d03', 1, 1);
  
  INSERT INTO base_s4h_cax.I_FrtCostDistrItm
    (FrtCostDistrItmRefUUID, FrtCostDistrItemAmount, FrtCostDistrItemAmtCrcy)
  VALUES
    ('b94b6a2f-823b-4011-80e3-55b480211d03', 120, 'CHF')
    ,('b94b6a2f-823b-4011-80e3-55b480211d03', 140, 'CHF')
    ,('340fb1ff-69a5-4018-b1c2-468fd4b25628', 100, 'CHF');

  INSERT INTO edw.fact_BillingDocumentItem
    (ReferenceSDDocument, ReferenceSDDocumentItem, BillingDocument, BillingDocumentItem, CurrencyTypeID)
  VALUES
    (1, 1, 1, 1, '10');

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
    [nk_fact_OutboundDeliveryItem]
  INTO
    actual
  FROM 
    [dm_sales].[vw_fact_OutboundDeliveryItem]
  GROUP BY
    nk_fact_OutboundDeliveryItem
  HAVING
    COUNT(*)>1;
  
  -- Assert:

  EXEC tSQLt.AssertEmptyTable 'actual';
END;
GO

-- Test for duplicates in [dm_sales].[vw_fact_OutboundDeliveryItem].[nk_fact_OutboundDeliveryItem]
CREATE PROCEDURE [OutboundDelivery].[test for composite key duplicates]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;

   -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_OutboundDeliveryItem]';
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_TransportationOrderItem]';
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_FrtCostDistrItm]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_BillingDocumentItem]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_BillingDocumentItemPrcgElmnt]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_ExchangeRates]';
  

  INSERT INTO edw.fact_OutboundDeliveryItem
    (sk_fact_OutboundDeliveryItem, nk_fact_OutboundDeliveryItem, OutboundDelivery, OutboundDeliveryItem, SDI_LocalCurrency)
  VALUES (1, '1|1', 1, 1, 'CHF');

  INSERT INTO base_s4h_cax.I_TransportationOrderItem
    (MANDT, TransportationOrderItemUUID, TranspOrdDocReferenceID, TranspOrdDocReferenceItmID)
  VALUES (200, 'b94b6a2f-823b-4011-80e3-55b480211d03', 1, 1);
  
  INSERT INTO base_s4h_cax.I_FrtCostDistrItm
    (FrtCostDistrItmRefUUID, FrtCostDistrItemAmount, FrtCostDistrItemAmtCrcy)
  VALUES
    ('b94b6a2f-823b-4011-80e3-55b480211d03', 120, 'CHF')
    ,('b94b6a2f-823b-4011-80e3-55b480211d03', 140, 'CHF')
    ,('340fb1ff-69a5-4018-b1c2-468fd4b25628', 100, 'CHF');

  INSERT INTO edw.fact_BillingDocumentItem
    (ReferenceSDDocument, ReferenceSDDocumentItem, BillingDocument, BillingDocumentItem, CurrencyTypeID)
  VALUES
    (1, 1, 1, 1, '10');

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
    [OutboundDelivery]
    ,[OutboundDeliveryItem]
  INTO
    actual
  FROM 
    [dm_sales].[vw_fact_OutboundDeliveryItem]
  GROUP BY
    [OutboundDelivery]
    ,[OutboundDeliveryItem]
  HAVING
    COUNT(*)>1;
  
  -- Assert:

  EXEC tSQLt.AssertEmptyTable 'actual';
END;
GO

EXEC [tSQLt].[SetFakeViewOff] 'edw';

GO
