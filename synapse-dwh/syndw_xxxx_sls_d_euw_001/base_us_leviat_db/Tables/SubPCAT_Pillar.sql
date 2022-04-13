CREATE TABLE [base_us_leviat_db].[SubPCAT_Pillar]
(
     [PCAT]                     NVARCHAR(40)            NULL
    ,[SubPCAT]                  NVARCHAR(40)            NULL
    ,[ReportedPCATCategory]     NVARCHAR(40)            NULL
    ,[Pillar]                   NVARCHAR(40)            NULL
    ,[ProductPillarID]          CHAR(2)                 NULL
    ,[ProductPillar]            NVARCHAR(40)            NULL
    ,[t_applicationId]          VARCHAR(32)             NULL
    ,[t_jobId]                  VARCHAR(36)             NULL
    ,[t_jobDtm]                 DATETIME
    ,[t_jobBy]                  NVARCHAR(128)           NULL
    ,[t_extractionDtm]          DATETIME
    ,[t_filePath]               NVARCHAR(1024)          NULL
)
WITH
    (
    HEAP, 
    DISTRIBUTION = ROUND_ROBIN
    );
