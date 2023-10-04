CREATE TABLE [base_s4h_cax].[T141]
(
    [MANDT]           NCHAR(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL,
    [MMSTA]           NCHAR(2) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL,
    [DEINK]           NCHAR(1),
    [DSTLK]           NCHAR(1),
    [DSTLP]           NCHAR(1),
    [DAPLA]           NCHAR(1),
    [DPBED]           NCHAR(1),
    [DDISP]           NCHAR(1),
    [DFAPO]           NCHAR(1),
    [DFAKO]           NCHAR(1),
    [DINST]           NCHAR(1),
    [DBEST]           NCHAR(1),
    [DPROG]           NCHAR(1),
    [DFHMI]           NCHAR(1),
    [DQMPF]           NCHAR(1),
    [DTBED]           NCHAR(1),
    [DTAUF]           NCHAR(1),
    [DERZK]           NCHAR(1),
    [DLFPL]           NCHAR(1),
    [DLOCK]           NCHAR(1),
    [AUPRF]           NVARCHAR(10),
    [t_applicationId] VARCHAR(32),
    [t_jobId]         VARCHAR(36),
    [t_jobDtm]        DATETIME,
    [t_jobBy]         NVARCHAR(128),
    [t_extractionDtm] DATETIME,
    [t_filePath]      NVARCHAR(1024),
    CONSTRAINT [PK_T141] PRIMARY KEY NONCLUSTERED (
        [MANDT], [MMSTA]
    ) NOT ENFORCED
) WITH (
  HEAP
)