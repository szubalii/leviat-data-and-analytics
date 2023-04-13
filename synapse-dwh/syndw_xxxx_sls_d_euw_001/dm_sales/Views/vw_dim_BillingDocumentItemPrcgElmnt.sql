CREATE VIEW [dm_sales].[vw_dim_BillingDocumentItemPrcgElmnt]
AS
SELECT
          [BillingDocument]
         ,[BillingDocumentItem]
         ,[sk_BillingDocumentItem]  
         ,[ConditionType]
         ,[ConditionBaseValue]
         ,[ConditionRateValue]
         ,[ConditionAmount]
         ,[CurrencyTypeID]
         ,[CurrencyType]
         ,[CurrencyID]
FROM
  [edw].[dim_BillingDocumentItemPrcgElmnt] 
WHERE ([ConditionInactiveReason] is null or [ConditionInactiveReason]='')