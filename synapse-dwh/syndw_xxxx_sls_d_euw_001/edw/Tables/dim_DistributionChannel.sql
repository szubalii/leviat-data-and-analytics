CREATE TABLE [edw].[dim_DistributionChannel]
(
    [DistributionChannelID] NVARCHAR(4)    NOT NULL,
    [DistributionChannel]   NVARCHAR(40)   NULL,

    [t_applicationId]       VARCHAR(32)    NULL,
    [t_jobId]               VARCHAR(36)    NULL,
    [t_jobDtm]              DATETIME       NULL,
    [t_lastActionCd]        VARCHAR(1),
    [t_jobBy]               NVARCHAR(128),
    CONSTRAINT [PK_dim_DistributionChannel] PRIMARY KEY NONCLUSTERED ([DistributionChannelID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO