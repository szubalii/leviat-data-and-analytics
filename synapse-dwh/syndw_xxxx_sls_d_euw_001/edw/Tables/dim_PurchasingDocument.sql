CREATE TABLE [edw].[dim_PurchasingDocument]
(
    [PurchasingDocumentID]              nvarchar(10) collate Latin1_General_100_BIN2 NOT NULL,
    [SupplierID]                        nvarchar(10) collate Latin1_General_100_BIN2,
    [PurchasingDocumentCategoryID]      nvarchar(1) collate Latin1_General_100_BIN2,
    [PurchasingDocumentType]            nvarchar(4) collate Latin1_General_100_BIN2,
    [CreationDate]                      date,
    [CreatedByUser]                     nvarchar(12) collate Latin1_General_100_BIN2,
    [CompanyCode]                       nvarchar(4) collate Latin1_General_100_BIN2,
    [PurchasingDocumentOrderDate]       date,
    [PurchasingOrganization]            nvarchar(4) collate Latin1_General_100_BIN2,
    [PurchasingGroupID]                 nvarchar(3) collate Latin1_General_100_BIN2,
    [PlantID]                           nvarchar(4) collate Latin1_General_100_BIN2,
    [PurchasingProcessingStatus]        nvarchar(2) collate Latin1_General_100_BIN2, 
    [PurchaseContract]                  nvarchar(10) collate Latin1_General_100_BIN2,
    [t_applicationId]                   VARCHAR(32),
    [t_extractionDtm]                   DATETIME,
    [t_jobId]                           VARCHAR(36),
    [t_jobDtm]                          DATETIME,
    [t_lastActionCd]                    VARCHAR(1),
    [t_jobBy]                           NVARCHAR(128),
    CONSTRAINT [PK_dim_PurchasingDocument] PRIMARY KEY NONCLUSTERED (PurchasingDocumentID, PurchasingDocumentCategoryID) NOT ENFORCED
)
WITH
    (DISTRIBUTION = REPLICATE, HEAP )
GO