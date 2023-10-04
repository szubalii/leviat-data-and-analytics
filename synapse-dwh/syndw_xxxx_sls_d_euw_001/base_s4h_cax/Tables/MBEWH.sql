CREATE TABLE [base_s4h_cax].[MBEWH]
(
    [MANDT]           nchar(3) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [MATNR]           nvarchar(40) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [BWKEY]           nvarchar(4) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [BWTAR]           nvarchar(10) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [LFGJA]           char(4) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [LFMON]           char(2) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [LBKUM]           decimal(13,3),
    [SALK3]           decimal(13,2),
    [VPRSV]           nvarchar(1), -- collate Latin1_General_100_BIN2,
    [VERPR]           decimal(11,2),
    [STPRS]           decimal(11,2),
    [PEINH]           decimal(5),
    [BKLAS]           nvarchar(4), -- collate Latin1_General_100_BIN2,
    [SALKV]           decimal(13,2),
    [VKSAL]           decimal(13,2),
    [t_applicationId] VARCHAR (32),
    [t_jobId]         VARCHAR(36),
    [t_jobDtm]        DATETIME,
    [t_jobBy]         NVARCHAR(128),
    [t_extractionDtm] DATETIME,
    [t_filePath]      NVARCHAR(1024),
    CONSTRAINT [PK_MBEWH] PRIMARY KEY NONCLUSTERED (
        [MANDT],[MATNR],[BWKEY],[BWTAR],[LFGJA],[LFMON]
    ) NOT ENFORCED
) WITH (
  HEAP
)
