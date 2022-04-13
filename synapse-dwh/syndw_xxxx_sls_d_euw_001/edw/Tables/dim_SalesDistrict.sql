CREATE TABLE [edw].[dim_SalesDistrict]
(
    [SalesDistrictID] NVARCHAR(12)   NOT NULL,
    [SalesDistrict]   NVARCHAR(40),

    [t_applicationId] VARCHAR(32)    NULL,
    [t_jobId]         VARCHAR(36)    NULL,
    [t_jobDtm]        DATETIME       NULL,
    [t_lastActionCd]        VARCHAR(1),
    [t_jobBy]               NVARCHAR(128),
    CONSTRAINT [PK_dim_SalesDistrict] PRIMARY KEY NONCLUSTERED ([SalesDistrictID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO