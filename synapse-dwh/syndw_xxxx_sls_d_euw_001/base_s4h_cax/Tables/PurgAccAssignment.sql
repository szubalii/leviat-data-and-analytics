CREATE TABLE [base_s4h_cax].[PurgAccAssignment](
        [MANDT]                 NCHAR(3) NOT NULL --       COLLATE Latin1_General_100_BIN2 NOT NULL
    ,   [EBELN]                 NVARCHAR(10) NOT NULL -- COLLATE Latin1_General_100_BIN2 NOT NULL
    ,   [EBELP]                 NCHAR(5) NOT NULL --       COLLATE Latin1_General_100_BIN2 NOT NULL
    ,   [ZEKKN]                 NCHAR(2) NOT NULL --       COLLATE Latin1_General_100_BIN2 NOT NULL
    ,   [SAKTO]                 NVARCHAR(10)    -- COLLATE Latin1_General_100_BIN2
    ,   [KOSTL]                 NVARCHAR(10)    -- COLLATE Latin1_General_100_BIN2
    ,   [VBELN]                 NVARCHAR(10)    -- COLLATE Latin1_General_100_BIN2
    ,   [VBELP]                 NVARCHAR(10)    -- COLLATE Latin1_General_100_BIN2
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
WITH ( 
  HEAP
)