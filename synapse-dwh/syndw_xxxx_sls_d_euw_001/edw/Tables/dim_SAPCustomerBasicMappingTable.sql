CREATE TABLE [edw].[dim_SAPCustomerBasicMappingTable] (
    [AXCustomeraccount]       NVARCHAR (255)  NULL,
    [AXCustomerCalculated]    NVARCHAR (263)  NULL,
    [AXDataAreaId]            NVARCHAR (255)  NULL,
    [SAPCustomeraccount]      NVARCHAR (255)  NULL,
    [Migrate]                 NVARCHAR (255)  NULL,
    [t_applicationId]         VARCHAR  (32)  NULL,
    [t_jobId]                 VARCHAR  (36)  NULL,
    [t_jobDtm]                DATETIME,
    [t_lastActionCd]          VARCHAR(1),
    [t_jobBy]                 NVARCHAR (128)  NULL,
    [t_extractionDtm]         DATETIME,
    [t_filePath]              NVARCHAR (1024)  NULL
)
WITH (HEAP, DISTRIBUTION = REPLICATE);