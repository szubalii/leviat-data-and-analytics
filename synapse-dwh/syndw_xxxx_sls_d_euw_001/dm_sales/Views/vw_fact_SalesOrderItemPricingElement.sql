CREATE VIEW [dm_sales].[vw_fact_SalesOrderItemPricingElement]
AS
SELECT
          [SalesOrder]
         ,[SalesOrderItem]
         ,[nk_SalesOrderItem]
         ,[ConditionType]
         ,[ConditionBaseValue]
         ,[ConditionRateValue]
         ,[ConditionAmount]
         ,[CurrencyTypeID]
         ,[CurrencyType]
         ,[CurrencyID]
FROM
  [edw].[fact_SalesOrderItemPricingElement]
WHERE ([ConditionInactiveReason] is null or [ConditionInactiveReason]='')
GROUP BY 
          [SalesOrder]
         ,[SalesOrderItem]
         ,[nk_SalesOrderItem]
         ,[ConditionType]
         ,[ConditionBaseValue]
         ,[ConditionRateValue]
         ,[ConditionAmount]
         ,[CurrencyTypeID]
         ,[CurrencyType]
         ,[CurrencyID]