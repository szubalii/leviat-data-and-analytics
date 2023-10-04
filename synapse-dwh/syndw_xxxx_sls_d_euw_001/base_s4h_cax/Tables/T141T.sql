CREATE TABLE [base_s4h_cax].[T141T]
(
    [MANDT]           NCHAR(3) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [SPRAS]           NCHAR(1) collate Latin1_General_100_BIN2    NOT NULL,
    [MMSTA]           NCHAR(2) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [MTSTB]           NVARCHAR(25) NOT NULL, -- collate Latin1_General_100_BIN2 NOT NULL,
    [t_applicationId] VARCHAR(32),
    [t_jobId]         VARCHAR(36),
    [t_jobDtm]        DATETIME,
    [t_jobBy]         NVARCHAR(128),
    [t_extractionDtm] DATETIME,
    [t_filePath]      NVARCHAR(1024),
    CONSTRAINT [PK_T141T] PRIMARY KEY NONCLUSTERED (
        [MANDT], [SPRAS], [MMSTA], [MTSTB]
    ) NOT ENFORCED
) WITH (
  HEAP
)