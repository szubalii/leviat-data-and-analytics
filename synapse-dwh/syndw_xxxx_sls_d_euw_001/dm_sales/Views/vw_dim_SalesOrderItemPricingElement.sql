CREATE VIEW [dm_sales].[vw_dim_SalesOrderItemPricingElement]
AS
SELECT
          [MANDT]
         ,[SalesOrder]
         ,[SalesOrderItem]
         ,CONCAT([SalesOrder],[SalesOrderItem]) as sk_SalesOrderItem
         ,[ConditionType]
         ,[ConditionBaseValue]
         ,[ConditionRateValue]
         ,[ConditionAmount]
         ,[TransactionCurrency]
FROM
  [base_s4h_cax].[I_SalesOrderItemPricingElement]