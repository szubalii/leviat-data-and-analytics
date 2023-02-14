-- This view is obsolete
CREATE VIEW [edw].[vw_BillingBudget]
AS
WITH BillingBudgetBase_axbi AS (

    SELECT
        docBud.[DW_Id]                          AS [BillingDocument]
    ,   '00010'                                 AS [BillingDocumentItem]
    ,   DA.[LOCALCURRENCY]                      AS [LOCALCURRENCY]
    ,   CASE
            WHEN docBud.[BudgetEUR] <> 0
            THEN docBud.[Budget] / docBud.[BudgetEUR]
            ELSE 0
        END                                     AS [ExchangeRate]
    ,   docBud.[Accountingdate]                 AS [BillingDocumentDate]
    ,   CASE
            WHEN SO.[target_SalesOrganizationID] is not null
            THEN SO.[target_SalesOrganizationID]
            ELSE docBud.[Company]
        END                                     AS [SalesOrganizationID]
    ,   SINMT.[SAPProductID]                    AS [Material]
    ,   DA.[COUNTRYID]                          AS [CountryID]
    ,   'ZZZ_BUD_AXBI'                          AS [SoldToParty]
    ,   docBud.[Budget]    -- [FinSales100]
    ,   docBud.[BudgetEUR] -- [FinSales100]
    ,   docBud.[Accountingdate]                 AS [AccountingDate]
    ,   docBud.[Year]
    ,   docBud.[Month]
    ,   FORMAT(docBud.[Accountingdate], 'yyyyMM')
                                                AS [YearMonth]
    ,   docBud.[Company]                        AS [axbi_DataAreaID]
    ,   DA.[NAME]                               AS [axbi_DataAreaName]
    ,   DA.[GROUP]                              AS [axbi_DataAreaGroup]
    ,   docBud.[Itemno]                         AS [axbi_MaterialID]
    ,   docBud.[Customerno]                     AS [axbi_CustomerID]
    ,   CASE
            WHEN SO.IsMigrated = 'Y'
            THEN SINMT.[SAPProductID]
            ELSE docBud.[Itemno]
        END                                     AS [MaterialCalculated]
    ,   'ZZZDUMMY_BUD_AXBI'                     AS [SoldToPartyCalculated]
    ,   docBud.[Inside_Outside]                 AS [InOutID]
    ,   docBud.[t_applicationId]                AS [t_applicationId]
    ,   docBud.[t_extractionDtm]                AS [t_extractionDtm]
    FROM intm_axbi.vw_FACT_HGPLUM docBud
    LEFT JOIN
       [map_AXBI].[SalesOrganization] AS SO
       ON
           docBud.[Company] = SO.[source_DataAreaID]
           and
           [target_SalesOrganizationID] != 'TBD'
    LEFT JOIN [base_tx_ca_0_hlp].[DATAAREA] DA
        ON
            DA.[DATAAREAID] = docBud.[Company]
    LEFT JOIN
       [edw].[dim_SAPItemNumberBasicMappingTable] AS SINMT
       ON
           docBud.[Itemno] = SINMT.[AXItemnumber]
           AND
            (
                (DA.[GROUP] = 'HALFEN' and [AXDataAreaId] = '0000') or (DA.[GROUP] <> 'HALFEN' and 1 = 1)
                )
            AND
           [Migrate] IN ('Y', 'D')
)

/*
    Local currency data from AX BI
*/

SELECT
    axbi10.[BillingDocument],
    axbi10.[BillingDocumentItem],
    CT.[CurrencyTypeID]    AS [CurrencyTypeID],
    CT.[CurrencyType]      AS [CurrencyType],
    axbi10.[LOCALCURRENCY] AS [CurrencyID],
    1.0                    AS [ExchangeRate],
    axbi10.[BillingDocumentDate],
    axbi10.[SalesOrganizationID],
    axbi10.[Material],
    axbi10.[SoldToParty],
    axbi10.[CountryID],
    axbi10.[Budget]         AS [FinSales100],
    axbi10.[AccountingDate],
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
FROM BillingBudgetBase_axbi axbi10
CROSS JOIN
     [edw].[dim_CurrencyType] CT
WHERE CT.[CurrencyTypeID] = '10'

UNION ALL
/*
    Euro currency data from AX BI
*/
SELECT
    axbi30.[BillingDocument],
    axbi30.[BillingDocumentItem],
    CT.[CurrencyTypeID] AS [CurrencyTypeID],
    CT.[CurrencyType]   AS [CurrencyType],
    'EUR'               AS [CurrencyID],
    axbi30.[ExchangeRate],
    axbi30.[BillingDocumentDate],
    axbi30.[SalesOrganizationID],
    axbi30.[Material],
    axbi30.[SoldToParty],
    axbi30.[CountryID],
    axbi30.[BudgetEUR]        AS [FinSales100],
    axbi30.[AccountingDate],
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
FROM BillingBudgetBase_axbi axbi30
CROSS JOIN
     [edw].[dim_CurrencyType] CT
WHERE CT.[CurrencyTypeID] = '30'