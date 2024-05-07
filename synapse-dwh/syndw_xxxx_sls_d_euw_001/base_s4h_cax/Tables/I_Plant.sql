CREATE TABLE [base_s4h_cax].[I_Plant](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [Plant] nvarchar(4) NOT NULL
, [PlantName] nvarchar(30)
, [ValuationArea] nvarchar(4)
, [PlantCustomer] nvarchar(10)
, [PlantSupplier] nvarchar(10)
, [FactoryCalendar] nvarchar(2)
, [DefaultPurchasingOrganization] nvarchar(4)
, [SalesOrganization] nvarchar(4)
, [AddressID] nvarchar(10)
, [PlantCategory] nvarchar(1)
, [DistributionChannel] nvarchar(2)
, [Division] nvarchar(2)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_Plant] PRIMARY KEY NONCLUSTERED (
    [MANDT], [Plant]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
