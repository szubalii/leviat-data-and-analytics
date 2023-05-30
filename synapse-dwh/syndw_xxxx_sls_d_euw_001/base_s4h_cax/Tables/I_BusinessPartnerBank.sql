CREATE TABLE [base_s4h_cax].[I_BusinessPartnerBank]
(
    [MANDT] CHAR(3) NOT NULL  -- Client
  , [BUSINESSPARTNER] NVARCHAR(10) NOT NULL  -- Business Partner Number
  , [BANKIDENTIFICATION] NVARCHAR(4) NOT NULL  -- Bank details ID
  , [BANKCOUNTRYKEY] NVARCHAR(3)  -- Bank Country Key
  , [BANKNAME] NVARCHAR(60)  -- Name of bank
  , [BANKNUMBER] NVARCHAR(15)  -- Bank Key
  , [SWIFTCode] NVARCHAR(11)  -- SWIFT/BIC for International Payments
  , [BankControlKey] NVARCHAR(2)  -- Bank Control Key
  , [BankAccountHolderName] NVARCHAR(60)  -- Account Holder Name
  , [BankAccountName] NVARCHAR(40)  -- Name of Bank Account
  , [ValidityStartDate] DECIMAL(15)  -- Validity Start of Business Partner Bank Details
  , [ValidityEndDate] DECIMAL(15)  -- Validity End of Business Partner Bank Details
  , [IBAN] NVARCHAR(34)  -- IBAN (International Bank Account Number)
  , [IBANValidityStartDate] DATE  -- Validity start of IBAN
  , [BankAccount] NVARCHAR(18)  -- Bank Account Number
  , [BankAccountReferenceText] NVARCHAR(20)  -- Reference Details for Bank Details
  , [CollectionAuthInd] NVARCHAR(1)  -- Indicator: Collection Authorization
  , [BusinessPartnerExternalBankID] NVARCHAR(20)  -- Bank details ID in external system
  , [BPBankDetailsChangeDate] DECIMAL(15)  -- Date of Change to Bank Details (BP)
  , [BPBankDetailsChangeTargetID] NVARCHAR(4)  -- ID of Target Details for Change of Bank Details (BP)
  , [BPBankIsProtected] NVARCHAR(1)  -- BP: Sensitivity Indicator
  , [CityName] NVARCHAR(35)  -- City
  , [AuthorizationGroup] NVARCHAR(4)  -- Authorization Group
  , [t_applicationId] VARCHAR (32)  -- Application ID
  , [t_jobId] VARCHAR (36)  -- Job ID
  , [t_jobDtm] DATETIME  -- Job Date Time
  , [t_jobBy] VARCHAR (128)  -- Job executed by
  , [t_extractionDtm] DATETIME  -- Extraction Date Time
  , [t_filePath] NVARCHAR (1024)  -- Filepath
  , CONSTRAINT [PK_I_BusinessPartnerBank] PRIMARY KEY NONCLUSTERED
  (
      [MANDT]
    , [BUSINESSPARTNER]
    , [BANKIDENTIFICATION]
  ) NOT ENFORCED
) WITH (
  HEAP
)
