CREATE TABLE [edw].[dim_ValuationType]
(
    [ValuationTypeID] NVARCHAR(10) NOT NULL,
    [ValuationType]   NVARCHAR(35),
    [t_applicationId] VARCHAR(32),
    [t_jobId]         VARCHAR(36),
    [t_jobDtm]        DATETIME,
    [t_lastActionCd]  VARCHAR(1),
    [t_jobBy]         NVARCHAR(128),
    CONSTRAINT [PK_dim_ValuationType] PRIMARY KEY NONCLUSTERED ([ValuationTypeID]) NOT ENFORCED
) WITH
(DISTRIBUTION = REPLICATE, HEAP )
GO