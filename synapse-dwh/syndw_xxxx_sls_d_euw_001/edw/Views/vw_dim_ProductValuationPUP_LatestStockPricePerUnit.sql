CREATE VIEW [edw].[vw_dim_ProductValuationPUP_LatestStockPrice]
AS

WITH OrderedStockPrice AS (
  SELECT
    ValuationTypeID
  , ValuationAreaID
  , ProductID
  , FirstDayOfMonthDate
  , StockPricePerUnit
  , StockPricePerUnit_EUR
  , StockPricePerUnit_USD
  , row_number() OVER (
      PARTITION BY
        ValuationTypeID,
        ValuationAreaID,
        ProductID
        ORDER BY FirstDayOfMonthDate DESC
    ) AS row_number
  FROM
    [edw].[dim_ProductValuationPUP]
)
SELECT
  ValuationTypeID
, ValuationAreaID
, ProductID
, FirstDayOfMonthDate
, StockPricePerUnit AS LatestStockPricePerUnit
, StockPricePerUnit_EUR AS LatestStockPricePerUnit_EUR
, StockPricePerUnit_USD AS LatestStockPricePerUnit_USD
FROM
  OrderedStockPrice
WHERE
  row_number = 1
