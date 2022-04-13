CREATE TABLE [edw].[dim_OverallTotalSDDocRefStatus]
(
    [OverallTotalSDDocRefStatusID] nvarchar(1) NOT NULL,
    [OverallTotalSDDocRefStatus]   nvarchar(20),
    [t_applicationId]              VARCHAR(32),
    [t_jobId]                      VARCHAR(36),
    [t_jobDtm]                     DATETIME,
    [t_lastActionCd]               VARCHAR(1),
    [t_jobBy]                      NVARCHAR(128),
    CONSTRAINT [PK_dim_OverallTotalSDDocRefStatus] PRIMARY KEY NONCLUSTERED ([OverallTotalSDDocRefStatusID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO