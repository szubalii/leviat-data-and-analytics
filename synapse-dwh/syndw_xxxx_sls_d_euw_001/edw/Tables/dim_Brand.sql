CREATE TABLE [edw].[dim_Brand]
(
    [BrandID]         NVARCHAR(3) NOT NULL,
    [Brand]           NVARCHAR(40),
    [t_applicationId] VARCHAR(32) NULL,
    [t_jobId]         VARCHAR(36) NULL,
    [t_jobDtm]        DATETIME    NULL,
    [t_lastActionCd]  VARCHAR(1),
    [t_jobBy]         NVARCHAR(128),
    CONSTRAINT [PK_dim_Brand] PRIMARY KEY NONCLUSTERED ([BrandID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO