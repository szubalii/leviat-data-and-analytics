CREATE VIEW [edw].[vw_OptVim1Head]
AS
SELECT
    MANDT                	            
    ,[DOCID]                AS DocumentLedgerID
    ,[DOCTYPE]              AS DocumentType
    ,[INDEX_DATE]           AS CreationDate
    ,[BELNR]                AS AccountingDocumentID
    ,[BUS_OBJTYPE]          AS [Object Type]
    ,[STATUS]               AS [Document Status]
    ,[NOFIRSTPASS]          AS NotFirstPass
    ,[BLART]                AS AccountingDocumentTypeID
    ,[GJAHR]                AS FiscalYear
    ,[BLDAT]                AS DocumentDate
    ,[BUDAT]                AS PostingDat
    ,[LIFNR]                AS SupplierID
    ,[XBLNR]                AS ReferenceID
    ,[WAERS]                AS CurrencyID
    ,[BKTXT]                AS HeaderTex
    ,[LAND1]                AS CountryI
FROM
    [base_s4h_cax].[Opt_Vim_1Head]
--WHERE
--    DOCTYPE <> 'NPO_S4'