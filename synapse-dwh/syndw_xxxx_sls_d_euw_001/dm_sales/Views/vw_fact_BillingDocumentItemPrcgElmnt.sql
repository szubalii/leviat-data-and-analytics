CREATE VIEW [dm_sales].[vw_fact_BillingDocumentItemPrcgElmnt]
AS
SELECT
          [BillingDocument]
         ,[BillingDocumentItem]
         ,[nk_BillingDocumentItem]  
         ,[ConditionType]
         ,sum([ConditionBaseValue]) as ConditionBaseValue
         ,sum([ConditionRateValue]) as ConditionRateValue
         ,sum([ConditionAmount]) as ConditionAmount
         ,[CurrencyTypeID]
         ,[CurrencyType]
         ,[CurrencyID]
FROM
  [edw].[fact_BillingDocumentItemPrcgElmnt] 
WHERE ([ConditionInactiveReason] is null or [ConditionInactiveReason]='')
       and  [CurrencyTypeID] in ('00' ,'10')
GROUP BY
          [BillingDocument]
         ,[BillingDocumentItem]
         ,[nk_BillingDocumentItem]  
         ,[ConditionType]
         ,[CurrencyTypeID]
         ,[CurrencyType]
         ,[CurrencyID]