CREATE TABLE [base_s4h_cax].[I_CustSalesAreaTax](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [Customer] nvarchar(10) NOT NULL
, [SalesOrganization] nvarchar(4) NOT NULL
, [DistributionChannel] nvarchar(2) NOT NULL
, [Division] nvarchar(2) NOT NULL
, [DepartureCountry] nvarchar(3) NOT NULL
, [CustomerTaxCategory] nvarchar(4) NOT NULL
, [CustomerTaxClassification] nvarchar(1)
, [AuthorizationGroup] nvarchar(4)
, [IsBusinessPurposeCompleted] nvarchar(1)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_CustSalesAreaTax] PRIMARY KEY NONCLUSTERED (
    [MANDT], [Customer], [SalesOrganization], [DistributionChannel], [Division], [DepartureCountry], [CustomerTaxCategory]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
