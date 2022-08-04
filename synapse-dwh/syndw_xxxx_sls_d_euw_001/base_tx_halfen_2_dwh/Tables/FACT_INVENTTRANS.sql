CREATE TABLE [base_tx_halfen_2_dwh].[FACT_INVENTTRANS]
(
	[DW_Id]                   		BIGINT NOT NULL,
	[DATAAREAID]              		NVARCHAR(4) NULL,
	[DATEPHYSICAL]            		DATETIME NULL,
	[HasPysicalDate]          		BIGINT NULL,
	[ITEMID]                  		NVARCHAR(20) NULL,
	[INVENTDIMID]             		NVARCHAR(20) NULL,
	[QTY]                     		DECIMAL(38, 12) NULL,
	[TRANSTYPE]               		BIGINT NULL,
	[TRANSTYPENAME]           		NVARCHAR(1999) NULL,
	[STATUSRECEIPT]           		BIGINT NULL,
	[INVENTTRANSID]           		NVARCHAR(24) NULL,
	[TransType_UsedForHCM]    		BIGINT NULL,
	[HALPRODUCTRANGEID]       		NVARCHAR(10) NULL,
	[Date_InventTrans]        		DATETIME NULL,
	[HALPRODUCTLINEID]        		NVARCHAR(10) NULL,
	[STATUSISSUE]             		BIGINT NULL,
	[COSTAMOUNTADJUSTMENT]    		DECIMAL(38, 12) NULL,
	[COSTAMOUNTPHYSICAL]      		DECIMAL(38, 12) NULL,
	[COSTAMOUNTPOSTED]        		DECIMAL(38, 12) NULL,
	[COSTAMOUNTSETTLED]       		DECIMAL(38, 12) NULL,
	[COSTAMOUNTSTD]           		DECIMAL(38, 12) NULL,
	[CostAmount_Total]        		DECIMAL(38, 16) NULL,
	[DATEFINANCIAL]           		DATETIME NULL,
	[DATEEXPECTED]            		DATETIME NULL,
	[DATEINVENT]              		DATETIME NULL,
	[DATESTATUS]              		DATETIME NULL,
	[RECID]                   		BIGINT NULL,
	[HALPlanner_DW_Id]        		BIGINT NULL,
	[DatePhysical_DateKey]    		BIGINT NULL,
	[ReqItemTable_DW_Id]      		BIGINT NULL,
	[INVENTSITEID]            		NVARCHAR(10) NULL,
	[INVENTLOCATIONID]        		NVARCHAR(10) NULL,
	[Date_InventTrans_DateKey]		BIGINT NULL,
	[DW_Id_Itemid]            		BIGINT NULL,
	[PACKINGSLIPID] 			    NVARCHAR(20) NULL,
	[INVOICEID]				        NVARCHAR(20) NULL,
	[VOUCHER] 					    NVARCHAR(20) NULL,
	[VOUCHERPHYSICAL] 			    NVARCHAR(20) NULL,
	[TRANSREFID] 				    NVARCHAR(20) NULL,
	[INVENTREFTRANSID] 			    NVARCHAR(24) NULL,	
	[DW_Batch]                		BIGINT NULL,
	[DW_SourceCode]           		VARCHAR(15) NOT NULL,
	[DW_TimeStamp]            		DATETIME NOT NULL, 
    [t_applicationId]               VARCHAR    (32)  NULL,
    [t_jobId]                       VARCHAR    (36)  NULL,
    [t_jobDtm]                      DATETIME,
    [t_jobBy]                       NVARCHAR  (128)  NULL,
    [t_extractionDtm]               DATETIME,
    [t_filePath]                    NVARCHAR (1024)  NULL,
    CONSTRAINT [PK_FACT_INVENTTRANS] PRIMARY KEY NONCLUSTERED (
        [DW_Id] ASC
    ) NOT ENFORCED
)
WITH (HEAP, DISTRIBUTION = ROUND_ROBIN);
