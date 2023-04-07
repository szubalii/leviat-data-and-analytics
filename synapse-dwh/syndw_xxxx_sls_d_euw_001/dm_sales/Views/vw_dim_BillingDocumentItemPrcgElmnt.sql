CREATE VIEW [dm_sales].[vw_dim_BillingDocumentItemPrcgElmnt]
AS
SELECT
          [BillingDocument]
         ,[BillingDocumentItem]
         ,CONCAT([BillingDocument],[BillingDocumentItem]) as sk_BillingDocumentItem
         ,[ConditionType]
         ,[ConditionBaseValue]
         ,[ConditionRateValue]
         ,[ConditionAmount]
         ,[TransactionCurrency]
FROM
  [edw].[dim_BillingDocumentItemPrcgElmnt]