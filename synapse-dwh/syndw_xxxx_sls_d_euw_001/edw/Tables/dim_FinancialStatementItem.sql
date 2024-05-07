 CREATE TABLE [edw].[dim_FinancialStatementItem] (
      [FinancialStatementVariant]     NVARCHAR(4)  NOT NULL
    , [HierarchyNode]                 CHAR(6)      NOT NULL
    , [NodeType]                      NVARCHAR(4) 
    , [FinancialStatementItem]        NVARCHAR(10) 
    , [ParentNode]                    CHAR(6) 
    , [ChildNode]                     CHAR(6) 
    , [SiblingNode]                   CHAR(6) 
    , [FinStatementHierarchyLevelVal] CHAR(2) 
    , [LastChangeDate]                DATE
    , [ResponsiblePerson]             NVARCHAR(12) 
    , [OffsettingItem]                NVARCHAR(10) 
    , [FinStatementItemDescription]   NVARCHAR(45) 
    , [t_applicationId]               VARCHAR (32)
    , [t_extractionDtm]               DATETIME
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