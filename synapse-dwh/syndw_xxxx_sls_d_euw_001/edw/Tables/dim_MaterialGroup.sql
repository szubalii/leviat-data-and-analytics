CREATE TABLE [edw].[dim_MaterialGroup]
(
    [MaterialGroupID]            NVARCHAR(9)    NOT NULL,
    [MaterialGroup]              NVARCHAR(20)   NULL,
    [MaterialAuthorizationGroup] nvarchar(4),
    [MaterialGroupText]          nvarchar(60),
    [t_applicationId]            VARCHAR(32)    NULL,
    [t_jobId]                    VARCHAR(36)    NULL,
    [t_jobDtm]                   DATETIME       NULL,
    [t_lastActionCd]        VARCHAR(1),
    [t_jobBy]               NVARCHAR(128),
    CONSTRAINT [PK_dim_MaterialGroup] PRIMARY KEY NONCLUSTERED ([MaterialGroupID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO