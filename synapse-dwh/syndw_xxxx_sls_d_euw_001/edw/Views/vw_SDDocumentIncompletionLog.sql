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
, LT.[ABAPDATAELEMENTHEADING]          AS FieldName
, LT.[ABAPDATAELEMENTDESCRIPTION]      AS FieldDescription
FROM [base_s4h_cax].[I_SDDocumentIncompletionLog] IL
LEFT JOIN [base_s4h_cax].[RollName] RN
  ON
    RN.TABNAME = IL.SDDocumentTable
    AND
    RN.FIELDNAME = IL.SDDocumentTableField
LEFT JOIN [base_s4h_cax].[I_DataElementLabelText] LT
  ON LT.ABAPDATAELEMENT = RN.ROLLNAME
WHERE IL.SDDocument NOT LIKE '001%'