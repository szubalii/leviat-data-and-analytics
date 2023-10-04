CREATE TABLE [edw].[dim_SupplierCompany]
(
    [SupplierID]                     NVARCHAR(10) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL,
    [CompanyCodeID]                  NVARCHAR(4) collate Latin1_General_100_BIN2  NOT NULL,
    [PaymentMethodsList]             NVARCHAR(10) -- collate Latin1_General_100_BIN2,
    [t_applicationId]                VARCHAR(32), 
    [t_extractionDtm]                DATETIME,
    [t_jobId]                        VARCHAR (36),
    [t_jobDtm]                       DATETIME,
    [t_lastActionCd]                 VARCHAR(1),
    [t_jobBy]                        NVARCHAR(128),
     CONSTRAINT [PK_dim_SupplierCompany] PRIMARY KEY NONCLUSTERED ([SupplierID], [CompanyCodeID]) NOT ENFORCED
)
WITH
    (DISTRIBUTION = REPLICATE, HEAP )
