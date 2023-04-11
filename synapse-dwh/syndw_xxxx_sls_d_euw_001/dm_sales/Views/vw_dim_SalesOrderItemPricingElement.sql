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
WHERE ([ConditionInactiveReason] is null or [ConditionInactiveReason]='') AND
ConditionType in ('ZNET','REA1','ZNRV','VPRS','EK02','ZC10','ZCF1','FRA1','ZCC1','ZOA1','ZM10','ZG60','ZG10','ZG40','ZG31','ZM60','ZM61','ZM62','ZM63','ZM64','ZM65','ZM66','ZM50','ZM55')