CREATE PROCEDURE [tc.edw.vw_ProductValuation].[test CurrencyConversion]
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
    CurrencyID nchar(5), -- collate Latin1_General_100_BIN2,
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
