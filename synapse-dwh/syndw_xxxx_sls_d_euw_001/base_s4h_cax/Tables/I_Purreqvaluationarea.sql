CREATE TABLE [base_s4h_cax].[I_Purreqvaluationarea]
(
    [MANDT]            nchar(3) NOT NULL, --    collate Latin1_General_100_BIN2 NOT NULL,
    [ValuationArea]    nchar(4) NOT NULL, --    collate Latin1_General_100_BIN2 NOT NULL,
    [CompanyCode]      nchar(4) NOT NULL, --    collate Latin1_General_100_BIN2 NOT NULL,
    [CompanyCodeName]  nvarchar(25) NOT NULL, --    collate Latin1_General_100_BIN2 NOT NULL,
    [t_applicationId]  VARCHAR (32),
    [t_jobId]          VARCHAR(36),
    [t_jobDtm]         DATETIME,
    [t_jobBy]          NVARCHAR(128),
    [t_extractionDtm]  DATETIME,
    [t_filePath]       NVARCHAR(1024),
    CONSTRAINT [PK_Purreqvaluationarea] PRIMARY KEY NONCLUSTERED (
        [MANDT], [ValuationArea]
    ) NOT ENFORCED
) WITH (
  HEAP
)
