CREATE VIEW [dm_sales].[vw_dim_SDDocumentIncompletionLog]
AS
SELECT
    [MANDT]
    , [SDDocument]
    , [SDDocumentItem]
    , svf_get2PartNaturalKey(SalesDocument, SalesDocumentItem)  AS nk_SDDocumentItem
    , [ScheduleLine]
    , [PartnerFunction]
    , [SDDocumentTextID]
    , [SDDocumentTable]
    , [SDDocumentTableField] 
    , [FieldName]       
    , [FieldDescription]
FROM
    [edw].[dim_SDDocumentIncompletionLog]