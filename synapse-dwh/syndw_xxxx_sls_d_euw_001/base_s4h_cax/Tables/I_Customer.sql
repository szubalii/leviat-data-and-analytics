CREATE TABLE [base_s4h_cax].[I_Customer](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [Customer] nvarchar(10) NOT NULL
, [CustomerName] nvarchar(80)
, [CustomerFullName] nvarchar(220)
, [CreatedByUser] nvarchar(12)
, [CreationDate] date
, [AddressID] nvarchar(10)
, [CustomerClassification] nvarchar(2)
, [VATRegistration] nvarchar(20)
, [CustomerAccountGroup] nvarchar(4)
, [AuthorizationGroup] nvarchar(4)
, [DeliveryIsBlocked] nvarchar(2)
, [PostingIsBlocked] nvarchar(1)
, [BillingIsBlockedForCustomer] nvarchar(2)
, [OrderIsBlockedForCustomer] nvarchar(2)
, [InternationalLocationNumber1] char(7) -- collate Latin1_General_100_BIN2
, [IsOneTimeAccount] nvarchar(1)
, [TaxJurisdiction] nvarchar(15)
, [Industry] nvarchar(4)
, [TaxNumberType] nvarchar(2)
, [TaxNumber1] nvarchar(16)
, [TaxNumber2] nvarchar(11)
, [TaxNumber3] nvarchar(18)
, [TaxNumber4] nvarchar(18)
, [TaxNumber5] nvarchar(60)
, [CustomerCorporateGroup] nvarchar(10)
, [Supplier] nvarchar(10)
, [NielsenRegion] nvarchar(2)
, [IndustryCode1] nvarchar(10)
, [IndustryCode2] nvarchar(10)
, [IndustryCode3] nvarchar(10)
, [IndustryCode4] nvarchar(10)
, [IndustryCode5] nvarchar(10)
, [Country] nvarchar(3)
, [OrganizationBPName1] nvarchar(35)
, [OrganizationBPName2] nvarchar(35)
, [CityName] nvarchar(35)
, [PostalCode] nvarchar(10)
, [StreetName] nvarchar(35)
, [SortField] nvarchar(10)
, [FaxNumber] nvarchar(31)
, [BR_SUFRAMACode] nvarchar(9)
, [Region] nvarchar(3)
, [TelephoneNumber1] nvarchar(16)
, [TelephoneNumber2] nvarchar(16)
, [AlternativePayerAccount] nvarchar(10)
, [DataMediumExchangeIndicator] nvarchar(1)
, [VATLiability] nvarchar(1)
, [IsBusinessPurposeCompleted] nvarchar(1)
, [ResponsibleType] nvarchar(2)
, [FiscalAddress] nvarchar(10)
, [NFPartnerIsNaturalPerson] nvarchar(1)
, [DeletionIndicator] nvarchar(1)
, [Language] char(1) -- collate Latin1_General_100_BIN2
, [TradingPartner] nvarchar(6)
, [TaxInvoiceRepresentativeName] nvarchar(10)
, [BusinessType] nvarchar(30)
, [IndustryType] nvarchar(30)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_Customer] PRIMARY KEY NONCLUSTERED (
    [MANDT], [Customer]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
