CREATE TABLE [map_AXBI].[Migration]
(
    [DataAreaID]                nvarchar(4),
    [MigrationDate]             date,
    [t_applicationId]           VARCHAR(32)    NULL,
    [t_jobId]                   VARCHAR(36)    NULL,
    [t_jobDtm]                  DATETIME       NULL,
    [t_jobBy]                   NVARCHAR(128)  NULL,
    [t_filePath]                NVARCHAR(1024) NULL
    CONSTRAINT [PK_Migration] PRIMARY KEY NONCLUSTERED (
        [DataAreaID]
    ) NOT ENFORCED
)
WITH (DISTRIBUTION = REPLICATE,
    HEAP)