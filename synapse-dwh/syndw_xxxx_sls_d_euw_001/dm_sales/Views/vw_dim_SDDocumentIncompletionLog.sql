CREATE VIEW [dm_sales].[vw_dim_SDDocumentIncompletionLog]
AS
SELECT
    [MANDT]
    , [SDDocument]
    , [SDDocumentItem]
    , edw.svf_get2PartNaturalKey(SDDocument, SDDocumentItem)  AS nk_SDDocumentItem
    , [ScheduleLine]
    , [PartnerFunction]
    , [SDDocumentTextID]
    , [SDDocumentTable]
    , [SDDocumentTableField] 
    , [FieldName]       
    , [FieldDescription]
FROM
    [edw].[dim_SDDocumentIncompletionLog]