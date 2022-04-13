CREATE TABLE [base_s4h_cax].[C_BillingDocumentPartnerFs](
  [MANDT] char(3) collate Latin1_General_100_BIN2 NOT NULL
, [SDDocument] nvarchar(10) NOT NULL
, [PartnerFunction] nvarchar(2) NOT NULL
, [PartnerFunctionName] nvarchar(20)
, [AddressID] nvarchar(10)
, [Customer] nvarchar(10)
, [Personnel] char(8) collate Latin1_General_100_BIN2
, [FullName] nvarchar(80)
, [CityName] nvarchar(40)
, [StreetName] nvarchar(60)
, [PostalCode] nvarchar(10)
, [EmailAddress] nvarchar(241)
, [PhoneNumber] nvarchar(30)
, [MobilePhoneNumber] nvarchar(30)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_C_BillingDocumentPartnerFs] PRIMARY KEY NONCLUSTERED (
    [MANDT], [SDDocument], [PartnerFunction]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
