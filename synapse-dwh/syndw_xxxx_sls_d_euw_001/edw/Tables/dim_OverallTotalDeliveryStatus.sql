CREATE TABLE [edw].[dim_OverallTotalDeliveryStatus]
(
    [OverallTotalDeliveryStatusID] nvarchar(1) NOT NULL,
    [OverallTotalDeliveryStatus]   nvarchar(20),
    [t_applicationId]              VARCHAR(32),
    [t_jobId]                      VARCHAR(36),
    [t_jobDtm]                     DATETIME,
    [t_lastActionCd]               VARCHAR(1),
    [t_jobBy]                      NVARCHAR(128),
    CONSTRAINT [PK_dim_OverallTotalDeliveryStatus] PRIMARY KEY NONCLUSTERED ([OverallTotalDeliveryStatusID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO