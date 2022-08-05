 CREATE TABLE [edw].[dim_FinancialStatementHierarchy] (
      [FinancialStatementVariant]   NVARCHAR(4) COLLATE Latin1_General_100_BIN2  NOT NULL
    , [FinancialStatementItem]      NVARCHAR(10) COLLATE Latin1_General_100_BIN2 NOT NULL
    , [ChartOfAccounts]             NVARCHAR(4) COLLATE Latin1_General_100_BIN2  NOT NULL
    , [LowerBoundaryAccount]        NVARCHAR(10) COLLATE Latin1_General_100_BIN2 NOT NULL
    , [LowerBoundaryFunctionalArea] NVARCHAR(16) COLLATE Latin1_General_100_BIN2 NOT NULL
    , [UpperBoundaryAccount]        NVARCHAR(10) COLLATE Latin1_General_100_BIN2
    , [UpperBoundaryFunctionalArea] NVARCHAR(16) COLLATE Latin1_General_100_BIN2
    , [IsDebitBalanceRelevant]      NVARCHAR(1) COLLATE Latin1_General_100_BIN2
    , [IsCreditBalanceRelevant]     NVARCHAR(1) COLLATE Latin1_General_100_BIN2
    , [FinStatementItemDescription] NVARCHAR(45) COLLATE Latin1_General_100_BIN2
    , [t_applicationId]             VARCHAR (32)
    , [t_extractionDtm]             DATETIME       NULL    
    , [t_jobId]                     VARCHAR (36)
    , [t_jobDtm]                    DATETIME
    , [t_lastActionCd]              VARCHAR(1)
    , [t_jobBy]                     NVARCHAR(128)
, CONSTRAINT [PK_fact_FinancialStatementHierarchy] PRIMARY KEY NONCLUSTERED([FinancialStatementVariant], [FinancialStatementItem]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,  HEAP
)
GO