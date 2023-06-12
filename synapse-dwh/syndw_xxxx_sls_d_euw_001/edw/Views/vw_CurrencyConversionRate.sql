CREATE VIEW [edw].[vw_CurrencyConversionRate]
AS
WITH MinDates AS (                                          -- get minimum date of rate for each currency
    SELECT 
        [SourceCurrency]
        ,MIN([ExchangeRateEffectiveDate]) AS MinDate
    FROM 
        edw.dim_ExchangeRates
    WHERE
        [ExchangeRateType] = 'P'
        and
        [TargetCurrency] = 'EUR'
    GROUP BY [SourceCurrency]
)
, OldRates AS (                                             -- leave only earlier rates using old source
    SELECT 
        ER.[SourceCurrency]
        ,[TargetCurrency]
        ,[ExchangeRateEffectiveDate]
        ,[ExchangeRate]
    FROM 
        edw.dim_ExchangeRates ER
    JOIN MinDates
        ON ER.SourceCurrency = MinDates.SourceCurrency
            AND ER.ExchangeRateEffectiveDate < MinDates.MinDate
    WHERE
        [ExchangeRateType] = 'ZAXBIBUD'
        and
        [TargetCurrency] = 'EUR'
)
, CombinedRates AS (                                        -- get all new rates and earlier rates from the old source
    SELECT
        [SourceCurrency]
        ,[TargetCurrency]
        ,[ExchangeRateEffectiveDate]
        ,[ExchangeRate]
    FROM 
        edw.dim_ExchangeRates
    WHERE
        [ExchangeRateType] = 'P'
        and
        [TargetCurrency] = 'EUR'
                                UNION ALL
    SELECT
        [SourceCurrency]
        ,[TargetCurrency]
        ,[ExchangeRateEffectiveDate]
        ,[ExchangeRate]
    FROM 
        OldRates
)
, AllRates AS (
    SELECT 
        [SourceCurrency]
        ,[TargetCurrency]
        ,[ExchangeRateEffectiveDate]
        , COALESCE(DATEADD(day, -1,LEAD([ExchangeRateEffectiveDate]) OVER (PARTITION BY [SourceCurrency],[TargetCurrency] ORDER BY [ExchangeRateEffectiveDate])),'9999-12-31') AS LastDay
        ,[ExchangeRate]
    FROM 
        CombinedRates
                            UNION ALL
    SELECT                              -- we don't have EUR2EUR rates for P type
        'EUR'
        ,'EUR'
        , CAST('1900-01-01' AS date)
        , CAST('9999-12-31' AS date)
        , 1.0
)

SELECT 
    [SourceCurrency]
    ,[TargetCurrency]
    ,[ExchangeRateEffectiveDate]
    ,[LastDay]
    ,[ExchangeRate]
    , 30 AS CurrencyTypeID
FROM 
    AllRates

        UNION ALL

SELECT [SourceCurrency]
    , [SourceCurrency]
    , CAST('1900-01-01' AS date)
    , CAST('9999-12-31' AS date)
    , 1.0
    , 10
FROM 
    edw.dim_ExchangeRates
GROUP BY
    [SourceCurrency]

        UNION ALL
        
SELECT other_currency.SourceCurrency
    , 'USD'
    , CASE
        WHEN rate2usd.ExchangeRateEffectiveDate > other_currency.ExchangeRateEffectiveDate
            THEN rate2usd.ExchangeRateEffectiveDate
        ELSE other_currency.ExchangeRateEffectiveDate
    END         -- substitute for GREATEST function
    , CASE
        WHEN rate2usd.LastDay < other_currency.LastDay
            THEN rate2usd.LastDay
        ELSE
            other_currency.LastDay
    END         -- substitute for LEAST function
    , other_currency.ExchangeRate/rate2usd.ExchangeRate
    , 40
FROM AllRates other_currency
INNER JOIN AllRates rate2usd
    ON rate2usd.ExchangeRateEffectiveDate BETWEEN other_currency.ExchangeRateEffectiveDate AND other_currency.LastDay
    OR other_currency.ExchangeRateEffectiveDate BETWEEN rate2usd.ExchangeRateEffectiveDate AND rate2usd.LastDay
WHERE rate2usd.SourceCurrency = 'USD'
    AND other_currency.SourceCurrency <> 'USD'

        UNION ALL

SELECT 'USD'
    , 'USD'
    , CAST('1900-01-01' AS date)
    , CAST('9999-12-31' AS date)
    , 1.0
    , 40