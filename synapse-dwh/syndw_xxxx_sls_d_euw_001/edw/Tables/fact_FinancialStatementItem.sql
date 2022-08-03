 CREATE TABLE [edw].[fact_FinancialStatementItem] (
      [FinancialStatementVariant]     NVARCHAR(4) COLLATE Latin1_General_100_BIN2 NOT NULL
    , [HierarchyNode]                 CHAR(6) COLLATE Latin1_General_100_BIN2     NOT NULL
    , [NodeType]                      NVARCHAR(4) COLLATE Latin1_General_100_BIN2
    , [FinancialStatementItem]        NVARCHAR(10) COLLATE Latin1_General_100_BIN2
    , [ParentNode]                    CHAR(6) COLLATE Latin1_General_100_BIN2
    , [ChildNode]                     CHAR(6) COLLATE Latin1_General_100_BIN2
    , [SiblingNode]                   CHAR(6) COLLATE Latin1_General_100_BIN2
    , [FinStatementHierarchyLevelVal] CHAR(2) COLLATE Latin1_General_100_BIN2
    , [LastChangeDate]                DATE
    , [ResponsiblePerson]             NVARCHAR(12) COLLATE Latin1_General_100_BIN2
    , [OffsettingItem]                NVARCHAR(10) COLLATE Latin1_General_100_BIN2
    , [FinStatementItemDescription]   NVARCHAR(45) COLLATE Latin1_General_100_BIN2
    , [t_applicationId]               VARCHAR (32)
    , [t_jobId]                       VARCHAR (36)
    , [t_jobDtm]                      DATETIME
    , [t_lastActionCd]                VARCHAR(1)
    , [t_jobBy]                       NVARCHAR(128)
, CONSTRAINT [PK_fact_FinancialStatementItem] PRIMARY KEY NONCLUSTERED([FinancialStatementVariant], [FinancialStatementItem]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,  HEAP
)
GO