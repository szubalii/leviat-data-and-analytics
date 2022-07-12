CREATE TABLE [base_tx_halfen_2_dwh].[DIM_CUSTOMEROBJECT]
(
    [DW_Id]                              BIGINT        NOT NULL,
    [CUSTOMEROBJECTID]                   NVARCHAR(20)  NULL,
    [NAME]                               NVARCHAR(140) NULL,
    [DELIVERYCOUNTY]                     NVARCHAR(10)  NULL,
    [DELIVERYCITY]                       NVARCHAR(140) NULL,
    [ACTIVE]                             INT           NULL,
    [CUSTOMEROBJECTID_NAME]              NVARCHAR(250) NULL,
    [CUSTOMEROBJECTID_NAME_COUNTRY_TOWN] NVARCHAR(250) NULL,
    [DW_Batch]                           BIGINT        NULL,
    [DW_SourceCode]                      VARCHAR(15)   NOT NULL,
    [DW_TimeStamp]                       DATETIME      NOT NULL,
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