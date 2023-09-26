CREATE VIEW [dm_procurement].[vw_dim_OptVim1Head]
AS
SELECT
    DocumentLedgerID
    ,DocumentType
    ,CreationDate
    ,AccountingDocumentID
    ,NULL AS PurchasingDocumentID
    ,[Object Type]
    ,[Document Status]
    ,NotFirstPass
    ,AccountingDocumentTypeID
    ,FiscalYear
    ,DocumentDate
    ,PostingDat
    ,SupplierID
    ,ReferenceID
    ,CurrencyID
    ,HeaderTex
    ,CountryI
FROM
    [edw].[vw_OptVim1Head]