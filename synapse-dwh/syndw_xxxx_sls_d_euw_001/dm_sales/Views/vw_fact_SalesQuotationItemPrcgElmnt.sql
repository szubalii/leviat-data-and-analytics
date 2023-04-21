CREATE VIEW [dm_sales].[vw_fact_SalesQuotationItemPrcgElmnt]
AS
SELECT
          [SalesQuotation]
         ,[SalesQuotationItem]
         ,nk_SalesQuotationItem
         ,[ConditionType]
         ,sum([ConditionBaseValue]) as ConditionBaseValue
         ,sum([ConditionRateValue]) as ConditionRateValue
         ,sum([ConditionAmount]) as ConditionAmount
         ,[CurrencyTypeID]
         ,[CurrencyType]
         ,[CurrencyID]
FROM
   [edw].[fact_SalesQuotationItemPrcgElmnt] 
WHERE ([ConditionInactiveReason] is null or [ConditionInactiveReason]='')
GROUP BY  [SalesQuotation]
         ,[SalesQuotationItem]
         ,nk_SalesQuotationItem
         ,[ConditionType]
         ,[CurrencyTypeID]
         ,[CurrencyType]
         ,[CurrencyID]
