CREATE TABLE [edw].[dim_PackingStatus]
(
    [PackingStatusID]   NVARCHAR(1) NOT NULL,
    [PackingStatusDesc] NVARCHAR(20),
    [t_applicationId]   VARCHAR(32),
    [t_jobId]           VARCHAR(36),
    [t_jobDtm]          DATETIME,
    [t_lastActionCd]    VARCHAR(1),
    [t_jobBy]           NVARCHAR(128)
,CONSTRAINT [PK_dim_PackingStatus] PRIMARY KEY NONCLUSTERED ([PackingStatusID]) NOT ENFORCED
)
WITH
    (DISTRIBUTION = REPLICATE, HEAP )
GO