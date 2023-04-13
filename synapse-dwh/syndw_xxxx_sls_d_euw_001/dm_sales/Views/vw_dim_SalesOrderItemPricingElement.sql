CREATE VIEW [dm_sales].[vw_dim_SalesOrderItemPricingElement]
AS
SELECT
          [SalesOrder]
         ,[SalesOrderItem]
         ,[sk_SalesOrderItem]
         ,[ConditionType]
         ,[ConditionBaseValue]
         ,[ConditionRateValue]
         ,[ConditionAmount]
         ,[CurrencyTypeID]
         ,[CurrencyType]
         ,[CurrencyID]
FROM
  [edw].[dim_SalesOrderItemPricingElement]
WHERE ([ConditionInactiveReason] is null or [ConditionInactiveReason]='')