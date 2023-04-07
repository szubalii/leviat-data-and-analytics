CREATE TABLE [base_tx_halfen_2_dwh].[FACT_INVENTSUM_Archive]
(
	[DW_Id]              			 BIGINT NOT NULL,
	[DATAAREAID]		 			 NVARCHAR(4) NULL,
	[ITEMID]			 			 NVARCHAR(20) NULL,
	[INVENTDIMID]        			 NVARCHAR(20) NULL,
	[POSTEDQTY]          			 DECIMAL(38, 12) NULL,
	[POSTEDVALUE]        			 DECIMAL(38, 12) NULL,
	[PHYSICALINVENT]     			 DECIMAL(38, 12) NULL,
	[RECEIVED]           			 DECIMAL(38, 12) NULL,
	[DEDUCTED]			 			 DECIMAL(38, 12) NULL,
	[AVAILPHYSICAL]		 			 DECIMAL(38, 12) NULL,
	[Physical_Invent_Calculated]	 DECIMAL(38, 12) NULL,
	[REGISTERED]         			 DECIMAL(38, 12) NULL,
	[PICKED]             			 DECIMAL(38, 12) NULL,
	[EndOfLastMonth]     			 DATETIME NULL,
	[YearOfEndLastMonth] 			 NVARCHAR(4) NULL,
	[CRH_EUR_Rate]       			 REAL NULL,
	[AX_EUR_Rate]        			 DECIMAL(38, 12) NULL,
	[COSTAMOUNT]         			 REAL NULL,
	[COSTAMOUNT_AX_EUR]  			 REAL NULL,
	[COSTAMOUNT_CRH_EUR] 			 REAL NULL,
	[INVENTSITEID]       			 NVARCHAR(10) NULL,
	[INVENTLOCATIONID]   			 NVARCHAR(10) NULL,
	[INVENTCONFIG]       			 NVARCHAR(24) NULL,
	[ReqItemTable_DW_Id] 			 BIGINT NULL,
	[InventConfig_DW_Id] 			 BIGINT NULL,
	[DW_Id_Itemid]       			 BIGINT NULL,
	[DW_Batch]           			 BIGINT NULL,
	[DW_SourceCode]      			 VARCHAR(15) NOT NULL,
	[DW_TimeStamp]       			 DATETIME NOT NULL,
    [t_applicationId]    			 VARCHAR    (32)  NULL,
    [t_jobId]            			 VARCHAR    (36)  NULL,
    [t_jobDtm]           			 DATETIME,
    [t_jobBy]            			 NVARCHAR  (128)  NULL,
    [t_extractionDtm]    			 DATETIME,
    [t_filePath]         			 NVARCHAR (1024)  NULL,
    CONSTRAINT [PK_FACT_INVENTSUM_Archive] PRIMARY KEY NONCLUSTERED (
        [DW_Id] ASC
    ) NOT ENFORCED
)
WITH
(
	HEAP,  
    DISTRIBUTION = REPLICATE 
);