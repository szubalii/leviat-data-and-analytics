CREATE VIEW [edw].[vw_BillingDocumentItem_US]
    AS 
WITH BillingDocumentItemBase AS
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
    ,   CONVERT(decimal(28,12),(BDI_Base.[NetAmount]*CCR.[ExchangeRate]))               AS [NetAmount]
    ,   BDI_Base.[TransactionCurrencyID]                    
    ,   CONVERT(decimal(28,12),(BDI_Base.[TaxAmount]*CCR.[ExchangeRate]))               AS [TaxAmount]
    ,   CONVERT(decimal(28,12),(BDI_Base.[CostAmount]*CCR.[ExchangeRate]))              AS [CostAmount]
    ,   BDI_Base.[CostCenter]                               
    ,   CASE
            WHEN CCR.CurrencyTypeID = '10'
                THEN 'USD'
            ELSE CCR.[TargetCurrency]
        END                                                                             AS [CurrencyID]
    ,   BDI_Base.[SalesDocumentID]                          
    ,   BDI_Base.[CountryID]                                
    ,   BDI_Base.[QuantitySold]                             
    ,   BDI_Base.[GrossMargin]
    ,   CASE
            WHEN CCR.CurrencyTypeID = '10' 
                THEN 1.0
            ELSE  CCR.[ExchangeRate]
	    END                                                                             AS [ExchangeRate]
    ,   CONVERT(decimal(28,12),(BDI_Base.[FinNetAmount]*CCR.[ExchangeRate]))            AS [FinNetAmount]
    ,   CONVERT(decimal(28,12),(BDI_Base.[FinNetAmountFreight]*CCR.[ExchangeRate]))     AS [FinNetAmountFreight]
    ,   CONVERT(decimal(28,12),(BDI_Base.[FinNetAmountOtherSales]*CCR.[ExchangeRate]))  AS [FinNetAmountOtherSales]
    ,   CONVERT(decimal(28,12),(BDI_Base.[FinNetAmountAllowances]*CCR.[ExchangeRate]))  AS [FinNetAmountAllowances]
    ,   CONVERT(decimal(28,12),(BDI_Base.[FinSales100]*CCR.[ExchangeRate]))             AS [FinSales100] --temporary
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
LEFT JOIN [edw].[vw_CurrencyConversionRate] CCR
    ON CCR.SourceCurrency = 'USD'
LEFT JOIN 
    [edw].[dim_CurrencyType] CT
    ON CCR.CurrencyTypeID = CT.CurrencyTypeID
WHERE CCR.CurrencyTypeID <> '00'