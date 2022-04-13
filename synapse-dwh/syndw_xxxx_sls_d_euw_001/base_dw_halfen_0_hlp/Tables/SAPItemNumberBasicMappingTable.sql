﻿CREATE TABLE [base_dw_halfen_0_hlp].[SAPItemNumberBasicMappingTable] (
    [AXItemnumber]          NVARCHAR (255)  NULL,
    [AXDataAreaId]          NVARCHAR (255)  NULL,
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
    [t_applicationId] VARCHAR    (32)  NULL,
    [t_jobId]         VARCHAR    (36)  NULL,
    [t_jobDtm]        DATETIME,
    [t_jobBy]         NVARCHAR  (128)  NULL,
    [t_extractionDtm] DATETIME,
    [t_filePath]      NVARCHAR (1024)  NULL
)
WITH (HEAP, DISTRIBUTION = ROUND_ROBIN);

