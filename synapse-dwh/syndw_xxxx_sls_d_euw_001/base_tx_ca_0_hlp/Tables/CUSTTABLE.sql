CREATE TABLE [base_tx_ca_0_hlp].[CUSTTABLE]
(
    [DATAAREAID] [nvarchar](8) NOT NULL,
    [ACCOUNTNUM] [nvarchar](100) NOT NULL,
    [NAME] [nvarchar](200) NOT NULL,
    [INOUT] [nvarchar](1) NOT NULL,
    [CUSTOMERPILLAR] [nvarchar](20) NOT NULL,
    [COMPANYCHAINID] [nvarchar](60) NOT NULL,
    [DIMENSION3_] [nvarchar](20) NOT NULL,
    [t_applicationId]   VARCHAR(32)       NULL,
    [t_jobId]           VARCHAR(36)       NULL,
    [t_jobDtm]          DATETIME,
    [t_jobBy]           NVARCHAR(128)     NULL,
    [t_extractionDtm]   DATETIME,
    [t_filePath]        NVARCHAR(1024)    NULL,
    CONSTRAINT [PK_CUSTTABLE] PRIMARY KEY NONCLUSTERED (
        [DATAAREAID], [ACCOUNTNUM]
    ) NOT ENFORCED
)
    WITH (HEAP, DISTRIBUTION = ROUND_ROBIN);
