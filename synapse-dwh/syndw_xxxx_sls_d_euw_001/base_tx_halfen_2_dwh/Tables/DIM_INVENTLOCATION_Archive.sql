CREATE TABLE [base_tx_halfen_2_dwh].[DIM_INVENTLOCATION_Archive](

	[DW_Id]		 		BIGINT NOT NULL,
	[NAME] 				NVARCHAR(140) NULL,
	[INVENTLOCATIONID] 	NVARCHAR(10) NULL,
	[DATAAREAID] 		NVARCHAR(4) NULL,
	[DW_Batch] 			BIGINT NULL,
	[DW_SourceCode] 	VARCHAR(15) NOT NULL,
	[DW_TimeStamp] 		DATETIME NOT NULL,    
	[t_applicationId]   VARCHAR    (32)  NULL,
    [t_jobId]           VARCHAR    (36)  NULL,
    [t_jobDtm]          DATETIME,
    [t_jobBy]           NVARCHAR  (128)  NULL,
    [t_extractionDtm]   DATETIME,
    [t_filePath]        NVARCHAR (1024)  NULL,
    CONSTRAINT [PK_DIM_INVENTLOCATION_Archive] PRIMARY KEY NONCLUSTERED (
        [DW_Id] ASC
    ) NOT ENFORCED
)
WITH  
(
	DISTRIBUTION = HASH ([INVENTLOCATIONID]),
	CLUSTERED COLUMNSTORE INDEX
);