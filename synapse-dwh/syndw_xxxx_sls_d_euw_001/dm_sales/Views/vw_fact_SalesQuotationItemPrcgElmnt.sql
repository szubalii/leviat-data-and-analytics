CREATE VIEW [dm_sales].[vw_fact_SalesQuotationItemPrcgElmnt]
AS
SELECT
          [SalesQuotation]
         ,[SalesQuotationItem]
         ,nk_SalesQuotationItem
         ,[ConditionType]
         ,[ConditionBaseValue]
         ,[ConditionRateValue]
         ,[ConditionAmount]
         ,[CurrencyTypeID]
         ,[CurrencyType]
         ,[CurrencyID]
FROM
   [edw].[fact_SalesQuotationItemPrcgElmnt] 
WHERE ([ConditionInactiveReason] is null or [ConditionInactiveReason]='')
