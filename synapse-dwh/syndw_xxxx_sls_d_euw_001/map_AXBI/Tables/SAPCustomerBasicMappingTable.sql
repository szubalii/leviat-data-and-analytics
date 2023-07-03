CREATE TABLE [map_AXBI].[SAPCustomerBasicMappingTable] (
    [AXCustomeraccount]       NVARCHAR (255)  NULL,
    [AXDataAreaId]            NVARCHAR (255)  NULL,
    [SAPCustomeraccount]      NVARCHAR (255)  NULL,
    [Migrate]                 NVARCHAR (255)  NULL,
    [t_applicationId] VARCHAR    (32)  NULL,
    [t_jobId]         VARCHAR    (36)  NULL,
    [t_jobDtm]        DATETIME,
    [t_jobBy]         NVARCHAR  (128)  NULL,
    [t_extractionDtm] DATETIME,
    [t_filePath]      NVARCHAR (1024)  NULL
)
WITH (HEAP, DISTRIBUTION = ROUND_ROBIN); 