CREATE TABLE [base_s4h_cax].[I_BusinessPartnerBank]
-- core view for Bank details
(
    [MANDT]                         nchar(3) collate Latin1_General_100_BIN2     NOT NULL,
    [BusinessPartner]               nvarchar(10) collate Latin1_General_100_BIN2 NOT NULL,
    [BankIdentification]            nvarchar(4) collate Latin1_General_100_BIN2  NOT NULL,
    [BankCountryKey]                nvarchar(3) collate Latin1_General_100_BIN2,
    [BankName]                      nvarchar(60) collate Latin1_General_100_BIN2,
    [BankNumber]                    nvarchar(15) collate Latin1_General_100_BIN2,
    [SWIFTCode]                     nvarchar(11) collate Latin1_General_100_BIN2,
    [BankControlKey]                nvarchar(2) collate Latin1_General_100_BIN2,
    [BankAccountHolderName]         nvarchar(60) collate Latin1_General_100_BIN2,
    [BankAccountName]               nvarchar(40) collate Latin1_General_100_BIN2,
    [ValidityStartDate]             decimal(15),
    [ValidityEndDate]               decimal(15),
    [IBAN]                          nvarchar(34) collate Latin1_General_100_BIN2,
    [IBANValidityStartDate]         date,
    [BankAccount]                   nvarchar(18) collate Latin1_General_100_BIN2,
    [BankAccountReferenceText]      nvarchar(20) collate Latin1_General_100_BIN2,
    [CollectionAuthInd]             nvarchar(1) collate Latin1_General_100_BIN2,
    [BusinessPartnerExternalBankID] nvarchar(20) collate Latin1_General_100_BIN2,
    [BPBankDetailsChangeDate]       decimal(15),
    [BPBankDetailsChangeTargetID]   nvarchar(4) collate Latin1_General_100_BIN2,
    [BPBankIsProtected]             nvarchar(1) collate Latin1_General_100_BIN2,
    [CityName]                      nvarchar(35) collate Latin1_General_100_BIN2,
    [AuthorizationGroup]            nvarchar(4) collate Latin1_General_100_BIN2,
    [t_applicationId]               VARCHAR(32),
    [t_jobId]                       VARCHAR(36),
    [t_jobDtm]                      DATETIME,
    [t_jobBy]                       NVARCHAR(128),
    [t_extractionDtm]               DATETIME,
    [t_filePath]                    NVARCHAR(1024),
    CONSTRAINT [PK_I_BusinessPartnerBank] PRIMARY KEY NONCLUSTERED ([MANDT], [BusinessPartner], [BankIdentification]) NOT ENFORCED
)
WITH (
    HEAP
    )
