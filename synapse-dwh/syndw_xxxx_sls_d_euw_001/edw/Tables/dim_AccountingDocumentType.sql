CREATE TABLE [edw].[dim_AccountingDocumentType] (
-- Journal Entry Type
  [AccountingDocumentTypeID] nvarchar(4) NOT NULL --renamed (ex AccountingDocumentType)
--, [Language] char(1)  NOT NULL --from [base_s4h_cax].[I_AccountingDocumentTypeText]
, [AccountingDocumentType] nvarchar(40) --renamed (ex AccountingDocumentTypeName) from [base_s4h_cax].[I_AccountingDocumentTypeText]
, [AccountingDocumentNumberRange] nvarchar(4)
, [AuthorizationGroup] nvarchar(8)
, [ExchangeRateType] nvarchar(8)
, [AllowedFinancialAccountTypes] nvarchar(10)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_lastActionCd]        VARCHAR(1)
, [t_jobBy]               NVARCHAR(128)
, CONSTRAINT [PK_dim_AccountingDocumentType] PRIMARY KEY NONCLUSTERED ([AccountingDocumentTypeID]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO
