CREATE TABLE [base_s4h_cax].[I_CompanyCode](
  [TS_SEQUENCE_NUMBER] INTEGER NOT NULL
, [ODQ_CHANGEMODE] CHAR(1)
, [ODQ_ENTITYCNTR] NUMERIC(19,0)
, [MANDT] char(3) collate Latin1_General_100_BIN2 NOT NULL
, [CompanyCode] nvarchar(4) NOT NULL
, [CompanyCodeName] nvarchar(25)
, [CityName] nvarchar(25)
, [Country] nvarchar(3)
, [Currency] char(5) collate Latin1_General_100_BIN2
, [Language] char(1) collate  Latin1_General_100_BIN2
, [ChartOfAccounts] nvarchar(4)
, [FiscalYearVariant] nvarchar(2)
, [Company] nvarchar(6)
, [CreditControlArea] nvarchar(4)
, [CountryChartOfAccounts] nvarchar(4)
, [FinancialManagementArea] nvarchar(4)
, [AddressID] nvarchar(10)
, [TaxableEntity] nvarchar(4)
, [VATRegistration] nvarchar(20)
, [ExtendedWhldgTaxIsActive] nvarchar(1)
, [ControllingArea] nvarchar(4)
, [FieldStatusVariant] nvarchar(4)
, [NonTaxableTransactionTaxCode] nvarchar(2)
, [DocDateIsUsedForTaxDetn] nvarchar(1)
, [TaxRptgDateIsActive] nvarchar(1)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_CompanyCode] PRIMARY KEY NONCLUSTERED (
    [TS_SEQUENCE_NUMBER], [MANDT], [CompanyCode]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
