CREATE TABLE [base_s4h_cax].[T025L]
(
    [MANDT]                 NCHAR(3) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [SPRAS]                 NCHAR(1) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [KKREF]                 NVARCHAR(4) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [KRFTX]                 NVARCHAR(35), -- collate Latin1_General_100_BIN2,
    [t_applicationId]       VARCHAR (32),
    [t_jobId]               VARCHAR(36),
    [t_jobDtm]              DATETIME,
    [t_jobBy]               NVARCHAR(128),
    [t_extractionDtm]       DATETIME,
    [t_filePath]            NVARCHAR(1024),
    CONSTRAINT [PK_T025L]  PRIMARY KEY NONCLUSTERED (
        [MANDT], [SPRAS], [KKREF]
    ) NOT ENFORCED
) WITH (
  HEAP
)
