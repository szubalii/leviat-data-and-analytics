CREATE TABLE [base_tx_halfen_2_dwh].[DIM_VENDTABLE](
    [DW_Id]                                     BIGINT          NOT NULL,
	[ACCOUNTNUM]                                NVARCHAR(20)    NULL,
	[DATAAREAID]                                NVARCHAR(4)     NULL,
	[NAME]                                      NVARCHAR(140)   NULL,
	[VENDGROUP]                                 NVARCHAR(10)    NULL,
	[DW_Batch]                                  BIGINT          NULL,
	[DW_SourceCode]                             VARCHAR(15)     NOT NULL,
	[DW_TimeStamp]                              DATETIME        NOT NULL,
    [t_applicationId]                           VARCHAR    (32) NULL,
    [t_jobId]                                   VARCHAR    (36) NULL,
    [t_jobDtm]                                  DATETIME,
    [t_jobBy]                                   NVARCHAR  (128) NULL,
    [t_extractionDtm]                           DATETIME,
    [t_filePath]                                NVARCHAR (1024) NULL,
    CONSTRAINT [PK_DIM_VENDTABLE] PRIMARY KEY NONCLUSTERED (
        [DW_Id]
    ) NOT ENFORCED
)
WITH (HEAP, DISTRIBUTION = REPLICATE);