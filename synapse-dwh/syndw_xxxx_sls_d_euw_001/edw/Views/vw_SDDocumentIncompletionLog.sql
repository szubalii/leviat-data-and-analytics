CREATE VIEW [edw].[vw_SDDocumentIncompletionLog]
AS
SELECT
    IL.SDDocument
    ,IL.SDDocumentItem
    ,IL.ScheduleLine
    ,MAX(LT.ABAPDATAELEMENTHEADING)      AS FieldName
FROM [base_s4h_cax].[I_SDDocumentIncompletionLog] IL
LEFT JOIN [base_s4h_cax].[I_DataElementLabelText] LT
    ON IL.SDDocumentTableField = LT.ABAPDATAELEMENT
GROUP BY
    IL.SDDocument
    ,IL.SDDocumentItem
    ,IL.ScheduleLine