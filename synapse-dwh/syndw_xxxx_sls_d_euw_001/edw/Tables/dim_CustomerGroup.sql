CREATE TABLE [edw].[dim_CustomerGroup]
(
    [CustomerGroupID] NVARCHAR(4)    NOT NULL,
    [CustomerGroup]   NVARCHAR(40)   NULL,

    [t_applicationId] VARCHAR(32)    NULL,
    [t_jobId]         VARCHAR(36)    NULL,
    [t_jobDtm]        DATETIME       NULL,
    [t_lastActionCd]        VARCHAR(1),
    [t_jobBy]               NVARCHAR(128),
    CONSTRAINT [PK_dim_CustomerGroup] PRIMARY KEY NONCLUSTERED ([CustomerGroupID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO