CREATE TABLE [base_s4h_cax].[I_Supplier](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [Supplier] nvarchar(10) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [SupplierAccountGroup] nvarchar(4)
, [SupplierName] nvarchar(80)
, [SupplierFullName] nvarchar(220)
, [IsBusinessPurposeCompleted] nvarchar(1)
, [CreatedByUser] nvarchar(12)
, [CreationDate] date
, [IsOneTimeAccount] nvarchar(1)
, [AuthorizationGroup] nvarchar(4)
, [VATRegistration] nvarchar(20)
, [AccountIsBlockedForPosting] nvarchar(1)
, [TaxJurisdiction] nvarchar(15)
, [SupplierCorporateGroup] nvarchar(10)
, [Customer] nvarchar(10)
, [Industry] nvarchar(4)
, [TaxNumber1] nvarchar(16)
, [TaxNumber2] nvarchar(11)
, [TaxNumber3] nvarchar(18)
, [TaxNumber4] nvarchar(18)
, [TaxNumber5] nvarchar(60)
, [PostingIsBlocked] nvarchar(1)
, [PurchasingIsBlocked] nvarchar(1)
, [InternationalLocationNumber1] char(7) -- collate Latin1_General_100_BIN2
, [InternationalLocationNumber2] char(5) -- collate Latin1_General_100_BIN2
, [InternationalLocationNumber3] char(1) -- collate Latin1_General_100_BIN2
, [AddressID] nvarchar(10)
, [Region] nvarchar(3)
, [OrganizationBPName1] nvarchar(35)
, [OrganizationBPName2] nvarchar(35)
, [CityName] nvarchar(35)
, [PostalCode] nvarchar(10)
, [StreetName] nvarchar(35)
, [Country] nvarchar(3)
, [ConcatenatedInternationalLocNo] nvarchar(20)
, [SupplierProcurementBlock] nvarchar(2)
, [SuplrQualityManagementSystem] nvarchar(4)
, [SuplrQltyInProcmtCertfnValidTo] date
, [SupplierLanguage] char(1) -- collate Latin1_General_100_BIN2
, [AlternativePayeeAccountNumber] nvarchar(10)
, [PhoneNumber1] nvarchar(16)
, [FaxNumber] nvarchar(31)
, [IsNaturalPerson] nvarchar(1)
, [TaxNumberResponsible] nvarchar(18)
, [UK_ContractorBusinessType] nvarchar(12)
, [UK_PartnerTradingName] nvarchar(30)
, [UK_PartnerTaxReference] nvarchar(20)
, [UK_VerificationStatus] nvarchar(3)
, [UK_VerificationNumber] nvarchar(20)
, [UK_CompanyRegistrationNumber] nvarchar(8)
, [UK_VerifiedTaxStatus] nvarchar(1)
, [FormOfAddress] nvarchar(15)
, [ReferenceAccountGroup] nvarchar(4)
, [VATLiability] nvarchar(1)
, [ResponsibleType] nvarchar(2)
, [TaxNumberType] nvarchar(2)
, [FiscalAddress] nvarchar(10)
, [BusinessType] nvarchar(30)
, [BirthDate] date
, [PaymentIsBlockedForSupplier] nvarchar(1)
, [SortField] nvarchar(10)
, [PhoneNumber2] nvarchar(16)
, [DeletionIndicator] nvarchar(1)
, [TradingPartner] nvarchar(6)
, [TaxInvoiceRepresentativeName] nvarchar(10)
, [IndustryType] nvarchar(30)
, [IN_GSTSupplierClassification] char(1)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		    NVARCHAR (128)
, [t_extractionDtm]		    DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_Supplier] PRIMARY KEY NONCLUSTERED (
    [MANDT], [Supplier]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
