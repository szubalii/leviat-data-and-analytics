CREATE TABLE [base_s4h_cax].[I_CN_CADEFinancialStatementItm]
(
    [MANDT]                         nchar(3) collate Latin1_General_100_BIN2    NOT NULL,
    [FinancialStatementVariant]     nvarchar(4) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL,
    [HierarchyNode]                 char(6) collate Latin1_General_100_BIN2     NOT NULL,
    [NodeType]                      nvarchar(4) -- collate Latin1_General_100_BIN2,
    [FinancialStatementItem]        nvarchar(10) -- collate Latin1_General_100_BIN2,
    [ParentNode]                    char(6) -- collate Latin1_General_100_BIN2,
    [ChildNode]                     char(6) -- collate Latin1_General_100_BIN2,
    [SiblingNode]                   char(6) -- collate Latin1_General_100_BIN2,
    [FinStatementHierarchyLevelVal] char(2) -- collate Latin1_General_100_BIN2,
    [SignIsInverted]                nvarchar(1) -- collate Latin1_General_100_BIN2,
    [LastChangeDate]                date,
    [t_applicationId]               VARCHAR(32),
    [t_jobId]                       VARCHAR(36),
    [t_jobDtm]                      DATETIME,
    [t_jobBy]                       NVARCHAR(128),
    [t_extractionDtm]               DATETIME,
    [t_filePath]                    NVARCHAR(1024),
    CONSTRAINT [PK_I_CN_CADEFinancialStatementItm] PRIMARY KEY NONCLUSTERED (
         [MANDT], [FinancialStatementVariant], [HierarchyNode]
   ) NOT ENFORCED
)
WITH (HEAP)