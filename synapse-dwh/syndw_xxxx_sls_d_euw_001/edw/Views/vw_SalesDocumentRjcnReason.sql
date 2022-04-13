CREATE VIEW [edw].[vw_SalesDocumentRjcnReason]
	AS SELECT
		   SalesDocumentRjcnReasonText.[SalesDocumentRjcnReason]        AS [SalesDocumentRjcnReasonID]
         , SalesDocumentRjcnReasonText.[SalesDocumentRjcnReasonName]    AS [SalesDocumentRjcnReason]
         , t_applicationId
    FROM [base_s4h_cax].[I_SalesDocumentRjcnReasonText] SalesDocumentRjcnReasonText
    WHERE SalesDocumentRjcnReasonText.[Language] = 'E'
      -- AND [MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
