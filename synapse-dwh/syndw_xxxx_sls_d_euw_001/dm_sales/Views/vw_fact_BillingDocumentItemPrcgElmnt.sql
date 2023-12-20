CREATE VIEW [dm_sales].[vw_fact_BillingDocumentItemPrcgElmnt]
AS
SELECT
          [fk_BillingDocumentItem]
         ,[BillingDocument]
         ,[BillingDocumentItem]
         ,[nk_BillingDocumentItem]  
         ,[ConditionType]
         ,sum([ConditionBaseValue])    AS ConditionBaseValue
         ,sum([ConditionRateValue])    AS ConditionRateValue
         ,sum([ConditionAmount])       AS ConditionAmount
         ,[CurrencyTypeID]
         ,[CurrencyType]
         ,[CurrencyID]
         ,[GLAccount] AS GLAccountID
         ,[ConditionInactiveReason]
FROM
  [edw].[fact_BillingDocumentItemPrcgElmnt]
GROUP BY  
          [fk_BillingDocumentItem]
         ,[BillingDocument]
         ,[BillingDocumentItem]
         ,[nk_BillingDocumentItem]  
         ,[ConditionType]
         ,[CurrencyTypeID]
         ,[CurrencyType]
         ,[CurrencyID]
         ,[GLAccount]
         ,[ConditionInactiveReason]