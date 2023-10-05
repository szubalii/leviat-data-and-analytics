CREATE TABLE [base_s4h_cax].[I_ProfitCenter_delta](
  [TS_SEQUENCE_NUMBER] INTEGER NOT NULL
, [ODQ_CHANGEMODE] CHAR(1)
, [ODQ_ENTITYCNTR] NUMERIC(19,0)
, [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [ControllingArea] nvarchar(4) NOT NULL
, [ProfitCenter] nvarchar(10) NOT NULL
, [ValidityEndDate] date NOT NULL
, [ProfitCtrResponsiblePersonName] nvarchar(20)
, [CompanyCode] nvarchar(4)
, [ProfitCtrResponsibleUser] nvarchar(12)
, [ValidityStartDate] date
, [Department] nvarchar(12)
, [ProfitCenterStandardHierarchy] nvarchar(12)
, [Segment] nvarchar(10)
, [ProfitCenterIsBlocked] nvarchar(1)
, [FormulaPlanningTemplate] nvarchar(10)
, [FormOfAddress] nvarchar(15)
, [AddressName] nvarchar(35)
, [AdditionalName] nvarchar(35)
, [ProfitCenterAddrName3] nvarchar(35)
, [ProfitCenterAddrName4] nvarchar(35)
, [StreetAddressName] nvarchar(35)
, [POBox] nvarchar(10)
, [CityName] nvarchar(35)
, [PostalCode] nvarchar(10)
, [District] nvarchar(35)
, [Country] nvarchar(3)
, [Region] nvarchar(3)
, [TaxJurisdiction] nvarchar(15)
, [Language] char(1) -- collate Latin1_General_100_BIN2
, [PhoneNumber1] nvarchar(16)
, [PhoneNumber2] nvarchar(16)
, [TeleboxNumber] nvarchar(15)
, [TelexNumber] nvarchar(30)
, [FaxNumber] nvarchar(31)
, [DataCommunicationPhoneNumber] nvarchar(14)
, [ProfitCenterPrinterName] nvarchar(4)
, [ProfitCenterCreatedByUser] nvarchar(12)
, [ProfitCenterCreationDate] date
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_ProfitCenter_delta] PRIMARY KEY NONCLUSTERED (
    [TS_SEQUENCE_NUMBER], [MANDT], [ControllingArea], [ProfitCenter], [ValidityEndDate]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
