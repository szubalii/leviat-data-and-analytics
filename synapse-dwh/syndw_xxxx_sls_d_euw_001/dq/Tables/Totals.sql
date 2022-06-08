CREATE TABLE [dq].[Totals](
[RuleCodeID]        NVARCHAR(50) NOT NULL
,[RecordTotals]     INT
,[ErrorTotals]      INT
,[t_applicationId]  VARCHAR (32)
,[t_extractionDtm]  DATETIME
,[t_jobId]          VARCHAR (36)
,[t_jobDtm]         DATETIME
,[t_lastActionCd]   VARCHAR(1)
,[t_jobBy]          NVARCHAR(128)
,CONSTRAINT [PK_Totals] PRIMARY KEY NONCLUSTERED ([RuleCodeID],[t_jobDtm]) NOT ENFORCED
)
WITH (
    DISTRIBUTION = HASH ([RuleCodeID]), CLUSTERED COLUMNSTORE INDEX
)