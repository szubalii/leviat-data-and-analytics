 CREATE TABLE [edw].[dim_FinancialStatementHierarchy] (
      [FinancialStatementVariant]   NVARCHAR(4)   NOT NULL
    , [FinancialStatementItem]      NVARCHAR(10)  NOT NULL
    , [ChartOfAccounts]             NVARCHAR(4)   NOT NULL
    , [LowerBoundaryAccount]        NVARCHAR(10)  NOT NULL
    , [LowerBoundaryFunctionalArea] NVARCHAR(16)  NOT NULL
    , [UpperBoundaryAccount]        NVARCHAR(10) 
    , [UpperBoundaryFunctionalArea] NVARCHAR(16) 
    , [IsDebitBalanceRelevant]      NVARCHAR(1) 
    , [IsCreditBalanceRelevant]     NVARCHAR(1) 
    , [FinStatementItemDescription] NVARCHAR(45) 
    , [t_applicationId]             VARCHAR (32)
    , [t_extractionDtm]             DATETIME   
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