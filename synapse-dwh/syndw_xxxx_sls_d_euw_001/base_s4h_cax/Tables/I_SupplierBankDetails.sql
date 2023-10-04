CREATE TABLE [base_s4h_cax].[I_SupplierBankDetails]
-- core view for Bank details
(
    [MANDT]                   nchar(3) collate Latin1_General_100_BIN2     NOT NULL,
    [Supplier]                nvarchar(10) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [BankCountry]             nvarchar(3) collate Latin1_General_100_BIN2  NOT NULL,
    [Bank]                    nvarchar(15) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [BankAccount]             nvarchar(18) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [BPBankAccountInternalID] nvarchar(4), -- collate Latin1_General_100_BIN2,
    [BankAccountHolderName]   nvarchar(60), -- collate Latin1_General_100_BIN2,
    [BankControlKey]          nvarchar(2), -- collate Latin1_General_100_BIN2,
    [BankDetailReference]     nvarchar(20), -- collate Latin1_General_100_BIN2,
    [AuthorizationGroup]      nvarchar(4), -- collate Latin1_General_100_BIN2,
    [t_applicationId]         VARCHAR(32),
    [t_jobId]                 VARCHAR(36),
    [t_jobDtm]                DATETIME,
    [t_jobBy]                 NVARCHAR(128),
    [t_extractionDtm]         DATETIME,
    [t_filePath]              NVARCHAR(1024),
    CONSTRAINT [PK_I_SupplierBankDetails] PRIMARY KEY NONCLUSTERED ([MANDT], [Supplier], [BankCountry], [Bank], [BankAccount]) NOT ENFORCED
)
WITH (
    HEAP
    )
