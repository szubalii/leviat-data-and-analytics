CREATE TABLE [edw].[dim_Plant]
(
    [PlantID]                       NVARCHAR(4)    NOT NULL,
    [Plant]                         NVARCHAR(40)   NULL,
    [ValuationArea]                 NVARCHAR(4),
    [PlantCustomer]                 NVARCHAR(10),
    [PlantSupplier]                 NVARCHAR(10),
    [FactoryCalendar]               NVARCHAR(2),
    [DefaultPurchasingOrganization] NVARCHAR(4),
    [SalesOrganization]             NVARCHAR(4),
    [AddressID]                     NVARCHAR(10),
    [PlantCategory]                 NVARCHAR(1),
    [DistributionChannel]           NVARCHAR(2),
    [Division]                      NVARCHAR(2),
    [t_applicationId]               VARCHAR(32),
    [t_extractionDtm]               DATETIME,
    [t_jobId]                       VARCHAR(36),
    [t_jobDtm]                      DATETIME,
    [t_lastActionCd]                VARCHAR(1),
    [t_jobBy]                       NVARCHAR(128),
    CONSTRAINT [PK_dim_Plant] PRIMARY KEY NONCLUSTERED ([PlantID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO