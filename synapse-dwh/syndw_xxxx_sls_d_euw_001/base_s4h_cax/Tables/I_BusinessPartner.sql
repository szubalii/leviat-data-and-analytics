CREATE TABLE [base_s4h_cax].[I_BusinessPartner](
  [MANDT] nchar(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [BusinessPartner] nvarchar(10) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [BusinessPartnerCategory] nvarchar(1) -- collate Latin1_General_100_BIN2
, [AuthorizationGroup] nvarchar(4) -- collate Latin1_General_100_BIN2
, [BusinessPartnerUUID] binary(16)
, [PersonNumber] nvarchar(10) -- collate Latin1_General_100_BIN2
, [ETag] nvarchar(26) -- collate Latin1_General_100_BIN2
, [BusinessPartnerName] nvarchar(81) -- collate Latin1_General_100_BIN2
, [BusinessPartnerFullName] nvarchar(81) -- collate Latin1_General_100_BIN2
, [CreatedByUser] nvarchar(12) -- collate Latin1_General_100_BIN2
, [CreationDate] date
, [CreationTime] time(0)
, [LastChangedByUser] nvarchar(12) -- collate Latin1_General_100_BIN2
, [LastChangeDate] date
, [LastChangeTime] time(0)
, [BusinessPartnerIsBlocked] nvarchar(1) -- collate Latin1_General_100_BIN2
, [IsBusinessPurposeCompleted] nvarchar(1) -- collate Latin1_General_100_BIN2
, [FirstName] nvarchar(40) -- collate Latin1_General_100_BIN2
, [LastName] nvarchar(40) -- collate Latin1_General_100_BIN2
, [PersonFullName] nvarchar(80) -- collate Latin1_General_100_BIN2
, [OrganizationBPName1] nvarchar(40) -- collate Latin1_General_100_BIN2
, [OrganizationBPName2] nvarchar(40) -- collate Latin1_General_100_BIN2
, [OrganizationBPName3] nvarchar(40) -- collate Latin1_General_100_BIN2
, [OrganizationBPName4] nvarchar(40) -- collate Latin1_General_100_BIN2
, [InternationalLocationNumber1] char(7) -- collate Latin1_General_100_BIN2
, [InternationalLocationNumber2] char(5) -- collate Latin1_General_100_BIN2
, [InternationalLocationNumber3] char(1) -- collate Latin1_General_100_BIN2
, [LegalForm] nvarchar(2) -- collate Latin1_General_100_BIN2
, [OrganizationFoundationDate] date
, [OrganizationLiquidationDate] date
, [Industry] nvarchar(10) -- collate Latin1_General_100_BIN2
, [IsNaturalPerson] nvarchar(1) -- collate Latin1_General_100_BIN2
, [IsFemale] nvarchar(1) -- collate Latin1_General_100_BIN2
, [IsMale] nvarchar(1) -- collate Latin1_General_100_BIN2
, [IsSexUnknown] nvarchar(1) -- collate Latin1_General_100_BIN2
, [FormOfAddress] nvarchar(4) -- collate Latin1_General_100_BIN2
, [AcademicTitle] nvarchar(4) -- collate Latin1_General_100_BIN2
, [NameFormat] nvarchar(2) -- collate Latin1_General_100_BIN2
, [NameCountry] nvarchar(3) -- collate Latin1_General_100_BIN2
, [BusinessPartnerGrouping] nvarchar(4) -- collate Latin1_General_100_BIN2
, [BusinessPartnerType] nvarchar(4) -- collate Latin1_General_100_BIN2
, [MiddleName] nvarchar(40) -- collate Latin1_General_100_BIN2
, [AdditionalLastName] nvarchar(40) -- collate Latin1_General_100_BIN2
, [GroupBusinessPartnerName1] nvarchar(40) -- collate Latin1_General_100_BIN2
, [GroupBusinessPartnerName2] nvarchar(40) -- collate Latin1_General_100_BIN2
, [CorrespondenceLanguage] nchar(1) -- collate Latin1_General_100_BIN2
, [Language] nchar(1) -- collate Latin1_General_100_BIN2
, [SearchTerm1] nvarchar(20) -- collate Latin1_General_100_BIN2
, [SearchTerm2] nvarchar(20) -- collate Latin1_General_100_BIN2
, [BPLastNameSearchHelp] nvarchar(35) -- collate Latin1_General_100_BIN2
, [BPFirstNameSearchHelp] nvarchar(35) -- collate Latin1_General_100_BIN2
, [BusinessPartnerNicknameLabel] nvarchar(40) -- collate Latin1_General_100_BIN2
, [IndependentAddressID] nvarchar(10) -- collate Latin1_General_100_BIN2
, [IsActiveEntity] nvarchar(1) -- collate Latin1_General_100_BIN2
, [BirthDate] date
, [IsMarkedForArchiving] nvarchar(1) -- collate Latin1_General_100_BIN2
, [ContactPermission] nvarchar(1) -- collate Latin1_General_100_BIN2
, [BusinessPartnerIDByExtSystem] nvarchar(20) -- collate Latin1_General_100_BIN2
, [LegalEntityOfOrganization] nvarchar(2) -- collate Latin1_General_100_BIN2
, [TrdCmplncLicenseIsMilitarySctr] nvarchar(1) -- collate Latin1_General_100_BIN2
, [TrdCmplncLicenseIsNuclearSctr] nvarchar(1) -- collate Latin1_General_100_BIN2
, [BusinessPartnerPrintFormat] nvarchar(1) -- collate Latin1_General_100_BIN2
, [BusinessPartnerDataOriginType] nvarchar(4) -- collate Latin1_General_100_BIN2
, [BusinessPartnerIsNotReleased] nvarchar(1) -- collate Latin1_General_100_BIN2
, [IsNotContractuallyCapable] nvarchar(1) -- collate Latin1_General_100_BIN2
, [t_applicationId]         VARCHAR (32)
, [t_jobId]                 VARCHAR (36)
, [t_jobDtm]                DATETIME
, [t_jobBy]                 VARCHAR (128)
, [t_extractionDtm]         DATETIME
, [t_filePath]              NVARCHAR (1024)
, CONSTRAINT [PK_I_BusinessPartner] PRIMARY KEY NONCLUSTERED (
    [MANDT], [BusinessPartner]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
