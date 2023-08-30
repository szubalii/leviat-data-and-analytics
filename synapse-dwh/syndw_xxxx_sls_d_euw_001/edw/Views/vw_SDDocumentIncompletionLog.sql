CREATE VIEW [edw].[vw_SDDocumentIncompletionLog]
AS
SELECT
    IL.SDDocument
    ,IL.SDDocumentItem
    ,IL.ScheduleLine
    ,LT.ABAPDATAELEMENTHEADING          AS FieldName
    ,LT.ABAPDATAELEMENTDESCRIPTION      AS FieldDescription
FROM [base_s4h_cax].[I_SDDocumentIncompletionLog] IL
LEFT JOIN [base_s4h_cax].[I_DataElementLabelText] LT
    ON IL.SDDocumentTableField = LT.ABAPDATAELEMENT
WHERE IL.SDDocument NOT LIKE '001%'