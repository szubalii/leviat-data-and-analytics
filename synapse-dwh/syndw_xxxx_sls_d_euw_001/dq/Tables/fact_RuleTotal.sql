﻿CREATE TABLE [dq].[fact_RuleTotal]
(
    [RuleID]            NVARCHAR(50) NOT NULL,
    [RecordTotals]      INT,
    [ErrorTotals]       INT,
    [t_jobId]           VARCHAR (36),
    [t_jobDtm]          DATETIME,
    [t_lastActionCd]    VARCHAR(1),
    [t_jobBy]           NVARCHAR(128),
    CONSTRAINT [PK_RuleTotal] PRIMARY KEY NONCLUSTERED ([RuleID],[t_jobDtm]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO