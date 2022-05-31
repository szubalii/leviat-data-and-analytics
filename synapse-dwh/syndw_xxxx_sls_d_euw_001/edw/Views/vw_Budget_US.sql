CREATE VIEW [edw].[vw_Budget_US]
AS

WITH EuroBudgetExchangeRate AS (
    SELECT 
        SourceCurrency
    ,   ExchangeRateEffectiveDate
    ,   ExchangeRate
    FROM 
        edw.dim_ExchangeRates
    WHERE 
        ExchangeRateType = 'ZAXBIBUD'
        AND
        TargetCurrency = 'EUR'
)
,BudgetBase_US as (
    SELECT
        CONCAT_WS(
            '¦',
            docBud.[SalesOrganizationID],
            docBud.[MaterialID],
            docBud.[InvoiceDate]
        ) AS [nk_fact_Budget_US]
    ,   docBud.[InvoiceDate] AS [BillingDocumentDate]
    ,   CONCAT('US-',docBud.[SalesOrganizationID]) AS [SalesOrganizationID]
    ,   docBud.[NetAmount]
    ,   docBud.[Currency] AS [TransactionCurrencyID]
    ,   docBud.[Currency] AS [CurrencyID]
    ,   docBud.[InvoiceDate] AS [AccountingDate]
    ,   CONCAT(docBud.[SalesOrganizationID],'-',docBud.[MaterialID]) AS [MaterialCalculated]
    ,   COMP.[CompName] AS [SalesOrgname]
    ,   ProductGroup.[CAProductGroupName] AS [MaterialLongDescription]
    ,   ProductGroup.[CAProductGroupName] AS [MaterialShortDescription]
    ,   docBud.[t_applicationId] AS [t_applicationId]
    from 
        [base_ff_USA].[Budget] docBud
    LEFT JOIN 
        [base_us_leviat_db].[COMPANIES] COMP
            ON
                COMP.[COMP] = docBud.[SalesOrganizationID]
    LEFT JOIN
        [base_ff_USA].[DummyMaterial] material
            ON
                material.MaterialID = docBud.MaterialID
    LEFT JOIN
        [base_ff_USA].[CAProductGroup] ProductGroup
            ON
                material.CAProductGroupID = ProductGroup.[CAProductGroupID]
),

/*
    Euro currency data from US
*/
BudgetGroupCurrency
AS
(
SELECT
    Budget_US_ExchangeRate_Date.[nk_fact_Budget_US],
    CT.[CurrencyTypeID]                   AS [CurrencyTypeID],
    CT.[CurrencyType]                     AS [CurrencyType],
    Budget_US_ExchangeRate_Date.[CurrencyID],
    EuroBudgetExchangeRate.[ExchangeRate] AS [ExchangeRate],
    Budget_US_ExchangeRate_Date.[BillingDocumentDate],
    Budget_US_ExchangeRate_Date.[SalesOrganizationID],
    CONVERT(decimal(28,12),(Budget_US_ExchangeRate_Date.[NetAmount]*EuroBudgetExchangeRate.[ExchangeRate])) AS [NetAmount],
    Budget_US_ExchangeRate_Date.[TransactionCurrencyID],
    Budget_US_ExchangeRate_Date.[AccountingDate],
    Budget_US_ExchangeRate_Date.[MaterialCalculated],
    Budget_US_ExchangeRate_Date.[SalesOrgname],
    Budget_US_ExchangeRate_Date.[MaterialLongDescription],
    Budget_US_ExchangeRate_Date.[MaterialShortDescription],
    Budget_US_ExchangeRate_Date.[t_applicationId]
FROM 
(SELECT
    Budg_US.[nk_fact_Budget_US],
    'EUR'                           AS [CurrencyID],
    Budg_US.[BillingDocumentDate],
    Budg_US.[SalesOrganizationID],
    Budg_US.[NetAmount],
    Budg_US.[TransactionCurrencyID],
    Budg_US.[AccountingDate],
    Budg_US.[MaterialCalculated],
    Budg_US.[SalesOrgname],
    Budg_US.[MaterialLongDescription],
    Budg_US.[MaterialShortDescription],
    Budg_US.[t_applicationId],
    MAX(EuroBudgetExchangeRate.ExchangeRateEffectiveDate) AS [ExchangeRateEffectiveDate]
FROM
    BudgetBase_US Budg_US
LEFT JOIN 
    EuroBudgetExchangeRate
        ON EuroBudgetExchangeRate.SourceCurrency = 'USD'
WHERE
           EuroBudgetExchangeRate.ExchangeRateEffectiveDate <= Budg_US.[BillingDocumentDate]
GROUP BY
    Budg_US.[nk_fact_Budget_US],
    Budg_US.[BillingDocumentDate],
    Budg_US.[SalesOrganizationID],
    Budg_US.[NetAmount],
    Budg_US.[TransactionCurrencyID],
    Budg_US.[AccountingDate],
    Budg_US.[MaterialCalculated],
    Budg_US.[SalesOrgname],
    Budg_US.[MaterialLongDescription],
    Budg_US.[MaterialShortDescription],
    Budg_US.[t_applicationId]
) Budget_US_ExchangeRate_Date 
LEFT JOIN 
    EuroBudgetExchangeRate
    ON
        EuroBudgetExchangeRate.[SourceCurrency] = 'USD'
        AND
        Budget_US_ExchangeRate_Date.[ExchangeRateEffectiveDate] = EuroBudgetExchangeRate.[ExchangeRateEffectiveDate]
CROSS JOIN
     [edw].[dim_CurrencyType] CT
WHERE CT.[CurrencyTypeID] = '30'
)

/*
    Local currency data from US
*/

SELECT
    Budg_US.[nk_fact_Budget_US],
    CT.[CurrencyTypeID]             AS [CurrencyTypeID],
    CT.[CurrencyType]               AS [CurrencyType],
    Budg_US.[CurrencyID]            AS [CurrencyID],
    1.0                             AS [ExchangeRate],
    Budg_US.[BillingDocumentDate],
    Budg_US.[SalesOrganizationID],
    Budg_US.[NetAmount],
    Budg_US.[TransactionCurrencyID],
    Budg_US.[NetAmount] AS [FinNetAmount],
    Budg_US.[AccountingDate],
    Budg_US.[MaterialCalculated],
    Budg_US.[SalesOrgname],
    Budg_US.[MaterialLongDescription],
    Budg_US.[MaterialShortDescription],
    Budg_US.[NetAmount] AS [FinSales100],
    Budg_US.[t_applicationId]
FROM BudgetBase_US Budg_US
CROSS JOIN
     [edw].[dim_CurrencyType] CT
WHERE CT.[CurrencyTypeID] = '10'

UNION ALL

SELECT
    BGC.[nk_fact_Budget_US],
    BGC.[CurrencyTypeID],
    BGC.[CurrencyType],
    BGC.[CurrencyID],
    BGC.[ExchangeRate],
    BGC.[BillingDocumentDate],
    BGC.[SalesOrganizationID],
    BGC.[NetAmount],
    BGC.[TransactionCurrencyID],
    BGC.[NetAmount] AS [FinNetAmount],
    BGC.[AccountingDate],
    BGC.[MaterialCalculated],
    BGC.[SalesOrgname],
    BGC.[MaterialLongDescription],
    BGC.[MaterialShortDescription],
    BGC.[NetAmount] AS [FinSales100],
    BGC.[t_applicationId]
FROM 
    BudgetGroupCurrency BGC

UNION ALL

SELECT
    Budg_US.[nk_fact_Budget_US],
    CT.[CurrencyTypeID]             AS [CurrencyTypeID],
    CT.[CurrencyType]               AS [CurrencyType],
    Budg_US.[CurrencyID]            AS [CurrencyID],
    1.0                             AS [ExchangeRate],
    Budg_US.[BillingDocumentDate],
    Budg_US.[SalesOrganizationID],
    Budg_US.[NetAmount],
    Budg_US.[TransactionCurrencyID],
    Budg_US.[NetAmount] AS [FinNetAmount],
    Budg_US.[AccountingDate],
    Budg_US.[MaterialCalculated],
    Budg_US.[SalesOrgname],
    Budg_US.[MaterialLongDescription],
    Budg_US.[MaterialShortDescription],
    Budg_US.[NetAmount] AS [FinSales100],
    Budg_US.[t_applicationId]
FROM BudgetBase_US Budg_US
CROSS JOIN
     [edw].[dim_CurrencyType] CT
WHERE CT.[CurrencyTypeID] = '40'

