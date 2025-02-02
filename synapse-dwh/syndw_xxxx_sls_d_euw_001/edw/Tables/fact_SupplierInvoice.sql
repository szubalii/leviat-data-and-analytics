CREATE TABLE [edw].[fact_SupplierInvoice]
(
    [SupplierInvoiceID]              nvarchar(10) NOT NULL, --collate Latin1_General_100_BIN2 NOT NULL,
    [FiscalYear]                     char(4) NOT NULL, --collate Latin1_General_100_BIN2      NOT NULL,
    [SupplierInvoiceUUID]            binary(16),
    [CompanyCodeID]                  nvarchar(4), -- collate Latin1_General_100_BIN2,
    [DocumentDate]                   date,
    [PostingDate]                    date,
    [InvoiceReceiptDate]             date,
    [SupplierInvoiceIDByInvcgParty]  nvarchar(16), -- collate Latin1_General_100_BIN2,
    [InvoicingPartyID]               nvarchar(10), -- collate Latin1_General_100_BIN2,
    [DocumentCurrencyID]             nchar(5), -- collate Latin1_General_100_BIN2,
    [InvoiceGrossAmount]             decimal(13, 2),
    [IsInvoice]                      nvarchar(1), -- collate Latin1_General_100_BIN2,
    [UnplannedDeliveryCost]          decimal(13, 2),
    [DocumentHeaderText]             nvarchar(25), -- collate Latin1_General_100_BIN2,
    [CreatedByUser]                  nvarchar(12), -- collate Latin1_General_100_BIN2,
    [LastChangedByUser]              nvarchar(12), -- collate Latin1_General_100_BIN2,
    [SuplrInvcExtCreatedByUser]      nvarchar(12), -- collate Latin1_General_100_BIN2,
    [CreationDate]                   date,
    [ManualCashDiscount]             decimal(13, 2),
    [PaymentTerms]                   nvarchar(4), -- collate Latin1_General_100_BIN2,
    [DueCalculationBaseDate]         date,
    [CashDiscount1Percent]           decimal(5, 3),
    [CashDiscount1Days]              decimal(3),
    [CashDiscount2Percent]           decimal(5, 3),
    [CashDiscount2Days]              decimal(3),
    [NetPaymentDays]                 decimal(3),
    [PaymentBlockingReason]          nvarchar(1), -- collate Latin1_General_100_BIN2,
    [AccountingDocumentType]         nvarchar(2), -- collate Latin1_General_100_BIN2,
    [SupplierInvoiceStatus]          nvarchar(1), -- collate Latin1_General_100_BIN2,
    [SupplierInvoiceOrigin]          nvarchar(1), -- collate Latin1_General_100_BIN2,
    [BusinessNetworkOrigin]          nvarchar(2), -- collate Latin1_General_100_BIN2,
    [SuplrInvcTransactionCategory]   nvarchar(2), -- collate Latin1_General_100_BIN2,
    [SuplrInvcManuallyReducedAmount] decimal(13, 2),
    [SuplrInvcManualReductionTaxAmt] decimal(13, 2),
    [SuplrInvcAutomReducedAmount]    decimal(13, 2),
    [SuplrInvcAutomReductionTaxAmt]  decimal(13, 2),
    [BPBankAccountInternalID]        nvarchar(4), -- collate Latin1_General_100_BIN2,
    [ExchangeRate]                   decimal(9, 5),
    [StateCentralBankPaymentReason]  nvarchar(3), -- collate Latin1_General_100_BIN2,
    [SupplyingCountryID]             nvarchar(3), -- collate Latin1_General_100_BIN2,
    [SupplyingCountry]               nvarchar(50),
    [PaymentMethod]                  nvarchar(1), -- collate Latin1_General_100_BIN2,
    [PaymentMethodSupplement]        nvarchar(2), -- collate Latin1_General_100_BIN2,
    [PaymentReference]               nvarchar(30), -- collate Latin1_General_100_BIN2,
    [InvoiceReference]               nvarchar(10), -- collate Latin1_General_100_BIN2,
    [InvoiceReferenceFiscalYear]     char(4), -- collate Latin1_General_100_BIN2,
    [FixedCashDiscount]              nvarchar(1), -- collate Latin1_General_100_BIN2,
    [UnplannedDeliveryCostTaxCode]   nvarchar(2), -- collate Latin1_General_100_BIN2,
    [UnplndDelivCostTaxJurisdiction] nvarchar(15), -- collate Latin1_General_100_BIN2,
    [AssignmentReference]            nvarchar(18), -- collate Latin1_General_100_BIN2,
    [SupplierPostingLineItemText]    nvarchar(50), -- collate Latin1_General_100_BIN2,
    [TaxIsCalculatedAutomatically]   nvarchar(1), -- collate Latin1_General_100_BIN2,
    [BusinessPlace]                  nvarchar(4), -- collate Latin1_General_100_BIN2,
    [PaytSlipWthRefSubscriber]       nvarchar(11), -- collate Latin1_General_100_BIN2,
    [PaytSlipWthRefCheckDigit]       nvarchar(2), -- collate Latin1_General_100_BIN2,
    [PaytSlipWthRefReference]        nvarchar(27), -- collate Latin1_General_100_BIN2,
    [IsEndOfPurposeBlocked]          nvarchar(1), -- collate Latin1_General_100_BIN2,
    [BusinessSectionCode]            nvarchar(4), -- collate Latin1_General_100_BIN2,
    [BusinessArea]                   nvarchar(4), -- collate Latin1_General_100_BIN2,
    [ElectronicInvoiceUUID]          nvarchar(36), -- collate Latin1_General_100_BIN2,
    [TaxDeterminationDate]           date,
    [DeliveryOfGoodsReportingCntry]  nvarchar(3), -- collate Latin1_General_100_BIN2,
    [SupplierVATRegistration]        nvarchar(20), -- collate Latin1_General_100_BIN2,
    [IsEUTriangularDeal]             nvarchar(1), -- collate Latin1_General_100_BIN2,
    [t_applicationId]                VARCHAR(32), 
    [t_extractionDtm]                DATETIME,
    [t_jobId]                        VARCHAR (36),
    [t_jobDtm]                       DATETIME,
    [t_lastActionCd]                 VARCHAR(1),
    [t_jobBy]                        NVARCHAR(128),
    CONSTRAINT [PK_fact_SupplierInvoice] PRIMARY KEY NONCLUSTERED ( [SupplierInvoiceID], [FiscalYear]) NOT ENFORCED
)
WITH ( DISTRIBUTION = HASH (SupplierInvoiceID), CLUSTERED COLUMNSTORE INDEX )
GO

