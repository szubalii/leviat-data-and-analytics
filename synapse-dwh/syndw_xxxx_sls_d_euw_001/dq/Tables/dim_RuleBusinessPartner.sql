CREATE TABLE [dq].[dim_RuleBusinessPartner]
(
    [RuleID]            NVARCHAR(50) NOT NULL,
    [BusinessPartner]    NVARCHAR(80),
    [t_jobId]           VARCHAR (36),
    [t_jobDtm]          DATETIME,
    [t_lastActionCd]    VARCHAR(1),
    [t_jobBy]           NVARCHAR(128),
    CONSTRAINT [PK_RuleBP] PRIMARY KEY NONCLUSTERED ([RuleID],[BusinessPartner],[t_jobDtm]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO