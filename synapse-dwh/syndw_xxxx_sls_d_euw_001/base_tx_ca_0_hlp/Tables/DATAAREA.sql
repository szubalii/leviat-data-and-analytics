CREATE TABLE [base_tx_ca_0_hlp].[DATAAREA] (
    [DATAAREAID]      NVARCHAR (8)    NOT NULL,
    [DATAAREAID2]     NVARCHAR (8)    NOT NULL,
    [NAME]            NVARCHAR (50)   NOT NULL,
    [PLATFORM]        NVARCHAR (20)   NOT NULL,
    [GROUP]           NVARCHAR (8)    NOT NULL,
    [COUNTRYID]       NVARCHAR (2)    NOT NULL,
    [COUNTRYNAME]     NVARCHAR (100)  NOT NULL,
    [REGION]          NVARCHAR (100)  NOT NULL,
    [CRHCOMPANYID]    NVARCHAR (10)   NOT NULL,
    [LOCALCURRENCY]   NVARCHAR (3)    NOT NULL,
    [t_applicationId] VARCHAR    (32)  NULL,
    [t_jobId]         VARCHAR    (36)  NULL,
    [t_jobDtm]        DATETIME,
    [t_jobBy]         NVARCHAR  (128)  NULL,
    [t_extractionDtm] DATETIME,
    [t_filePath]      NVARCHAR (1024)  NULL,
    CONSTRAINT [PK_DATAAREA] PRIMARY KEY NONCLUSTERED (
       [DATAAREAID]
    ) NOT ENFORCED

)
WITH (HEAP, DISTRIBUTION = ROUND_ROBIN);

