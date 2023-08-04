CREATE VIEW [dm_sales].[vw_fact_SalesOrderItemPricingElement]
AS
SELECT
          [SalesOrder]
         ,[SalesOrderItem]
         ,[nk_SalesOrderItem]
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
  [edw].[fact_SalesOrderItemPricingElement]
GROUP BY 
          [SalesOrder]
         ,[SalesOrderItem]
         ,[nk_SalesOrderItem]
         ,[ConditionType]
         ,[CurrencyTypeID]
         ,[CurrencyType]
         ,[CurrencyID]