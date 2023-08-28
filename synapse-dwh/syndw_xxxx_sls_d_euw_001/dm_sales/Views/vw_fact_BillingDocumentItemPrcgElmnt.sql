CREATE VIEW [dm_sales].[vw_fact_BillingDocumentItemPrcgElmnt]
AS
SELECT
          [sk_fact_BillingDocumentItemPrcgElmnt]
         ,[BillingDocument]
         ,[BillingDocumentItem]
         ,[nk_BillingDocumentItem]  
         ,[ConditionType]
         ,sum([ConditionBaseValue])    AS ConditionBaseValue
         ,sum([BaseAmountEUR])         AS BaseAmountEUR
         ,sum([BaseAmountUSD])         AS BaseAmountUSD
         ,sum([ConditionRateValue])    AS ConditionRateValue
         ,sum([ConditionAmount])       AS ConditionAmount
         ,sum([ConditionAmountEUR])    AS ConditionAmountEUR
         ,sum([ConditionAmountUSD])    AS ConditionAmountUSD
         ,[CurrencyTypeID]
         ,[CurrencyType]
         ,[CurrencyID]
FROM
  [edw].[fact_BillingDocumentItemPrcgElmnt] 
WHERE [CurrencyTypeID] = '10'
GROUP BY
          [BillingDocument]
         ,[BillingDocumentItem]
         ,[nk_BillingDocumentItem]  
         ,[ConditionType]
         ,[CurrencyTypeID]
         ,[CurrencyType]
         ,[CurrencyID]