CREATE VIEW [edw].[vw_SalesDocumentItem_axbi]
AS
WITH
SalesDocumentItem_Filtered_Out_Organization AS
(
    SELECT
        FSL_DOC.[SALESID]                                                AS [SalesDocument]
    ,   FSL_DOC.[INVENTTRANSID]                                          AS [SalesDocumentItem]
    ,   FSL_DOC.[adm_CompCurrency]                                       AS [CurrencyID]
    ,   FSL_DOC.[RETURNREASONCODEID]
    ,   FSL_DOC.[SALESQTY]                                               AS [OrderQuantity]  
    ,   CAST(FSL_DOC.[CREATEDDATETIME] AS date)                          AS [CreationDate]
    ,   CAST(FSL_DOC.[CREATEDDATETIME] AS time(0))                       AS [CreationTime]
    ,   FSL_DOC.[LineAmount_EUR_Createddatetime]                         AS [LineAmount_EUR_Createddatetime]
    ,   FSL_DOC.[LineAmount_MST_TransDate]                               AS [LineAmount_MST_TransDate]
    ,   FSL_DOC.[MarginValue]                                            AS [Margin_LOCAL]
    ,   FSL_DOC.[SHIPPINGDATEREQUESTED]                                  AS [RequestedDeliveryDate]
    ,   CASE 
        when SO.target_SalesOrganizationID is not null 
            then SO.target_SalesOrganizationID 
        else 
            FSL_DOC.[DATAAREAID] 
        end                                                              AS [SalesOrganizationID]
    ,   FSL_DOC.[CURRENCYCODE]                                           AS [CURRENCYCODE]
    ,   FSL_DOC.t_applicationId                                          AS [t_applicationId]
    ,   FSL_DOC.t_extractionDtm                                          AS [t_extractionDtm]
    ,   FSL_DOC.[SALESGROUP]
    ,   FSL_DOC.[SALESTYPE]
    ,   FSL_DOC.[DATAAREAID]
    ,   FSL_DOC.[CUSTACCOUNT]
    ,   FSL_DOC.[INVOICEAACOUNT]
    ,   FSL_DOC.[SalesTaker]
    ,   FSL_DOC.[SALESID]
    ,   FSL_DOC.[ITEMID]
    ,   edw.svf_getInOutID_axbi (INOUT)                                  AS [InOutID]  
    ,   SOff.SalesOfficeID             
    FROM intm_axbi.vw_FACT_SALESLINE FSL_DOC
    LEFT JOIN
        [map_AXBI].[SalesOrganization] AS SO
        ON
            FSL_DOC.[DATAAREAID] = source_DataAreaID
    LEFT JOIN
        [base_tx_ca_0_hlp].[DATAAREA] DA
        ON
           FSL_DOC.[DATAAREAID] = DA.[DATAAREAID]
    LEFT JOIN
         [intm_axbi].[dim_CUSTTABLE]  CT
        ON
            CT.ACCOUNTNUM = DA.[DATAAREAID2] + '-' + FSL_DOC.CUSTACCOUNT
    LEFT JOIN [map_AXBI].[SalesOffice] SOff
        ON FSL_DOC.[DATAAREAID] = SOff.[DataAreaID]
           
    WHERE
        (
            (
            SO.source_DataAreaID in ('ASCH', 'ANCH', '5313', 'anat', 'anch', 'ANAT', 'ASS', '5311', 'ass') 
            AND
            CAST(FSL_DOC.[CREATEDDATETIME] AS date)  < CAST('2021-10-01' as date)
            ) 
            OR
            (
            SO.source_DataAreaID not in ('ASCH', 'ANCH', '5313', 'anat', 'anch', 'ANAT', 'ASS', '5311', 'ass') 
            AND
            1=1
            )
        )
        AND
        SO.source_DataAreaID  <> '5330'
),
SalesDocumentItem_axbi_mapping AS (
    SELECT 
        SDIOrg.[SalesDocument]
    ,   SDIOrg.[SalesDocumentItem]
    ,   SDIOrg.[CurrencyID]
    ,   case when SDIOrg.[LineAmount_MST_TransDate] != 0
             then cast(SDIOrg.[LineAmount_EUR_Createddatetime] / SDIOrg.[LineAmount_MST_TransDate] AS DECIMAL(15, 6))
             else 0
        end                                                              AS [ExchangeRate]
    ,   CASE 
            WHEN  
                SDIOrg.SALESTYPE = '3'
            THEN 
                'C'
            WHEN  
                SDIOrg.SALESTYPE = '4'
            THEN 
                'H' 
            WHEN  
                SDIOrg.SALESTYPE = '101'
            THEN 
                'C' 
            WHEN  
                SDIOrg.SALESTYPE = '110'
            THEN    
                CASE 
                    WHEN 
                        SDIOrg.[LineAmount_MST_TransDate] > 0
                    THEN  
                        'L' 
                    WHEN 
                        SDIOrg.[LineAmount_MST_TransDate] < 0
                    THEN  
                        'K' 
                    WHEN 
                        SDIOrg.[LineAmount_MST_TransDate] = 0
                    THEN    
                        Case 
                            WHEN 
                                SDIOrg.[OrderQuantity] > 0
                            THEN  
                                'L'   
                            WHEN 
                                SDIOrg.[OrderQuantity] < 0
                            THEN  
                                'K' 
                        END
                END
        END
                                                        AS [SDDocumentCategoryID]
    ,   CASE 
            WHEN  
                SDIOrg.SALESTYPE = '3'
            THEN 
                'ZOR' 
            WHEN  
                SDIOrg.SALESTYPE = '4'
            THEN 
                'RE' 
            WHEN  
                SDIOrg.SALESTYPE = '101'
            THEN 
                'ZOR' 
            WHEN  
                SDIOrg.SALESTYPE = '110'
            THEN    
                CASE 
                    WHEN 
                        SDIOrg.[LineAmount_MST_TransDate] > 0
                    THEN  
                        'ZDR' 
                    WHEN 
                        SDIOrg.[LineAmount_MST_TransDate] < 0
                    THEN  
                        'ZCR'  
                    WHEN 
                        SDIOrg.[LineAmount_MST_TransDate] = 0
                    THEN    
                        Case 
                            WHEN 
                                SDIOrg.[OrderQuantity] > 0
                            THEN  
                                'ZDR'        
                            WHEN 
                                SDIOrg.[OrderQuantity] < 0
                            THEN  
                                'ZCR' 
                        END
                END
        END
                        AS [SalesDocumentTypeID] 
    ,   case
            when SDIOrg.[RETURNREASONCODEID] != '' and SDIOrg.[RETURNREASONCODEID] is not null
            then 'X'
            else ''
        end                                                              AS [IsReturnsItemID]
    ,   SDIOrg.[CreationDate]
    ,   SDIOrg.[CreationTime]
    -- ,   RIGHT('000000000000000000' + mapMaterial.[target_Material], 18)  AS [MaterialID]
    ,   CASE
            WHEN
                SINMT.[SAPProductID] IS NOT NULL
            THEN
                SINMT.[SAPProductID]
            ELSE
                ITEMID
        END AS [MaterialID]   
    ,   mapBrand.[BrandID]                                               AS [BrandID]
    ,   mapBrand.[Brand]                                                 AS [Brand]
    ,   DimCustSold.[CustomerID]                                         AS [SoldToPartyID]
    ,   DimCustBill.[CustomerID]                                         AS [BillToPartyID]
    ,   SDIOrg.[OrderQuantity]
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
    ,   SDIOrg.[LineAmount_EUR_Createddatetime]
    ,   SDIOrg.[LineAmount_MST_TransDate]
    ,   SDIOrg.[Margin_LOCAL]
    ,   SDIOrg.[RequestedDeliveryDate]
    ,   esa.target_ExternalSalesAgentID                                  AS [ExternalSalesAgentID]
    ,   se.target_SalesEmployeeID                                        AS [SalesEmployeeID]
    -- Make sure the target XRefID value from the mapping is prefixed with zero's to total length of 10 chars
    ,   RIGHT('0000000000'+CAST(mbp.target_XRefID AS VARCHAR(10)),10)    AS [ProjectID]
    ,   ibp.BusinessPartnerName                                          AS [Project]
    ,   SDIOrg.[SalesOrganizationID]
    ,   SDIOrg.[CURRENCYCODE]
    ,   SDIOrg.[InOutID]
    ,   SD.[SalesDistrictID]                                             AS [SalesDistrictID]
    ,   SDIOrg.SalesOfficeID
    ,   SDIOrg.[t_applicationId]
    ,   SDIOrg.[t_extractionDtm]
    FROM SalesDocumentItem_Filtered_Out_Organization SDIOrg
    LEFT JOIN [map_AXBI].[SalesEmployee] esa
        ON 
            esa.source_SalesPersonID = SDIOrg.[SALESGROUP]
    
/*    LEFT JOIN [map_AXBI].[SDDocumentCategory] AS SDDC
        ON 
            SDIOrg.SALESTYPE = SDDC.source_SalesTypeID
    
    LEFT JOIN [map_AXBI].[SalesDocumentType] AS SDT
        ON 
            SDIOrg.SALESTYPE = SDT.source_SalesTypeID */ --Ksenia task 1505
    
    LEFT JOIN [edw].[dim_SAPCustomerBasicMappingTable] AS SapCBMTSold
        ON 
            UPPER(SapCBMTSold.[AXDataAreaId]) = SDIOrg.[DATAAREAID]
            and
            SapCBMTSold.[AXCustomeraccount] = SDIOrg.[CUSTACCOUNT]
    LEFT JOIN
        [edw].[dim_Customer] DimCustSold
        ON
            DimCustSold.[CustomerExternalID] = SapCBMTSold.[SAPCustomeraccount]

    LEFT JOIN [edw].[dim_SAPCustomerBasicMappingTable] AS SapCBMTBill
        ON 
            UPPER(SapCBMTBill.[AXDataAreaId]) = SDIOrg.[DATAAREAID]
            and
            SapCBMTBill.[AXCustomeraccount] = SDIOrg.[INVOICEAACOUNT]
    LEFT JOIN
        [edw].[dim_Customer] DimCustBill
        ON
            DimCustBill.[CustomerExternalID] = SapCBMTBill.[SAPCustomeraccount]
    
    -- LEFT JOIN [map_AXBI].[Material] AS mapMaterial
    --     ON
    --         -- SapINBMTMat.[AXDataAreaId] = FSL_DOC.[DATAAREAID]
    --         -- AND
    --         mapMaterial.[source_Material] = FSL_DOC.[ITEMID]

    LEFT JOIN
        [edw].[dim_SAPItemNumberBasicMappingTable] AS SINMT
        ON
            SDIOrg.[ITEMID] = SINMT.[AXItemnumber]
            AND
            SINMT.[AXDataAreaId] = '0000'
            AND
            SINMT.[Migrate] IN ('Y', 'D')
            AND
            SINMT.SAPProductID IS NOT NULL
    LEFT JOIN 
        [map_AXBI].[SalesEmployee] se
        ON 
            se.source_SalesPersonID = SDIOrg.[SalesTaker]

    LEFT JOIN 
        intm_axbi.vw_FACT_SALESTABLE fst
        ON
            SDIOrg.[SALESID] = fst.[SALESID]

    LEFT JOIN
        [base_ff].[SalesDistrict] SD 
        ON 
        SDIOrg.[SalesOrganizationID] = SD.[SalesOrganizationID]
        AND
        fst.[DELIVERYCOUNTRYREGIONID] = SD.[CountryID]
        AND
        SD.[ZipCodeFrom] = fst.[DELIVERYZIPCODE]
        /*
        -- for Germany,  range is used relative to the postcode fields ZipCodeFrom, ZipCodeTo 
        -- for other countries these values are equal        
        (
            (
                SD.[CountryID] <> 'DE'
                AND
                SD.[ZipCodeFrom] = fst.[DELIVERYZIPCODE]  
            )
            OR
            (
                SD.[CountryID] = 'DE'
                AND
                (   
                    SD.[ZipCodeFrom] >= fst.[DELIVERYZIPCODE] 
                    AND 
                    fst.[DELIVERYZIPCODE] <= SD.[ZipCodeTo]
                )                                                        
            )
        ) */       
    LEFT JOIN 
        [map_AXBI].[SalesOrganization] mso
        ON
            fst.[DATAAREAID] = mso.[source_DataAreaID]

    LEFT JOIN 
        [map_AXBI].[BusinessPartner] mbp
        ON
            XRefType = 'PROJECTS-TO'
            AND
            -- Lookup the correct UDF Legacy ID and add AS a prefix 
            CONCAT(
                mso.[source_UDFLegacyID],
                fst.[HPLCUSTOMEROBJECTID]
            ) = mbp.source_XRefID

    LEFT JOIN 
        [base_s4h_cax].[I_BusinessPartner] ibp 
        ON 
            ibp.BusinessPartner = RIGHT('0000000000'+CAST(mbp.target_XRefID  AS VARCHAR(10)),10)
            -- AND 
            -- ibp.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
    LEFT JOIN 
        intm_axbi.vw_DIM_CUSTOMER DIM_CUST
        ON 
            DIM_CUST.[Customerno] = SDIOrg.[CUSTACCOUNT]
            AND
            DIM_CUST.[Company] = SDIOrg.[DATAAREAID]
     LEFT JOIN
        [map_AXBI].[Brand] mapBrand
        ON
        mapBrand.[source_DataAreaID]=SDIOrg.[DATAAREAID]
            
), 
subCalculationMargin AS (
    SELECT
        SDIaxbi.[SalesDocument]
    ,   SDIaxbi.[SalesDocumentItem]
    ,   SDIaxbi.[CurrencyID]
    ,   SDIaxbi.[ExchangeRate]
    ,   SDIaxbi.[SDDocumentCategoryID]
    ,   SDIaxbi.[SalesDocumentTypeID]
    ,   SDIaxbi.[IsReturnsItemID]
    ,   SDIaxbi.[CreationDate]
    ,   SDIaxbi.[CreationTime]
    ,   SDIaxbi.[MaterialID]
    ,   SDIaxbi.[BrandID]
    ,   SDIaxbi.[Brand]
    ,   SDIaxbi.[SoldToPartyID]
    ,   SDIaxbi.[BillToPartyID]
    ,   SDIaxbi.[OrderQuantity]
    ,   SDIaxbi.[CustomerGroupID]
    ,   SDIaxbi.[SoldToPartyID]                  AS [GlobalParentCalculatedID]
    ,   DIM_CUST_S4H.[Customer]                  AS [GlobalParentCalculated]
    ,   SDIaxbi.[SoldToPartyID]                  AS [LocalParentCalculatedID]
    ,   DIM_CUST_S4H.[Customer]                  AS [LocalParentCalculated]
    ,   SDIaxbi.[LineAmount_MST_TransDate]       AS [NetAmount_LOCAL]
    ,   SDIaxbi.[LineAmount_EUR_Createddatetime] AS [NetAmount_EUR]
    ,   CASE
            WHEN
                SDIaxbi.[CurrencyID] = 'EUR'
            THEN 
                SDIaxbi.[Margin_LOCAL]
            ELSE 
                SDIaxbi.[ExchangeRate] * SDIaxbi.[Margin_LOCAL]
        END AS [Margin_EUR]
    ,   SDIaxbi.[Margin_LOCAL]
    ,   SDIaxbi.[CURRENCYCODE]
    ,   SDIaxbi.[RequestedDeliveryDate]
    ,   SDIaxbi.[ExternalSalesAgentID]
    ,   SDIaxbi.[SalesEmployeeID]
    ,   SDIaxbi.[ProjectID]
    ,   SDIaxbi.[Project]
    ,   SDIaxbi.[SalesOrganizationID]
    ,   SDIaxbi.[InOutID]
    ,   SDIaxbi.[SalesDistrictID]
    ,   SDIaxbi.[SalesOfficeID]
    ,   SDIaxbi.[t_applicationId]
    ,   SDIaxbi.[t_extractionDtm]
    FROM    
        SalesDocumentItem_axbi_mapping SDIaxbi
    LEFT JOIN
        [edw].[dim_Customer] DIM_CUST_S4H
            on
                DIM_CUST_S4H.[CustomerID] = SDIaxbi.[SoldToPartyID]
)

SELECT
    edw.svf_getNaturalKey(SDIaxbi.[SalesDocument],SDIaxbi.[SalesDocumentItem],CR.[CurrencyTypeID]) AS [nk_fact_SalesDocumentItem]
,   SDIaxbi.[SalesDocument]
,   SDIaxbi.[SalesDocumentItem]
,   CR.[CurrencyTypeID]
,   CR.[CurrencyType]
,   CASE
        WHEN CCR.CurrencyTypeID = '10' THEN 1.0
        WHEN CCR.CurrencyTypeID = '40' THEN CCR40.[ExchangeRate]
        ELSE SDIaxbi.[ExchangeRate]
	END                                        AS [ExchangeRate]
,   CCR.[TargetCurrency]                       AS [CurrencyID]
,   SDIaxbi.[SDDocumentCategoryID]
,   SDIaxbi.[SalesDocumentTypeID]
,   SDIaxbi.[IsReturnsItemID]
,   SDIaxbi.[CreationDate]
,   SDIaxbi.[CreationTime]
,   SDIaxbi.[MaterialID]
,   SDIaxbi.[BrandID]
,   SDIaxbi.[Brand]
,   SDIaxbi.[SoldToPartyID]
,   SDIaxbi.[BillToPartyID]
,   SDIaxbi.[OrderQuantity]
,   SDIaxbi.[CustomerGroupID]
,   SDIaxbi.[GlobalParentCalculatedID]
,   SDIaxbi.[GlobalParentCalculated]
,   SDIaxbi.[LocalParentCalculatedID]
,   SDIaxbi.[LocalParentCalculated]
,   CASE
        WHEN CCR.CurrencyTypeID = '30' THEN SDIaxbi.[NetAmount_EUR]
        WHEN CCR.CurrencyTypeID = '40' THEN SDIaxbi.[NetAmount_EUR]*CCR40.[ExchangeRate]
        ELSE [NetAmount_LOCAL]
    END                                                                                     AS [NetAmount]
,   CASE
        WHEN CCR.CurrencyTypeID = '30' THEN SDIaxbi.[Margin_EUR]
        WHEN CCR.CurrencyTypeID = '40' THEN SDIaxbi.[Margin_EUR]*CCR40.[ExchangeRate]
        ELSE [Margin_LOCAL]
    END                                                                                     AS [Margin]
,   CASE
        WHEN CCR.CurrencyTypeID = '30' THEN SDIaxbi.[NetAmount_EUR]-SDIaxbi.[Margin_EUR]
        WHEN CCR.CurrencyTypeID = '40' THEN (SDIaxbi.[NetAmount_EUR]-SDIaxbi.[Margin_EUR])*CCR40.[ExchangeRate]
        ELSE SDIaxbi.[NetAmount_LOCAL] - SDIaxbi.[Margin_LOCAL]
    END                                                                                     AS [CostAmount]
,   SDIaxbi.[RequestedDeliveryDate]
,   SDIaxbi.[ExternalSalesAgentID]
,   SDIaxbi.[SalesEmployeeID]
,   SDIaxbi.[ProjectID]
,   SDIaxbi.[Project]
,   SDIaxbi.[SalesOrganizationID]
,   SDIaxbi.[InOutID]
,   SDIaxbi.[SalesDistrictID]
,   SDIaxbi.[SalesOfficeID]
,   SDIaxbi.[t_applicationId]
,   SDIaxbi.[t_extractionDtm]
FROM 
    subCalculationMargin SDIaxbi
LEFT JOIN [edw].[vw_CurrencyConversionRate] CCR
    ON SDIaxbi.CurrencyID = CCR.SourceCurrency    
LEFT JOIN 
    [edw].[dim_CurrencyType] CR
    ON CCR.CurrencyTypeID = CR.CurrencyTypeID
LEFT JOIN [edw].[vw_CurrencyConversionRate] CCR40
    ON CCR40.SourceCurrency= 'EUR' and CCR40.TargetCurrency = 'USD'
WHERE CCR.[CurrencyTypeID] <> '00'