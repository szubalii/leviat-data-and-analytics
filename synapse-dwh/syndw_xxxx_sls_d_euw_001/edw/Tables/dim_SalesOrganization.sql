CREATE TABLE [edw].[dim_SalesOrganization]
(
    [SalesOrganizationID]         NVARCHAR(4)  NOT NULL,
    [SalesOrganization]           NVARCHAR(50) NULL,
    [SalesOrganizationCurrency]   char(5),
    [CompanyCode]                 nvarchar(10),
    [IntercompanyBillingCustomer] nvarchar(10),
    [ArgentinaDeliveryDateEvent]  nvarchar(1),
    [CountryID]                   NVARCHAR(3),
    [CountryName]                 NVARCHAR(50),
    [RegionID]                    NVARCHAR(10),
    [RegionName]                  NVARCHAR(80),
    [Access_Control_Unit]         NVARCHAR(20),
    [t_applicationId]             VARCHAR(32)   NULL,
    [t_jobId]                     VARCHAR(36)  NULL,
    [t_jobDtm]                    DATETIME     NULL,
    [t_lastActionCd]              VARCHAR(1),
    [t_jobBy]                     NVARCHAR(128),
    [t_extractionDtm]             DATETIME     NULL
    CONSTRAINT [PK_dim_SalesOrganization] PRIMARY KEY NONCLUSTERED ([SalesOrganizationID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO