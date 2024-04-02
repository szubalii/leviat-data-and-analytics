CREATE TABLE [edw].[dim_Customer] (
-- Customer
  [CustomerID] nvarchar(20) NOT NULL
, [CustomerExternalID] nvarchar(20) NOT NULL
, [Customer] nvarchar(160)
, [CustomerID_Name] nvarchar(180)
, [CustomerFullName] nvarchar(440)
, [CreatedByUser] nvarchar(24)
, [CreationDate] date
, [AddressID] nvarchar(20)
, [CustomerClassification] nvarchar(4)
, [VATRegistration] nvarchar(40)
, [CustomerAccountGroupID] nvarchar(8) -- renamed (ex CustomerAccountGroup) from [base_s4h_cax].[I_CustomerAccountGroupText]
, [AccountGroup] nvarchar(60) -- from [base_s4h_cax].[I_CustomerAccountGroupText]
, [AuthorizationGroup] nvarchar(8)
, [DeliveryIsBlocked] nvarchar(4)
, [PostingIsBlocked] nvarchar(2)
, [BillingIsBlockedForCustomer] nvarchar(4)
, [OrderIsBlockedForCustomer] nvarchar(4)
, [InternationalLocationNumber1] char(7) collate Latin1_General_100_BIN2
, [IsOneTimeAccount] nvarchar(2)
, [TaxJurisdiction] nvarchar(30)
, [Industry] nvarchar(8)
, [TaxNumberType] nvarchar(4)
, [TaxNumber1] nvarchar(32)
, [TaxNumber2] nvarchar(22)
, [TaxNumber3] nvarchar(36)
, [TaxNumber4] nvarchar(36)
, [TaxNumber5] nvarchar(120)
, [CustomerCorporateGroup] nvarchar(20)
, [Supplier] nvarchar(20)
, [NielsenRegion] nvarchar(4)
, [IndustryCode1] nvarchar(20)
, [IndustryCode2] nvarchar(20)
, [IndustryCode3] nvarchar(20)
, [IndustryCode4] nvarchar(20)
, [IndustryCode5] nvarchar(20)
, [CountryID] nvarchar(6) -- renamed (ex. Country), from base_s4h_cax.I_CountryText
, [Country] nvarchar(100) -- from base_s4h_cax.I_CountryText
, [NationalityName] nvarchar(30) -- from base_s4h_cax.I_CountryText
, [NationalityLongName] nvarchar(100) -- from base_s4h_cax.I_CountryText
, [CountryShortName] nvarchar(30) -- from base_s4h_cax.I_CountryText
, [OrganizationBPName1] nvarchar(70)
, [OrganizationBPName2] nvarchar(70)
, [CityName] nvarchar(70)
, [PostalCode] nvarchar(20)
, [StreetName] nvarchar(70)
, [SortField] nvarchar(20)
, [FaxNumber] nvarchar(62)
, [BR_SUFRAMACode] nvarchar(18)
, [RegionID] nvarchar(6) -- renamed (ex. Region), from [base_s4h_cax].[I_RegionText]
, [Region] nvarchar(40) -- from [base_s4h_cax].[I_RegionText]
, [TelephoneNumber1] nvarchar(32)
, [TelephoneNumber2] nvarchar(32)
, [AlternativePayerAccount] nvarchar(20)
, [DataMediumExchangeIndicator] nvarchar(2)
, [VATLiability] nvarchar(2)
, [IsBusinessPurposeCompleted] nvarchar(2)
, [ResponsibleType] nvarchar(4)
, [FiscalAddress] nvarchar(20)
, [NFPartnerIsNaturalPerson] nvarchar(2)
, [DeletionIndicator] nvarchar(2)
, [Language] char(1) collate  Latin1_General_100_BIN2
, [TradingPartner] nvarchar(12)
, [DeliveryDateTypeRule] nvarchar(2)
, [TaxInvoiceRepresentativeName] nvarchar(20)
, [BusinessType] nvarchar(60)
, [IndustryType] nvarchar(60)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_lastActionCd]        VARCHAR(1)
, [t_jobBy]               NVARCHAR(128)
, [t_extractionDtm]       DATETIME
,    CONSTRAINT [PK_dim_Customer] PRIMARY KEY NONCLUSTERED ([CustomerID]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO
