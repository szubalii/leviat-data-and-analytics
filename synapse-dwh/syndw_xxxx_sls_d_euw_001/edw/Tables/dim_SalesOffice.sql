CREATE TABLE [edw].[dim_SalesOffice]
(
    [SalesOfficeID]   NVARCHAR(8)    NOT NULL,
    [SalesOffice]     NVARCHAR(40)   NULL,

    [t_applicationId] VARCHAR(32)    NULL,
    [t_jobId]         VARCHAR(36)    NULL,
    [t_jobDtm]        DATETIME       NULL,
    [t_lastActionCd]        VARCHAR(1),
    [t_jobBy]               NVARCHAR(128),
    CONSTRAINT [PK_dim_SalesOffice] PRIMARY KEY NONCLUSTERED ([SalesOfficeID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO