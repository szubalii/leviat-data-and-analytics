﻿CREATE TABLE [base_dw_halfen_2_dwh].[DIM_CRHPRODUCTGROUP] (
    [DW_Id]                    BIGINT          NOT NULL,
    [CRHPRODUCTPILLARKEY]      TINYINT         NULL,
    [CRHPRODUCTPILLARID]       NVARCHAR (10)   NULL,
    [CRHPRODUCTPILLARDESC]     NVARCHAR (60)   NULL,
    [CRHPRODUCTPILLAR_ID_DESC] VARCHAR (60)    NULL,
    [CRHMAINGROUPKEY]          TINYINT         NULL,
    [CRHMAINGROUPID]           NVARCHAR (10)   NULL,
    [CRHMAINGROUPDESC]         NVARCHAR (60)   NULL,
    [CRHMAINGROUP_ID_DESC]     VARCHAR (60)    NULL,
    [CRHPRODUCTGROUPKEY]       TINYINT         NULL,
    [CRHPRODUCTGROUPID]        NVARCHAR (10)   NULL,
    [CRHPRODUCTGROUPDESC]      NVARCHAR (60)   NULL,
    [CRHPRODUCTGROUP_ID_DESC]  VARCHAR (60)    NULL,
    [DW_Batch]                 BIGINT          NULL,
    [DW_SourceCode]            VARCHAR (15)    NOT NULL,
    [DW_TimeStamp]             DATETIME        NOT NULL,
    [t_applicationId] VARCHAR    (32)  NULL,
    [t_jobId]         VARCHAR    (36)  NULL,
    [t_jobDtm]        DATETIME,
    [t_jobBy]         NVARCHAR  (128)  NULL,
    [t_extractionDtm] DATETIME,
    [t_filePath]      NVARCHAR (1024)  NULL
    CONSTRAINT [PK_DIM_CRHPRODUCTGROUP] PRIMARY KEY NONCLUSTERED ([DW_Id] ASC) NOT ENFORCED
)
WITH (HEAP, DISTRIBUTION = ROUND_ROBIN);

