CREATE VIEW [dm_sales].[vw_dim_QuotationDocumentItemPrcgElmnt]
AS
SELECT
          [MANDT]
         ,[QuoteDocument]
         ,[QuoteDocumentItem]
         ,CONCAT([QuoteDocument],[QuoteDocumentItem]) as sk_QuoteDocumentItem
         ,[ConditionType]
         ,[ConditionBaseValue]
         ,[ConditionRateValue]
         ,[ConditionAmount]
         ,[TransactionCurrency]
FROM
   [base_s4h_cax].[I_SalesQuotationPrcgElmnt]