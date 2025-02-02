CREATE TABLE [edw].[dim_ProductValuation]
(
    [ProductID]                     NVARCHAR(40) NOT NULL,
    [ValuationAreaID]               NVARCHAR(4) NOT NULL,
    [ValuationTypeID]               NVARCHAR(10) NOT NULL,
    [ValuationClassID]              NVARCHAR(4),
    [PriceDeterminationControlID]   NVARCHAR(1),
    [FiscalMonthCurrentPeriod]      CHAR(2),
    [FiscalYearCurrentPeriod]       CHAR(4),
    [StandardPrice]                 DECIMAL(11, 2),
    [PriceUnitQuantity]             DECIMAL(5),
    [StandardPricePerUnit]          DECIMAL(11, 2),
    [StandardPricePerUnit_EUR]      DECIMAL(19, 6),
    [InventoryValuationProcedure]   NVARCHAR(1),
    [FutureEvaluatedAmountValue]    DECIMAL(11, 2),
    [FuturePriceValidityStartDate]  DATE,
    [PrevInvtryPriceInCoCodeCrcy]   DECIMAL(11, 2),
    [MovingAveragePrice]            DECIMAL(11, 2),
    [MovingAvgPricePerUnit]         DECIMAL(11, 2),
    [MovingAvgPricePerUnit_EUR]     DECIMAL(19, 6),
    [ValuationCategoryID]           NVARCHAR(1),
    [ProductUsageType]              NVARCHAR(1),
    [ProductOriginType]             NVARCHAR(1),
    [IsProducedInhouse]             NVARCHAR(1),
    [ProdCostEstNumber]             CHAR(12),
    [IsMarkedForDeletion]           NVARCHAR(1),
    [ValuationMargin]               DECIMAL(6, 2),
    [IsActiveEntity]                NVARCHAR(1),
    [CompanyCodeID]                 NVARCHAR(4),
    [ValuationClassSalesOrderStock] NVARCHAR(4),
    [ProjectStockValuationClass]    NVARCHAR(4),
    [PlannedPrice1InCoCodeCrcy]     DECIMAL(11, 2),
    [PlannedPrice2InCoCodeCrcy]     DECIMAL(11, 2),
    [PlannedPrice3InCoCodeCrcy]     DECIMAL(11, 2),
    [FuturePlndPrice1ValdtyDate]    DATE,
    [FuturePlndPrice2ValdtyDate]    DATE,
    [FuturePlndPrice3ValdtyDate]    DATE,
    [TaxBasedPricesPriceUnitQty]    DECIMAL(5),
    [PriceLastChangeDate]           DATE,
    [PlannedPrice]                  DECIMAL(11, 2),
    [CurrencyID]                    NCHAR(5),
    [t_applicationId]               VARCHAR(32),
    [t_extractionDtm]               DATETIME,
    [t_jobId]                       VARCHAR(36),
    [t_jobDtm]                      DATETIME,
    [t_lastActionCd]                VARCHAR(1),
    [t_jobBy]                       NVARCHAR(128),
    CONSTRAINT [PK_ProductValuation] PRIMARY KEY NONCLUSTERED ([ProductID], [ValuationAreaID], [ValuationTypeID])
    NOT ENFORCED
)
    WITH
    (
        DISTRIBUTION = REPLICATE, HEAP )
GO
