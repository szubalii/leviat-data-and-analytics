CREATE PROCEDURE [tc.edw.vw_dim_ProductValuationPUP_LatestStockPrice].[test latest stock price]
AS
BEGIN

  IF OBJECT_ID('actual') IS NOT NULL DROP TABLE actual;
  IF OBJECT_ID('expected') IS NOT NULL DROP TABLE expected;

  -- Assemble: Fake Table
  EXEC tSQLt.FakeTable '[edw]', '[dim_ProductValuationPUP]';

  INSERT INTO edw.dim_ProductValuationPUP (
    ValuationTypeID
  , ValuationAreaID
  , ProductID
  , FirstDayOfMonthDate
  , StockPricePerUnit
  )
  VALUES
    ('TypeA', 'ArA', 'ProductA', '2023-01-01', 10),
    ('TypeA', 'ArA', 'ProductA', '2023-02-01', 20),
    ('TypeA', 'ArA', 'ProductB', '2023-01-01',  5),
    ('TypeA', 'ArA', 'ProductB', '2023-02-01', 10),
    ('TypeA', 'ArB', 'ProductA', '2023-01-01', 15),
    ('TypeA', 'ArB', 'ProductA', '2023-02-01', 10),
    ('TypeB', 'ArA', 'ProductA', '2023-01-01', 10),
    ('TypeB', 'ArA', 'ProductA', '2023-02-01', 10);

  -- Act: 
  SELECT
    ValuationTypeID
  , ValuationAreaID
  , ProductID
  , FirstDayOfMonthDate
  , LatestStockPricePerUnit
  INTO actual
  FROM [edw].[vw_dim_ProductValuationPUP_LatestStockPrice]

  -- Assert:
  SELECT TOP(0) *
  INTO expected
  FROM actual;
  
  INSERT INTO expected (
    ValuationTypeID
  , ValuationAreaID
  , ProductID
  , FirstDayOfMonthDate
  , LatestStockPricePerUnit
  )
  VALUES
    ('TypeA', 'ArA', 'ProductA', '2023-02-01', 20),
    ('TypeA', 'ArA', 'ProductB', '2023-02-01', 10),
    ('TypeA', 'ArB', 'ProductA', '2023-02-01', 10),
    ('TypeB', 'ArA', 'ProductA', '2023-02-01', 10);

  EXEC tSQLt.AssertEqualsTable 'expected', 'actual';
END;
