CREATE VIEW [edw].[vw_BillingDocumentItem_US]
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
), 
CTE_DeliveryCharge AS
(SELECT
        CS.[INVOICE]
    ,   SUM(CS.[SALES]) AS [DeliveryCharge]
FROM
    [base_us_leviat_db].[CUSTOMER_SALES] CS
WHERE
    CS.[ItemName] LIKE 'Delivery Charge%'
GROUP BY
     CS.[INVOICE]
),
CTE_SumSales AS
(SELECT
        CS.[INVOICE]
    ,   SUM(CS.[SALES]) AS [SumSales]
FROM
    [base_us_leviat_db].[CUSTOMER_SALES] CS
WHERE
    CS.[ItemName] NOT LIKE 'Delivery Charge%'
GROUP BY
     CS.[INVOICE]
)
,BillingDocumentItemBase AS
(SELECT
        CS.[INVOICE] AS [BillingDocument]
    ,   RIGHT(
             CONCAT(
                    '0000',
                    10*ROW_NUMBER() OVER(PARTITION BY CS.[INVOICE] ORDER BY CS.[LineNo] ASC)
             )
             ,6
        ) AS [BillingDocumentItem]
    ,    CASE
            WHEN 
			     CS.[INVOICE] LIKE 'C%' 
            THEN
                'G2'
            ELSE 
                'F2'
        END AS [BillingDocumentTypeID]
    ,    CASE
            WHEN 
			     CS.[INVOICE] LIKE 'C%' 
            THEN
                'O'
            ELSE 
                'M'
        END AS [SDDocumentCategoryID]
   -- ,   CS.[] AS [CurrencyTypeID]                           
   -- ,   CS.[] AS [CurrencyType]                             
    ,   CS.[InvDate] AS [BillingDocumentDate]                      
    ,   CONCAT('US-',CS.[COMP]) AS [SalesOrganizationID]
    ,   CS.[ItemGroup] AS [MaterialGroupID]                          
    ,   CS.[SALES] AS [NetAmount]                                
    ,   CS.[CUR] AS [TransactionCurrencyID]                    
    ,   CS.[SalesTax] AS [TaxAmount]                                
    ,   CS.[COGS] AS [CostAmount]
    ,   CONCAT('US-',CS.[CostCenter]) AS [CostCenter]                               
    ,   CS.[SalesOrder] AS [SalesDocumentID]                          
    ,   MAPCUST.[Country] AS [CountryID]                                
    ,   CS.[SalesQty] AS [QuantitySold]                             
    ,   (CS.[SALES]-CS.[COGS]) AS [GrossMargin]                      
    ,   CS.[SALES] AS [FinNetAmount]
    ,   CASE 
            WHEN ISNULL(SS.[SumSales],0) != 0 
                 AND
                 CS.[ItemName] NOT LIKE 'Delivery Charge%'
            THEN CS.[SALES]/SS.[SumSales]*DC.[DeliveryCharge] 
            ELSE 0
        END AS [FinNetAmountFreight]
    --,   CS.[ImbFrtCost] AS [FinNetAmountOtherSales]
    ,   0 AS [FinNetAmountAllowances]
    --,   CS.[SALES] + ISNULL(DC.[DeliveryCharge],0) AS [FinSales100]
    ,   CS.[InvDate] AS [AccountingDate]                           
    ,   CONCAT(CS.[COMP],'-',CS.[ITEM]) AS [MaterialCalculated]                       
    ,   CONCAT(CS.[COMP],'-',CS.[CUSTOMER]) AS [SoldToPartyCalculated]  
    ,   CONCAT(CS.[COMP],'-',CS.[ITEM]) AS [axbi_MaterialID]                          
    ,   CONCAT(CS.[COMP],'-',CS.[CUSTOMER]) AS [axbi_CustomerID]                          
    ,   CS.[SALESTYPE] AS [axbi_SalesTypeID]                         
    ,   CS.[CompName] AS [SalesOrgname]                             
    ,   PCAT.[Pillar] AS [Pillar]                                   
    ,   CS.[ItemName] AS [MaterialLongDescription]                  
    ,   CS.[ItemName] AS [MaterialShortDescription]                 
    ,   CS.[CustName] AS [CustomerName]                             
    ,   CS.[WH] AS [axbi_StorageLocationID]                   
    ,   CS.[CostCenter] AS [axbi_CostCenter]
    ,   MAPCUST.[Region] AS [SalesDistrictID]
    ,   MAPCUST.[CustomerPillar] AS [CustomerGroupID]
    ,   CASE WHEN MAPCUST.[InsideOutside] IS NOT NULL
        THEN
            MAPCUST.[InsideOutside]
        ELSE
            'O'
        END AS [InOutID]
    ,   CS.[t_applicationId]                          
    ,   CS.[t_extractionDtm]
FROM 
    [base_us_leviat_db].[CUSTOMER_SALES] CS
LEFT JOIN
    [base_us_leviat_db].[CUSTOMERS] CUST
        ON CS.[CUSTOMER] = CUST.[CUSTOMER] 
           AND 
           CS.[COMP] = CUST.[COMP]
LEFT JOIN
    [map_USA].[Customer] MAPCUST
        ON MAPCUST.[UniqueCustomerNumber] = CONCAT(CS.[COMP],'-',CS.[CUSTOMER])
LEFT JOIN
    [base_ff_USA].[SubPCAT_Pillar] PCAT
        ON PCAT.[PCAT] = CS.[PCAT]
           AND 
           PCAT.[SubPCAT] = CS.[SubPCAT]
LEFT JOIN
    CTE_DeliveryCharge DC
        ON DC.[INVOICE] = CS.[INVOICE]
LEFT JOIN
    CTE_SumSales SS
        ON SS.[INVOICE] = CS.[INVOICE]
),
BillingDocumentItemBase_KPI AS (
SELECT
        BDI_Base.[BillingDocument]                          
    ,   BDI_Base.[BillingDocumentItem] 
    ,   BDI_Base.[BillingDocumentTypeID]
    ,   BDI_Base.[SDDocumentCategoryID]
    ,   BDI_Base.[BillingDocumentDate]                      
    ,   BDI_Base.[SalesOrganizationID]
    ,   BDI_Base.[MaterialGroupID]                          
    ,   BDI_Base.[NetAmount]                                
    ,   BDI_Base.[TransactionCurrencyID]                    
    ,   BDI_Base.[TaxAmount]                                
    ,   BDI_Base.[CostAmount]
    ,   BDI_Base.[CostCenter]  
    ,   BDI_Base.[SalesDocumentID]                          
    ,   BDI_Base.[CountryID]                                
    ,   BDI_Base.[QuantitySold]                             
    ,   BDI_Base.[GrossMargin]              
    ,   BDI_Base.[FinNetAmount]                             
    ,   BDI_Base.[FinNetAmountFreight]
    ,   BDI_Base.[FinNetAmountFreight] AS [FinNetAmountOtherSales]
    ,   BDI_Base.[FinNetAmountAllowances]                   
    ,   CASE
            WHEN BDI_Base.[MaterialLongDescription] NOT LIKE 'Delivery Charge%'
            THEN (BDI_Base.[NetAmount] + ISNULL([FinNetAmountFreight],0))
            ELSE 0
        END AS [FinSales100]  --temporary
    ,   BDI_Base.[AccountingDate]                           
    ,   BDI_Base.[MaterialCalculated]                       
    ,   BDI_Base.[SoldToPartyCalculated]  
    ,   BDI_Base.[axbi_MaterialID]                          
    ,   BDI_Base.[axbi_CustomerID]                          
    ,   BDI_Base.[axbi_SalesTypeID]                         
    ,   BDI_Base.[SalesOrgname]                             
    ,   BDI_Base.[Pillar]                                   
    ,   BDI_Base.[MaterialLongDescription]                  
    ,   BDI_Base.[MaterialShortDescription]                 
    ,   BDI_Base.[CustomerName]                             
    ,   BDI_Base.[axbi_StorageLocationID]                   
    ,   BDI_Base.[axbi_CostCenter] 
    ,   BDI_Base.[SalesDistrictID]
    ,   BDI_Base.[CustomerGroupID]
    ,   BDI_Base.[InOutID]                         
    ,   BDI_Base.[t_applicationId]                          
    ,   BDI_Base.[t_extractionDtm]
FROM
    BillingDocumentItemBase BDI_Base)
SELECT
        BDI_Base_KPI.[BillingDocument]                          
    ,   BDI_Base_KPI.[BillingDocumentItem]                      
    ,   CT.[CurrencyTypeID]                           
    ,   CT.[CurrencyType]                 
    ,   BDI_Base_KPI.[BillingDocumentTypeID]
    ,   BDI_Base_KPI.[SDDocumentCategoryID]
    ,   BDI_Base_KPI.[BillingDocumentDate]                      
    ,   BDI_Base_KPI.[SalesOrganizationID]
    ,   BDI_Base_KPI.[MaterialGroupID]                          
    ,   BDI_Base_KPI.[NetAmount]                                
    ,   BDI_Base_KPI.[TransactionCurrencyID]                    
    ,   BDI_Base_KPI.[TaxAmount]                                
    ,   BDI_Base_KPI.[CostAmount]
    ,   BDI_Base_KPI.[CostCenter]                               
    ,   'USD' AS [CurrencyID]                               
    ,   BDI_Base_KPI.[SalesDocumentID]                          
    ,   BDI_Base_KPI.[CountryID]                                
    ,   BDI_Base_KPI.[QuantitySold]                             
    ,   BDI_Base_KPI.[GrossMargin]                              
    ,   1.0 AS [ExchangeRate]                             
    ,   BDI_Base_KPI.[FinNetAmount]                             
    ,   BDI_Base_KPI.[FinNetAmountFreight]
    ,   BDI_Base_KPI.[FinNetAmountOtherSales]
    ,   BDI_Base_KPI.[FinNetAmountAllowances]                   
    ,   BDI_Base_KPI.[FinSales100]  --temporary
    ,   BDI_Base_KPI.[AccountingDate]                           
    ,   BDI_Base_KPI.[MaterialCalculated]                       
    ,   BDI_Base_KPI.[SoldToPartyCalculated]  
    ,   BDI_Base_KPI.[axbi_MaterialID]                          
    ,   BDI_Base_KPI.[axbi_CustomerID]                          
    ,   BDI_Base_KPI.[axbi_SalesTypeID]                         
    ,   BDI_Base_KPI.[SalesOrgname]                             
    ,   BDI_Base_KPI.[Pillar]                                   
    ,   BDI_Base_KPI.[MaterialLongDescription]                  
    ,   BDI_Base_KPI.[MaterialShortDescription]                 
    ,   BDI_Base_KPI.[CustomerName]                             
    ,   BDI_Base_KPI.[axbi_StorageLocationID]                   
    ,   BDI_Base_KPI.[axbi_CostCenter] 
    ,   BDI_Base_KPI.[SalesDistrictID]
    ,   BDI_Base_KPI.[CustomerGroupID]
    ,   BDI_Base_KPI.[InOutID]                         
    ,   BDI_Base_KPI.[t_applicationId]                          
    ,   BDI_Base_KPI.[t_extractionDtm]
FROM BillingDocumentItemBase_KPI BDI_Base_KPI
CROSS JOIN
    [edw].[dim_CurrencyType] CT
WHERE
    CT.[CurrencyTypeID] = '10'

UNION ALL

SELECT
        BDI_ExchangeRate_Date.[BillingDocument]                          
    ,   BDI_ExchangeRate_Date.[BillingDocumentItem]                      
    ,   CT.[CurrencyTypeID]                           
    ,   CT.[CurrencyType]    
    ,   BDI_ExchangeRate_Date.[BillingDocumentTypeID]
    ,   BDI_ExchangeRate_Date.[SDDocumentCategoryID]                                
    ,   BDI_ExchangeRate_Date.[BillingDocumentDate]               
    ,   BDI_ExchangeRate_Date.[SalesOrganizationID]
    ,   BDI_ExchangeRate_Date.[MaterialGroupID]                          
    ,   CONVERT(decimal(28,12),(BDI_ExchangeRate_Date.[NetAmount]*EuroBudgetExchangeRate.[ExchangeRate])) AS [NetAmount]                                
    ,   BDI_ExchangeRate_Date.[TransactionCurrencyID]                    
    ,   CONVERT(decimal(28,12),(BDI_ExchangeRate_Date.[TaxAmount]*EuroBudgetExchangeRate.[ExchangeRate])) AS [TaxAmount]   
    ,   CONVERT(decimal(38,12),(BDI_ExchangeRate_Date.[CostAmount]*EuroBudgetExchangeRate.[ExchangeRate])) AS [CostAmount] 
    ,   BDI_ExchangeRate_Date.[CostCenter]                               
    ,   BDI_ExchangeRate_Date.[CurrencyID]                               
    ,   BDI_ExchangeRate_Date.[SalesDocumentID]                          
    ,   BDI_ExchangeRate_Date.[CountryID]                                
    ,   BDI_ExchangeRate_Date.[QuantitySold]                             
    ,   BDI_ExchangeRate_Date.[GrossMargin]*EuroBudgetExchangeRate.[ExchangeRate] AS [GrossMargin]                              
    ,   EuroBudgetExchangeRate.[ExchangeRate]                             
    ,   CONVERT(decimal(28,12),(BDI_ExchangeRate_Date.[FinNetAmount]*EuroBudgetExchangeRate.[ExchangeRate])) AS [FinNetAmount]                             
    ,   CONVERT(decimal(28,12),(BDI_ExchangeRate_Date.[FinNetAmountFreight]*EuroBudgetExchangeRate.[ExchangeRate])) AS [FinNetAmountFreight]
    ,   CONVERT(decimal(28,12),(BDI_ExchangeRate_Date.[FinNetAmountOtherSales]*EuroBudgetExchangeRate.[ExchangeRate])) AS [FinNetAmountOtherSales]
    ,   CONVERT(decimal(28,12),(BDI_ExchangeRate_Date.[FinNetAmountAllowances]*EuroBudgetExchangeRate.[ExchangeRate])) AS [FinNetAmountAllowances]                   
    ,   CONVERT(decimal(28,12),(BDI_ExchangeRate_Date.[FinSales100]*EuroBudgetExchangeRate.[ExchangeRate])) AS [FinSales100] -- temporary 
    ,   BDI_ExchangeRate_Date.[AccountingDate]                           
    ,   BDI_ExchangeRate_Date.[MaterialCalculated]                       
    ,   BDI_ExchangeRate_Date.[SoldToPartyCalculated]  
    ,   BDI_ExchangeRate_Date.[axbi_MaterialID]                          
    ,   BDI_ExchangeRate_Date.[axbi_CustomerID]                          
    ,   BDI_ExchangeRate_Date.[axbi_SalesTypeID]                         
    ,   BDI_ExchangeRate_Date.[SalesOrgname]                             
    ,   BDI_ExchangeRate_Date.[Pillar]                                   
    ,   BDI_ExchangeRate_Date.[MaterialLongDescription]                  
    ,   BDI_ExchangeRate_Date.[MaterialShortDescription]                 
    ,   BDI_ExchangeRate_Date.[CustomerName]                             
    ,   BDI_ExchangeRate_Date.[axbi_StorageLocationID]                   
    ,   BDI_ExchangeRate_Date.[axbi_CostCenter]                   
    ,   BDI_ExchangeRate_Date.[SalesDistrictID]
    ,   BDI_ExchangeRate_Date.[CustomerGroupID]
    ,   BDI_ExchangeRate_Date.[InOutID]                     
    ,   BDI_ExchangeRate_Date.[t_applicationId]                          
    ,   BDI_ExchangeRate_Date.[t_extractionDtm]
FROM
(SELECT 
        BDI_Base_KPI.[BillingDocument]                          
    ,   BDI_Base_KPI.[BillingDocumentItem]      
    ,   BDI_Base_KPI.[BillingDocumentTypeID]
    ,   BDI_Base_KPI.[SDDocumentCategoryID]                                
    ,   BDI_Base_KPI.[BillingDocumentDate]               
    ,   BDI_Base_KPI.[SalesOrganizationID]
    ,   BDI_Base_KPI.[MaterialGroupID]                          
    ,   BDI_Base_KPI.[NetAmount]                                
    ,   BDI_Base_KPI.[TransactionCurrencyID]                    
    ,   BDI_Base_KPI.[TaxAmount]   
    ,   BDI_Base_KPI.[CostAmount]
    ,   BDI_Base_KPI.[CostCenter]                               
    ,   'EUR' AS [CurrencyID]                               
    ,   BDI_Base_KPI.[SalesDocumentID]                          
    ,   BDI_Base_KPI.[CountryID]                                
    ,   BDI_Base_KPI.[QuantitySold]                             
    ,   BDI_Base_KPI.[GrossMargin]                                
    ,   BDI_Base_KPI.[FinNetAmount]                             
    ,   BDI_Base_KPI.[FinNetAmountFreight]
    ,   BDI_Base_KPI.[FinNetAmountOtherSales]
    ,   BDI_Base_KPI.[FinNetAmountAllowances]                   
    ,   BDI_Base_KPI.[FinSales100] -- temporary 
    ,   BDI_Base_KPI.[AccountingDate]                           
    ,   BDI_Base_KPI.[MaterialCalculated]                       
    ,   BDI_Base_KPI.[SoldToPartyCalculated]  
    ,   BDI_Base_KPI.[axbi_MaterialID]                          
    ,   BDI_Base_KPI.[axbi_CustomerID]                          
    ,   BDI_Base_KPI.[axbi_SalesTypeID]                         
    ,   BDI_Base_KPI.[SalesOrgname]                             
    ,   BDI_Base_KPI.[Pillar]                                   
    ,   BDI_Base_KPI.[MaterialLongDescription]                  
    ,   BDI_Base_KPI.[MaterialShortDescription]                 
    ,   BDI_Base_KPI.[CustomerName]                             
    ,   BDI_Base_KPI.[axbi_StorageLocationID]                   
    ,   BDI_Base_KPI.[axbi_CostCenter]                   
    ,   BDI_Base_KPI.[SalesDistrictID]
    ,   BDI_Base_KPI.[CustomerGroupID]
    ,   BDI_Base_KPI.[InOutID]                     
    ,   BDI_Base_KPI.[t_applicationId]                          
    ,   BDI_Base_KPI.[t_extractionDtm]
    ,   MAX(EuroBudgetExchangeRate.ExchangeRateEffectiveDate) AS [ExchangeRateEffectiveDate]
FROM BillingDocumentItemBase_KPI BDI_Base_KPI
LEFT JOIN 
    EuroBudgetExchangeRate
        ON EuroBudgetExchangeRate.SourceCurrency = 'USD'
WHERE
           EuroBudgetExchangeRate.ExchangeRateEffectiveDate <= BDI_Base_KPI.[BillingDocumentDate]
GROUP BY
        BDI_Base_KPI.[BillingDocument]                          
    ,   BDI_Base_KPI.[BillingDocumentItem]      
    ,   BDI_Base_KPI.[BillingDocumentTypeID]
    ,   BDI_Base_KPI.[SDDocumentCategoryID]                                
    ,   BDI_Base_KPI.[BillingDocumentDate]               
    ,   BDI_Base_KPI.[SalesOrganizationID]
    ,   BDI_Base_KPI.[MaterialGroupID]                          
    ,   BDI_Base_KPI.[NetAmount]                                
    ,   BDI_Base_KPI.[TransactionCurrencyID]                    
    ,   BDI_Base_KPI.[TaxAmount]   
    ,   BDI_Base_KPI.[CostAmount]
    ,   BDI_Base_KPI.[CostCenter]                               
    ,   BDI_Base_KPI.[SalesDocumentID]                          
    ,   BDI_Base_KPI.[CountryID]                                
    ,   BDI_Base_KPI.[QuantitySold]                             
    ,   BDI_Base_KPI.[GrossMargin]                                
    ,   BDI_Base_KPI.[FinNetAmount]                             
    ,   BDI_Base_KPI.[FinNetAmountFreight]
    ,   BDI_Base_KPI.[FinNetAmountOtherSales]
    ,   BDI_Base_KPI.[FinNetAmountAllowances]                   
    ,   BDI_Base_KPI.[FinSales100] -- temporary 
    ,   BDI_Base_KPI.[AccountingDate]                           
    ,   BDI_Base_KPI.[MaterialCalculated]                       
    ,   BDI_Base_KPI.[SoldToPartyCalculated]  
    ,   BDI_Base_KPI.[axbi_MaterialID]                          
    ,   BDI_Base_KPI.[axbi_CustomerID]                          
    ,   BDI_Base_KPI.[axbi_SalesTypeID]                         
    ,   BDI_Base_KPI.[SalesOrgname]                             
    ,   BDI_Base_KPI.[Pillar]                                   
    ,   BDI_Base_KPI.[MaterialLongDescription]                  
    ,   BDI_Base_KPI.[MaterialShortDescription]                 
    ,   BDI_Base_KPI.[CustomerName]                             
    ,   BDI_Base_KPI.[axbi_StorageLocationID]                   
    ,   BDI_Base_KPI.[axbi_CostCenter]                   
    ,   BDI_Base_KPI.[SalesDistrictID]
    ,   BDI_Base_KPI.[CustomerGroupID]
    ,   BDI_Base_KPI.[InOutID]                     
    ,   BDI_Base_KPI.[t_applicationId]                          
    ,   BDI_Base_KPI.[t_extractionDtm]
) BDI_ExchangeRate_Date
LEFT JOIN 
    EuroBudgetExchangeRate
    ON
        EuroBudgetExchangeRate.[SourceCurrency] = 'USD'
        AND
        BDI_ExchangeRate_Date.[ExchangeRateEffectiveDate] = EuroBudgetExchangeRate.[ExchangeRateEffectiveDate]
CROSS JOIN
    [edw].[dim_CurrencyType] CT
WHERE
    CT.[CurrencyTypeID] = '30'

UNION ALL

SELECT
        BDI_Base_KPI.[BillingDocument]                          
    ,   BDI_Base_KPI.[BillingDocumentItem]                      
    ,   CT.[CurrencyTypeID]                           
    ,   CT.[CurrencyType]                 
    ,   BDI_Base_KPI.[BillingDocumentTypeID]
    ,   BDI_Base_KPI.[SDDocumentCategoryID]
    ,   BDI_Base_KPI.[BillingDocumentDate]                      
    ,   BDI_Base_KPI.[SalesOrganizationID]
    ,   BDI_Base_KPI.[MaterialGroupID]                          
    ,   BDI_Base_KPI.[NetAmount]                                
    ,   BDI_Base_KPI.[TransactionCurrencyID]                    
    ,   BDI_Base_KPI.[TaxAmount]                                
    ,   BDI_Base_KPI.[CostAmount]
    ,   BDI_Base_KPI.[CostCenter]                               
    ,   'USD' AS [CurrencyID]                               
    ,   BDI_Base_KPI.[SalesDocumentID]                          
    ,   BDI_Base_KPI.[CountryID]                                
    ,   BDI_Base_KPI.[QuantitySold]                             
    ,   BDI_Base_KPI.[GrossMargin]                              
    ,   1.0 AS [ExchangeRate]                             
    ,   BDI_Base_KPI.[FinNetAmount]                             
    ,   BDI_Base_KPI.[FinNetAmountFreight]
    ,   BDI_Base_KPI.[FinNetAmountFreight] AS [FinNetAmountOtherSales]
    ,   BDI_Base_KPI.[FinNetAmountAllowances]                   
    ,   BDI_Base_KPI.[FinSales100]  --temporary
    ,   BDI_Base_KPI.[AccountingDate]                           
    ,   BDI_Base_KPI.[MaterialCalculated]                       
    ,   BDI_Base_KPI.[SoldToPartyCalculated]  
    ,   BDI_Base_KPI.[axbi_MaterialID]                          
    ,   BDI_Base_KPI.[axbi_CustomerID]                          
    ,   BDI_Base_KPI.[axbi_SalesTypeID]                         
    ,   BDI_Base_KPI.[SalesOrgname]                             
    ,   BDI_Base_KPI.[Pillar]                                   
    ,   BDI_Base_KPI.[MaterialLongDescription]                  
    ,   BDI_Base_KPI.[MaterialShortDescription]                 
    ,   BDI_Base_KPI.[CustomerName]                             
    ,   BDI_Base_KPI.[axbi_StorageLocationID]                   
    ,   BDI_Base_KPI.[axbi_CostCenter] 
    ,   BDI_Base_KPI.[SalesDistrictID]
    ,   BDI_Base_KPI.[CustomerGroupID]
    ,   BDI_Base_KPI.[InOutID]                         
    ,   BDI_Base_KPI.[t_applicationId]                          
    ,   BDI_Base_KPI.[t_extractionDtm]
FROM BillingDocumentItemBase_KPI BDI_Base_KPI
CROSS JOIN
    [edw].[dim_CurrencyType] CT
WHERE
    CT.[CurrencyTypeID] = '40'