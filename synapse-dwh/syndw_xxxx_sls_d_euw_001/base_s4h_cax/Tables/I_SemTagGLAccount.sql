CREATE TABLE [base_s4h_cax].[I_SemTagGLAccount]
(
    [MANDT]                     char(3) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [GLAccountHierarchy]        nvarchar(42)                            NOT NULL,
    [HierarchyNode]             nvarchar(50)                            NOT NULL,
    [SemanticTag]               nvarchar(10)                            NOT NULL,
    [ValidityEndDate]           date                                    NOT NULL,
    [ValidityStartDate]         date                                    NOT NULL,
    [ChartOfAccounts]           nvarchar(12)                            NOT NULL,
    [GLAccount]                 nvarchar(40)                            NOT NULL,
    [IsFunctionalAreaPermitted] nvarchar(1)                             NOT NULL,
    [t_applicationId]           VARCHAR(32),
    [t_jobId]                   VARCHAR(36),
    [t_jobDtm]                  DATETIME,
    [t_jobBy]                   NVARCHAR(128),
    [t_extractionDtm]           DATETIME,
    [t_filePath]                NVARCHAR(1024),
    CONSTRAINT [PK_I_SemTagGLAccount] PRIMARY KEY NONCLUSTERED (
        [MANDT], [GLAccountHierarchy], [HierarchyNode], [SemanticTag], [ValidityEndDate], [ValidityStartDate], [ChartOfAccounts], [GLAccount], [IsFunctionalAreaPermitted]
    ) NOT ENFORCED
)
WITH (
  HEAP
)
