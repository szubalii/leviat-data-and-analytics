CREATE TABLE [edw].[dim_SDProcessStatus]
(
    [SDProcessStatusID]             NVARCHAR(1)    NOT NULL,
    [SDProcessStatus]               NVARCHAR(20),
    [t_applicationId]               VARCHAR(32)    NULL,
    [t_jobId]                       VARCHAR(36)    NULL,
    [t_jobDtm]                      DATETIME       NULL,
    [t_lastActionCd]                VARCHAR(1),
    [t_jobBy]                       NVARCHAR(128),
    CONSTRAINT [PK_dim_SDProcessStatus] PRIMARY KEY NONCLUSTERED ([SDProcessStatusID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO
