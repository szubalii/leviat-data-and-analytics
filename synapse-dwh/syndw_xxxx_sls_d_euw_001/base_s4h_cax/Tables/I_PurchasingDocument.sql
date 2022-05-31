CREATE TABLE [base_s4h_cax].[I_PurchasingDocument]
(
    [MANDT]                          nchar(3) collate Latin1_General_100_BIN2     NOT NULL,
    [PurchasingDocument]             nvarchar(10) collate Latin1_General_100_BIN2 NOT NULL,
    [PurchasingDocumentCategory]     nvarchar(1) collate Latin1_General_100_BIN2,
    [PurchasingDocumentType]         nvarchar(4) collate Latin1_General_100_BIN2,
    [PurchasingDocumentSubtype]      nvarchar(1) collate Latin1_General_100_BIN2,
    [CompanyCode]                    nvarchar(4) collate Latin1_General_100_BIN2,
    [PurchasingDocumentDeletionCode] nvarchar(1) collate Latin1_General_100_BIN2,
    [PurchasingDocumentIsAged]       nvarchar(1) collate Latin1_General_100_BIN2,
    [ItemNumberInterval]             char(5) collate Latin1_General_100_BIN2,
    [ItemNumberIntervalForSubItems]  char(5) collate Latin1_General_100_BIN2,
    [PurchasingDocumentOrigin]       nvarchar(1) collate Latin1_General_100_BIN2,
    [ReleaseIsNotCompleted]          nvarchar(1) collate Latin1_General_100_BIN2,
    [ReleaseCode]                    nvarchar(1) collate Latin1_General_100_BIN2,
    [PurchasingReleaseStrategy]      nvarchar(2) collate Latin1_General_100_BIN2,
    [PurgReleaseSequenceStatus]      nvarchar(8) collate Latin1_General_100_BIN2,
    [TaxReturnCountry]               nvarchar(3) collate Latin1_General_100_BIN2,
    [CreationDate]                   date,
    [LastChangeDateTime]             decimal(21, 7),
    [CreatedByUser]                  nvarchar(12) collate Latin1_General_100_BIN2,
    [Supplier]                       nvarchar(10) collate Latin1_General_100_BIN2,
    [SupplierRespSalesPersonName]    nvarchar(30) collate Latin1_General_100_BIN2,
    [SupplierPhoneNumber]            nvarchar(16) collate Latin1_General_100_BIN2,
    [SupplierAddressID]              nvarchar(10) collate Latin1_General_100_BIN2,
    [ManualSupplierAddressID]        nvarchar(10) collate Latin1_General_100_BIN2,
    [CorrespncExternalReference]     nvarchar(12) collate Latin1_General_100_BIN2,
    [CorrespncInternalReference]     nvarchar(12) collate Latin1_General_100_BIN2,
    [PurchasingOrganization]         nvarchar(4) collate Latin1_General_100_BIN2,
    [PurchasingGroup]                nvarchar(3) collate Latin1_General_100_BIN2,
    [DocumentCurrency]               nchar(5) collate Latin1_General_100_BIN2,
    [ExchangeRate]                   decimal(9, 5),
    [PurchasingDocumentOrderDate]    date,
    [SupplyingSupplier]              nvarchar(10) collate Latin1_General_100_BIN2,
    [SupplyingPlant]                 nvarchar(4) collate Latin1_General_100_BIN2,
    [InvoicingParty]                 nvarchar(10) collate Latin1_General_100_BIN2,
    [Customer]                       nvarchar(10) collate Latin1_General_100_BIN2,
    [PurchaseContract]               nvarchar(10) collate Latin1_General_100_BIN2,
    [Language]                       nchar(1) collate Latin1_General_100_BIN2,
    [PurgReasonForDocCancellation]   char(2) collate Latin1_General_100_BIN2,
    [PurchasingCompletenessStatus]   nvarchar(1) collate Latin1_General_100_BIN2,
    [IncotermsClassification]        nvarchar(3) collate Latin1_General_100_BIN2,
    [IncotermsTransferLocation]      nvarchar(28) collate Latin1_General_100_BIN2,
    [PaymentTerms]                   nvarchar(4) collate Latin1_General_100_BIN2,
    [CashDiscount1Days]              decimal(3),
    [CashDiscount2Days]              decimal(3),
    [NetPaymentDays]                 decimal(3),
    [CashDiscount1Percent]           decimal(5, 3),
    [CashDiscount2Percent]           decimal(5, 3),
    [PricingProcedure]               nvarchar(6) collate Latin1_General_100_BIN2,
    [TargetAmount]                   decimal(15, 2),
    [PurgDocumentDistributionType]   nvarchar(1) collate Latin1_General_100_BIN2,
    [PurchasingDocumentCondition]    nvarchar(10) collate Latin1_General_100_BIN2,
    [ValidityStartDate]              date,
    [ValidityEndDate]                date,
    [ScheduleAgreementHasReleaseDoc] nvarchar(1) collate Latin1_General_100_BIN2,
    [QuotationLatestSubmissionDate]  date,
    [BindingPeriodValidityEndDate]   date,
    [QuotationSubmissionDate]        date,
    [SupplierQuotationExternalID]    nvarchar(10) collate Latin1_General_100_BIN2,
    [RequestForQuotation]            nvarchar(10) collate Latin1_General_100_BIN2,
    [ExchangeRateIsFixed]            nvarchar(1) collate Latin1_General_100_BIN2,
    [IncotermsVersion]               nvarchar(4) collate Latin1_General_100_BIN2,
    [IncotermsLocation1]             nvarchar(70) collate Latin1_General_100_BIN2,
    [IncotermsLocation2]             nvarchar(70) collate Latin1_General_100_BIN2,
    [PurchasingProcessingStatus]     nvarchar(2) collate Latin1_General_100_BIN2,
    [PurgReleaseTimeTotalAmount]     decimal(15, 2),
    [DownPaymentType]                nvarchar(4) collate Latin1_General_100_BIN2,
    [DownPaymentPercentageOfTotAmt]  decimal(5, 2),
    [DownPaymentAmount]              decimal(11, 2),
    [DownPaymentDueDate]             date,
    [PurchasingDocumentName]         nvarchar(40) collate Latin1_General_100_BIN2,
    [QuotationEarliestSubmsnDate]    date,
    [LatestRegistrationDate]         date,
    [FollowOnDocumentCategory]       nvarchar(1) collate Latin1_General_100_BIN2,
    [FollowOnDocumentType]           nvarchar(4) collate Latin1_General_100_BIN2,
    [VATRegistration]                nvarchar(20) collate Latin1_General_100_BIN2,
    [VATRegistrationCountry]         nvarchar(3) collate Latin1_General_100_BIN2,
    [IsIntrastatReportingRelevant]   nvarchar(1) collate Latin1_General_100_BIN2,
    [IsIntrastatReportingExcluded]   nvarchar(1) collate Latin1_General_100_BIN2,
    [IsEndOfPurposeBlocked]          nvarchar(1) collate Latin1_General_100_BIN2,
    [t_applicationId]                VARCHAR (32), 
    [t_jobId]                        VARCHAR (36), 
    [t_jobDtm]                       DATETIME, 
    [t_jobBy]        		         NVARCHAR (128), 
    [t_extractionDtm]		         DATETIME, 
    [t_filePath]                     NVARCHAR (1024), 
    CONSTRAINT [PK_I_PurchasingDocument]  PRIMARY KEY NONCLUSTERED (
        [MANDT], [PurchasingDocument]
    ) NOT ENFORCED
)
