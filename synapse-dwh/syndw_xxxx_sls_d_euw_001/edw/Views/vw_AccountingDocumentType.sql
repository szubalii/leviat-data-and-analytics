CREATE VIEW [edw].[vw_AccountingDocumentType]
	AS SELECT  
       AccountingDocumentType.[AccountingDocumentType] AS [AccountingDocumentTypeID]
      ,AccountingDocumentTypeText.[AccountingDocumentTypeName] AS [AccountingDocumentType]
      ,[AccountingDocumentNumberRange]
      ,[AuthorizationGroup]
      ,[ExchangeRateType]
      ,[AllowedFinancialAccountTypes]
      ,AccountingDocumentType.[t_applicationId]
    FROM 
        [base_s4h_cax].[I_AccountingDocumentType] AccountingDocumentType
    LEFT JOIN 
        [base_s4h_cax].[I_AccountingDocumentTypeText] AccountingDocumentTypeText
        ON 
            AccountingDocumentType.[AccountingDocumentType] = AccountingDocumentTypeText.[AccountingDocumentType]
            AND
            AccountingDocumentTypeText.[Language] = 'E'
    -- WHERE  AccountingDocumentType.[MANDT] = 200 and AccountingDocumentTypeText.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
