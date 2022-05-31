CREATE TABLE [edw].[dim_StorageLocation]
(
    [StorageLocationID]          NVARCHAR(4)    NOT NULL,
    [StorageLocation]            NVARCHAR(40)   NULL,
    [Plant]                      NVARCHAR(4)    NOT NULL,
    [SalesOrganization]          NVARCHAR(4),
    [DistributionChannel]        NVARCHAR(2),
    [Division]                   NVARCHAR(2),
    [IsStorLocAuthznCheckActive] NVARCHAR(1),
    [t_applicationId]            VARCHAR(32)    NULL,
    [t_extractionDtm]            DATETIME       NULL,
    [t_jobId]                    VARCHAR(36)    NULL,
    [t_jobDtm]                   DATETIME       NULL,
    [t_lastActionCd]        VARCHAR(1),
    [t_jobBy]               NVARCHAR(128),
    CONSTRAINT [PK_dim_StorageLocation] PRIMARY KEY NONCLUSTERED ([StorageLocationID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO