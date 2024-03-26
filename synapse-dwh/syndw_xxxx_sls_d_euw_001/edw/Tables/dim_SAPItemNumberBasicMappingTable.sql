CREATE TABLE [edw].[dim_SAPItemNumberBasicMappingTable] (
    [AXItemnumber]          NVARCHAR (255)  NULL,
    [axbi_ItemNoCalc]       NVARCHAR (510)  NULL,
    [AXDataAreaId]          NVARCHAR (255)  NULL,
    [AXDataAreaId_Original] NVARCHAR (255)  NULL,
    [SAPProductID]          NVARCHAR (80)   NULL,
    [SAPItemnumber]         NVARCHAR (255)  NULL,
    [SAPMaterialtype]       NVARCHAR (255)  NULL,
    [Migrate]               NVARCHAR (255)  NULL,
    [SAPshortdescription]   NVARCHAR (255)  NULL,
    [VALUATIONCLASS]        NVARCHAR (255)  NULL,
    [VALUATIONCLASSCH01]    NVARCHAR (255)  NULL,
    [VALUATIONCLASSDE01]    NVARCHAR (255)  NULL,
    [VALUATIONCLASSDE02]    NVARCHAR (255)  NULL,
    [VALUATIONCLASSPL01]    NVARCHAR (255)  NULL,
    [Wave]                  NVARCHAR (255)  NULL,
    [t_applicationId]       VARCHAR(32),
    [t_jobId]               VARCHAR(36),
    [t_jobDtm]              DATETIME,
    [t_lastActionCd]        VARCHAR(1),
    [t_jobBy]               NVARCHAR(128),
    [t_extractionDtm]       DATETIME,
    [t_filePath]            NVARCHAR (1024)  NULL
)
WITH (HEAP, DISTRIBUTION = REPLICATE);

