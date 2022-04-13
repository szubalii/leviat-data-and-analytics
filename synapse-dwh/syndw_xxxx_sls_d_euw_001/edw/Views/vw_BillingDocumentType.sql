CREATE VIEW [edw].[vw_BillingDocumentType]
	AS SELECT 
		   BillingDocumentType.[BillingDocumentType]     AS [BillingDocumentTypeID]
         , BillingDocumentTypeText.[BillingDocumentTypeName] AS [BillingDocumentType]
         , [SDDocumentCategory]
         , [IncrementItemNumber]
         , [BillingDocumentCategory]
         , BillingDocumentType.t_applicationId
    FROM [base_s4h_cax].[I_BillingDocumentType] BillingDocumentType
             LEFT JOIN
         [base_s4h_cax].[I_BillingDocumentTypeText] BillingDocumentTypeText
         ON
                     BillingDocumentType.[BillingDocumentType] = BillingDocumentTypeText.[BillingDocumentType]
                 AND
                     BillingDocumentTypeText.[Language] = 'E'
    -- WHERE BillingDocumentType.[MANDT] = 200 AND BillingDocumentTypeText.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
