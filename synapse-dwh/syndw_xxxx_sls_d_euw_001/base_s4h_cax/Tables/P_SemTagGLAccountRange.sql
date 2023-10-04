CREATE TABLE [base_s4h_cax].[P_SemTagGLAccountRange]
(
    [MANDT]              char(3) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [GLAccountHierarchy] nvarchar(42)                            NOT NULL,
    [HierarchyNode]      nvarchar(50)                            NOT NULL,
    [SemanticTag]        nvarchar(10)                            NOT NULL,
    [ValidityEndDate]    date                                    NOT NULL,
    [ValidityStartDate]  date                                    NOT NULL,
    [ChartOfAccounts]    nvarchar(4)                             NOT NULL,
    [GLAccount]          nvarchar(40)                            NOT NULL,
    [BalanceIndicator]   nvarchar(1)                             NOT NULL,
    [t_applicationId]    VARCHAR(32),
    [t_jobId]            VARCHAR(36),
    [t_jobDtm]           DATETIME,
    [t_jobBy]            NVARCHAR(128),
    [t_extractionDtm]    DATETIME,
    [t_filePath]         NVARCHAR(1024),
    CONSTRAINT [PK_P_SemTagGLAccountRange] PRIMARY KEY NONCLUSTERED (
        [MANDT], [GLAccountHierarchy], [HierarchyNode], [SemanticTag], [ValidityEndDate], [ValidityStartDate], [ChartOfAccounts], [GLAccount], [BalanceIndicator]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
