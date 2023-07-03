CREATE TABLE [map_AXBI].[SAPCustomerBasicMappingTable] (
    [AXCustomeraccount]       NVARCHAR (8)  NULL,
    [AXDataAreaId]            NVARCHAR (4)  NULL,
    [SAPCustomeraccount]      NVARCHAR (4)  NULL,
    [Migrate]                 CHAR(1)  NULL,
    [t_applicationId] VARCHAR    (32)  NULL,
    [t_jobId]         VARCHAR    (36)  NULL,
    [t_jobDtm]        DATETIME,
    [t_jobBy]         NVARCHAR  (128)  NULL,
    [t_extractionDtm] DATETIME,
    [t_filePath]      NVARCHAR (1024)  NULL
)
WITH (HEAP, DISTRIBUTION = ROUND_ROBIN); 