CREATE TABLE [edw].[dim_SupplierPurchasingOrg]
(
    [SupplierID]                     nvarchar(10) NOT NULL, --collate Latin1_General_100_BIN2 NOT NULL,
    [PurchasingOrganizationID]       nvarchar(4) NOT NULL, --collate Latin1_General_100_BIN2  NOT NULL,
    [PurchasingGroupID]              nvarchar(3), -- collate Latin1_General_100_BIN2,
    [t_applicationId]                VARCHAR(32), 
    [t_extractionDtm]                DATETIME,
    [t_jobId]                        VARCHAR (36),
    [t_jobDtm]                       DATETIME,
    [t_lastActionCd]                 VARCHAR(1),
    [t_jobBy]                        NVARCHAR(128),
    CONSTRAINT [PK_dim_SupplierPurchasingOrg] PRIMARY KEY NONCLUSTERED ([SupplierID], [PurchasingOrganizationID]) NOT ENFORCED
)
WITH
    (DISTRIBUTION = REPLICATE, HEAP )
GO
