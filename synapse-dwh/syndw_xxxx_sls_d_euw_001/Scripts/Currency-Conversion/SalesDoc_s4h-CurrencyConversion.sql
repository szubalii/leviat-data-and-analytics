--Samples examples on CAP-100.
SELECT 
     CurrencyType
    ,CurrencyID
    ,ExchangeRate
    ,TransactionCurrencyID
    ,NetAmount

FROM edw.vw_SalesDocumentItem_s4h A

WHERE A.SalesDocument = '0020088135' --Different Currencies.
WHERE A.SalesDocument = '0020044818' --Same Currencies.

--Transaction Currency. We should not convert the values, and the ExchangeRate should be 1.
SELECT 
     DISTINCT(ExchangeRate)

FROM edw.vw_SalesDocumentItem_s4h A

WHERE CurrencyType = 'Transaction Currency'

--Local Currency. We shouldn't convert if the currencies match, if they don't they should be converted.
SELECT 
     DISTINCT(ExchangeRate)

FROM edw.vw_SalesDocumentItem_s4h A

WHERE CurrencyType = 'Local Currency'
AND TransactionCurrencyID = CompanyCodeCurrencyID

WITH LC AS(
SELECT
     A.SalesDocument
    ,A.SalesDocumentItem
    ,A.TransactionCurrencyID
    ,A.CurrencyID
    ,A.ExchangeRate AS ExchangeRateResult
    ,CCR.ExchangeRate
    ,A.PriceDetnExchangeRate
    ,A.PriceDetnExchangeRate * CCR.ExchangeRate AS ExchangeRateCheck

FROM edw.vw_SalesDocumentItem_s4h A 

    LEFT OUTER JOIN [edw].[vw_CurrencyConversionRate] CCR
    ON A.CompanyCodeCurrencyID = CCR.SourceCurrency
    AND CCR.CurrencyTypeID = '10'

WHERE A.CurrencyType = 'Local Currency'
AND TransactionCurrencyID <> CompanyCodeCurrencyID 
)

SELECT top 10 * 

FROM LC

WHERE ExchangeRateResult <> ExchangeRateCheck


--Group Currency EUR. 
--For Cases where the Transaction Currency is not equal to the Currency of the Company we expect to have an exchange rate that equals the result of the 
--PriceDetnExchangeRate and the ExchangeRate from CCR.

--For Cases where the transaction currency is equal to the currency of the compant we expect to have an exchange rate that equals the ExchangeRate from CCR.
WITH TCEqualsCC B AS(
SELECT
      A.SalesDocument
     ,A.SalesDocumentItem
     ,A.TransactionCurrencyID
     ,A.CurrencyID
     ,A.ExchangeRate AS ExchangeRateResult
     ,CCR.ExchangeRate
     ,A.PriceDetnExchangeRate
     ,A.PriceDetnExchangeRate * CCR.ExchangeRate AS ExchangeRateCheck

FROM edw.vw_SalesDocumentItem_s4h A 

    LEFT OUTER JOIN [edw].[vw_CurrencyConversionRate] CCR
    ON A.CompanyCodeCurrencyID = CCR.SourceCurrency
    AND CCR.CurrencyTypeID = '30'

WHERE A.CurrencyType = 'Group Currency EUR'
AND TransactionCurrencyID = CompanyCodeCurrencyID 
)

WITH TCNotEqualsCC AS(
SELECT
     A.SalesDocument
    ,A.SalesDocumentItem
    ,A.TransactionCurrencyID
    ,A.CurrencyID, A.ExchangeRate AS ExchangeRateResult
    ,CCR.ExchangeRate
    ,A.PriceDetnExchangeRate
    ,A.PriceDetnExchangeRate * CCR.ExchangeRate AS ExchangeRateCheck

FROM edw.vw_SalesDocumentItem_s4h A 

    LEFT OUTER JOIN [edw].[vw_CurrencyConversionRate] CCR
    ON A.CompanyCodeCurrencyID = CCR.SourceCurrency
    AND CCR.CurrencyTypeID = '30'

WHERE A.CurrencyType = 'Group Currency EUR'
AND TransactionCurrencyID <> CompanyCodeCurrencyID 
)

SELECT TOP 10 *

FROM TCEqualsCC

WHERE ExchangeRateCheck <> ExchangeRateResult

SELECT TOP 10 *

FROM TCNotEqualsCC 

WHERE ExchangeRateCheck <> ExchangeRateResult

--Group Currency USD
--For Cases where the Transaction Currency is not equal to the Currency of the Company we expect to have an exchange rate that equals the result of the 
--PriceDetnExchangeRate and the ExchangeRate from CCR.

--For Cases where the transaction currency is equal to the currency of the compant we expect to have an exchange rate that equals the ExchangeRate from CCR.
WITH TCEqualsCC AS(
SELECT
     A.SalesDocument
    ,A.SalesDocumentItem
    ,A.TransactionCurrencyID
    ,A.CurrencyID, A.ExchangeRate AS ExchangeRateResult
    ,CCR.ExchangeRate
    ,A.PriceDetnExchangeRate
    ,A.PriceDetnExchangeRate * CCR.ExchangeRate AS ExchangeRateCheck

FROM edw.vw_SalesDocumentItem_s4h A 

    LEFT OUTER JOIN [edw].[vw_CurrencyConversionRate] CCR
    ON A.CompanyCodeCurrencyID = CCR.SourceCurrency
    AND CCR.CurrencyTypeID = '40'

WHERE A.CurrencyType = 'Group Currency USD'
AND TransactionCurrencyID = CompanyCodeCurrencyID 
)

WITH TCENotEqualsCC AS(
SELECT
     A.SalesDocument
    ,A.SalesDocumentItem
    ,A.TransactionCurrencyID
    ,A.CurrencyID, A.ExchangeRate AS ExchangeRateResult
    ,CCR.ExchangeRate
    ,A.PriceDetnExchangeRate
    ,A.PriceDetnExchangeRate * CCR.ExchangeRate AS ExchangeRateCheck

FROM edw.vw_SalesDocumentItem_s4h A 

    LEFT OUTER JOIN [edw].[vw_CurrencyConversionRate] CCR
    ON A.CompanyCodeCurrencyID = CCR.SourceCurrency
    AND CCR.CurrencyTypeID = '40'

WHERE A.CurrencyType = 'Group Currency USD'
AND TransactionCurrencyID <> CompanyCodeCurrencyID 
)

SELECT TOP 10 *

FROM TCEqualsCC

WHERE ExchangeRateCheck <> ExchangeRateResult

SELECT TOP 10 *

FROM TCENotEqualsCC

WHERE ExchangeRateCheck <> ExchangeRateResult