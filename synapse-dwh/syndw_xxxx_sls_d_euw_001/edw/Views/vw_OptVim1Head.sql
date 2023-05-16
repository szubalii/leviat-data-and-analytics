CREATE VIEW [edw].[vw_OptVim1Head]
AS
SELECT
    MANDT                	            
    ,[DOCID]                AS DocumentLedgerID
    ,[DOCTYPE]              AS DocumentType
    ,[INDEX_DATE]           AS CreationDate
    ,[BELNR]                AS AccountingDocumentID
    ,[EBELN]                AS PurchasingDocumentID
FROM
    [base_s4h_cax].[Opt_Vim_1Head]
--WHERE
--    DOCTYPE <> 'NPO_S4'