CREATE TABLE [edw].[dim_ProductValuationPUP]
(   
    [sk_dim_ProductValuationPUP]     BIGINT IDENTITY (1,1)                        NOT NULL,
    [nk_dim_ProductValuationPUP]     NVARCHAR(54)                                 NOT NULL,
    [CalendarYear]                   CHAR(4) NOT NULL, --COLLATE Latin1_General_100_BIN2      NOT NULL,
    [CalendarMonth]                  CHAR(2) NOT NULL, --COLLATE Latin1_General_100_BIN2      NOT NULL,
    [FirstDayOfMonthDate]            DATE,
    [ProductID]                      NVARCHAR(40) NOT NULL, --COLLATE Latin1_General_100_BIN2 NOT NULL,
    [ValuationAreaID]                NVARCHAR(4) NOT NULL, --COLLATE Latin1_General_100_BIN2  NOT NULL,
    [ValuationArea]                  NVARCHAR(50),
    [ValuationTypeID]                NVARCHAR(10) NOT NULL, --COLLATE Latin1_General_100_BIN2 NOT NULL,
    [ValuationClassID]               NVARCHAR(4), -- COLLATE Latin1_General_100_BIN2,
    [FiscalYearPeriod]               CHAR(4) NOT NULL, --COLLATE Latin1_General_100_BIN2      NOT NULL,
    [FiscalMonthPeriod]              CHAR(2) NOT NULL, --COLLATE Latin1_General_100_BIN2      NOT NULL,
    [FiscalPeriodDate]               DATE,
    [TotalValuatedStock]             DECIMAL(13, 3),
    [TotalValuatedStockValue]        DECIMAL(13, 2),
    [PriceControlIndicatorID]        nvarCHAR(1), -- COLLATE Latin1_General_100_BIN2,
    [PriceControlIndicator]          NVARCHAR(25), -- COLLATE Latin1_General_100_BIN2,
    [PeriodicUnitPrice]              DECIMAL(11, 2),
    [StandardPrice]                  DECIMAL(11, 2),
    [PriceUnit]                      DECIMAL(5),
    [SAPTotalStockValuePUP]          DECIMAL(13, 2),
    [SAPTotalStockValueAtSalesPrice] DECIMAL(13, 2),
    [CurrencyID]                     CHAR(5), -- COLLATE Latin1_General_100_BIN2,
    [StockPricePerUnit]              DECIMAL(15, 4),
    [StockPricePerUnit_EUR]          DECIMAL(15, 4),
    [StockPricePerUnit_USD]          DECIMAL(15, 4),
    [isAddedMissingMonth]            BIT,    
    [t_applicationId]                VARCHAR(32),
    [t_extractionDtm]                DATETIME,
    [t_jobId]                        VARCHAR(36),
    [t_jobDtm]                       DATETIME,
    [t_lastActionCd]                 VARCHAR(1),
    [t_jobBy]                        NVARCHAR(128),
    CONSTRAINT [PK_ProductValuationPUP] PRIMARY KEY NONCLUSTERED ([sk_dim_ProductValuationPUP])
        NOT ENFORCED
)
WITH
    (DISTRIBUTION = REPLICATE, HEAP )
GO