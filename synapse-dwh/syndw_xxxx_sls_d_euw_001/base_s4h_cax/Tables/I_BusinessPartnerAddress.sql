CREATE TABLE [base_s4h_cax].[I_BusinessPartnerAddress]
(
    [MANDT] CHAR(3) NOT NULL  -- Client
  , [BUSINESSPARTNER] NVARCHAR(10) NOT NULL  -- Business Partner Number
  , [ADDRESSNUMBER] NVARCHAR(10) NOT NULL  -- Address Number
  , [ValidityStartDate] DECIMAL(15)  -- Validity Start of a Business Partner Address
  , [ValidityEndDate] DECIMAL(15)  -- Validity End of a Business Partner Address
  , [Country] NVARCHAR(3)  -- Country Key
  , [Region] NVARCHAR(3)  -- Region (State, Province, County)
  , [PhoneNumber] NVARCHAR(30)  -- Telephone no.: dialling code+number
  , [t_applicationId] VARCHAR (32)  -- Application ID
  , [t_jobId] VARCHAR (36)  -- Job ID
  , [t_jobDtm] DATETIME  -- Job Date Time
  , [t_jobBy] VARCHAR (128)  -- Job executed by
  , [t_extractionDtm] DATETIME  -- Extraction Date Time
  , [t_filePath] NVARCHAR (1024)  -- Filepath
  , CONSTRAINT [PK_I_BusinessPartnerAddress] PRIMARY KEY NONCLUSTERED(
      
      [MANDT]
    , [BUSINESSPARTNER]
    , [ADDRESSNUMBER]
  ) NOT ENFORCED
) WITH (
  HEAP
)
