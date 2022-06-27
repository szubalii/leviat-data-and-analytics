CREATE TABLE [dq].[dim_RuleProduct]
(
    [RuleID]            NVARCHAR(50) NOT NULL,
    [Product]           NVARCHAR(80),
    [t_jobId]           VARCHAR (36),
    [t_jobDtm]          DATETIME,
    [t_lastActionCd]    VARCHAR(1),
    [t_jobBy]           NVARCHAR(128),
    CONSTRAINT [PK_ProductTotals] PRIMARY KEY NONCLUSTERED ([RuleID],[Product],[t_jobDtm]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO