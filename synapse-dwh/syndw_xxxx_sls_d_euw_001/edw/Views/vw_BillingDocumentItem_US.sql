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
        ExchangeRateType = 'P'
        AND
        TargetCurrency = 'EUR'
        AND
        ExchangeRateEffectiveDate <= GETDATE()
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
    ,   CASE 
            WHEN MAPCUST.[InsideOutside] = 'I' then 'IC_Lev'
            WHEN MAPCUST.[InsideOutside] = 'O' then 'OC'
            ELSE MAPCUST.[InsideOutside]
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
)
SELECT
        BDI_Base.[BillingDocument]                          
    ,   BDI_Base.[BillingDocumentItem]                      
    ,   CT.[CurrencyTypeID]                           
    ,   CT.[CurrencyType]                 
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
    ,   'USD' AS [CurrencyID]                               
    ,   BDI_Base.[SalesDocumentID]                          
    ,   BDI_Base.[CountryID]                                
    ,   BDI_Base.[QuantitySold]                             
    ,   BDI_Base.[GrossMargin]
    ,   1.0 AS [ExchangeRate]                             
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
JOIN
    [edw].[dim_CurrencyType] CT
    ON CT.[CurrencyTypeID] = '10'

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
    ,   'EUR' AS [CurrencyID]                               
    ,   BDI_Base.[SalesDocumentID]                          
    ,   BDI_Base.[CountryID]                                
    ,   BDI_Base.[QuantitySold]                             
    ,   BDI_Base.[GrossMargin]                                
    ,   BDI_Base.[FinNetAmount]                             
    ,   BDI_Base.[FinNetAmountFreight]
    ,   BDI_Base.[FinNetAmountOtherSales]
    ,   BDI_Base.[FinNetAmountAllowances]                   
    ,   BDI_Base.[FinSales100] -- temporary 
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
    ,   MAX(EuroBudgetExchangeRate.ExchangeRateEffectiveDate) AS [ExchangeRateEffectiveDate]
FROM BillingDocumentItemBase BDI_Base
LEFT JOIN 
    EuroBudgetExchangeRate
        ON EuroBudgetExchangeRate.SourceCurrency = 'USD'
--WHERE
            --BDI_Base.[BillingDocumentDate]
GROUP BY
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
    ,   BDI_Base.[FinNetAmountOtherSales]
    ,   BDI_Base.[FinNetAmountAllowances]                   
    ,   BDI_Base.[FinSales100] -- temporary 
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
) BDI_ExchangeRate_Date
LEFT JOIN 
    EuroBudgetExchangeRate
    ON
        EuroBudgetExchangeRate.[SourceCurrency] = 'USD'
        AND
        BDI_ExchangeRate_Date.[ExchangeRateEffectiveDate] = EuroBudgetExchangeRate.[ExchangeRateEffectiveDate]
JOIN
    [edw].[dim_CurrencyType] CT
    ON CT.[CurrencyTypeID] = '30'

UNION ALL

SELECT
        BDI_Base.[BillingDocument]                          
    ,   BDI_Base.[BillingDocumentItem]                      
    ,   CT.[CurrencyTypeID]                           
    ,   CT.[CurrencyType]                 
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
    ,   'USD' AS [CurrencyID]                               
    ,   BDI_Base.[SalesDocumentID]                          
    ,   BDI_Base.[CountryID]                                
    ,   BDI_Base.[QuantitySold]                             
    ,   BDI_Base.[GrossMargin]                              
    ,   1.0 AS [ExchangeRate]                             
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
JOIN
    [edw].[dim_CurrencyType] CT
    ON CT.[CurrencyTypeID] = '40'