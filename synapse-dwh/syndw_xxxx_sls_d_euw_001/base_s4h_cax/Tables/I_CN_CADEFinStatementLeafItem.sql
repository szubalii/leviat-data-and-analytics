CREATE TABLE [base_s4h_cax].[I_CN_CADEFinStatementLeafItem]
(
    [MANDT]                       nchar(3) collate Latin1_General_100_BIN2     NOT NULL,
    [FinancialStatementVariant]   nvarchar(4) collate Latin1_General_100_BIN2  NOT NULL,
    [FinancialStatementItem]      nvarchar(10) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [ChartOfAccounts]             nvarchar(4) collate Latin1_General_100_BIN2  NOT NULL,
    [LowerBoundaryAccount]        nvarchar(10) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [LowerBoundaryFunctionalArea] nvarchar(16) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [UpperBoundaryAccount]        nvarchar(10), -- collate Latin1_General_100_BIN2,
    [UpperBoundaryFunctionalArea] nvarchar(16), -- collate Latin1_General_100_BIN2,
    [IsDebitBalanceRelevant]      nvarchar(1), -- collate Latin1_General_100_BIN2,
    [IsCreditBalanceRelevant]     nvarchar(1), -- collate Latin1_General_100_BIN2,
    [t_applicationId]             VARCHAR(32),
    [t_jobId]                     VARCHAR(36),
    [t_jobDtm]                    DATETIME,
    [t_jobBy]                     NVARCHAR(128),
    [t_extractionDtm]             DATETIME,
    [t_filePath]                  NVARCHAR(1024),
    CONSTRAINT [PK_I_CN_CADEFinStatementLeafItem] PRIMARY KEY NONCLUSTERED (
       [MANDT], [FinancialStatementVariant],
       [FinancialStatementItem], [ChartOfAccounts],
       [LowerBoundaryAccount], [LowerBoundaryFunctionalArea]
   ) NOT ENFORCED
)
WITH (HEAP)

