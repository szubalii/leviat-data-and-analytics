CREATE VIEW [dm_procurement].[vw_dim_OptVim1Head]
AS
SELECT
    DocumentLedgerID
    ,DocumentType
    ,CreationDate
    ,AccountingDocumentID
    ,PurchasingDocumentID
FROM
    [edw].[vw_OptVim1Head]