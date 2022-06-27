﻿CREATE VIEW [edw].[vw_BillingDocumentItem_US]
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
,BillingDocumentItemBase AS
(SELECT
        CS.[INVOICE] AS [BillingDocument]                          
    ,   CAST(CAST(CS.[LineNo] as INT) AS CHAR(7)) AS [BillingDocumentItem]    
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
    ,   (CS.[SALES]+CS.[COGS]) AS [ProfitMargin]
    ,   CONCAT('US-',CS.[CostCenter]) AS [CostCenter]                               
    ,   CS.[SalesOrder] AS [SalesDocumentID]                          
    ,   MAPCUST.[Country] AS [CountryID]                                
    ,   CS.[SalesQty] AS [QuantitySold]                             
    --,   (CS.[NetAmount]-CS.[Cost]) AS [GrossMargin]                      
    ,   CS.[SALES] AS [FinNetAmount]                             
    ,   CS.[ImbFrtCost] AS [FinNetAmountFreight]
    ,   CS.[ImbFrtCost] AS [FinNetAmountOtherSales]
    ,   0 AS [FinNetAmountAllowances]                   
    ,   CS.[SALES] + CS.[ImbFrtCost] AS [FinSales100]  --temporary
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
),
BillingDocumentItemBase_Margin AS
(SELECT
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
    ,   BDI_Base.[ProfitMargin]
    ,   CASE
            WHEN
                BDI_Base.[NetAmount] = 0
                OR
                BDI_Base.[NetAmount] IS NULL
            THEN 0
            ELSE BDI_Base.[ProfitMargin]/BDI_Base.[NetAmount]
        END AS [MarginPercent]
    ,   BDI_Base.[CostCenter]                               
    ,   BDI_Base.[SalesDocumentID]                          
    ,   BDI_Base.[CountryID]                                
    ,   BDI_Base.[QuantitySold]                             
    ,   (BDI_Base.[NetAmount] - BDI_Base.[CostAmount]) AS [GrossMargin]
    ,   BDI_Base.[FinNetAmount]                             
    ,   BDI_Base.[FinNetAmountFreight]
    ,   BDI_Base.[FinNetAmountOtherSales]
    ,   BDI_Base.[FinNetAmountAllowances]                   
    ,   BDI_Base.[FinSales100]  --temporary
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
FROM BillingDocumentItemBase BDI_Base
)
SELECT
        BDI_Base_Margin.[BillingDocument]                          
    ,   BDI_Base_Margin.[BillingDocumentItem]                      
    ,   CT.[CurrencyTypeID]                           
    ,   CT.[CurrencyType]                 
    ,   BDI_Base_Margin.[BillingDocumentTypeID]
    ,   BDI_Base_Margin.[SDDocumentCategoryID]
    ,   BDI_Base_Margin.[BillingDocumentDate]                      
    ,   BDI_Base_Margin.[SalesOrganizationID]
    ,   BDI_Base_Margin.[MaterialGroupID]                          
    ,   BDI_Base_Margin.[NetAmount]                                
    ,   BDI_Base_Margin.[TransactionCurrencyID]                    
    ,   BDI_Base_Margin.[TaxAmount]                                
    ,   BDI_Base_Margin.[CostAmount]
    ,   BDI_Base_Margin.[ProfitMargin]
    ,   BDI_Base_Margin.[MarginPercent]
    ,   BDI_Base_Margin.[CostCenter]                               
    ,   'USD' AS [CurrencyID]                               
    ,   BDI_Base_Margin.[SalesDocumentID]                          
    ,   BDI_Base_Margin.[CountryID]                                
    ,   BDI_Base_Margin.[QuantitySold]                             
    ,   BDI_Base_Margin.[GrossMargin]                              
    ,   1.0 AS [ExchangeRate]                             
    ,   BDI_Base_Margin.[FinNetAmount]                             
    ,   BDI_Base_Margin.[FinNetAmountFreight]
    ,   BDI_Base_Margin.[FinNetAmountOtherSales]
    ,   BDI_Base_Margin.[FinNetAmountAllowances]                   
    ,   BDI_Base_Margin.[FinSales100]  --temporary
    ,   BDI_Base_Margin.[AccountingDate]                           
    ,   BDI_Base_Margin.[MaterialCalculated]                       
    ,   BDI_Base_Margin.[SoldToPartyCalculated]  
    ,   BDI_Base_Margin.[axbi_MaterialID]                          
    ,   BDI_Base_Margin.[axbi_CustomerID]                          
    ,   BDI_Base_Margin.[axbi_SalesTypeID]                         
    ,   BDI_Base_Margin.[SalesOrgname]                             
    ,   BDI_Base_Margin.[Pillar]                                   
    ,   BDI_Base_Margin.[MaterialLongDescription]                  
    ,   BDI_Base_Margin.[MaterialShortDescription]                 
    ,   BDI_Base_Margin.[CustomerName]                             
    ,   BDI_Base_Margin.[axbi_StorageLocationID]                   
    ,   BDI_Base_Margin.[axbi_CostCenter] 
    ,   BDI_Base_Margin.[SalesDistrictID]
    ,   BDI_Base_Margin.[CustomerGroupID]
    ,   BDI_Base_Margin.[InOutID]                         
    ,   BDI_Base_Margin.[t_applicationId]                          
    ,   BDI_Base_Margin.[t_extractionDtm]
FROM BillingDocumentItemBase_Margin BDI_Base_Margin
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
    ,   CONVERT(decimal(38,12),(BDI_ExchangeRate_Date.[ProfitMargin]*EuroBudgetExchangeRate.[ExchangeRate])) AS [ProfitMargin]
    ,   CONVERT(decimal(38,12),(BDI_ExchangeRate_Date.[MarginPercent]*EuroBudgetExchangeRate.[ExchangeRate])) AS [MarginPercent]
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
        BDI_Base_Margin.[BillingDocument]                          
    ,   BDI_Base_Margin.[BillingDocumentItem]      
    ,   BDI_Base_Margin.[BillingDocumentTypeID]
    ,   BDI_Base_Margin.[SDDocumentCategoryID]                                
    ,   BDI_Base_Margin.[BillingDocumentDate]               
    ,   BDI_Base_Margin.[SalesOrganizationID]
    ,   BDI_Base_Margin.[MaterialGroupID]                          
    ,   BDI_Base_Margin.[NetAmount]                                
    ,   BDI_Base_Margin.[TransactionCurrencyID]                    
    ,   BDI_Base_Margin.[TaxAmount]   
    ,   BDI_Base_Margin.[CostAmount]
    ,   BDI_Base_Margin.[ProfitMargin]
    ,   BDI_Base_Margin.[MarginPercent]
    ,   BDI_Base_Margin.[CostCenter]                               
    ,   'EUR' AS [CurrencyID]                               
    ,   BDI_Base_Margin.[SalesDocumentID]                          
    ,   BDI_Base_Margin.[CountryID]                                
    ,   BDI_Base_Margin.[QuantitySold]                             
    ,   BDI_Base_Margin.[GrossMargin]                                
    ,   BDI_Base_Margin.[FinNetAmount]                             
    ,   BDI_Base_Margin.[FinNetAmountFreight]
    ,   BDI_Base_Margin.[FinNetAmountOtherSales]
    ,   BDI_Base_Margin.[FinNetAmountAllowances]                   
    ,   BDI_Base_Margin.[FinSales100] -- temporary 
    ,   BDI_Base_Margin.[AccountingDate]                           
    ,   BDI_Base_Margin.[MaterialCalculated]                       
    ,   BDI_Base_Margin.[SoldToPartyCalculated]  
    ,   BDI_Base_Margin.[axbi_MaterialID]                          
    ,   BDI_Base_Margin.[axbi_CustomerID]                          
    ,   BDI_Base_Margin.[axbi_SalesTypeID]                         
    ,   BDI_Base_Margin.[SalesOrgname]                             
    ,   BDI_Base_Margin.[Pillar]                                   
    ,   BDI_Base_Margin.[MaterialLongDescription]                  
    ,   BDI_Base_Margin.[MaterialShortDescription]                 
    ,   BDI_Base_Margin.[CustomerName]                             
    ,   BDI_Base_Margin.[axbi_StorageLocationID]                   
    ,   BDI_Base_Margin.[axbi_CostCenter]                   
    ,   BDI_Base_Margin.[SalesDistrictID]
    ,   BDI_Base_Margin.[CustomerGroupID]
    ,   BDI_Base_Margin.[InOutID]                     
    ,   BDI_Base_Margin.[t_applicationId]                          
    ,   BDI_Base_Margin.[t_extractionDtm]
    ,   MAX(EuroBudgetExchangeRate.ExchangeRateEffectiveDate) AS [ExchangeRateEffectiveDate]
FROM BillingDocumentItemBase_Margin BDI_Base_Margin
LEFT JOIN 
    EuroBudgetExchangeRate
        ON EuroBudgetExchangeRate.SourceCurrency = 'USD'
WHERE
           EuroBudgetExchangeRate.ExchangeRateEffectiveDate <= BDI_Base_Margin.[BillingDocumentDate]
GROUP BY
        BDI_Base_Margin.[BillingDocument]                          
    ,   BDI_Base_Margin.[BillingDocumentItem]      
    ,   BDI_Base_Margin.[BillingDocumentTypeID]
    ,   BDI_Base_Margin.[SDDocumentCategoryID]                                
    ,   BDI_Base_Margin.[BillingDocumentDate]               
    ,   BDI_Base_Margin.[SalesOrganizationID]
    ,   BDI_Base_Margin.[MaterialGroupID]                          
    ,   BDI_Base_Margin.[NetAmount]                                
    ,   BDI_Base_Margin.[TransactionCurrencyID]                    
    ,   BDI_Base_Margin.[TaxAmount]   
    ,   BDI_Base_Margin.[CostAmount]
    ,   BDI_Base_Margin.[ProfitMargin]
    ,   BDI_Base_Margin.[MarginPercent]    
    ,   BDI_Base_Margin.[CostCenter]                               
    ,   BDI_Base_Margin.[SalesDocumentID]                          
    ,   BDI_Base_Margin.[CountryID]                                
    ,   BDI_Base_Margin.[QuantitySold]                             
    ,   BDI_Base_Margin.[GrossMargin]                                
    ,   BDI_Base_Margin.[FinNetAmount]                             
    ,   BDI_Base_Margin.[FinNetAmountFreight]
    ,   BDI_Base_Margin.[FinNetAmountOtherSales]
    ,   BDI_Base_Margin.[FinNetAmountAllowances]                   
    ,   BDI_Base_Margin.[FinSales100] -- temporary 
    ,   BDI_Base_Margin.[AccountingDate]                           
    ,   BDI_Base_Margin.[MaterialCalculated]                       
    ,   BDI_Base_Margin.[SoldToPartyCalculated]  
    ,   BDI_Base_Margin.[axbi_MaterialID]                          
    ,   BDI_Base_Margin.[axbi_CustomerID]                          
    ,   BDI_Base_Margin.[axbi_SalesTypeID]                         
    ,   BDI_Base_Margin.[SalesOrgname]                             
    ,   BDI_Base_Margin.[Pillar]                                   
    ,   BDI_Base_Margin.[MaterialLongDescription]                  
    ,   BDI_Base_Margin.[MaterialShortDescription]                 
    ,   BDI_Base_Margin.[CustomerName]                             
    ,   BDI_Base_Margin.[axbi_StorageLocationID]                   
    ,   BDI_Base_Margin.[axbi_CostCenter]                   
    ,   BDI_Base_Margin.[SalesDistrictID]
    ,   BDI_Base_Margin.[CustomerGroupID]
    ,   BDI_Base_Margin.[InOutID]                     
    ,   BDI_Base_Margin.[t_applicationId]                          
    ,   BDI_Base_Margin.[t_extractionDtm]
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
        BDI_Base_Margin.[BillingDocument]                          
    ,   BDI_Base_Margin.[BillingDocumentItem]                      
    ,   CT.[CurrencyTypeID]                           
    ,   CT.[CurrencyType]                 
    ,   BDI_Base_Margin.[BillingDocumentTypeID]
    ,   BDI_Base_Margin.[SDDocumentCategoryID]
    ,   BDI_Base_Margin.[BillingDocumentDate]                      
    ,   BDI_Base_Margin.[SalesOrganizationID]
    ,   BDI_Base_Margin.[MaterialGroupID]                          
    ,   BDI_Base_Margin.[NetAmount]                                
    ,   BDI_Base_Margin.[TransactionCurrencyID]                    
    ,   BDI_Base_Margin.[TaxAmount]                                
    ,   BDI_Base_Margin.[CostAmount] 
    ,   BDI_Base_Margin.[ProfitMargin]
    ,   BDI_Base_Margin.[MarginPercent]                              
    ,   BDI_Base_Margin.[CostCenter]                               
    ,   'USD' AS [CurrencyID]                               
    ,   BDI_Base_Margin.[SalesDocumentID]                          
    ,   BDI_Base_Margin.[CountryID]                                
    ,   BDI_Base_Margin.[QuantitySold]                             
    ,   BDI_Base_Margin.[GrossMargin]                              
    ,   1.0 AS [ExchangeRate]                             
    ,   BDI_Base_Margin.[FinNetAmount]                             
    ,   BDI_Base_Margin.[FinNetAmountFreight]
    ,   BDI_Base_Margin.[FinNetAmountOtherSales]
    ,   BDI_Base_Margin.[FinNetAmountAllowances]                   
    ,   BDI_Base_Margin.[FinSales100]  --temporary
    ,   BDI_Base_Margin.[AccountingDate]                           
    ,   BDI_Base_Margin.[MaterialCalculated]                       
    ,   BDI_Base_Margin.[SoldToPartyCalculated]  
    ,   BDI_Base_Margin.[axbi_MaterialID]                          
    ,   BDI_Base_Margin.[axbi_CustomerID]                          
    ,   BDI_Base_Margin.[axbi_SalesTypeID]                         
    ,   BDI_Base_Margin.[SalesOrgname]                             
    ,   BDI_Base_Margin.[Pillar]                                   
    ,   BDI_Base_Margin.[MaterialLongDescription]                  
    ,   BDI_Base_Margin.[MaterialShortDescription]                 
    ,   BDI_Base_Margin.[CustomerName]                             
    ,   BDI_Base_Margin.[axbi_StorageLocationID]                   
    ,   BDI_Base_Margin.[axbi_CostCenter] 
    ,   BDI_Base_Margin.[SalesDistrictID]
    ,   BDI_Base_Margin.[CustomerGroupID]
    ,   BDI_Base_Margin.[InOutID]                         
    ,   BDI_Base_Margin.[t_applicationId]                          
    ,   BDI_Base_Margin.[t_extractionDtm]
FROM BillingDocumentItemBase_Margin BDI_Base_Margin
CROSS JOIN
    [edw].[dim_CurrencyType] CT
WHERE
    CT.[CurrencyTypeID] = '40'