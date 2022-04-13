CREATE TABLE [base_tx_halfen_2_dwh].[DIM_CUSTOMEROBJECT]
(
    [DW_Id]                              [bigint]        NOT NULL,
    [CUSTOMEROBJECTID]                   [nvarchar](20)  NULL,
    [NAME]                               [nvarchar](140) NULL,
    [DELIVERYCOUNTY]                     [nvarchar](10)  NULL,
    [DELIVERYCITY]                       [nvarchar](140) NULL,
    [ACTIVE]                             [int]           NULL,
    [CUSTOMEROBJECTID_NAME]              [nvarchar](250) NULL,
    [CUSTOMEROBJECTID_NAME_COUNTRY_TOWN] [nvarchar](250) NULL,
    [DW_Batch]                           [bigint]        NULL,
    [DW_SourceCode]                      [varchar](15)   NOT NULL,
    [DW_TimeStamp]                       [datetime]      NOT NULL,
    [t_applicationId]                    VARCHAR(32)     NULL,
    [t_jobId]                            VARCHAR(36)     NULL,
    [t_jobDtm]                           DATETIME,
    [t_jobBy]                            NVARCHAR(128)   NULL,
    [t_extractionDtm]                    DATETIME,
    [t_filePath]                         NVARCHAR(1024)  NULL
	CONSTRAINT [PK_DIM_CUSTOMEROBJECT] PRIMARY KEY NONCLUSTERED ([DW_Id]) NOT ENFORCED
)
WITH (
	HEAP, 
	DISTRIBUTION = ROUND_ROBIN
);