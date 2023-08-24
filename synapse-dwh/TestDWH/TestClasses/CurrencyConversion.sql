-- Write your own SQL object definition here, and it'll be included in your package.
EXEC [tSQLt].[SetFakeViewOn] 'edw';
GO

EXEC tSQLt.NewTestClass 'CurrencyConversion';
GO


CREATE PROCEDURE [CurrencyConversion].[test edw.vw_StockPricePerUnit]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('tempdb..#vw_CurrencyConversionRate') IS NOT NULL DROP TABLE #vw_CurrencyConversionRate;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[MBEWH]';
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_Purreqvaluationarea]';
  EXEC tSQLt.FakeTable '[edw]', '[dim_CompanyCode]';
  EXEC tSQLt.FakeTable '[edw]', '[vw_CurrencyConversionRate]';

  INSERT INTO base_s4h_cax.MBEWH (
    MATNR, --ProductID,
    BWKEY, --ValuationAreaID,
    BWTAR, --ValuationTypeID,
    LFGJA, --FiscalYearPeriod,
    LFMON, --FiscalMonthPeriod,
    VPRSV, --PriceControlIndicatorID
    PEINH, --PriceUnit
    STPRS, --StandardPrice,
    VERPR  --PeriodicUnitPrice
  )
  VALUES
    (1, 1, 1, 2022, 12, 'S', 100, 1000, NULL),
    (1, 1, 1, 2022, 12, 'V', 100, NULL, 1100),
    -- (1, 1, 1, 2023, 12, 'S', 100, 2000, NULL),
    -- (1, 1, 1, 2023, 12, 'V', 100, NULL, 2200),
    (1, 2, 1, 2022, 12, 'S', 400, 2000, NULL),
    (1, 2, 1, 2022, 12, 'V', 400, NULL, 2200);
    -- (1, 2, 1, 2023, 12, 'S', 100, 2000, NULL),
    -- (1, 2, 1, 2023, 12, 'V', 100, NULL, 2200);

  INSERT INTO base_s4h_cax.I_Purreqvaluationarea (ValuationArea, CompanyCode)
  VALUES (1, 1), (2, 2);
  INSERT INTO edw.dim_CompanyCode (CompanyCodeID, Currency)
  VALUES (1, 'EUR'), (2, 'PLN');

  SELECT TOP(0) *
  INTO #vw_CurrencyConversionRate
  FROM edw.vw_CurrencyConversionRate;

  -- #2
  INSERT INTO #vw_CurrencyConversionRate (SourceCurrency, CurrencyTypeID, ExchangeRate)
  VALUES
    ('EUR', '30', 1.0),
    ('EUR', '40', 0.9),
    ('PLN', '30', 5),
    ('PLN', '40', 4);

  EXEC ('INSERT INTO edw.vw_CurrencyConversionRate SELECT * FROM #vw_CurrencyConversionRate');

  -- Act: 
  SELECT
    ProductID,
    ValuationAreaID,
    ValuationTypeID,
    FiscalYearPeriod,
    FiscalMonthPeriod,
    CurrencyID,
    ExchangeRate_EUR,
    ExchangeRate_USD,
    PriceControlIndicatorID,
    StockPricePerUnit,
    StockPricePerUnit_EUR,
    StockPricePerUnit_USD
  INTO actual
  FROM [edw].[vw_StockPricePerUnit]

  -- Assert:
  CREATE TABLE expected (
    ProductID NVARCHAR(40) collate Latin1_General_100_BIN2,
    ValuationAreaID NVARCHAR(4) collate Latin1_General_100_BIN2,
    ValuationTypeID NVARCHAR(10) collate Latin1_General_100_BIN2,
    FiscalYearPeriod CHAR(4) collate Latin1_General_100_BIN2,
    FiscalMonthPeriod CHAR(2) collate Latin1_General_100_BIN2,
    CurrencyID CHAR(5) collate Latin1_General_100_BIN2,
    ExchangeRate_EUR numeric(15, 6),
    ExchangeRate_USD numeric(15, 6),
    PriceControlIndicatorID NVARCHAR(1) collate Latin1_General_100_BIN2,
    StockPricePerUnit DECIMAL(11, 2),
    StockPricePerUnit_EUR DECIMAL(11, 2),
    StockPricePerUnit_USD DECIMAL(11, 2)
  );
  INSERT INTO expected (
    ProductID,
    ValuationAreaID,
    ValuationTypeID,
    FiscalYearPeriod,
    FiscalMonthPeriod,
    CurrencyID,
    ExchangeRate_EUR,
    ExchangeRate_USD,
    PriceControlIndicatorID,
    StockPricePerUnit,
    StockPricePerUnit_EUR,
    StockPricePerUnit_USD
  )
  VALUES
    (1, 1, 1, 2022, 12, 'EUR', 1, 0.9, 'S', 10, 10, 9.0),
    (1, 1, 1, 2022, 12, 'EUR', 1, 0.9, 'V', 11, 11, 9.9),
    (1, 2, 1, 2022, 12, 'PLN', 5, 4, 'S', 5, 25, 20),
    (1, 2, 1, 2022, 12, 'PLN', 5, 4, 'V', 5.5, 27.5, 22);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO



-- CREATE PROCEDURE [CurrencyConversion].[test edw.vw_OutboundDeliveryItem_s4h: uniqueness]
-- AS
-- BEGIN

--   IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
--   -- IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

--   -- Assemble: Fake Table
--   EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_OutboundDeliveryItem]';
--   EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_OutboundDelivery]';
--   EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_SDDocumentCompletePartners]';
--   EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_Supplier]';
--   EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_SalesDocumentScheduleLine]';
--   EXEC tSQLt.FakeTable '[edw]', '[dim_Route]';
--   EXEC tSQLt.FakeTable '[edw]', '[dim_Customer]';
--   EXEC tSQLt.FakeTable '[edw]', '[fact_SalesDocumentItem]';

--   INSERT INTO base_s4h_cax.I_OutboundDeliveryItem (OutboundDelivery, OutboundDeliveryItem)
--   VALUES (1, 1), (1, 2), (2, 1), (2, 2);

--   INSERT INTO base_s4h_cax.I_OutboundDelivery (OutboundDelivery, SoldToParty, ActualDeliveryRoute, ProposedDeliveryRoute)
--   VALUES (1, 1, 1, 1), (2, 2, 2, 2);

--   INSERT INTO base_s4h_cax.I_SDDocumentCompletePartners (SDDocument, SDDocumentItem, PartnerFunction, Supplier)
--   VALUES
--     (1, 1, 'XX', 1),
--     (1, 000000, 'SP', 1), -- SDDocumentItem is always 000000 for PartnerFunction SP (Delivery Agent)
--     (1, 2, 'XX', 1),
--     (2, 1, 'XX', 1),
--     (2, 000000, 'SP', 1),
--     (2, 2, 'XX', 1);

--   INSERT INTO base_s4h_cax.I_Supplier (Supplier)
--   VALUES (1), (2);

--   INSERT INTO base_s4h_cax.I_SalesDocumentScheduleLine (SalesDocument, SalesDocumentItem, ScheduleLine)
--   VALUES (1, 1, 1), (1, 1, 2), (1, 2, 1), (1, 2, 2), (2, 1, 1), (2, 1, 2), (2, 2, 1), (2, 2, 2);

--   INSERT INTO edw.dim_Route (ROUTEID)
--   VALUES (1), (2);

--   INSERT INTO edw.dim_Customer (CustomerID)
--   VALUES (1), (2);

--   INSERT INTO edw.fact_SalesDocumentItem (
--     sk_fact_SalesDocumentItem,
--     -- nk_fact_SalesDocumentItem,
--     SalesDocument,
--     SalesDocumentItem,
--     CurrencyTypeID,
--     t_applicationId
--   )
--   VALUES
--     ( 0, 1, 1, 10, 's4h-ca'),
--     ( 1, 1, 1, 20, 's4h-ca'),
--     ( 2, 1, 1, 30, 's4h-ca'),
--     ( 3, 1, 2, 10, 's4h-ca'),
--     ( 4, 1, 2, 20, 's4h-ca'),
--     ( 5, 1, 2, 30, 's4h-ca'),
--     ( 6, 2, 1, 10, 's4h-ca'),
--     ( 7, 2, 1, 20, 's4h-ca'),
--     ( 8, 2, 1, 30, 's4h-ca'),
--     ( 9, 2, 2, 10, 's4h-ca'),
--     (10, 2, 2, 20, 's4h-ca'),
--     (11, 2, 2, 30, 's4h-ca');

--   -- Act: 
--   SELECT
--     nk_fact_OutboundDeliveryItem
--   INTO actual
--   FROM [edw].[vw_OutboundDeliveryItem_s4h]
--   GROUP BY
--     nk_fact_OutboundDeliveryItem
--   HAVING COUNT(*) > 1

--   -- Assert:
--   EXEC tSQLt.AssertEmptyTable 'actual';
-- END;
-- GO

-- CREATE PROCEDURE [CurrencyConversion].[test dm_sales.vw_fact_OutboundDeliveryItem: uniqueness]
-- AS
-- BEGIN

--   IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
--   -- IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

--   -- Assemble: Fake Table
--   EXEC tSQLt.FakeTable '[edw]', '[fact_OutboundDeliveryItem]';
--   EXEC tSQLt.FakeTable '[edw]', '[dim_SDDocumentCategory]';
--   EXEC tSQLt.FakeTable '[edw]', '[dim_MaterialGroup]';
--   EXEC tSQLt.FakeTable '[edw]', '[dim_SalesDocumentItemCategory]';
--   EXEC tSQLt.FakeTable '[edw]', '[dim_DeliveryDocumentType]';
--   EXEC tSQLt.FakeTable '[edw]', '[dim_SalesDocumentItemType]';
--   EXEC tSQLt.FakeTable '[edw]', '[dim_DistributionChannel]';
--   EXEC tSQLt.FakeTable '[edw]', '[dim_SDProcessStatus]';

--   INSERT INTO edw.dim_SDDocumentCategory (SDDocumentCategoryID, SDDocumentCategory)
--   VALUES (1, 'text1'), (2, 'text2');

--   INSERT INTO edw.dim_MaterialGroup (MaterialGroupID, MaterialGroup)
--   VALUES (1, 'text1'), (2, 'text2');

--   INSERT INTO edw.dim_SalesDocumentItemCategory (SalesDocumentItemCategoryID, SalesDocumentItemCategory)
--   VALUES (1, 'text1'), (2, 'text2');

--   INSERT INTO edw.dim_DeliveryDocumentType (DeliveryDocumentTypeID, DeliveryDocumentType)
--   VALUES (1, 'text1'), (2, 'text2');

--   INSERT INTO edw.dim_SalesDocumentItemType (SalesDocumentItemTypeID, SalesDocumentItemType)
--   VALUES (1, 'text1'), (2, 'text2');

--   INSERT INTO edw.dim_DistributionChannel (DistributionChannelID, DistributionChannel)
--   VALUES (1, 'text1'), (2, 'text2');

--   INSERT INTO edw.dim_SDProcessStatus (SDProcessStatusID, SDProcessStatus)
--   VALUES (1, 'text1'), (2, 'text2');

--   INSERT INTO edw.fact_OutboundDeliveryItem (
--     sk_fact_OutboundDeliveryItem,
--     ReferenceSDDocumentCategoryID,
--     ProductGroupID,
--     DeliveryDocumentItemCategoryID,
--     HDR_DeliveryDocumentTypeID,
--     SalesDocumentItemTypeID,
--     DistributionChannelID,
--     SDProcessStatusID
--   )
--   VALUES
--     (0, 1, 1, 1, 1, 1, 1, 1),
--     (1, 1, 1, 1, 1, 1, 1, 1),
--     (2, 2, 2, 2, 2, 2, 2, 2),
--     (3, 2, 2, 2, 2, 2, 2, 2);

--   -- Act: 
--   SELECT
--     sk_fact_OutboundDeliveryItem
--   INTO actual
--   FROM [dm_sales].[vw_fact_OutboundDeliveryItem]
--   GROUP BY
--     sk_fact_OutboundDeliveryItem
--   HAVING COUNT(*) > 1

--   -- Assert:
--   EXEC tSQLt.AssertEmptyTable 'actual';
-- END;
-- GO


EXEC [tSQLt].[SetFakeViewOff] 'edw';

GO