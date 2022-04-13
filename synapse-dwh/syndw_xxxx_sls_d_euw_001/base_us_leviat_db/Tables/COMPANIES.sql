CREATE TABLE [base_us_leviat_db].[COMPANIES]
(
    [COMP]              NVARCHAR(24)   NOT NULL,
    [CompName]          NVARCHAR(80)   NULL,
    [REGION]            NVARCHAR(40)   NULL,
    [SubRegion]         NVARCHAR(40)   NULL,
    [CompFax]           NVARCHAR(40)   NULL,
    [LANGUAGE]          NVARCHAR(14)   NULL,
    [CompClosed]        NVARCHAR(3)    NULL,
    [DASHBOARD]         NVARCHAR(3)    NULL,
    [ProductLine]       NVARCHAR(20)   NULL,
    [CollectionType]    NVARCHAR(20)   NULL,
    [CurrentComp]       NVARCHAR(20)   NULL,
    [CompPhone]         NVARCHAR(40)   NULL,
    [CompAddress]       NVARCHAR(500)  NULL,
    [CURRENT_COMP_NAME] NVARCHAR(80)   NULL,
    [t_applicationId]   VARCHAR(32)    NULL,
    [t_jobId]           VARCHAR(36)    NULL,
    [t_jobDtm]          DATETIME,
    [t_jobBy]           NVARCHAR(128)  NULL,
    [t_extractionDtm]   DATETIME,
    [t_filePath]        NVARCHAR(1024) NULL
    ,CONSTRAINT [PK_COMPANIES] PRIMARY KEY NONCLUSTERED ([COMP]) NOT ENFORCED
)
    WITH (HEAP, DISTRIBUTION = ROUND_ROBIN);
