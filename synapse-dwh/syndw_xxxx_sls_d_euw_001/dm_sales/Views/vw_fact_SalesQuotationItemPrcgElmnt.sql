CREATE VIEW [dm_sales].[vw_fact_SalesQuotationItemPrcgElmnt]
AS
SELECT
          [fk_SalesDocumentItem]
         ,[SalesQuotation]
         ,[SalesQuotationItem]
         ,[nk_SalesQuotationItem]
         ,[ConditionType]
         ,sum([ConditionBaseValue])    AS [ConditionBaseValue]
         ,sum([ConditionRateValue])    AS [ConditionRateValue]
         ,sum([ConditionAmount])       AS [ConditionAmount]
         ,[CurrencyTypeID]
         ,[CurrencyType]
         ,[CurrencyID]
FROM
   [edw].[fact_SalesQuotationItemPrcgElmnt] 
WHERE ([ConditionInactiveReason] IS NULL OR [ConditionInactiveReason] ='')
GROUP BY  
          [fk_SalesDocumentItem]
         ,[SalesQuotation]
         ,[SalesQuotationItem]
         ,[nk_SalesQuotationItem]
         ,[ConditionType]
         ,[CurrencyTypeID]
         ,[CurrencyType]
         ,[CurrencyID]
