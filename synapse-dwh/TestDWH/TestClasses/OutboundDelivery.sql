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

-- Test for duplicates in [dm_sales].[vw_fact_OutboundDeliveryItem]
CREATE PROCEDURE [OutboundDelivery].[test dm_sales.vw_fact_OutboundDeliveryItem composite key uniqueness]
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
  VALUES (200, CONVERT(BINARY(16),0x000D3A2775B31EECA598CFA2549EA269), 1, 1);
  
  INSERT INTO base_s4h_cax.I_FrtCostDistrItm
    (FrtCostDistrItmRefUUID, FrtCostDistrItemAmount, FrtCostDistrItemAmtCrcy)
  VALUES
    (CONVERT(BINARY(16),0x000D3A2775B31EECA598CFA2549EA269), 120, 'CHF')
    ,(CONVERT(BINARY(16),0x000D3A2775B31EECA598CFA2549EA269), 140, 'CHF')
    ,(CONVERT(BINARY(16),0x000D3A2775B31EECA598CFA2549DA269), 100, 'CHF');

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

-- Test for ConditionType filtration in [edw].[vw_fact_BillingDocumentItemFreight]
CREATE PROCEDURE [OutboundDelivery].[test edw.vw_fact_BillingDocumentItemFreight filter ConditionType]
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
    ,(1, 1, 'ZTFM', '10', 'CHF', 20)
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
GO

-- Test for Canceled document filtration in [edw].[vw_fact_BillingDocumentItemFreight]
CREATE PROCEDURE [OutboundDelivery].[test edw.vw_fact_BillingDocumentItemFreight filter Canceled]
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
    ,(4, 4, 1, 1, '10', '1', '1';
  
  -- Act: 
  SELECT
    @actual = COUNT(DISTINCT ReferenceSDDocument)
  FROM 
    [edw].[vw_fact_BillingDocumentItemFreight];
  
  -- Assert:

  EXEC tSQLt.AssertEquals @expected, @actual;
END;
GO

-- Test for CurrencyTypeID filtration in [edw].[vw_fact_BillingDocumentItemFreight]
CREATE PROCEDURE [OutboundDelivery].[test edw.vw_fact_BillingDocumentItemFreight filter CurrencyTypeID]
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
    (1, 1, 1, 1, '10')
    ,(2, 2, 1, 1, '00')
    ,(3, 3, 1, 1, '30')
    ,(4, 4, 1, 1, '40');
  
  -- Act: 
  SELECT
    @actual = COUNT(DISTINCT ReferenceSDDocument)
  FROM 
    [edw].[vw_fact_BillingDocumentItemFreight];
  
  -- Assert:

  EXEC tSQLt.AssertEquals @expected, @actual;
END;
GO

-- Test for sum logic in [edw].[vw_TransportationOrderItemFreightCost]
CREATE PROCEDURE [OutboundDelivery].[test edw.vw_TransportationOrderItemFreightCost sum logic]
AS
BEGIN
  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

   -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_TransportationOrderItem]';
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_FrtCostDistrItm]';
  
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
    ,(CONVERT(BINARY(16),0x000D3A2775B31EECA598CFA2549DA269), 100, 'EUR');
  
  -- Act: 
  SELECT
     TranspOrdDocReferenceID
    , TranspOrdDocReferenceItmID
    , FrtCostDistrItemAmount
    , FrtCostDistrItemAmtCrcy
  INTO actual
  FROM 
    [edw].[vw_TransportationOrderItemFreightCost];

  -- Fill expected

  INSERT INTO expected 
    (TranspOrdDocReferenceID, TranspOrdDocReferenceItmID, FrtCostDistrItemAmount, FrtCostDistrItemAmtCrcy)
  VALUES
    (1, 1, 260, 'CHF')
    , (2, 2, 100, 'EUR');
  
  -- Assert:

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO

EXEC [tSQLt].[SetFakeViewOff] 'edw';

GO
