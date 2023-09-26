EXEC [tSQLt].[SetFakeViewOn] 'edw';
GO
EXEC tSQLt.NewTestClass 'OutboundDelivery';
GO

CREATE PROCEDURE [OutboundDelivery].[test edw.vw_LatestOutboundDeliveryItem: uniqueness]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_OutboundDeliveryItem]';

  INSERT INTO edw.fact_OutboundDeliveryItem (
    OutboundDelivery,
    OutboundDeliveryItem,
    ReferenceSDDocument,
    ReferenceSDDocumentItem,
    HDR_ActualGoodsMovementDate
  )
  VALUES
    (1, 1, 1, 1, '2020-01-01')
  , (1, 2, 1, 2, '2020-01-01')
  , (1, 3, 1, 2, '2020-01-01')
  , (2, 1, 1, 1, '2020-01-10')
  , (2, 2, 1, 2, '2020-01-10')

  -- Collect non-unique records
  SELECT
    [ReferenceSDDocument],
    [ReferenceSDDocumentItem]
  INTO actual
  FROM [edw].[vw_LatestOutboundDeliveryItem]
  GROUP BY
    [ReferenceSDDocument],
    [ReferenceSDDocumentItem]
  HAVING COUNT(*) > 1

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
GO

-- test we have latest HDR_ActualGoodsMovementDate in dm_sales.vw_fact_ScheduleLineStatus
CREATE PROCEDURE [OutboundDelivery].[test vw_LatestOutboundDeliveryItem: latest HDR_ActualGoodsMovementDate]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[fact_OutboundDeliveryItem]';

  INSERT INTO edw.fact_OutboundDeliveryItem (
    OutboundDelivery,
    OutboundDeliveryItem,
    ReferenceSDDocument,
    ReferenceSDDocumentItem,
    HDR_ActualGoodsMovementDate
  )
  VALUES
    (1, 1, 1, 1, '2020-01-01')
  , (1, 2, 1, 2, '2020-01-01')
  , (1, 3, 1, 2, '2020-01-01')
  , (2, 1, 1, 1, '2020-01-10')
  , (3, 1, 1, 2, '2020-01-11');

  -- Act
  SELECT
    [ReferenceSDDocument],
    [ReferenceSDDocumentItem],
    [LatestActualGoodsMovementDate]
  INTO actual
  FROM [edw].[vw_LatestOutboundDeliveryItem]
  GROUP BY
    [ReferenceSDDocument],
    [ReferenceSDDocumentItem],
    [LatestActualGoodsMovementDate]

  -- Assert:
  CREATE TABLE expected (
    ReferenceSDDocument INT,
    ReferenceSDDocumentItem INT,
    LatestActualGoodsMovementDate DATE
  );

  INSERT INTO expected(
    ReferenceSDDocument,
    ReferenceSDDocumentItem,
    LatestActualGoodsMovementDate
  )
  VALUES
    (1, 1, '2020-01-10'),
    (1, 2, '2020-01-11');

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO

CREATE PROCEDURE [OutboundDelivery].[test dm_sales.vw_fact_OutboundDeliveryItem: uniqueness]
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
    SDProcessStatusID
  )
  VALUES
    (0, 1, 1, 1, 1, 1, 1, 1),
    (1, 1, 1, 1, 1, 1, 1, 1),
    (2, 2, 2, 2, 2, 2, 2, 2),
    (3, 2, 2, 2, 2, 2, 2, 2);

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
GO

CREATE PROCEDURE [OutboundDelivery].[test edw.vw_OutboundDeliveryItem_s4h: uniqueness]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  -- IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_OutboundDeliveryItem]';
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_OutboundDelivery]';
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_SDDocumentCompletePartners]';
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_Supplier]';
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_SalesDocumentScheduleLine]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_Route]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_Customer]';
  EXEC tSQLt.FakeTable '[edw]', '[fact_SalesDocumentItem]';

  INSERT INTO base_s4h_cax.I_OutboundDeliveryItem (OutboundDelivery, OutboundDeliveryItem)
  VALUES (1, 1), (1, 2), (2, 1), (2, 2);

  INSERT INTO base_s4h_cax.I_OutboundDelivery (OutboundDelivery, SoldToParty, ActualDeliveryRoute, ProposedDeliveryRoute)
  VALUES (1, 1, 1, 1), (2, 2, 2, 2);

  INSERT INTO base_s4h_cax.I_SDDocumentCompletePartners (SDDocument, SDDocumentItem, PartnerFunction, Supplier)
  VALUES
    (1, 1, 'XX', 1),
    (1, 000000, 'SP', 1), -- SDDocumentItem is always 000000 for PartnerFunction SP (Delivery Agent)
    (1, 2, 'XX', 1),
    (2, 1, 'XX', 1),
    (2, 000000, 'SP', 1),
    (2, 2, 'XX', 1);

  INSERT INTO base_s4h_cax.I_Supplier (Supplier)
  VALUES (1), (2);

  INSERT INTO base_s4h_cax.I_SalesDocumentScheduleLine (SalesDocument, SalesDocumentItem, ScheduleLine)
  VALUES (1, 1, 1), (1, 1, 2), (1, 2, 1), (1, 2, 2), (2, 1, 1), (2, 1, 2), (2, 2, 1), (2, 2, 2);

  INSERT INTO edw.dim_Route (ROUTEID)
  VALUES (1), (2);

  INSERT INTO edw.dim_Customer (CustomerID)
  VALUES (1), (2);

  INSERT INTO edw.fact_SalesDocumentItem (
    sk_fact_SalesDocumentItem,
    -- nk_fact_SalesDocumentItem,
    SalesDocument,
    SalesDocumentItem,
    CurrencyTypeID,
    t_applicationId
  )
  VALUES
    ( 0, 1, 1, 10, 's4h-ca'),
    ( 1, 1, 1, 20, 's4h-ca'),
    ( 2, 1, 1, 30, 's4h-ca'),
    ( 3, 1, 2, 10, 's4h-ca'),
    ( 4, 1, 2, 20, 's4h-ca'),
    ( 5, 1, 2, 30, 's4h-ca'),
    ( 6, 2, 1, 10, 's4h-ca'),
    ( 7, 2, 1, 20, 's4h-ca'),
    ( 8, 2, 1, 30, 's4h-ca'),
    ( 9, 2, 2, 10, 's4h-ca'),
    (10, 2, 2, 20, 's4h-ca'),
    (11, 2, 2, 30, 's4h-ca');

  -- Act: 
  SELECT
    nk_fact_OutboundDeliveryItem
  INTO actual
  FROM [edw].[vw_OutboundDeliveryItem_s4h]
  GROUP BY
    nk_fact_OutboundDeliveryItem
  HAVING COUNT(*) > 1

  -- Assert:
  EXEC tSQLt.AssertEmptyTable 'actual';
END;
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
