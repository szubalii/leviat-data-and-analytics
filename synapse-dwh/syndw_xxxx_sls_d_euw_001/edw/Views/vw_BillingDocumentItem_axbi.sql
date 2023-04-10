﻿CREATE VIEW [edw].[vw_BillingDocumentItem_axbi]
AS
WITH
CustInvoiceTrans_without_quotes AS(
    SELECT
        CASE
            WHEN 
			    LEFT(CIT.[ITEMID], 1) = '"'
			    AND
                RIGHT(CIT.[ITEMID], 1) <> '"'
            THEN
			    SUBSTRING(CIT.[ITEMID], 2, LEN(CIT.[ITEMID]))
            WHEN
			    LEFT(CIT.[ITEMID], 1) = '"'
                AND
                RIGHT(CIT.[ITEMID], 1) = '"'
            THEN
			    SUBSTRING(CIT.[ITEMID], 2, LEN(CIT.[ITEMID]) - 2)
            WHEN
			    LEFT(CIT.[ITEMID], 1) <> '"'
                AND
                RIGHT(CIT.[ITEMID], 1) = '"'
            THEN
			    SUBSTRING(CIT.[ITEMID], 1, LEN(CIT.[ITEMID]) - 1)
            ELSE
                CIT.[ITEMID]
        END AS [ITEMID]
    ,   CIT.[INVOICEID]
    ,   CIT.[DATAAREAID]
    ,   CIT.[CUSTOMERNO]
    ,   CIT.[LINENUM]
    ,   CIT.ACCOUNTINGDATE
    ,   CIT.QTY
    ,   CIT.[PRODUCTSALESLOCAL]
    ,   CIT.[PRODUCTSALESEUR]
    ,   CIT.[COSTAMOUNTLOCAL]
    ,   CIT.[COSTAMOUNTEUR]
    ,   CIT.[DELIVERYCOUNTRYID]
    ,   CIT.[SALESID]
    ,   CIT.[OTHERSALESLOCAL]
    ,   CIT.[OTHERSALESEUR]
    ,   CIT.[ALLOWANCESLOCAL]
    ,   CIT.[ALLOWANCESEUR]
    ,   CIT.[t_applicationId]
    ,   CIT.[t_extractionDtm]
    FROM    
        [intm_axbi].[fact_CUSTINVOICETRANS] CIT
),
BillingDocumentItemBase_axbi AS (
    SELECT 
        DA.[DATAAREAID]                                       AS [DataAreaID]
    ,   [INVOICEID]                                           AS [BillingDocument]
    ,   RIGHT('00000' + CAST(CAST(CITQ.[LINENUM] as INT)      AS VARCHAR(5)), 5) +
            '0' collate Latin1_General_100_BIN2               AS [BillingDocumentItem]
    ,   ''                                                    AS [ReturnItemProcessingType]
    ,   DA.[LOCALCURRENCY]                                    AS [CurrencyIDLocal]
    ,   'EUR'                                                 AS [CurrencyIDGroupEUR]
    ,   Null                                                  AS [ExchangeRate]
    ,   Null                                                  AS [SalesType]
    ,   CITQ.ACCOUNTINGDATE                                   AS [BillingDocumentDate]
    ,   NULL                                                  AS [DistributionChannelID]
    ,   SINMT.[SAPProductID]                                  AS [Material]
    ,   NULL                                                  AS LengthInMPer1
    ,   NULL                                                  AS LengthInM
    ,   NULL                                                  AS [PlantID]
    ,   CAST(CITQ.[QTY] as DECIMAL(13, 3))                    AS [BillingQuantity]
    ,   'ST' collate Latin1_General_100_BIN2                  AS [BillingQuantityUnitID]
    ,   sum(CAST(CITQ.[PRODUCTSALESLOCAL] as DECIMAL(19, 6))) AS [NetAmountLocal]
    ,   sum(CAST(CITQ.[PRODUCTSALESEUR] as DECIMAL(19, 6)))   AS [NetAmountGroupEUR]
    ,   CITQ.[COSTAMOUNTLOCAL]                                AS [CostAmountLocal]
    ,   CITQ.[COSTAMOUNTEUR]                                  AS [CostAmountGroupEUR]
    ,   CAST(CITQ.QTY as DECIMAL(13, 3))                      AS [QuantitySold]
    ,   [DELIVERYCOUNTRYID]                                   AS [CountryID]
    ,   [SALESID]                                             AS [SalesDocumentID]
    ,   CASE
            WHEN
                CT.[CUSTOMERPILLAR] = 'PRECAST'
            THEN
                '04'
            WHEN
                CT.[CUSTOMERPILLAR] = 'INDUSTRIAL'
            THEN
                '03'
            WHEN
                UPPER(CT.[CUSTOMERPILLAR]) = 'OTHER'
            THEN
                'ZZ'
        END                                                         AS [CustomerGroupID]
    ,   NUll                                                        AS [Postalcode]
    ,   CITQ.[CUSTOMERNO]                                           AS [Customerno]
    ,   NULL                                                        AS [Salesperson]
    ,   NULL                                                        as [Projectno]
    ,   NULL                                                        AS [Responsible]
    ,   NULL                                                        AS [GlobalParentID]
    ,   NULL                                                        AS [SalesOrderTypeID]

    ,   sum(CAST(CITQ.[PRODUCTSALESLOCAL] as DECIMAL(19, 6)))       AS [FinNetAmountLOCAL]           -- FinNetAmount
    ,   sum(CAST(CITQ.[PRODUCTSALESEUR] as DECIMAL(19, 6)))         AS [FinNetAmountEUR]             -- FinNetAmount
    ,   sum(CAST(CITQ.[OTHERSALESLOCAL] as DECIMAL(19, 6)))         AS [FinNetAmountOtherSalesLOCAL] -- [FinNetAmountOtherSales]
    ,   sum(CAST(CITQ.[OTHERSALESEUR] as DECIMAL(19, 6)))           AS [FinNetAmountOtherSalesEUR]   -- [FinNetAmountOtherSales]
    ,   sum(CAST(CITQ.[OTHERSALESLOCAL] as DECIMAL(19, 6)))         AS [FinNetAmountServOtherLOCAL] -- [FinNetAmountServOther]
    ,   sum(CAST(CITQ.[OTHERSALESEUR] as DECIMAL(19, 6)))           AS [FinNetAmountServOtherEUR]   -- [FinNetAmountServOther]    
    ,   sum(CAST(CITQ.[ALLOWANCESLOCAL] as DECIMAL(19, 6)))         AS [FinNetAmountAllowancesLOCAL] --[FinNetAmountAllowances]
    ,   sum(CAST(CITQ.[ALLOWANCESEUR] as DECIMAL(19, 6)))           AS [FinNetAmountAllowancesEUR]   --[FinNetAmountAllowances]
    ,   sum(CAST(CITQ.[PRODUCTSALESLOCAL] as DECIMAL(19, 6))) +
            sum(CAST(CITQ.[OTHERSALESLOCAL] as DECIMAL(19, 6))) +
            sum(CAST(CITQ.[ALLOWANCESLOCAL] as DECIMAL(19, 6)))     AS [FinSales100LOCAL]
    ,   sum(CAST(CITQ.[PRODUCTSALESEUR] as DECIMAL(19, 6))) +
            sum(CAST(CITQ.[OTHERSALESEUR] as DECIMAL(19, 6))) +
            sum(CAST(CITQ.[ALLOWANCESEUR] as DECIMAL(19, 6)))       AS [FinSales100EUR]
    ,   [ACCOUNTINGDATE]                                            AS [AccountingDate]              --  (bookingdate of the invoice).
    ,   CITQ.[DATAAREAID]                                           AS [axbi_DataAreaID]
    ,   DA.[NAME]                                                   AS [axbi_DataAreaName]
    ,   DA.[GROUP]                                                  AS [axbi_DataAreaGroup]
    ,   CITQ.[ITEMID]                                               AS [axbi_MaterialID]
    ,   CITQ.[CUSTOMERNO]                                           AS [axbi_CustomerID]
    ,   edw.svf_getInOutID_axbi (INOUT)                             AS [InOutID]
    ,   CITQ.[ITEMID]                                               AS [axbi_ItemNoCalc]
    ,   DA.DATAAREAID2                                              AS [axbi_DataAreaID2]
    ,   CITQ.[t_applicationId]                                      AS [t_applicationId]
    ,   CITQ.[t_extractionDtm]                                      AS [t_extractionDtm]
    FROM
        CustInvoiceTrans_without_quotes CITQ
    LEFT JOIN 
        [base_tx_ca_0_hlp].[DATAAREA] DA
        ON
            DA.[DATAAREAID2] = CITQ.DATAAREAID
    LEFT JOIN 
         [intm_axbi].[dim_CUSTTABLE]  CT
        ON
            CT.[ACCOUNTNUM] = CITQ.[CUSTOMERNO]
            AND
            CT.[DATAAREAID] = CITQ.[DATAAREAID]
    LEFT JOIN
        [edw].[dim_SAPItemNumberBasicMappingTable] AS SINMT
        ON
            CITQ.[ITEMID] = SINMT.[axbi_ItemNoCalc]
            AND
            SINMT.[Migrate] IN ('Y', 'D')
            AND
            UPPER(SINMT.[AXDataAreaId]) = UPPER(CITQ.[DATAAREAID])
            AND
            SINMT.[SAPProductID] IS NOT NULL

    WHERE 
        DA.[GROUP] != 'HALFEN'
    GROUP BY
        DA.[DATAAREAID]
    ,   [INVOICEID]
    ,   [LINENUM]
    ,   DA.[LOCALCURRENCY]
    ,   ACCOUNTINGDATE
    ,   SINMT.[SAPProductID]
    ,   QTY
    ,   [CUSTOMERNO]
    ,   [DELIVERYCOUNTRYID]
    ,   CT.[CUSTOMERPILLAR]
    ,   CITQ.[DATAAREAID]
    ,   DA.[NAME]
    ,   DA.[GROUP]
    ,   CITQ.[ITEMID]
    ,   CITQ.[CUSTOMERNO]
    ,   CT.[INOUT]
    ,   SINMT.[AXItemnumber]
    ,   CITQ.[t_applicationId]
    ,   CITQ.[t_extractionDtm]
    ,   CITQ.[SALESID]
    ,   [COSTAMOUNTLOCAL]
    ,   [COSTAMOUNTEUR]
    ,   DA.[DATAAREAID2]

    UNION ALL

    select
        FH.[Company]                                                        as [DataAreaID]
    ,   FH.[Invoiceno] collate Latin1_General_100_BIN2                      as [BillingDocument]
        --TODO check LPAD: LPAD is MySQL specific
    ,   RIGHT('00000' + CAST(CAST(FH.[Posno] as INT) as VARCHAR(5)), 5) +
        '0' collate Latin1_General_100_BIN2                                 as [BillingDocumentItem]
    ,   case when FH.SalesType = 4 then 'X' else '' end                     as [ReturnItemProcessingType]
    ,   FH.Currencylocal collate Latin1_General_100_BIN2                    as [CurrencyIDLocal]
    ,   FH.CurrencyEUR collate Latin1_General_100_BIN2                      as [CurrencyIDGroupEUR]
    ,   CAST(FH.[CurrencyRatelocaltoCRH1EUR] as DECIMAL(15, 6))             as [ExchangeRate]
    ,   FH.SalesType                                                        as [SalesType]    --[SDDocumentCategoryID]
    ,   CONVERT(DATE, FH.Invoicedate)                                       as [BillingDocumentDate]
    ,   FH.Inside_Outside                                                   as [DistributionChannelID]
    ,   SINMT.[SAPProductID]                                                AS [Material]
    ,   FH.[LengthinMper1]                                                  AS [LengthInMPer1]
    ,   FH.[LengthinM]                                                      AS [LengthInM]
    ,   FH.[Originwarehouse]                                                AS [PlantID]
    ,   CAST(FH.Invoicequantity as DECIMAL(13, 3))                          AS [BillingQuantity]
    ,   'ST' collate Latin1_General_100_BIN2                                AS [BillingQuantityUnitID] --TODO check
    ,   CAST(FH.Invoicedsaleslocal as DECIMAL(19, 6))                       AS [NetAmountLocal]
    ,   CAST(FH.InvoicedsalesCRHEUR as DECIMAL(19, 6))                      AS [NetAmountGroupEUR]
    ,   CAST(FH.ICPlocal as DECIMAL(19, 6))                                 AS [CostAmountLocal]
    ,   CAST(FH.ICPCRHEUR as DECIMAL(19, 6))                                AS [CostAmountGroupEUR]
    ,   CAST(FH.Invoicequantity as DECIMAL(13, 3))                          AS [QuantitySold]
    ,   FH.[Country]                                                        AS [CountryID]
    ,   FH.[Orderno]                                                        AS [SalesDocumentID]
    ,   CASE
            WHEN
                DIM_CUST.[CustomerPillar] = 'PRECAST'
            THEN
                '04'
            WHEN
                DIM_CUST.[CustomerPillar] = 'INDUSTRIAL'
            THEN
                '03'
            WHEN
                UPPER(DIM_CUST.[CustomerPillar]) = 'OTHER'
            THEN
                'ZZ'
        END                                                                 AS [CustomerGroupID]
    ,   FH.[Postalcode]                                                     AS [Postalcode]            
    ,   DA.DATAAREAID2 + '-' + FH.[Customerno]                              AS [Customerno]
    ,   FH.[Salesperson]                                                    AS [Salesperson]
    ,   FH.[Projectno]                                                      AS [Projectno]
    ,   FH.Responsible                                                      AS [Responsible]
    ,   case when trim(FH.Concern) = ''
        then
            NULL
        else
            FH.Concern
        end                                                                 AS [GlobalParentID]
    ,   SalesType                                                           AS [SalesOrderTypeID]
    ,   [Invoicedsaleslocal]                                                AS [FinNetAmountLOCAL]
    ,   [InvoicedsalesCRHEUR]                                               AS [FinNetAmountEUR]
    ,   [Othersaleslocal]                                                   AS [FinNetAmountOtherSalesLOCAL]
    ,   [OthersalesCRHEUR]                                                  AS [FinNetAmountOtherSalesEUR]
    ,   [Othersaleslocal]                                                   AS [FinNetAmountServOtherLOCAL] -- [FinNetAmountServOther]
    ,   [OthersalesCRHEUR]                                                  AS [FinNetAmountServOtherEUR]   -- [FinNetAmountServOther]
    ,   [Allowanceslocal]                                                   AS [FinNetAmountAllowancesLOCAL]
    ,   [AllowancesCRHEUR]                                                  AS [FinNetAmountAllowancesEUR]
    ,   [Invoicedsaleslocal] + [Othersaleslocal] + [Allowanceslocal]        as [FinSales100LOCAL]
    ,   [InvoicedsalesCRHEUR] + [OthersalesCRHEUR] + [AllowancesCRHEUR]     as [FinSales100EUR]
    ,   [Accountingdate]                                                    AS [AccountingDate]
    ,   FH.[Company]                                                        AS [axbi_DataAreaID]
    ,   DA.[NAME]                                                           AS [axbi_DataAreaName]
    ,   DA.[GROUP]                                                          AS [axbi_DataAreaGroup]
    ,   'HALF-' + FH.[Itemno]                                               AS [axbi_MaterialID]
    ,   DA.DATAAREAID2 + '-' + FH.[Customerno]                              AS [axbi_CustomerID]
    ,   CT.[INOUT]                                                          AS [InOutID]
    ,   'HALF-' + FH.[Itemno]                                               AS [axbi_ItemNoCalc]
    ,   DA.DATAAREAID2                                                      AS [axbi_DataAreaID2] 
    ,   FH.[t_applicationId]                                                AS [t_applicationId]
    ,   FH.[t_extractionDtm]                                                AS [t_extractionDtm]
    FROM    
        intm_axbi.vw_FACT_HGDAWA FH
    LEFT JOIN 
        [base_tx_ca_0_hlp].[DATAAREA] DA
        ON
            DA.[DATAAREAID] = FH.[Company]
    LEFT JOIN
        intm_axbi.vw_DIM_CUSTOMER DIM_CUST
        ON
            DIM_CUST.[Customerno] = FH.[Customerno]
            AND
            DIM_CUST.[Company] = FH.[Company]
    LEFT JOIN
        [edw].[dim_SAPItemNumberBasicMappingTable] AS SINMT
        ON
            FH.[Itemno] = SINMT.[AXItemnumber]
            AND
            SINMT.[AXDataAreaId] = '0000'
            AND
            SINMT.[Migrate] IN ('Y', 'D')
            AND
            SINMT.SAPProductID IS NOT NULL
    LEFT JOIN
         [intm_axbi].[dim_CUSTTABLE] CT
        ON
            CT.[ACCOUNTNUM] = DA.[DATAAREAID2] + '-' + FH.[Customerno]
),
BillingDocumentItemBase_axbi_mapped AS (
    SELECT
        SubQ.[BillingDocument]
    ,   SubQ.[BillingDocumentItem]
    ,   SubQ.[ReturnItemProcessingType]
    ,   SubQ.[DataAreaID]
    ,   SubQ.[CurrencyIDLocal]
    ,   SubQ.[CurrencyIDGroupEUR]
    ,   SubQ.[ExchangeRate]
    ,   CASE WHEN  
                SubQ.[SalesType] = '3'
            THEN 
                'C' 
            WHEN  
                SubQ.[SalesType] = '4'
            THEN 
                'H' 
            WHEN  
                SubQ.[SalesType] = '110'
            THEN 
                'C'
            WHEN  
                SubQ.[SalesType] = '101'
            THEN    
                CASE 
                    WHEN 
                        SubQ.[FinNetAmountEUR] > 0
                    THEN  
                        'L' 
                    WHEN 
                        SubQ.[FinNetAmountEUR] < 0
                    THEN  
                        'K' 
                    WHEN 
                        SubQ.[FinNetAmountEUR] = 0
                    THEN  
                        CASE 
                            WHEN 
                                SubQ.[FinNetAmountOtherSalesEUR] > 0
                            THEN  
                                'L'        
                            WHEN 
                                SubQ.[FinNetAmountOtherSalesEUR] < 0
                            THEN  
                                'K' 
                            WHEN 
                                SubQ.[FinNetAmountOtherSalesEUR] = 0
                            THEN 
                                CASE 
                                    WHEN 
                                        SubQ.[BillingQuantity] > 0
                                    THEN 
                                        'L'
                                    WHEN 
                                        SubQ.[BillingQuantity] <= 0
                                    THEN 
                                        'K'   
                                END
                        END
                END
        END
                       AS [SDDocumentCategoryID]

    ,   SubQ.[BillingDocumentDate]
    ,   CASE
            WHEN
                SO.target_SalesOrganizationID IS NOT NULL
            THEN 
                SO.target_SalesOrganizationID 
            ELSE
                [DataAreaID]
        END AS [SalesOrganizationID]
    ,   SubQ.[DistributionChannelID]
    ,   CASE
            WHEN
                SubQ.[Material] IS NOT NULL
            THEN
                SubQ.[Material]
            ELSE
                axbi_ItemNoCalc
        END AS [Material]
    ,   SubQ.[LengthInMPer1]
    ,   SubQ.[LengthInM]
    ,   SubQ.[PlantID]
    ,   SubQ.[BillingQuantity]
    ,   SubQ.[BillingQuantityUnitID]
    ,   SubQ.[NetAmountLocal]
    ,   SubQ.[NetAmountGroupEUR]
    ,   SubQ.[CostAmountLocal]
    ,   SubQ.[CostAmountGroupEUR]
    ,   SubQ.[QuantitySold]
    ,   SubQ.[CountryID]
    ,   SubQ.[SalesDocumentID]
    ,   SubQ.[CustomerGroupID]
    ,   SD.[SalesDistrictID]                                             AS [SalesDistrictID]
    ,   DimCust.[CustomerID]                                             AS [SoldToParty]
    ,   ESA.target_ExternalSalesAgentID                                  AS [ExternalSalesAgentID]
    ,   RIGHT('0000000000' + CAST(MBP.target_XRefID as VARCHAR(10)), 10) AS [ProjectID]
    ,   IBP.BusinessPartnerName                                          AS [Project]
    ,   SE.target_SalesEmployeeID collate Latin1_General_100_BIN2        AS [SalesEmployeeID]
    ,   SubQ.[GlobalParentID]
    ,   CASE 
            WHEN  
                SubQ.[SalesType] = '3'
            THEN 
                'ZOR' 
            WHEN  
                SubQ.[SalesType] = '4'
            THEN 
                'RE' 
            WHEN  
                SubQ.[SalesType] = '110'
            THEN 
                'ZOR' 
            WHEN  
                SubQ.[SalesType] = '101'
            THEN  
                CASE 
                    WHEN 
                        SubQ.[FinNetAmountEUR] > 0
                    THEN  
                        'ZDR' 
                    WHEN 
                        SubQ.[FinNetAmountEUR] < 0
                    THEN  
                        'ZCR' 
                    WHEN 
                        SubQ.[FinNetAmountEUR] = 0
                    THEN 
                        CASE 
                            WHEN 
                                SubQ.[FinNetAmountOtherSalesEUR] > 0
                            THEN  
                                'ZDR'        
                            WHEN 
                                SubQ.[FinNetAmountOtherSalesEUR] < 0
                            THEN  
                                'ZCR' 
                            WHEN 
                                SubQ.[FinNetAmountOtherSalesEUR] = 0
                            THEN 
                                CASE 
                                    WHEN 
                                        SubQ.[BillingQuantity] > 0
                                    THEN 
                                        'ZDR'
                                    WHEN 
                                        SubQ.[BillingQuantity] <= 0
                                    THEN 
                                        'ZCR'
                                END
                        END
                END
        END
                       AS [SalesOrderTypeID]

    ,   SubQ.[FinNetAmountLOCAL]
    ,   SubQ.[FinNetAmountEUR]
    ,   SubQ.[FinNetAmountOtherSalesLOCAL]
    ,   SubQ.[FinNetAmountOtherSalesEUR]
    ,   SubQ.[FinNetAmountServOtherLOCAL]
    ,   SubQ.[FinNetAmountServOtherEUR]    
    ,   SubQ.[FinNetAmountAllowancesLOCAL]
    ,   SubQ.[FinNetAmountAllowancesEUR]
    ,   SubQ.[FinSales100LOCAL]
    ,   SubQ.[FinSales100EUR]
    ,   SubQ.[AccountingDate]
    ,   SubQ.[axbi_DataAreaID]
    ,   SubQ.[axbi_DataAreaName]
    ,   SubQ.[axbi_DataAreaGroup]
    ,   SubQ.[axbi_MaterialID]
    ,   SubQ.[axbi_CustomerID]
    ,   CASE
            WHEN 
                [Material] IS NOT NULL
            THEN 
                SubQ.[Material]
            ELSE 
                SubQ.[axbi_MaterialID]
        END AS [MaterialCalculated]
    ,   CASE 
            WHEN 
                SO.IsMigrated = 'Y'
            THEN
                CASE
                    WHEN 
                        SCBMT.[SAPCustomeraccount] IS NOT NULL
                    THEN 
                        DimCust.[CustomerID]
                    ELSE 
                        SubQ.[axbi_CustomerID] 
                END
            ELSE 
                SubQ.[axbi_CustomerID]
        END AS [SoldToPartyCalculated]

    ,   mapBrand.[BrandID]  AS [BrandID]
    ,   mapBrand.[Brand]    AS [Brand]
  --,   CT.[INOUT] AS [InOutID]
    ,   SubQ.[InOutID]
    ,   SubQ.[axbi_ItemNoCalc]
    ,   SubQ.[axbi_DataAreaID2]
    ,   SubQ.[t_applicationId]
    ,   SubQ.[t_extractionDtm]

    FROM 
        BillingDocumentItemBase_axbi as SubQ
    LEFT JOIN
        [map_AXBI].[SalesOrganization] AS SO
        ON
            SubQ.[DataAreaID] = source_DataAreaID 
            AND 
            [target_SalesOrganizationID] != 'TBD'        
    LEFT JOIN
        [base_ff].[SalesDistrict] SD 
        ON 
            SD.[CountryID] = SubQ.[CountryID] 
            AND
            SD.[SalesOrganizationID] = SO.[target_SalesOrganizationID]
            AND
            SD.[ZipCodeFrom] = SubQ.[Postalcode]  
            -- while we do not have data for Germany, we temporarily comment on these conditions 
            /*
            -- for Germany,  range is used relative to the postcode fields ZipCodeFrom, ZipCodeTo 
            -- for other countries these values are equal
            (
                (
                    SD.[CountryID] <> 'DE'
                    AND
                    SD.[ZipCodeFrom] = SubQ.[Postalcode]  
                )
                OR
                (
                    SD.[CountryID] = 'DE'
                    AND
                    (   
                        SD.[ZipCodeFrom] >= SubQ.[Postalcode] 
                        AND 
                        SubQ.[Postalcode] <= SD.[ZipCodeTo]
                    )
                                                           
                )
            ) */
    LEFT JOIN
        [map_AXBI].[SalesEmployee] AS ESA
        ON
            SubQ.[Salesperson] = ESA.source_SalesPersonID
    LEFT JOIN
        [map_AXBI].[SalesEmployee] AS SE
        ON
            SubQ.[Responsible] = SE.source_SalesPersonID
/*    LEFT JOIN
        [map_AXBI].[SDDocumentCategory] AS SDDC
        ON
            SubQ.[SalesType] = SDDC.source_SalesTypeID
    LEFT JOIN
        [map_AXBI].[SalesDocumentType] AS SDT
        ON
            SubQ.[SalesType] = SDT.source_SalesTypeID */ -- Ksenia task 1505
/*        LEFT JOIN
        [map_AXBI].[Material] as mapMaterial
        ON
            -- SubQ.[DataAreaID] = upper(SINMT.[AXDataAreaId])
            -- AND
            SubQ.[Itemno] = mapMaterial.[source_Material] */
    LEFT JOIN
        [edw].[dim_SAPCustomerBasicMappingTable] SCBMT
        ON
            SubQ.[DataAreaID] = SCBMT.[AXDataAreaId]
            AND
            SubQ.[Customerno] = SCBMT.[AXCustomerCalculated]
    LEFT JOIN
        [edw].[dim_Customer] DimCust
        ON
            DimCust.[CustomerExternalID] = SCBMT.[SAPCustomeraccount]
    LEFT JOIN 
        [map_AXBI].[BusinessPartner] MBP
        ON
            MBP.XRefType = 'PROJECTS-TO'
            AND
            -- Lookup the correct UDF Legacy ID and add as a prefix
            CONCAT(
                SO.[source_UDFLegacyID],
                SubQ.[Projectno]
            ) = MBP.source_XRefID

    LEFT JOIN 
        [base_s4h_cax].[I_BusinessPartner] IBP
        ON
            IBP.BusinessPartner = RIGHT('0000000000'+CAST(MBP.target_XRefID collate Latin1_General_100_BIN2 as VARCHAR(10)),10)
            -- AND
            -- IBP.[MANDT] = 200 MPS 2021/11/03: commented out due to different client values between dev,qas, and prod
    -- LEFT JOIN
    --     [base_tx_ca_0_hlp].[CUSTTABLE] CT
    --     ON
    --         CT.[ACCOUNTNUM] = SubQ.[axbi_CustomerID]
    --         AND
    --         SubQ.[DataAreaID] = CT.[DATAAREAID]
     LEFT JOIN
        [map_AXBI].[Brand] mapBrand
        ON
        mapBrand.[source_DataAreaID]= SubQ.[axbi_DataAreaID]
), BillingDocumentItemBase_axbi_mapped_calc as (
    SELECT
        CONCAT(TRIM(SubQ.[SalesOrganizationID]),'_',TRIM(SubQ.[BillingDocument]) COLLATE SQL_Latin1_General_CP1_CS_AS) AS [BillingDocument]
    ,   SubQ.[BillingDocumentItem]
    ,   SubQ.[ReturnItemProcessingType]
    ,   SubQ.[DataAreaID]
    ,   SubQ.[CurrencyIDLocal]
    ,   SubQ.[CurrencyIDGroupEUR]
    ,   SubQ.[ExchangeRate]
    ,   SubQ.[SDDocumentCategoryID]
    ,   SubQ.[BillingDocumentDate]
    ,   SubQ.[SalesOrganizationID]
    ,   SubQ.[DistributionChannelID]
    ,   SubQ.[Material]
    ,   SubQ.[LengthInMPer1]
    ,   SubQ.[LengthInM]
    ,   SubQ.[PlantID]
    ,   SubQ.[BillingQuantity]
    ,   SubQ.[BillingQuantityUnitID]
    ,   SubQ.[NetAmountLocal]
    ,   SubQ.[NetAmountGroupEUR]
    ,   SubQ.[CostAmountLocal]
    ,   SubQ.[CostAmountGroupEUR]
    ,   SubQ.[QuantitySold]
    ,   SubQ.[CountryID]
    ,   SubQ.[SalesDocumentID]
    ,   SubQ.[CustomerGroupID]
    ,   SubQ.[SalesDistrictID]
    ,   SubQ.[SoldToParty]
    ,   SubQ.[ExternalSalesAgentID]
    ,   SubQ.[ProjectID]
    ,   SubQ.[Project]
    ,   SubQ.[SalesEmployeeID]
    ,   SubQ.[GlobalParentID]
    ,   case when SubQ.[GlobalParentID] is null
            then SubQ.[SoldToParty]
            else SubQ.[GlobalParentID]
        end                                                              AS [GlobalParentCalculatedID]
    ,   case when SubQ.[GlobalParentID] is null -- task 1611
            then DIM_CUST_S4H.[Customer]
            else CustTb.[NAME]
        end                                                              AS [GlobalParentCalculated]
    ,   SubQ.[SoldToParty]                                               AS [LocalParentCalculatedID]
    ,   DIM_CUST_S4H.[Customer]                                          AS [LocalParentCalculated]
    ,   SubQ.[SalesOrderTypeID]
    ,   SubQ.[FinNetAmountLOCAL]
    ,   SubQ.[FinNetAmountEUR]
    ,   SubQ.[FinNetAmountOtherSalesLOCAL]
    ,   SubQ.[FinNetAmountOtherSalesEUR]
    ,   SubQ.[FinNetAmountServOtherLOCAL]
    ,   SubQ.[FinNetAmountServOtherEUR]  
    ,   SubQ.[FinNetAmountAllowancesLOCAL]
    ,   SubQ.[FinNetAmountAllowancesEUR]
    ,   SubQ.[FinSales100LOCAL]
    ,   SubQ.[FinSales100EUR]
    ,   SubQ.[AccountingDate]
    ,   SubQ.[axbi_DataAreaID]
    ,   SubQ.[axbi_DataAreaName]
    ,   SubQ.[axbi_DataAreaGroup]
    ,   SubQ.[axbi_MaterialID]
    ,   SubQ.[axbi_CustomerID]
    ,   SubQ.[MaterialCalculated]
    ,   SubQ.[SoldToPartyCalculated]
    ,   SubQ.[BrandID]
    ,   SubQ.[Brand]
    ,   SubQ.[InOutID]
    ,   SubQ.[axbi_ItemNoCalc]
    ,   SubQ.[t_applicationId]
    ,   SubQ.[t_extractionDtm]
    FROM
        BillingDocumentItemBase_axbi_mapped as SubQ
        LEFT JOIN
            [edw].[dim_Customer] DIM_CUST_S4H
                on
                    DIM_CUST_S4H.[CustomerID] = SubQ.[SoldToParty]

        LEFT JOIN
             [intm_axbi].[dim_CUSTTABLE]  CustTb
            ON
                CustTb.[DATAAREAID] = SubQ.[axbi_DataAreaID2]
                AND
                CustTb.[ACCOUNTNUM] = SubQ.[axbi_DataAreaID2] + '-' + SubQ.[GlobalParentID]
    WHERE 
        SubQ.[SalesOrganizationID] <> '5330' -- filtered out US data
)
/*
    Add dummy generated records for invoices containing packaging or services
    materials only.
*/
,BDIZZZDUMMY AS(   
    SELECT
        [BillingDocument]
    ,   STUFF([BillingDocumentItem], 1, 1, 'Z') + '0' AS [BillingDocumentItem]
    ,   [ReturnItemProcessingType]
    ,   [DataAreaID]
    ,   [CurrencyIDLocal]
    ,   [CurrencyIDGroupEUR]
    ,   [ExchangeRate]
    ,   [SDDocumentCategoryID]
    ,   [BillingDocumentDate]
    ,   [SalesOrganizationID]
    ,   [DistributionChannelID]
    ,   'ZZZDUMMY01'                  AS [Material]
    ,   NULL                          AS LengthInMPer1
    ,   NULL                          AS LengthInM
    ,   [PlantID]
    ,   NULL                          AS [BillingQuantity]
    ,   [BillingQuantityUnitID]
    ,   [FinNetAmountOtherSalesLOCAL] AS [NetAmountLocal]
    ,   [FinNetAmountOtherSalesEUR]   AS [NetAmountGroupEUR]
    ,   NULL                          AS [CostAmountLocal]
    ,   NULL                          AS [CostAmountGroupEUR]
    ,   [QuantitySold]
    ,   [CountryID]
    ,   [SalesDocumentID]
    ,   [CustomerGroupID]
    ,   [SalesDistrictID]
    ,   [SoldToParty]
    ,   [ExternalSalesAgentID]
    ,   [ProjectID]
    ,   [Project]
    ,   [SalesEmployeeID]
    ,   [GlobalParentID]
    ,   [GlobalParentCalculatedID]
    ,   [GlobalParentCalculated]
    ,   [LocalParentCalculatedID]
    ,   [LocalParentCalculated]
    ,   [SalesOrderTypeID]
    ,   NULL AS [FinNetAmountLOCAL]
    ,   NULL AS [FinNetAmountEUR]
    ,   NULL AS [FinNetAmountOtherSalesLOCAL]
    ,   NULL AS [FinNetAmountOtherSalesEUR]
    ,   NULL AS [FinNetAmountServOtherLOCAL]
    ,   NULL AS [FinNetAmountServOtherEUR]
    ,   NULL AS [FinNetAmountAllowancesLOCAL]
    ,   NULL AS [FinNetAmountAllowancesEUR]
    ,   NULL AS [FinSales100LOCAL]
    ,   NULL AS [FinSales100EUR]
    ,   [AccountingDate]
    ,   [axbi_DataAreaID]
    ,   [axbi_DataAreaName]
    ,   [axbi_DataAreaGroup]
    ,   NULL AS [axbi_MaterialID]
    ,   [axbi_CustomerID]
    ,   'ZZZDUMMY01' AS [MaterialCalculated]
    ,   [SoldToPartyCalculated]
    ,   NULL AS [BrandID]
    ,   NULL AS [Brand]
    ,   [InOutID]
    ,   [axbi_ItemNoCalc]
    ,   [t_applicationId]
    ,   [t_extractionDtm]
    FROM
        BillingDocumentItemBase_axbi_mapped_calc
    WHERE 
        ISNULL ([FinNetAmountOtherSalesLOCAL], 0) != 0
        OR
        ISNULL ([FinNetAmountOtherSalesEUR], 0) != 0
)
,BDIAXBI_DUMMY AS (
    SELECT *
    FROM BillingDocumentItemBase_axbi_mapped_calc

    UNION ALL 

    SELECT *
    FROM BDIZZZDUMMY
)
,EuroBudgetExchangeRate AS (
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
,EuroBudgetExchangeRateUSD as (
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
, BDIAXBI_DUMMY_30 AS(
    SELECT 
            [BillingDocument]
        ,   [BillingDocumentItem]
        ,   [ReturnItemProcessingType]
        ,   CurrencyIDGroupEUR                       AS [CurrencyID]
        ,   [ExchangeRate]
        ,   [SDDocumentCategoryID]
        ,   [BillingDocumentDate]
        ,   [SalesOrganizationID]
        ,   [DistributionChannelID]
        ,   [Material]
        ,   [LengthInMPer1]
        ,   [LengthInM]
        ,   [PlantID]
        ,   [BillingQuantity]
        ,   [BillingQuantityUnitID]
        ,   [NetAmountGroupEUR]                      AS [NetAmount]
        ,   [CostAmountGroupEUR]                     AS [CostAmount]
        ,   [QuantitySold]
        ,   [CountryID]
        ,   [SalesDocumentID]
        ,   [CustomerGroupID]
        ,   [SalesDistrictID]
        ,   [SoldToParty]
        ,   [ExternalSalesAgentID]
        ,   [ProjectID]
        ,   [Project]
        ,   [SalesEmployeeID]
        ,   [GlobalParentID]
        ,   [GlobalParentCalculatedID]
        ,   [GlobalParentCalculated]
        ,   [LocalParentCalculatedID]
        ,   [LocalParentCalculated]
        ,   [SalesOrderTypeID]
        ,   COALESCE([FinNetAmountEUR], 0)           AS [FinNetAmountRealProduct]
        ,   COALESCE([FinNetAmountOtherSalesEUR], 0) AS [FinNetAmountOtherSales]
        ,   COALESCE([FinNetAmountServOtherEUR], 0)  AS [FinNetAmountServOther]        
        ,   COALESCE([FinNetAmountAllowancesEUR], 0) AS [FinNetAmountAllowances]
        ,   COALESCE([FinSales100EUR], 0)            AS [FinSales100]
        ,   [AccountingDate]
        ,   [axbi_DataAreaID]
        ,   [axbi_DataAreaName]
        ,   [axbi_DataAreaGroup]
        ,   [axbi_MaterialID]
        ,   [axbi_CustomerID]
        ,   [MaterialCalculated]
        ,   [SoldToPartyCalculated]
        ,   [BrandID]
        ,   [Brand]
        ,   [InOutID]
        ,   [axbi_ItemNoCalc]
        ,   BDIAXBI_DUMMY.[t_applicationId]
        ,   BDIAXBI_DUMMY.[t_extractionDtm]
    FROM 
        BDIAXBI_DUMMY
)
,ExchangeRateUSD AS(
    SELECT
            [BillingDocument]
        ,   [BillingDocumentItem]
        ,   EuroBudgetExchangeRateUSD.[ExchangeRate] AS [ExchangeRate]
    FROM
        (SELECT
                [BillingDocument]
            ,   [BillingDocumentItem]
            ,   [CurrencyID]
            ,    MAX([ExchangeRateEffectiveDate]) AS [ExchangeRateEffectiveDate]
        FROM 
            BDIAXBI_DUMMY_30 axbi_dummy_40
        LEFT JOIN
            EuroBudgetExchangeRateUSD
            ON
                axbi_dummy_40.[CurrencyID] = EuroBudgetExchangeRateUSD.TargetCurrency
        WHERE
            [ExchangeRateEffectiveDate] <= [BillingDocumentDate]
        GROUP BY
                [BillingDocument]
            ,   [BillingDocumentItem]
            ,   [CurrencyID]
        ) axbiUSD
    LEFT JOIN
        EuroBudgetExchangeRateUSD
        ON
            axbiUSD.[CurrencyID] = EuroBudgetExchangeRateUSD.[TargetCurrency]
            AND
            axbiUSD.[ExchangeRateEffectiveDate] = EuroBudgetExchangeRateUSD.[ExchangeRateEffectiveDate]
)
/*
    Local currency data from AX BI
*/

SELECT 
    CONCAT_WS(
        '¦'
    ,   [BillingDocument] collate SQL_Latin1_General_CP1_CS_AS
    ,   [BillingDocumentItem] collate SQL_Latin1_General_CP1_CS_AS
    ,   CT.[CurrencyTypeID]
        ) AS [nk_fact_BillingDocumentItem]
    ,   [BillingDocument]
    ,   [BillingDocumentItem]
    ,   [ReturnItemProcessingType]
    ,   CT.[CurrencyTypeID]                      as [CurrencyTypeID]
    ,   CT.[CurrencyType]                        as [CurrencyType]
    ,   CurrencyIDLocal                          as [CurrencyID]
    ,   1.0                                      as [ExchangeRate]
    ,   [SDDocumentCategoryID]
    ,   [BillingDocumentDate]
    ,   [SalesOrganizationID]
    ,   [DistributionChannelID]
    ,   [Material]
    ,   [LengthInMPer1]
    ,   [LengthInM]
    ,   [PlantID]
    ,   [BillingQuantity]
    ,   [BillingQuantityUnitID]
    ,   [NetAmountLocal]                         as [NetAmount]
    ,   [CostAmountLocal]                        as [CostAmount]
    ,   [QuantitySold]
    ,   [CountryID]
    ,   [SalesDocumentID]
    ,   [CustomerGroupID]
    ,   [SalesDistrictID]
    ,   [SoldToParty]
    ,   [ExternalSalesAgentID]
    ,   [ProjectID]
    ,   [Project]
    ,   [SalesEmployeeID]
    ,   [GlobalParentID]
    ,   [GlobalParentCalculatedID]
    ,   [GlobalParentCalculated]
    ,   [LocalParentCalculatedID]
    ,   [LocalParentCalculated]
    ,   [SalesOrderTypeID]
    ,   COALESCE([FinNetAmountLOCAL], 0)           AS [FinNetAmountRealProduct]
    ,   COALESCE([FinNetAmountOtherSalesLOCAL], 0) AS [FinNetAmountOtherSales]
    ,   COALESCE([FinNetAmountServOtherLOCAL], 0)  AS [FinNetAmountServOther]
    ,   COALESCE([FinNetAmountAllowancesLOCAL], 0) AS [FinNetAmountAllowances]
    ,   COALESCE([FinSales100LOCAL], 0)            AS [FinSales100]
    ,   [AccountingDate]
    ,   [axbi_DataAreaID]
    ,   [axbi_DataAreaName]
    ,   [axbi_DataAreaGroup]
    ,   [axbi_MaterialID]
    ,   [axbi_CustomerID]
    ,   [MaterialCalculated]
    ,   [SoldToPartyCalculated]
    ,   [BrandID]
    ,   [Brand]
    ,   [InOutID]
    ,   [axbi_ItemNoCalc]
    ,   BDIAXBI_DUMMY.[t_applicationId]
    ,   BDIAXBI_DUMMY.[t_extractionDtm]
FROM 
    BDIAXBI_DUMMY
CROSS JOIN
    [edw].[dim_CurrencyType] CT
WHERE
    CT.[CurrencyTypeID] = '10'

UNION ALL

/*
    Euro currency data from AX BI
*/

SELECT 
        CONCAT_WS(
        '¦'
    ,   [BillingDocument] collate SQL_Latin1_General_CP1_CS_AS
    ,   [BillingDocumentItem] collate SQL_Latin1_General_CP1_CS_AS
    ,   CT.[CurrencyTypeID]
        ) AS [nk_fact_BillingDocumentItem]
    ,   [BillingDocument]
    ,   [BillingDocumentItem]
    ,   [ReturnItemProcessingType]
    ,   CT.[CurrencyTypeID]                      AS [CurrencyTypeID]
    ,   CT.[CurrencyType]                        AS [CurrencyType]
    ,   [CurrencyID]
    ,   [ExchangeRate]
    ,   [SDDocumentCategoryID]
    ,   [BillingDocumentDate]
    ,   [SalesOrganizationID]
    ,   [DistributionChannelID]
    ,   [Material]
    ,   [LengthInMPer1]
    ,   [LengthInM]
    ,   [PlantID]
    ,   [BillingQuantity]
    ,   [BillingQuantityUnitID]
    ,   [NetAmount]
    ,   [CostAmount]
    ,   [QuantitySold]
    ,   [CountryID]
    ,   [SalesDocumentID]
    ,   [CustomerGroupID]
    ,   [SalesDistrictID]
    ,   [SoldToParty]
    ,   [ExternalSalesAgentID]
    ,   [ProjectID]
    ,   [Project]
    ,   [SalesEmployeeID]
    ,   [GlobalParentID]
    ,   [GlobalParentCalculatedID]
    ,   [GlobalParentCalculated]
    ,   [LocalParentCalculatedID]
    ,   [LocalParentCalculated]
    ,   [SalesOrderTypeID]
    ,   [FinNetAmountRealProduct]
    ,   [FinNetAmountOtherSales]    
    ,   [FinNetAmountServOther]
    ,   [FinNetAmountAllowances]
    ,   [FinSales100]
    ,   [AccountingDate]
    ,   [axbi_DataAreaID]
    ,   [axbi_DataAreaName]
    ,   [axbi_DataAreaGroup]
    ,   [axbi_MaterialID]
    ,   [axbi_CustomerID]
    ,   [MaterialCalculated]
    ,   [SoldToPartyCalculated]
    ,   [BrandID]
    ,   [Brand]
    ,   [InOutID]
    ,   [axbi_ItemNoCalc]
    ,   BDIAXBI_DUMMY_30.[t_applicationId]
    ,   BDIAXBI_DUMMY_30.[t_extractionDtm]
FROM 
    BDIAXBI_DUMMY_30
CROSS JOIN
    [edw].[dim_CurrencyType] CT
WHERE
    CT.[CurrencyTypeID] = '30'

UNION ALL

SELECT 
        CONCAT_WS(
        '¦'
    ,   ExchangeRateUSD.[BillingDocument] collate SQL_Latin1_General_CP1_CS_AS
    ,   ExchangeRateUSD.[BillingDocumentItem] collate SQL_Latin1_General_CP1_CS_AS
    ,   CT.[CurrencyTypeID]
        ) AS [nk_fact_BillingDocumentItem]
    ,   ExchangeRateUSD.[BillingDocument]
    ,   ExchangeRateUSD.[BillingDocumentItem]
    ,   [ReturnItemProcessingType]
    ,   CT.[CurrencyTypeID]                      AS [CurrencyTypeID]
    ,   CT.[CurrencyType]                        AS [CurrencyType]
    ,   'USD'                                    AS [CurrencyID]
    ,   1/ExchangeRateUSD.[ExchangeRate] AS [ExchangeRate]
    ,   [SDDocumentCategoryID]
    ,   [BillingDocumentDate]
    ,   [SalesOrganizationID]
    ,   [DistributionChannelID]
    ,   [Material]
    ,   [LengthInMPer1]
    ,   [LengthInM]
    ,   [PlantID]
    ,   [BillingQuantity]
    ,   [BillingQuantityUnitID]
    ,   [NetAmount]*(1/ExchangeRateUSD.[ExchangeRate]) AS [NetAmount]
    ,   [CostAmount]*(1/ExchangeRateUSD.[ExchangeRate]) AS [CostAmount]
    ,   [QuantitySold]
    ,   [CountryID]
    ,   [SalesDocumentID]
    ,   [CustomerGroupID]
    ,   [SalesDistrictID]
    ,   [SoldToParty]
    ,   [ExternalSalesAgentID]
    ,   [ProjectID]
    ,   [Project]
    ,   [SalesEmployeeID]
    ,   [GlobalParentID]
    ,   [GlobalParentCalculatedID]
    ,   [GlobalParentCalculated]
    ,   [LocalParentCalculatedID]
    ,   [LocalParentCalculated]
    ,   [SalesOrderTypeID]
    ,   [FinNetAmountRealProduct]*(1/ExchangeRateUSD.[ExchangeRate]) AS [FinNetAmountRealProduct]
    ,   [FinNetAmountOtherSales]*(1/ExchangeRateUSD.[ExchangeRate]) AS [FinNetAmountOtherSales]
    ,   [FinNetAmountServOther]*(1/ExchangeRateUSD.[ExchangeRate]) AS [FinNetAmountServOther]  
    ,   [FinNetAmountAllowances]*(1/ExchangeRateUSD.[ExchangeRate]) AS [FinNetAmountAllowances]
    ,   [FinSales100]*(1/ExchangeRateUSD.[ExchangeRate]) AS [FinSales100]
    ,   [AccountingDate]
    ,   [axbi_DataAreaID]
    ,   [axbi_DataAreaName]
    ,   [axbi_DataAreaGroup]
    ,   [axbi_MaterialID]
    ,   [axbi_CustomerID]
    ,   [MaterialCalculated]
    ,   [SoldToPartyCalculated]
    ,   [BrandID]
    ,   [Brand]
    ,   [InOutID]
    ,   [axbi_ItemNoCalc]
    ,   BDIAXBI_DUMMY_30.[t_applicationId]
    ,   BDIAXBI_DUMMY_30.[t_extractionDtm]
FROM 
    ExchangeRateUSD
LEFT JOIN
    BDIAXBI_DUMMY_30
    ON 
        BDIAXBI_DUMMY_30.BillingDocument=ExchangeRateUSD.BillingDocument 
        AND     
        BDIAXBI_DUMMY_30.BillingDocumentItem=ExchangeRateUSD.BillingDocumentItem  
CROSS JOIN
    [edw].[dim_CurrencyType] CT
WHERE
    CT.[CurrencyTypeID] = '40'
