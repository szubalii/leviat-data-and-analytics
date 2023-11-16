CREATE VIEW [edw].[vw_Budget_axbi]
AS
WITH BudgetBase_axbi as (
    SELECT
        CONCAT_WS(
            '¦',
            docBud.[DATAAREAID],
            docBud.[INOUT],
            docBud.[DIM3DATAR],
            docBud.[ITEMID],
            CAST(docBud.[ACCOUNTINGDATE] AS DATE)
        ) AS [nk_fact_Budget]
    ,   DA.[LOCALCURRENCY] collate Latin1_General_100_BIN2                                                                             AS [LOCALCURRENCY]
    ,   CASE
            WHEN docBud.[BUDGETEUR] <> 0
                THEN docBud.[BUDGETLOC] / docBud.[BUDGETEUR]
            ELSE 0
        END                                                                                                                            AS [ExchangeRate]
    -- ,   docBud.[ACCOUNTINGDATE]                                                                                                        AS [AccountingDate]
    ,   CASE
            WHEN SO.[target_SalesOrganizationID] is not null
                THEN SO.[target_SalesOrganizationID]
            ELSE DA.[DATAAREAID]
        END                                                                                                                            AS [SalesOrganizationID]
    ,   'ZZZ_BUD_AXBI'                                                                                                                 AS [SoldToParty]
    ,   docBud.[BUDGETLOC]                                                                                                             AS [Budget]             -- [FinSales100]
    ,   docBud.[BUDGETEUR]                                                                                                             AS [BudgetEUR]-- [FinSales100]
    ,   docBud.[ACCOUNTINGDATE] AS AccountingDate
    ,   FORMAT(docBud.[ACCOUNTINGDATE], 'yyyy')                                                                                        AS [Year]
    ,   FORMAT(docBud.[ACCOUNTINGDATE], 'MM')                                                                                          AS [Month]
    ,   FORMAT(docBud.[ACCOUNTINGDATE], 'yyyyMM')                                                                                      AS [YearMonth]
    ,   docBud.[DATAAREAID]                                                                                                            AS [axbi_DataAreaID]
    ,   DA.[NAME]                                                                                                                      AS [axbi_DataAreaName]
    ,   DA.[GROUP]                                                                                                                     AS [axbi_DataAreaGroup]
    ,   docBud.[ITEMID]                                                                                                                AS [axbi_MaterialID]
    ,   NULL                                                                                                                           AS [axbi_CustomerID] -- no update yet
    ,   docBud.[ITEMID]                                                                                                                AS [MaterialCalculated] -- ?????
    ,   'ZZZDUMMY_BUD_AXBI'                                                                                                            AS [SoldToPartyCalculated]
    ,   edw.svf_getInOutID_axbi (INOUT)                                                                                                AS [InOutID]
    ,   docBud.[t_applicationId]                                                                                                       AS [t_applicationId]
    ,   docBud.[t_extractionDtm]                                                                                                       AS [t_extractionDtm]
    from [base_tx_ca_0_hlp].[BUDGET] docBud

        LEFT JOIN [base_tx_ca_0_hlp].[DATAAREA] DA
            ON
                DA.[DATAAREAID2] = docBud.[DATAAREAID]
        LEFT JOIN
               [map_AXBI].[SalesOrganization] AS SO
               ON
                   DA.[DATAAREAID] = SO.[source_DataAreaID]
                   and
                   [target_SalesOrganizationID] != 'TBD'
),
EuroBudgetExchangeRateUSD as (
    select
         TargetCurrency
        ,ExchangeRateEffectiveDate
        ,ExchangeRate
    from
        edw.dim_ExchangeRates
    where        
        ExchangeRateType = 'ZAXBIBUD'
        AND
        SourceCurrency = 'USD')

/*
    Local currency data from AX BI
*/

select
    axbi10.[nk_fact_Budget],
    CT.[CurrencyTypeID]    as [CurrencyTypeID],
    CT.[CurrencyType]      as [CurrencyType],
    axbi10.[LOCALCURRENCY] as [CurrencyID],
    1.0                    as [ExchangeRate],
    axbi10.[AccountingDate],
    axbi10.[SalesOrganizationID],
    axbi10.[SoldToParty],
    axbi10.[Budget]         as [FinSales100],
    axbi10.[Year],
    axbi10.[Month],
    axbi10.[YearMonth],
    axbi10.[axbi_DataAreaID],
    axbi10.[axbi_DataAreaName],
    axbi10.[axbi_DataAreaGroup],
    axbi10.[axbi_MaterialID],
    axbi10.[axbi_CustomerID],
    axbi10.[MaterialCalculated],
    axbi10.[SoldToPartyCalculated],
    axbi10.[InOutID],
    axbi10.[t_applicationId],
    axbi10.[t_extractionDtm]
FROM BudgetBase_axbi axbi10
CROSS JOIN
     [edw].[dim_CurrencyType] CT
WHERE CT.[CurrencyTypeID] = '10'

UNION ALL
/*
    Euro currency data from AX BI
*/
select
    axbi30.[nk_fact_Budget],
    CT.[CurrencyTypeID] as [CurrencyTypeID],
    CT.[CurrencyType]   as [CurrencyType],
    'EUR'               as [CurrencyID],
    axbi30.[ExchangeRate],
    axbi30.[AccountingDate],
    axbi30.[SalesOrganizationID],
    axbi30.[SoldToParty],
    axbi30.[BudgetEUR]        as [FinSales100],
    axbi30.[Year],
    axbi30.[Month],
    axbi30.[YearMonth],
    axbi30.[axbi_DataAreaID],
    axbi30.[axbi_DataAreaName],
    axbi30.[axbi_DataAreaGroup],
    axbi30.[axbi_MaterialID],
    axbi30.[axbi_CustomerID],
    axbi30.[MaterialCalculated],
    axbi30.[SoldToPartyCalculated],
    axbi30.[InOutID],
    axbi30.[t_applicationId],
    axbi30.[t_extractionDtm]
FROM BudgetBase_axbi axbi30
CROSS JOIN
     [edw].[dim_CurrencyType] CT
WHERE CT.[CurrencyTypeID] = '30'

UNION ALL
/*
    USD currency data from AX BI
*/
SELECT
    axbi40.[nk_fact_Budget],
    CT.[CurrencyTypeID] AS [CurrencyTypeID],
    CT.[CurrencyType]   AS [CurrencyType],
    'USD' AS [CurrencyID],
    1/EuroBudgetExchangeRateUSD.[ExchangeRate] AS [ExchangeRate],
    axbi40.[AccountingDate],
    axbi40.[SalesOrganizationID],
    axbi40.[SoldToParty],
    axbi40.[BudgetEUR]*(1/EuroBudgetExchangeRateUSD.[ExchangeRate]) AS [FinSales100],
    axbi40.[Year],
    axbi40.[Month],
    axbi40.[YearMonth],
    axbi40.[axbi_DataAreaID],
    axbi40.[axbi_DataAreaName],
    axbi40.[axbi_DataAreaGroup],
    axbi40.[axbi_MaterialID],
    axbi40.[axbi_CustomerID],
    axbi40.[MaterialCalculated],
    axbi40.[SoldToPartyCalculated],
    axbi40.[InOutID],
    axbi40.[t_applicationId],
    axbi40.[t_extractionDtm]
FROM
(SELECT
    axbiUSD.[nk_fact_Budget],
    axbiUSD.[AccountingDate],
    axbiUSD.[SalesOrganizationID],
    axbiUSD.[SoldToParty],
    axbiUSD.[BudgetEUR],
    axbiUSD.[Year],
    axbiUSD.[Month],
    axbiUSD.[YearMonth],
    axbiUSD.[axbi_DataAreaID],
    axbiUSD.[axbi_DataAreaName],
    axbiUSD.[axbi_DataAreaGroup],
    axbiUSD.[axbi_MaterialID],
    axbiUSD.[axbi_CustomerID],
    axbiUSD.[MaterialCalculated],
    axbiUSD.[SoldToPartyCalculated],
    axbiUSD.[InOutID],
    axbiUSD.[t_applicationId],
    axbiUSD.[t_extractionDtm],    
    MAX([ExchangeRateEffectiveDate]) as [ExchangeRateEffectiveDate]
FROM 
    BudgetBase_axbi axbiUSD
LEFT JOIN
  EuroBudgetExchangeRateUSD
      on
          EuroBudgetExchangeRateUSD.TargetCurrency = 'EUR'
where
  [ExchangeRateEffectiveDate] <= [AccountingDate]
group by
    axbiUSD.[nk_fact_Budget],
    axbiUSD.[AccountingDate],
    axbiUSD.[SalesOrganizationID],
    axbiUSD.[SoldToParty],
    axbiUSD.[BudgetEUR],
    axbiUSD.[Year],
    axbiUSD.[Month],
    axbiUSD.[YearMonth],
    axbiUSD.[axbi_DataAreaID],
    axbiUSD.[axbi_DataAreaName],
    axbiUSD.[axbi_DataAreaGroup],
    axbiUSD.[axbi_MaterialID],
    axbiUSD.[axbi_CustomerID],
    axbiUSD.[MaterialCalculated],
    axbiUSD.[SoldToPartyCalculated],
    axbiUSD.[InOutID],
    axbiUSD.[t_applicationId],
    axbiUSD.[t_extractionDtm]
) axbi40
left join
    EuroBudgetExchangeRateUSD
    ON
        EuroBudgetExchangeRateUSD.[TargetCurrency] = 'EUR'
        AND
        axbi40.[ExchangeRateEffectiveDate] = EuroBudgetExchangeRateUSD.[ExchangeRateEffectiveDate]
CROSS JOIN
    [edw].[dim_CurrencyType] CT
WHERE
    CT.[CurrencyTypeID] = '40'