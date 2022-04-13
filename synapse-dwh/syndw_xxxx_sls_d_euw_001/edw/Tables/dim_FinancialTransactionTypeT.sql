CREATE TABLE [edw].[dim_FinancialTransactionTypeT] (
-- Financial Transaction Type Text
  [FinancialTransactionTypeID] NVARCHAR(3) NOT NULL
, [FinancialTransactionType] NVARCHAR(20)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_lastActionCd]        VARCHAR(1)
, [t_jobBy]               NVARCHAR(128)
, CONSTRAINT [PK_dim_FinancialTransactionTypeT] PRIMARY KEY NONCLUSTERED([FinancialTransactionTypeID]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO
