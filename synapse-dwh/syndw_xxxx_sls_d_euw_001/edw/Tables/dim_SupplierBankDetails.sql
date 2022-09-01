CREATE TABLE [edw].[dim_SupplierBankDetails]
(
    [SupplierID]                     nvarchar(10) collate Latin1_General_100_BIN2 NOT NULL,
    [BankCountryID]                  nvarchar(3) collate Latin1_General_100_BIN2  NOT NULL,
    [BankID]                         nvarchar(15) collate Latin1_General_100_BIN2 NOT NULL,
    [BankAccountID]                  nvarchar(18) collate Latin1_General_100_BIN2 NOT NULL,
    [t_applicationId]                VARCHAR(32),
    [t_extractionDtm]                DATETIME,
    [t_jobId]                        VARCHAR(36),
    [t_jobDtm]                       DATETIME,
    [t_lastActionCd]                 VARCHAR(1),
    [t_jobBy]                        NVARCHAR(128)
, CONSTRAINT [PK_dim_SupplierBankDetails] PRIMARY KEY NONCLUSTERED ([SupplierID], [BankCountryID], [BankID], [BankAccountID]) NOT ENFORCED
)
WITH
    (
    DISTRIBUTION = REPLICATE, HEAP )
GO