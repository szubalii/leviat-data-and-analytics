CREATE TABLE [edw].[dim_ValuationClass]
(
    [ValuationClassID] NVARCHAR(4) NOT NULL, --collate Latin1_General_100_BIN2 NOT NULL,
    [ValuationClass]   NVARCHAR(25),
    [t_applicationId]  VARCHAR(32),
    [t_jobId]          VARCHAR(36),
    [t_jobDtm]         DATETIME,
    [t_lastActionCd]   VARCHAR(1),
    [t_jobBy]          NVARCHAR(128),
    CONSTRAINT [PK_dim_ValuationClass] PRIMARY KEY NONCLUSTERED ([ValuationClassID]) NOT ENFORCED
) WITH
(DISTRIBUTION = REPLICATE, HEAP )
GO