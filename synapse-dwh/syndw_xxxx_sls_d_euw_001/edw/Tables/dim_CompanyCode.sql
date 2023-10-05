CREATE TABLE [edw].[dim_CompanyCode] (
-- Company Code
  [CompanyCodeID] nvarchar(8) NOT NULL 
, [CompanyCode] nvarchar(50) 
, [CompanyCodeDescription] nvarchar(50)
, [CityName] nvarchar(50)
, [Country] nvarchar(6)
, [Currency] char(5) -- collate Latin1_General_100_BIN2
, [Language] char(1) -- collate Latin1_General_100_BIN2
, [ChartOfAccounts] nvarchar(8)
, [FiscalYearVariant] nvarchar(4)
, [Company] nvarchar(12)
, [CreditControlArea] nvarchar(8)
, [CountryChartOfAccounts] nvarchar(8)
, [FinancialManagementArea] nvarchar(8)
, [AddressID] nvarchar(20)
, [TaxableEntity] nvarchar(8)
, [VATRegistration] nvarchar(40)
, [ExtendedWhldgTaxIsActive] nvarchar(2)
, [ControllingArea] nvarchar(8)
, [FieldStatusVariant] nvarchar(8)
, [NonTaxableTransactionTaxCode] nvarchar(4)
, [DocDateIsUsedForTaxDetn] nvarchar(2)
, [TaxRptgDateIsActive] nvarchar(2)
, [CashDiscountBaseAmtIsNetAmt] nvarchar(2)
, [RegionID] nvarchar(10)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_lastActionCd]        VARCHAR(1)
, [t_jobBy]               NVARCHAR(128)
,    CONSTRAINT [PK_dim_CompanyCode] PRIMARY KEY NONCLUSTERED ([CompanyCodeID]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO
