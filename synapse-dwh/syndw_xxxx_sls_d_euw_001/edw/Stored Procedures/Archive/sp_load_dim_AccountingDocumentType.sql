CREATE PROC [edw].[sp_load_dim_AccountingDocumentType]
     @t_jobId [varchar](36)
    ,@t_jobDtm [datetime]
    ,@t_lastActionCd [varchar](1)
    ,@t_jobBy [nvarchar](128) 
AS
BEGIN

    IF OBJECT_ID('syndw_xxxx_sls_d_euw_001.edw.dim_AccountingDocumentType', 'U') is not null TRUNCATE TABLE [edw].[dim_AccountingDocumentType]

    INSERT INTO [edw].[dim_AccountingDocumentType](
       [AccountingDocumentTypeID]
      ,[AccountingDocumentType]
      ,[AccountingDocumentNumberRange]
      ,[AuthorizationGroup]
      ,[ExchangeRateType]
      ,[AllowedFinancialAccountTypes]
      ,[t_applicationId]
      ,[t_jobId]
      ,[t_jobDtm]
      ,[t_lastActionCd]
      ,[t_jobBy]
    )
    SELECT 
       AccountingDocumentType.[AccountingDocumentType] as [AccountingDocumentTypeID]
      ,AccountingDocumentTypeText.[AccountingDocumentTypeName] as [AccountingDocumentType]
      ,[AccountingDocumentNumberRange]
      ,[AuthorizationGroup]
      ,[ExchangeRateType]
      ,[AllowedFinancialAccountTypes]
      ,AccountingDocumentType.[t_applicationId]
      ,@t_jobId AS t_jobId
      ,@t_jobDtm AS t_jobDtm
      ,@t_lastActionCd AS t_lastActionCd
      ,@t_jobBy AS t_jobBy
    FROM 
        [base_s4h_uat_caa].[I_AccountingDocumentType] AccountingDocumentType
    LEFT JOIN 
        [base_s4h_uat_caa].[I_AccountingDocumentTypeText] AccountingDocumentTypeText
        ON 
            AccountingDocumentType.[AccountingDocumentType] = AccountingDocumentTypeText.[AccountingDocumentType]
            AND
            AccountingDocumentTypeText.[Language] = 'E'

    where  AccountingDocumentType.[MANDT] = 200 and AccountingDocumentTypeText.[MANDT] = 200
END