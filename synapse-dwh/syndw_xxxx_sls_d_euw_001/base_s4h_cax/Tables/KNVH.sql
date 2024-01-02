CREATE TABLE [base_s4h_cax].[KNVH]
(
    [MANDT]           nchar(3)      NOT NULL,
    [HITYP]           nvarchar(1)   NOT NULL,
    [KUNNR]           nvarchar(10)  NOT NULL,
    [VKORG]           nvarchar(4)   NOT NULL,
    [VTWEG]           nvarchar(2)   NOT NULL,
    [SPART]           nvarchar(2)   NOT NULL,
    [DATAB]           date          NOT NULL,
    [DATBI]           date,
    [HKUNNR]          nvarchar(10),
    [HVKORG]          nvarchar(4),
    [HVTWEG]          nvarchar(2),
    [HSPART]          nvarchar(2),
    [GRPNO]           nvarchar(3),
    [BOKRE]           nvarchar(1),
    [PRFRE]           nvarchar(1),
    [HZUOR]           nvarchar(2),
    [NODE_GUID]       nvarchar(32),
    [NODE_ID]         nvarchar(20),
    [t_applicationId] VARCHAR (32),
    [t_jobId]         VARCHAR(36),
    [t_jobDtm]        DATETIME,
    [t_jobBy]         NVARCHAR(128),
    [t_extractionDtm] DATETIME,
    [t_filePath]      NVARCHAR(1024),
    CONSTRAINT [PK_KNVH] PRIMARY KEY NONCLUSTERED (
        [MANDT],[HITYP],[KUNNR],[VKORG],[VTWEG],[SPART],[DATAB]
    ) NOT ENFORCED
) WITH (
  HEAP
)
