CREATE VIEW [dm_sales].[vw_dim_SalesQuotationItemPrcgElmnt]
AS
SELECT
          [SalesQuotation]
         ,[SalesQuotationItem]
         ,sk_SalesQuotationItem
         ,[ConditionType]
         ,[ConditionBaseValue]
         ,[ConditionRateValue]
         ,[ConditionAmount]
         ,[CurrencyTypeID]
         ,[CurrencyType]
         ,[CurrencyID]
FROM
   [edw].[dim_SalesQuotationItemPrcgElmnt] 
WHERE ([ConditionInactiveReason] is null or [ConditionInactiveReason]='')
