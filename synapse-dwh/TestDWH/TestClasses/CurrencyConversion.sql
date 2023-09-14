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
    (1, 2, 1, 2022, 12, 'S', 400, 2000, NULL),
    (1, 2, 1, 2022, 12, 'V', 400, NULL, 2200);

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



CREATE PROCEDURE [CurrencyConversion].[test edw.vw_ProductValuation]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('tempdb..#vw_CurrencyConversionRate') IS NOT NULL DROP TABLE #vw_CurrencyConversionRate;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[base_s4h_cax]', '[I_ProductValuation]';
  -- EXEC tSQLt.FakeTable '[edw]', '[dim_CurrencyType]';
  EXEC tSQLt.FakeTable '[edw]', '[vw_CurrencyConversionRate]';

  INSERT INTO base_s4h_cax.I_ProductValuation (
    Currency, StandardPrice, MovingAveragePrice, PriceUnitQty
  )
  VALUES ('PLN', 100, 50, 2), ('EUR', 10, 2, 2);

  -- INSERT INTO edw.dim_CurrencyType (CurrencyTypeID, CurrencyID)
  -- VALUES ('30', 'EUR');

  SELECT TOP(0) *
  INTO #vw_CurrencyConversionRate
  FROM edw.vw_CurrencyConversionRate;

  -- #2
  INSERT INTO #vw_CurrencyConversionRate (SourceCurrency, CurrencyTypeID, ExchangeRate)
  VALUES
    ('EUR', '30', 1.0),
    ('EUR', '40', 0.9),
    ('PLN', '30', 0.05),
    ('PLN', '40', 0.04);

  EXEC ('INSERT INTO edw.vw_CurrencyConversionRate SELECT * FROM #vw_CurrencyConversionRate');

  -- Act: 
  SELECT
    CurrencyID,
    StandardPricePerUnit,
    StandardPricePerUnit_EUR,
    MovingAvgPricePerUnit,
    MovingAvgPricePerUnit_EUR
  INTO actual
  FROM [edw].[vw_ProductValuation]

  -- Assert:
  CREATE TABLE expected (
    CurrencyID nchar(5) collate Latin1_General_100_BIN2,
    StandardPricePerUnit decimal(11, 2),
    StandardPricePerUnit_EUR decimal(11, 2),
    MovingAvgPricePerUnit decimal(11, 2),
    MovingAvgPricePerUnit_EUR decimal(11, 2)
  );
  INSERT INTO expected (
    CurrencyID,
    StandardPricePerUnit,
    StandardPricePerUnit_EUR,
    MovingAvgPricePerUnit,
    MovingAvgPricePerUnit_EUR
  )
  VALUES
    ('PLN', 50, 2.5, 25, 1.25),
    ('EUR',  5, 5.0,  1, 1);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
GO


EXEC [tSQLt].[SetFakeViewOff] 'edw';

GO