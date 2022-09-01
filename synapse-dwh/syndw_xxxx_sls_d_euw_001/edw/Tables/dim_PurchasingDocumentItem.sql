CREATE TABLE [edw].[dim_PurchasingDocumentItem]
(

    [PurchasingDocumentID]             nvarchar(10) collate Latin1_General_100_BIN2 NOT NULL,
    [PurchasingDocumentItemID]         char(5) collate Latin1_General_100_BIN2      NOT NULL,
    [Material]                         nvarchar(40) collate Latin1_General_100_BIN2,
    [PurchaseOrderCurrencyID]          nchar(5) collate Latin1_General_100_BIN2,
--edw.vw_Currency	Currency		X	PurchaseOrderCurrency		
    [PlantID]                          nvarchar(4) collate Latin1_General_100_BIN2,
    [CompanyCode]                      nvarchar(4) collate Latin1_General_100_BIN2,
    [MaterialGroupID]                  nvarchar(9) collate Latin1_General_100_BIN2,
    [PurchaseContract]                 nvarchar(10) collate Latin1_General_100_BIN2,
    [PurchaseContractItem]             char(5) collate Latin1_General_100_BIN2,
    [PurchaseOrderNetAmount]           decimal(13, 2),
    [PurchaseOrderQuantity]            decimal(13, 3),
    [StorageLocationID]                nvarchar(4) collate Latin1_General_100_BIN2,
    [OrderPriceUnit]                   nvarchar(3) collate Latin1_General_100_BIN2,
    [NetPriceAmount]                   decimal(11, 2),
    [NetPriceQuantity]                 decimal(13, 3),
    [PurchasingDocumentItemCategoryID] nvarchar(1) collate Latin1_General_100_BIN2,
    [t_applicationId]                  VARCHAR(32),
    [t_extractionDtm]                  DATETIME,
    [t_jobId]                          VARCHAR(36),
    [t_jobDtm]                         DATETIME,
    [t_lastActionCd]                   VARCHAR(1),
    [t_jobBy]                          NVARCHAR(128),
    CONSTRAINT [PK_dim_PurchasingDocumentItem] PRIMARY KEY NONCLUSTERED ([PurchasingDocumentID], [PurchasingDocumentItemID]) NOT ENFORCED
)
    WITH
        (DISTRIBUTION = REPLICATE, HEAP )
GO

