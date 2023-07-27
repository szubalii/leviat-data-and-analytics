CREATE TABLE [base_s4h_cax].[I_BusinessPartnerAddress]
(
    [MANDT] CHAR(3) NOT NULL  -- Client
  , [BUSINESSPARTNER] NVARCHAR(10) NOT NULL  -- Business Partner Number
  , [ADDRESSNUMBER] NVARCHAR(10) NOT NULL  -- Address Number
  , [ValidityStartDate] DECIMAL(15)  -- Validity Start of a Business Partner Address
  , [ValidityEndDate] DECIMAL(15)  -- Validity End of a Business Partner Address
  , [CareOfName] NVARCHAR(40)  -- c/o name
  , [FullName] NVARCHAR(80)  -- Full name of a party (Bus. Partner, Org. Unit, Doc. address)
  , [HouseNumber] NVARCHAR(10)  -- House Number
  , [StreetName] NVARCHAR(60)  -- Street
  , [HouseNumberSupplementText] NVARCHAR(10)  -- House number supplement
  , [District] NVARCHAR(40)  -- District
  , [PostalCode] NVARCHAR(10)  -- City postal code
  , [CityName] NVARCHAR(40)  -- City
  , [Country] NVARCHAR(3)  -- Country Key
  , [Region] NVARCHAR(3)  -- Region (State, Province, County)
  , [AddressTimeZone] NVARCHAR(6)  -- Address time zone
  , [TaxJurisdiction] NVARCHAR(15)  -- Tax Jurisdiction
  , [TransportZone] NVARCHAR(10)  -- Transportation zone to or from which the goods are delivered
  , [CompanyPostalCode] NVARCHAR(10)  -- Company Postal Code (for Large Customers)
  , [DeliveryServiceNumber] NVARCHAR(10)  -- Number of Delivery Service
  , [POBox] NVARCHAR(10)  -- PO Box
  , [POBoxIsWithoutNumber] NVARCHAR(1)  -- Flag: PO Box Without Number
  , [POBoxPostalCode] NVARCHAR(10)  -- PO Box Postal Code
  , [POBoxLobbyName] NVARCHAR(40)  -- PO Box Lobby
  , [POBoxDeviatingCityName] NVARCHAR(40)  -- PO Box city
  , [POBoxDeviatingRegion] NVARCHAR(3)  -- Region for PO Box (Country, State, Province, ...)
  , [POBoxDeviatingCountry] NVARCHAR(3)  -- PO box country
  , [CorrespondenceLanguage] CHAR(1)  -- Language Key
  , [PrfrdCommMediumType] NVARCHAR(3)  -- Communication Method (Key) (Business Address Services)
  , [StreetPrefixName] NVARCHAR(40)  -- Street 2
  , [AdditionalStreetPrefixName] NVARCHAR(40)  -- Street 3
  , [StreetSuffixName] NVARCHAR(40)  -- Street 4
  , [AdditionalStreetSuffixName] NVARCHAR(40)  -- Street 5
  , [HomeCityName] NVARCHAR(40)  -- City (different from postal city)
  , [DeliveryServiceTypeCode] NVARCHAR(4)  -- Type of Delivery Service
  , [PhoneNumber] NVARCHAR(30)  -- Telephone no.: dialling code+number
  , [PhoneNumberCountry] NVARCHAR(3)  -- Country for telephone/fax number
  , [PhoneNumberExtension] NVARCHAR(10)  -- Telephone no.: Extension
  , [FaxNumber] NVARCHAR(30)  -- Fax number: dialling code+number
  , [FaxCountry] NVARCHAR(3)  -- Country for telephone/fax number
  , [FaxNumberExtension] NVARCHAR(10)  -- Fax no.: Extension
  , [MobilePhoneNumber] NVARCHAR(30)  -- Telephone no.: dialling code+number
  , [MobilePhoneCountry] NVARCHAR(3)  -- Country for telephone/fax number
  , [EmailAddress] NVARCHAR(241)  -- E-Mail Address
  , [URLFieldLength] smallint  -- URI field length
  , [WebsiteURL] VARCHAR(50)  -- Universal Resource Identifier (URI)
  , [t_applicationId] VARCHAR (32)  -- Application ID
  , [t_jobId] VARCHAR (36)  -- Job ID
  , [t_jobDtm] DATETIME  -- Job Date Time
  , [t_jobBy] VARCHAR (128)  -- Job executed by
  , [t_extractionDtm] DATETIME  -- Extraction Date Time
  , [t_filePath] NVARCHAR (1024)  -- Filepath
  , CONSTRAINT [PK_I_BusinessPartnerAddress] PRIMARY KEY NONCLUSTERED
    (
      [MANDT]
    , [BUSINESSPARTNER]
    , [ADDRESSNUMBER]
    ) NOT ENFORCED
) WITH (
  HEAP
)
