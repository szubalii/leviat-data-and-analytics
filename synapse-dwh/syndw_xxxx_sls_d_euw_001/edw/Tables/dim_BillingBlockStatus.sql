CREATE TABLE [edw].[dim_BillingBlockStatus]
(
    [BillingBlockStatusID] NVARCHAR(1)  NOT NULL,
    [BillingBlockStatus]   NVARCHAR(20) NULL,
    [t_applicationId]      VARCHAR(32),
    [t_jobId]              VARCHAR(36),
    [t_jobDtm]             DATETIME,
    [t_lastActionCd]       VARCHAR(1),
    [t_jobBy]              NVARCHAR(128),
    CONSTRAINT [PK_dim_BillingBlockStatus] PRIMARY KEY NONCLUSTERED ([BillingBlockStatusID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO