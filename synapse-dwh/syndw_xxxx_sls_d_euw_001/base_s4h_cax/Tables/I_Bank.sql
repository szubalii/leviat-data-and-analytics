CREATE TABLE [base_s4h_cax].[I_Bank]
-- Bank Master Details
(
  [MANDT] nchar(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [BankCountry] nvarchar(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [BankInternalID] nvarchar(15) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [CreationDate] date
, [CreatedByUser] nvarchar(12) -- collate Latin1_General_100_BIN2
, [BankName] nvarchar(60) -- collate Latin1_General_100_BIN2
, [Region] nvarchar(3) -- collate Latin1_General_100_BIN2
, [StreetName] nvarchar(35) -- collate Latin1_General_100_BIN2
, [CityName] nvarchar(35) -- collate Latin1_General_100_BIN2
, [SWIFTCode] nvarchar(11) -- collate Latin1_General_100_BIN2
, [BankGroup] nvarchar(2) -- collate Latin1_General_100_BIN2
, [IsPostBankAccount] nvarchar(1) -- collate Latin1_General_100_BIN2
, [IsMarkedForDeletion] nvarchar(1) -- collate Latin1_General_100_BIN2
, [Bank] nvarchar(15) -- collate Latin1_General_100_BIN2
, [PostOfficeBankAccount] nvarchar(16) -- collate Latin1_General_100_BIN2
, [Branch] nvarchar(40) -- collate Latin1_General_100_BIN2
, [CheckDigitCalculationMethod] nvarchar(4) -- collate Latin1_General_100_BIN2
, [BankDataFileFormat] nvarchar(3) -- collate Latin1_General_100_BIN2
, [AddressID] nvarchar(10) -- collate Latin1_General_100_BIN2
, [t_applicationId] VARCHAR (32)
, [t_jobId]         VARCHAR (36)
, [t_jobDtm]        DATETIME
, [t_jobBy]         NVARCHAR (128)
, [t_extractionDtm] DATETIME
, [t_filePath]      NVARCHAR (1024)
, CONSTRAINT [PK_I_Bank] PRIMARY KEY NONCLUSTERED([MANDT],[BankCountry],[BankInternalID]) NOT ENFORCED 
)
WITH ( 
  HEAP
)
