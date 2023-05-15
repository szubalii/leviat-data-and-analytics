CREATE VIEW [dm_procurement].[vw_OptVim1Head]
AS
SELECT
    MANDT                	            
    ,DocumentLedgerID
    ,DocumentType
    ,CreationDate
    ,AccountingDocumentID
    ,PurchasingDocumentID
FROM
    [edw].[vw_OptVim1Head]