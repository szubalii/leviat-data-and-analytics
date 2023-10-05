CREATE TABLE [base_s4h_cax].[I_CustomerCompany](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [Customer] nvarchar(10) NOT NULL
, [CompanyCode] nvarchar(4) NOT NULL
, [AccountingClerk] nvarchar(2)
, [ReconciliationAccount] nvarchar(10)
, [AuthorizationGroup] nvarchar(4)
, [CustomerHeadOffice] nvarchar(10)
, [AlternativePayerAccount] nvarchar(10)
, [PaymentBlockingReason] nvarchar(1)
, [InterestCalculationCode] nvarchar(2)
, [InterestCalculationDate] date
, [IntrstCalcFrequencyInMonths] char(2) -- collate Latin1_General_100_BIN2
, [CustomerAccountNote] nvarchar(30)
, [APARToleranceGroup] nvarchar(4)
, [HouseBank] nvarchar(5)
, [ItemIsToBePaidSeparately] nvarchar(1)
, [PaytAdviceIsSentbyEDI] nvarchar(1)
, [PhysicalInventoryBlockInd] nvarchar(1)
, [UserAtCustomer] nvarchar(15)
, [AccountingClerkPhoneNumber] nvarchar(30)
, [AccountingClerkFaxNumber] nvarchar(31)
, [AccountingClerkInternetAddress] nvarchar(130)
, [AccountByCustomer] nvarchar(12)
, [IsToBeLocallyProcessed] nvarchar(1)
, [CollectiveInvoiceVariant] nvarchar(1)
, [LayoutSortingRule] nvarchar(3)
, [PaymentTerms] nvarchar(4)
, [CustomerSupplierClearingIsUsed] nvarchar(1)
, [RecordPaymentHistoryIndicator] nvarchar(1)
, [PaymentMethodsList] nvarchar(10)
, [DeletionIndicator] nvarchar(1)
, [CreditMemoPaymentTerms] nvarchar(4)
, [DunningNoticeGroup] nvarchar(2)
, [LastInterestCalcRunDate] date
, [CustPreviousMasterRecordNumber] nvarchar(10)
, [ValueAdjustmentKey] nvarchar(2)
, [IsBusinessPurposeCompleted] nvarchar(1)
, [LastDunnedOn] date
, [DunningProcedure] nvarchar(4)
, [DunningLevel] char(1) -- collate Latin1_General_100_BIN2
, [DunningBlock] nvarchar(1)
, [DunningRecipient] nvarchar(10)
, [LegDunningProcedureOn] date
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_CustomerCompany] PRIMARY KEY NONCLUSTERED (
    [MANDT], [Customer], [CompanyCode]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
