CREATE TABLE [base_tx_halfen_2_dwh].[DIM_INVENTTABLE](

	[DW_Id]                            	 		BIGINT NOT NULL,
	[ITEMID]                             		NVARCHAR(20) NULL,
	[ITEMGROUPID]                        		NVARCHAR(20) NULL,
	[ITEMNAME]                           		NVARCHAR(140) NULL,
	[DATAAREAID]                         		NVARCHAR(4) NULL,
	[HALPRODUCTLINEID]                   		NVARCHAR(10) NULL,
	[ITEMTYPE]                           		BIGINT NULL,
	[STOPEXPLODE]                        		BIGINT NULL,
	[HALITEMTYPE_NAME]                   		NVARCHAR(1999) NULL,
	[HALITEMTYPE]                        		BIGINT NULL,
	[ITEMTYPE_NAME]                      		NVARCHAR(1999) NULL,
	[HPLBUSINESSRULESTATUSID]            		NVARCHAR(30) NULL,
	[bomlines]                           		BIGINT NULL,
	[HALISKIT]                           		VARCHAR(50) NULL,
	[HALPRODUCTRANGEID]                         NVARCHAR(10) NULL,
	[PRIMARYVENDORID] 							NVARCHAR(20) NULL,
	[REQGROUPID]								NVARCHAR(10) NULL,
	[HALSALEABLEITEM] 							BIGINT NULL,
	[HPLMAINSTATISTICGROUPID] 					NVARCHAR(10) NULL,
	[COSTGROUPID]					    		NVARCHAR(10) NULL,
	[HALSurchargeGroupPURCH] 					NVARCHAR(10) NULL,
	[ITEMBUYERGROUPID] 							NVARCHAR(10) NULL,
	[NETWEIGHT] 								DECIMAL(38, 12) NULL,
	[StockUnit] 								NVARCHAR(10) NULL,
	[MODELGROUPID] 								NVARCHAR(10) NULL,
	[ADMIN_VirtualDataAreaid_INVENTMODELGROUP] 	NVARCHAR(4) NULL,
	[MODELGROUP_NAME]                  			NVARCHAR(140) NULL,
	[INCLPHYSICALVALUEINCOST]          			BIGINT NULL,
	[BOMUNITID]                        			NVARCHAR(10) NULL,
	[HALSTATISTICGROUPID]              			NVARCHAR(10) NULL,
	[HALPURCHCLASSIFIERID]             			NVARCHAR(25) NULL,
	[LastYear]                         			BIGINT NULL,
	[Type4PriceLastYear]               			DECIMAL(38, 12) NULL,
	[PurchasePriceUnit]                			DECIMAL(38, 12) NULL,
	[PurchPriceUnitID]                 			NVARCHAR(10) NULL,
	[Price_ForInventoryReporting]      			DECIMAL(38, 12) NULL,
	[EXCHRATE_EUR]                     			DECIMAL(38, 12) NULL,
	[Type4PriceLastYear_EUR]           			DECIMAL(38, 2) NULL,
	[HALPRODUCTLINENAME]               			NVARCHAR(60) NULL,
	[HALPRODUCTLINEID_NAME]            			VARCHAR(100) NULL,
	[HALPRODUCTRANGENAME]              			NVARCHAR(60) NULL,
	[HALPRODUCTRANGEID_NAME]           			VARCHAR(100) NULL,
	[HPLMAINSTATISTICGROUPNAME]        			NVARCHAR(60) NULL,
	[HPLLONGMAINSTATISTICGROUPID]      			NVARCHAR(60) NULL,
	[HPLLONGMAINSTATISTICGROUPID_NAME] 			VARCHAR(100) NULL,
	[HALSTATISTICGROUPNAME]            			NVARCHAR(60) NULL,
	[HALSTATISTICGROUPID_NAME]         			VARCHAR(100) NULL,
	[HPLSTATISTICGROUPID]              			NVARCHAR(10) NULL,
	[HPLSTATISTICGROUPNAME]            			NVARCHAR(60) NULL,
	[HPLSTATITICGROUPID_NAME]          			VARCHAR(100) NULL,
	[ITEMID_NAME]                      			VARCHAR(100) NULL,
	[Type4MarkupLastYear]              			DECIMAL(38, 12) NULL,
	[Type4PriceUnitLastYear]           			DECIMAL(38, 12) NULL,
	[Type4PriceQuantityLastYear]       			DECIMAL(38, 12) NULL,
	[INTRACODE]                        			NVARCHAR(10) NULL,
	[INTRACODENAME]                    			NVARCHAR(250) NULL,
	[INTRACODE_NAME]                   			NVARCHAR(200) NULL,
	[DW_Batch]                         			BIGINT NULL,
	[DW_SourceCode]                    			VARCHAR(15) NOT NULL,
	[DW_TimeStamp]                     			DATETIME NOT NULL,
    [t_applicationId]   						VARCHAR    (32)  NULL,
    [t_jobId]           						VARCHAR    (36)  NULL,
    [t_jobDtm]          						DATETIME,
    [t_jobBy]           						NVARCHAR  (128)  NULL,
    [t_extractionDtm]   						DATETIME,
    [t_filePath]        						NVARCHAR (1024)  NULL,
    CONSTRAINT [PK_DIM_INVENTTABLE] PRIMARY KEY NONCLUSTERED (
        [DW_Id] ASC
    ) NOT ENFORCED
)
WITH (HEAP, DISTRIBUTION = ROUND_ROBIN);