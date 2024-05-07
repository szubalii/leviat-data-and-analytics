CREATE TABLE [edw].[fact_PurchasingDocument]
(
    [PurchasingDocument]              nvarchar(10) NOT NULL,-- collate Latin1_General_100_BIN2 NOT NULL,
    [SupplierID]                        nvarchar(10), -- collate Latin1_General_100_BIN2,
    [PurchasingDocumentCategoryID]      nvarchar(1), -- collate Latin1_General_100_BIN2,
    [PurchasingDocumentTypeID]          nvarchar(4), -- collate Latin1_General_100_BIN2,
    [CreationDate]                      date,
    [CreatedByUser]                     nvarchar(12), -- collate Latin1_General_100_BIN2,
    [CompanyCodeID]                     nvarchar(4), -- collate Latin1_General_100_BIN2,
    [PurchasingDocumentOrderDate]       date,
    [PurchasingOrganizationID]          nvarchar(4), -- collate Latin1_General_100_BIN2,
    [PurchasingGroupID]                 nvarchar(3), -- collate Latin1_General_100_BIN2,
    [SupplyingPlantID]                  nvarchar(4), -- collate Latin1_General_100_BIN2,
    [PurchasingProcessingStatusID]      nvarchar(2), -- collate Latin1_General_100_BIN2, 
    [PurchaseContract]                  nvarchar(10), -- collate Latin1_General_100_BIN2,
    [PurchasingDocumentCondition]       nvarchar(10), -- collate Latin1_General_100_BIN2,
    [t_applicationId]                   VARCHAR(32),
    [t_extractionDtm]                   DATETIME,
    [t_jobId]                           VARCHAR(36),
    [t_jobDtm]                          DATETIME,
    [t_lastActionCd]                    VARCHAR(1),
    [t_jobBy]                           NVARCHAR(128),
    CONSTRAINT [PK_dim_PurchasingDocument] PRIMARY KEY NONCLUSTERED (PurchasingDocument) NOT ENFORCED
)
WITH ( DISTRIBUTION = HASH (PurchasingDocument), CLUSTERED COLUMNSTORE INDEX )
