CREATE VIEW [dm_sales].[vw_fact_SalesOrderItemPricingElement]
AS
SELECT
          [fk_SalesDocumentItem]
         ,[SalesOrder]
         ,[SalesOrderItem]
         ,[nk_SalesOrderItem]
         ,[ConditionType]
         ,sum([ConditionBaseValue])    AS [ConditionBaseValue]
         ,sum([ConditionRateValue])    AS [ConditionRateValue]
         ,sum([ConditionAmount])       AS [ConditionAmount]
         ,[CurrencyTypeID]
         ,[CurrencyType]
         ,[CurrencyID]
         ,[GLAccount] AS GLAccountID
         ,[ConditionInactiveReason]
FROM
  [edw].[fact_SalesOrderItemPricingElement]
GROUP BY
          [fk_SalesDocumentItem]
         ,[SalesOrder]
         ,[SalesOrderItem]
         ,[nk_SalesOrderItem]
         ,[ConditionType]
         ,[CurrencyTypeID]
         ,[CurrencyType]
         ,[CurrencyID]
         ,[GLAccount]
         ,[ConditionInactiveReason]