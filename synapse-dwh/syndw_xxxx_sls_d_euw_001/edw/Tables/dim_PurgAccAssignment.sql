CREATE TABLE [edw].[dim_PurgAccAssignment](
        [MANDT]                 NCHAR(3)        COLLATE Latin1_General_100_BIN2 NOT NULL
    ,   [EBELN]                 NVARCHAR(10)    COLLATE Latin1_General_100_BIN2 NOT NULL
    ,   [EBELP]                 NCHAR(5)        COLLATE Latin1_General_100_BIN2 NOT NULL
    ,   [VBELN]                 NVARCHAR(10)    COLLATE Latin1_General_100_BIN2 NOT NULL
    ,   [VBELP]                 NVARCHAR(10)    COLLATE Latin1_General_100_BIN2 NOT NULL
    ,   [ZEKKN]                 NCHAR(2)        COLLATE Latin1_General_100_BIN2 NOT NULL
    ,   [SAKTO]                 NVARCHAR(10)    COLLATE Latin1_General_100_BIN2
    ,   [KOSTL]                 NVARCHAR(10)    COLLATE Latin1_General_100_BIN2
    ,   [t_applicationId]       VARCHAR(32)
    ,   [t_jobId]               VARCHAR(36)
    ,   [t_jobDtm]              DATETIME
    ,   [t_jobBy]               NVARCHAR(128)
    ,   [t_filePath]            NVARCHAR(1024)
    ,   [t_extractionDtm]       DATETIME
    ,   CONSTRAINT [PK_PurgAccAssignment] PRIMARY KEY NONCLUSTERED(
            [MANDT],
            [EBELN],
            [EBELP],
            [ZEKKN]
        )NOT ENFORCED 
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO