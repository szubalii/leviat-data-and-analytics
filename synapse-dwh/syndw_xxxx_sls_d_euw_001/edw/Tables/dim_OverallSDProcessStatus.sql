CREATE TABLE [edw].[dim_OverallSDProcessStatus]
(
    [OverallSDProcessStatusID] NVARCHAR(1)    NOT NULL,
    [OverallSDProcessStatus]   NVARCHAR(20),
    [t_applicationId]          VARCHAR(32)    NULL,
    [t_jobId]                  VARCHAR(36)    NULL,
    [t_jobDtm]                 DATETIME       NULL,
    [t_lastActionCd]           VARCHAR(1)   NULL,
    [t_jobBy]                  NVARCHAR(128) NULL,
    CONSTRAINT [PK_dim_OverallSDProcessStatusText] PRIMARY KEY NONCLUSTERED ([OverallSDProcessStatusID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO