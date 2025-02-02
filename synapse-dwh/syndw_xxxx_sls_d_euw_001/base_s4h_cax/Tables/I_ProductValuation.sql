CREATE TABLE [base_s4h_cax].[I_ProductValuation]
(
    [MANDT]                         nchar(3) NOT NULL, --collate Latin1_General_100_BIN2     NOT NULL,
    [Product]                       nvarchar(40) NOT NULL, --collate Latin1_General_100_BIN2 NOT NULL,
    [ValuationArea]                 nvarchar(4) NOT NULL, --collate Latin1_General_100_BIN2  NOT NULL,
    [ValuationType]                 nvarchar(10) NOT NULL, --collate Latin1_General_100_BIN2 NOT NULL,
    [ValuationClass]                nvarchar(4), -- collate Latin1_General_100_BIN2,
    [PriceDeterminationControl]     nvarchar(1), -- collate Latin1_General_100_BIN2,
    [FiscalMonthCurrentPeriod]      char(2), -- collate Latin1_General_100_BIN2,
    [FiscalYearCurrentPeriod]       char(4), -- collate Latin1_General_100_BIN2,
    [StandardPrice]                 decimal(11, 2),
    [PriceUnitQty]                  decimal(5),
    [InventoryValuationProcedure]   nvarchar(1), -- collate Latin1_General_100_BIN2,
    [FutureEvaluatedAmountValue]    decimal(11, 2),
    [FuturePriceValidityStartDate]  date,
    [PrevInvtryPriceInCoCodeCrcy]   decimal(11, 2),
    [MovingAveragePrice]            decimal(11, 2),
    [ValuationCategory]             nvarchar(1), -- collate Latin1_General_100_BIN2,
    [ProductUsageType]              nvarchar(1), -- collate Latin1_General_100_BIN2,
    [ProductOriginType]             nvarchar(1), -- collate Latin1_General_100_BIN2,
    [IsProducedInhouse]             nvarchar(1), -- collate Latin1_General_100_BIN2,
    [ProdCostEstNumber]             char(12), -- collate Latin1_General_100_BIN2,
    [IsMarkedForDeletion]           nvarchar(1), -- collate Latin1_General_100_BIN2,
    [ValuationMargin]               decimal(6, 2),
    [IsActiveEntity]                nvarchar(1), -- collate Latin1_General_100_BIN2,
    [CompanyCode]                   nvarchar(4), -- collate Latin1_General_100_BIN2,
    [ValuationClassSalesOrderStock] nvarchar(4), -- collate Latin1_General_100_BIN2,
    [ProjectStockValuationClass]    nvarchar(4), -- collate Latin1_General_100_BIN2,
    [PlannedPrice1InCoCodeCrcy]     decimal(11, 2),
    [PlannedPrice2InCoCodeCrcy]     decimal(11, 2),
    [PlannedPrice3InCoCodeCrcy]     decimal(11, 2),
    [FuturePlndPrice1ValdtyDate]    date,
    [FuturePlndPrice2ValdtyDate]    date,
    [FuturePlndPrice3ValdtyDate]    date,
    [TaxBasedPricesPriceUnitQty]    decimal(5),
    [PriceLastChangeDate]           date,
    [PlannedPrice]                  decimal(11, 2),
    [Currency]                      nchar(5), -- collate Latin1_General_100_BIN2,
    [t_applicationId]               VARCHAR (32),
    [t_jobId]                       VARCHAR (36),
    [t_jobDtm]                      DATETIME,
    [t_jobBy]        		        NVARCHAR (128),
    [t_extractionDtm]		        DATETIME,
    [t_filePath]                    NVARCHAR (1024),
    CONSTRAINT [PK_I_ProductValuation]  PRIMARY KEY NONCLUSTERED (
        [MANDT], [Product], [ValuationArea], [ValuationType]
    ) NOT ENFORCED
) WITH (
  HEAP
)
