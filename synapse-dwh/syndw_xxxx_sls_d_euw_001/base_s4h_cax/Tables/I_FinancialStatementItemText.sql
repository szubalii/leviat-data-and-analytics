CREATE TABLE [base_s4h_cax].[I_FinancialStatementItemText]
(
    [MANDT]                       nchar(3) collate Latin1_General_100_BIN2     NOT NULL,
    [FinancialStatementVariant]   nvarchar(4) collate Latin1_General_100_BIN2  NOT NULL,
    [FinancialStatementItem]      nvarchar(10) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL,
    [Language]                    nchar(1) collate Latin1_General_100_BIN2     NOT NULL,
    [FinStatementItemDescription] nvarchar(45) -- collate Latin1_General_100_BIN2,
    [t_applicationId]             VARCHAR(32),
    [t_jobId]                     VARCHAR(36),
    [t_jobDtm]                    DATETIME,
    [t_jobBy]                     NVARCHAR(128),
    [t_extractionDtm]             DATETIME,
    [t_filePath]                  NVARCHAR(1024),
    CONSTRAINT [PK_I_FinancialStatementItemText] PRIMARY KEY NONCLUSTERED(
        [MANDT], [FinancialStatementVariant], [FinancialStatementItem], [Language]
    ) NOT ENFORCED
)
WITH (HEAP)

