CREATE TABLE [edw].[dim_Plant]
(
    [PlantID]                       NVARCHAR(4)    NOT NULL,
    [Plant]                         NVARCHAR(40)   NULL,
    [ValuationArea]                 nvarchar(4),
    [PlantCustomer]                 nvarchar(10),
    [PlantSupplier]                 nvarchar(10),
    [FactoryCalendar]               nvarchar(2),
    [DefaultPurchasingOrganization] nvarchar(4),
    [SalesOrganization]             nvarchar(4),
    [AddressID]                     nvarchar(10),
    [PlantCategory]                 nvarchar(1),
    [DistributionChannel]           nvarchar(2),
    [Division]                      nvarchar(2),
    [t_applicationId]               VARCHAR(32)    ,
    [t_jobId]                       VARCHAR(36)    ,
    [t_jobDtm]                      DATETIME       ,
    [t_lastActionCd]        VARCHAR(1),
    [t_jobBy]               NVARCHAR(128),
    CONSTRAINT [PK_dim_Plant] PRIMARY KEY NONCLUSTERED ([PlantID]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO