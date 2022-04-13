CREATE TABLE [edw].[dim_ItemGeneralIncompletionStatus]
(
    [ItemGeneralIncompletionStatusID] NVARCHAR(1)   NOT NULL,
    [ItemGeneralIncompletionStatus]   NVARCHAR(20) NULL,
    [t_applicationId]                 VARCHAR(32),
    [t_jobId]                         VARCHAR(36),
    [t_jobDtm]                        DATETIME,
    [t_lastActionCd]                  VARCHAR(1),
    [t_jobBy]                         NVARCHAR(128),
    CONSTRAINT [PK_dim_ItemGeneralIncompletionStatus] PRIMARY KEY NONCLUSTERED ([ItemGeneralIncompletionStatusID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO

