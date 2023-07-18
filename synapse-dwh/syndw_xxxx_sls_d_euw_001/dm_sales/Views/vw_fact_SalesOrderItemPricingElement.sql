CREATE VIEW [dm_sales].[vw_fact_SalesOrderItemPricingElement]
AS
SELECT
          [SalesOrder]
         ,[SalesOrderItem]
         ,[nk_SalesOrderItem]
         ,[ConditionType]
         ,sum([ConditionBaseValue]) as ConditionBaseValue
         ,sum([ConditionRateValue]) as ConditionRateValue
         ,sum([ConditionAmount]) as ConditionAmount
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