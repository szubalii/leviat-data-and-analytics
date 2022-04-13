CREATE TABLE [base_tx_ca_0_hlp].[CRHCURRENCY] (
    [YEAR]            SMALLINT        NOT NULL,
    [NAME]            NVARCHAR (50)   NOT NULL,
    [CURRENCY]        NVARCHAR (3)    NOT NULL,
    [CRHRATE]         NUMERIC (15, 6) NOT NULL,
    [t_applicationId] VARCHAR    (32)  NULL,
    [t_jobId]         VARCHAR    (36)  NULL,
    [t_jobDtm]        DATETIME,
    [t_jobBy]         NVARCHAR  (128)  NULL,
    [t_extractionDtm] DATETIME,
    [t_filePath]      NVARCHAR (1024)  NULL,
    CONSTRAINT [PK_CRHCURRENCY] PRIMARY KEY NONCLUSTERED (
        [YEAR], [NAME], [CURRENCY]
    ) NOT ENFORCED
)
WITH (HEAP, DISTRIBUTION = ROUND_ROBIN);

