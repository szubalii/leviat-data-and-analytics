CREATE TABLE [base_s4h_cax].[T149T]
(
    [MANDT]           NCHAR(3) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [SPRAS]           NCHAR(1) collate Latin1_General_100_BIN2    NOT NULL,
    [BWTTY]           NCHAR(1) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [BTBEZ]           NVARCHAR(25) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [t_applicationId] VARCHAR(32),
    [t_jobId]         VARCHAR(36),
    [t_jobDtm]        DATETIME,
    [t_jobBy]         NVARCHAR(128),
    [t_extractionDtm] DATETIME,
    [t_filePath]      NVARCHAR(1024),
    CONSTRAINT [PK_T149T] PRIMARY KEY NONCLUSTERED (
        [MANDT], [SPRAS], [BWTTY], [BTBEZ]
    ) NOT ENFORCED
) WITH (
  HEAP
)
