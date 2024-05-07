CREATE TABLE [base_s4h_cax].[I_SalesOrganization](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [SalesOrganization] nvarchar(4) NOT NULL
, [SalesOrganizationCurrency] char(5) -- collate Latin1_General_100_BIN2
, [CompanyCode] nvarchar(4)
, [IntercompanyBillingCustomer] nvarchar(10)
, [ArgentinaDeliveryDateEvent] nvarchar(1)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_SalesOrganization] PRIMARY KEY NONCLUSTERED (
    [MANDT], [SalesOrganization]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
