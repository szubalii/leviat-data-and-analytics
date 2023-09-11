CREATE VIEW [edw].[vw_SDDocumentIncompletionLog]
AS

SELECT
  IL.[MANDT]
, IL.[SDDocument]
, IL.[SDDocumentItem]
, IL.[ScheduleLine]
, IL.[PartnerFunction]
, IL.[SDDocumentTextID]
, IL.[SDDocumentTable]
, IL.[SDDocumentTableField]
, LT.[ABAPDataElementHeading]          AS FieldName
, LT.[ABAPDataElementDescription]      AS FieldDescription
FROM [base_s4h_cax].[I_SDDocumentIncompletionLog] IL
LEFT JOIN [base_s4h_cax].[RollName] RN
  ON
    RN.TabName = IL.SDDocumentTable
    AND
    RN.FieldName = IL.SDDocumentTableField
LEFT JOIN [base_s4h_cax].[I_DataElementLabelText] LT
  ON LT.ABAPDataElement = RN.RollName
WHERE IL.SDDocument NOT LIKE '001%'