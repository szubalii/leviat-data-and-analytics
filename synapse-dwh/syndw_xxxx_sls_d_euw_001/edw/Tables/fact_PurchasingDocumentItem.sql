CREATE TABLE [edw].[fact_PurchasingDocumentItem]
(
    [sk_fact_PurchasingDocumentItem]            bigint IDENTITY(1,1) NOT NULL,
    [PurchasingDocument]                        nvarchar(10) collate Latin1_General_100_BIN2 NOT NULL,
    [PurchasingDocumentItem]                    char(5) collate Latin1_General_100_BIN2      NOT NULL,
    [MaterialID]                                nvarchar(40) collate Latin1_General_100_BIN2,
    [PurchasingDocumentItemText]                nvarchar(40) collate Latin1_General_100_BIN2,
    [DocumentCurrencyID]                        nchar(5) collate Latin1_General_100_BIN2,
--edw.vw_Currency	Currency		X           PurchaseOrderCurrency		
    [PlantID]                                   nvarchar(4) collate Latin1_General_100_BIN2,
    [CompanyCodeID]                             nvarchar(4) collate Latin1_General_100_BIN2,
    [MaterialGroupID]                           nvarchar(9) collate Latin1_General_100_BIN2,
    [PurchaseContract]                          nvarchar(10) collate Latin1_General_100_BIN2,
    [PurchaseContractItem]                      char(5) collate Latin1_General_100_BIN2,
    [NetAmount]                                 decimal(13, 2),
    [PurchaseOrderQuantity]                     decimal(13, 3),
    [StorageLocationID]                         nvarchar(4) collate Latin1_General_100_BIN2,
    [OrderPriceUnit]                            nvarchar(3) collate Latin1_General_100_BIN2,
    [NetPriceAmount]                            decimal(11, 2),
    [NetPriceQuantity]                          decimal(13, 3),
    [PurchasingDocumentItemCategoryID]          nvarchar(1) collate Latin1_General_100_BIN2,
    [NextDeliveryOpenQuantity]                  decimal(13, 3),
    [NextDeliveryDate]                          date,
    [IsCompletelyDelivered]                     nvarchar(1) collate Latin1_General_100_BIN2,    
    [OrderQuantityUnit]                         nvarchar(3) collate Latin1_General_100_BIN2,
    [CostCenterID]                              nvarchar(10) collate Latin1_General_100_BIN2,
    [GLAccount]                                 nvarchar(10) collate Latin1_General_100_BIN2,
    [GoodsReceiptQuantity]                      decimal(13, 3),
    [t_applicationId]                           VARCHAR(32),
    [t_extractionDtm]                           DATETIME,
    [t_jobId]                                   VARCHAR(36),
    [t_jobDtm]                                  DATETIME,
    [t_lastActionCd]                            VARCHAR(1),
    [t_jobBy]                                   NVARCHAR(128),
    CONSTRAINT [PK_fact_PurchasingDocumentItem] PRIMARY KEY NONCLUSTERED ([PurchasingDocument], [PurchasingDocumentItem]) NOT ENFORCED
)
WITH ( DISTRIBUTION = HASH (PurchasingDocument), CLUSTERED COLUMNSTORE INDEX )
GO

