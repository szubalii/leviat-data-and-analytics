CREATE TABLE [base_tx_halfen_2_dwh].[DIM_DATAAREA]
(
    [DW_Id]              BIGINT         NOT NULL,
    [ID]                 NVARCHAR(4)    NOT NULL,
    [NAME]               NVARCHAR(40)   NULL,
    [ID_NAME]            VARCHAR(100)   NULL,
    [Group1]             NVARCHAR(1)    NULL,
    [Group1_Description] NVARCHAR(100)  NULL,
    [Group2]             NVARCHAR(3)    NULL,
    [Group2_Description] NVARCHAR(100)  NULL,
    [Group3]             NVARCHAR(3)    NULL,
    [Group3_Description] NVARCHAR(100)  NULL,
    [Group4]             NVARCHAR(3)    NULL,
    [DW_Batch]           BIGINT         NULL,
    [DW_SourceCode]      VARCHAR(15)    NOT NULL,
    [DW_TimeStamp]       DATETIME       NOT NULL,
    [t_applicationId]    VARCHAR(32)    NULL,
    [t_jobId]            VARCHAR(36)    NULL,
    [t_jobDtm]           DATETIME,
    [t_jobBy]            NVARCHAR(128)  NULL,
    [t_extractionDtm]    DATETIME,
    [t_filePath]         NVARCHAR(1024) NULL,
    CONSTRAINT [PK_DIM_DATAAREA] PRIMARY KEY NONCLUSTERED ([ID]) NOT ENFORCED
)
WITH (HEAP, DISTRIBUTION = ROUND_ROBIN);