CREATE TABLE [base_s4h_cax].[I_SupplierCompany]
-- Supplier Company
(
    [MANDT]                          nchar(3) collate Latin1_General_100_BIN2     NOT NULL,
    [Supplier]                       nvarchar(10) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL,
    [CompanyCode]                    nvarchar(4) collate Latin1_General_100_BIN2  NOT NULL,
    [AuthorizationGroup]             nvarchar(4) -- collate Latin1_General_100_BIN2,
    [CompanyCodeName]                nvarchar(25) -- collate Latin1_General_100_BIN2,
    [PaymentBlockingReason]          nvarchar(1) -- collate Latin1_General_100_BIN2,
    [SupplierIsBlockedForPosting]    nvarchar(1) -- collate Latin1_General_100_BIN2,
    [IsBusinessPurposeCompleted]     nvarchar(1) -- collate Latin1_General_100_BIN2,
    [AccountingClerk]                nvarchar(2) -- collate Latin1_General_100_BIN2,
    [AccountingClerkFaxNumber]       nvarchar(31) -- collate Latin1_General_100_BIN2,
    [AccountingClerkPhoneNumber]     nvarchar(30) -- collate Latin1_General_100_BIN2,
    [AccountingClerkInternetAddress] nvarchar(130) -- collate Latin1_General_100_BIN2,
    [SupplierClerk]                  nvarchar(15) -- collate Latin1_General_100_BIN2,
    [SupplierClerkURL]               nvarchar(130) -- collate Latin1_General_100_BIN2,
    [PaymentMethodsList]             nvarchar(10) -- collate Latin1_General_100_BIN2,
    [PaymentTerms]                   nvarchar(4) -- collate Latin1_General_100_BIN2,
    [ClearCustomerSupplier]          nvarchar(1) -- collate Latin1_General_100_BIN2,
    [IsToBeLocallyProcessed]         nvarchar(1) -- collate Latin1_General_100_BIN2,
    [ItemIsToBePaidSeparately]       nvarchar(1) -- collate Latin1_General_100_BIN2,
    [PaymentIsToBeSentByEDI]         nvarchar(1) -- collate Latin1_General_100_BIN2,
    [HouseBank]                      nvarchar(5) -- collate Latin1_General_100_BIN2,
    [CheckPaidDurationInDays]        decimal(3),
    [BillOfExchLmtAmtInCoCodeCrcy]   decimal(13, 2),
    [SupplierClerkIDBySupplier]      nvarchar(12) -- collate Latin1_General_100_BIN2,
    [IsDoubleInvoice]                nvarchar(1) -- collate Latin1_General_100_BIN2,
    [CustomerSupplierClearingIsUsed] nvarchar(1) -- collate Latin1_General_100_BIN2,
    [ReconciliationAccount]          nvarchar(10) -- collate Latin1_General_100_BIN2,
    [InterestCalculationCode]        nvarchar(2) -- collate Latin1_General_100_BIN2,
    [InterestCalculationDate]        date,
    [IntrstCalcFrequencyInMonths]    char(2) -- collate Latin1_General_100_BIN2,
    [SupplierHeadOffice]             nvarchar(10) -- collate Latin1_General_100_BIN2,
    [AlternativePayee]               nvarchar(10) -- collate Latin1_General_100_BIN2,
    [LayoutSortingRule]              nvarchar(3) -- collate Latin1_General_100_BIN2,
    [APARToleranceGroup]             nvarchar(4) -- collate Latin1_General_100_BIN2,
    [SupplierCertificationDate]      date,
    [SupplierAccountNote]            nvarchar(30) -- collate Latin1_General_100_BIN2,
    [WithholdingTaxCountry]          nvarchar(3) -- collate Latin1_General_100_BIN2,
    [DeletionIndicator]              nvarchar(1) -- collate Latin1_General_100_BIN2,
    [CashPlanningGroup]              nvarchar(10) -- collate Latin1_General_100_BIN2,
    [IsToBeCheckedForDuplicates]     nvarchar(1) -- collate Latin1_General_100_BIN2,
    [PersonnelNumber]                char(8) -- collate Latin1_General_100_BIN2,
    [PreviousAccountNumber]          nvarchar(10) -- collate Latin1_General_100_BIN2,
    [t_applicationId]                VARCHAR(32),
    [t_jobId]                        VARCHAR(36),
    [t_jobDtm]                       DATETIME,
    [t_jobBy]                        NVARCHAR(128),
    [t_extractionDtm]                DATETIME,
    [t_filePath]                     NVARCHAR(1024),
    CONSTRAINT [PK_I_SupplierCompany] PRIMARY KEY NONCLUSTERED ([MANDT], [Supplier], [CompanyCode]) NOT ENFORCED
)
WITH (
    HEAP
    )