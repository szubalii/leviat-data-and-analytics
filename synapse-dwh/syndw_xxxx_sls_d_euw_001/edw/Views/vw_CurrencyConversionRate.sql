CREATE VIEW [edw].[vw_CurrencyConversionRate]
AS
WITH AllRates AS (
    SELECT 
        [SourceCurrency]
        ,[TargetCurrency]
        ,[ExchangeRate]
        ,ROW_NUMBER() OVER (
            PARTITION BY [SourceCurrency]
            ORDER BY [ExchangeRateEffectiveDate] DESC
        )   AS rn
    FROM 
        edw.dim_ExchangeRates
    WHERE
        [ExchangeRateType] = 'P'
        AND [TargetCurrency] = 'EUR'
        AND [ExchangeRateEffectiveDate] < GETDATE()
                            UNION ALL
    SELECT                              -- we don't have EUR2EUR rates for P type
        'EUR'
        ,'EUR'
        , 1.0
        , 1
)

SELECT 
    [SourceCurrency]
    ,[TargetCurrency]
    ,[ExchangeRate]
    , '30' AS CurrencyTypeID
FROM 
    AllRates
WHERE rn = 1

        UNION ALL

SELECT [SourceCurrency]
    , [SourceCurrency]
    , 1.0
    , '10'
FROM 
    edw.dim_ExchangeRates
GROUP BY
    [SourceCurrency]

        UNION ALL

SELECT [SourceCurrency]
    , [SourceCurrency]
    , 1.0
    , '00'
FROM 
    edw.dim_ExchangeRates
GROUP BY
    [SourceCurrency]

        UNION ALL
        
SELECT other_currency.SourceCurrency
    , 'USD'
    , other_currency.ExchangeRate/rate2usd.ExchangeRate
    , '40'
FROM AllRates other_currency
CROSS JOIN AllRates rate2usd
WHERE rate2usd.SourceCurrency = 'USD'
    AND other_currency.SourceCurrency <> 'USD'
    AND other_currency.rn = 1
    AND rate2usd.rn = 1

        UNION ALL

SELECT 'USD'
    , 'USD'
    , 1.0
    , '40'