CREATE TABLE [edw].[dim_OverallSDDocReferenceStatus]
(
    [OverallSDDocReferenceStatusID] nvarchar(1) NOT NULL,
    [OverallSDDocReferenceStatus]   nvarchar(20),
    [t_applicationId]               VARCHAR(32),
    [t_jobId]                       VARCHAR(36),
    [t_jobDtm]                      DATETIME,
    [t_lastActionCd]                VARCHAR(1),
    [t_jobBy]                       NVARCHAR(128),
    CONSTRAINT [PK_dim_OverallSDDocReferenceStatus] PRIMARY KEY NONCLUSTERED ([OverallSDDocReferenceStatusID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO