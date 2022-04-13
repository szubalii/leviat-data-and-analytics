CREATE VIEW [edw].[vw_SDDocumentReason]
AS 

SELECT 
    SDDocumentReason.[SDDocumentReason]         AS [SDDocumentReasonID]
,   SDDocumentReasonText.[SDDocumentReasonText] AS [SDDocumentReason]
,   SDDocumentReason.t_applicationId
FROM 
    [base_s4h_cax].[I_SDDocumentReason] SDDocumentReason
LEFT JOIN
    [base_s4h_cax].[I_SDDocumentReasonText] SDDocumentReasonText
    ON
        SDDocumentReason.[SDDocumentReason] = SDDocumentReasonText.[SDDocumentReason]
        AND
        SDDocumentReasonText.[Language] = 'E'
        -- AND
        -- SDDocumentReason.[MANDT] = 200
        -- AND
        -- SDDocumentReasonText.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod