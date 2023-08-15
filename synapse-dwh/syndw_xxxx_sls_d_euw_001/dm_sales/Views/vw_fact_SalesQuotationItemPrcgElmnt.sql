CREATE VIEW [dm_sales].[vw_fact_SalesQuotationItemPrcgElmnt]
AS
SELECT
          [SalesQuotation]
         ,[SalesQuotationItem]
         ,nk_SalesQuotationItem
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
   [edw].[fact_SalesQuotationItemPrcgElmnt] 
WHERE ([ConditionInactiveReason] IS NULL OR [ConditionInactiveReason] ='')
GROUP BY  [SalesQuotation]
         ,[SalesQuotationItem]
         ,nk_SalesQuotationItem
         ,[ConditionType]
         ,[CurrencyTypeID]
         ,[CurrencyType]
         ,[CurrencyID]
