CREATE TABLE [base_s4h_cax].[I_PricingElement]
-- Pricing Element
(
  [MANDT] nchar(3) NOT NULL, --collate Latin1_General_100_BIN2 NOT NULL
, [PricingDocument] nvarchar(10) NOT NULL, --collate Latin1_General_100_BIN2 NOT NULL
, [PricingDocumentItem] char(6) NOT NULL, --collate Latin1_General_100_BIN2 NOT NULL
, [PricingProcedureStep] char(3) NOT NULL, --collate Latin1_General_100_BIN2 NOT NULL
, [PricingProcedureCounter] char(3) NOT NULL, --collate Latin1_General_100_BIN2 NOT NULL
, [ConditionApplication] nvarchar(2), --collate Latin1_General_100_BIN2
, [ConditionType] nvarchar(4), --collate Latin1_General_100_BIN2
, [PricingDateTime] nvarchar(14), --collate Latin1_General_100_BIN2
, [ConditionCalculationType] nvarchar(3), --collate Latin1_General_100_BIN2
, [ConditionBaseValue] decimal(24,9)
, [ConditionRateValue] decimal(24,9)
, [ConditionCurrency] nchar(5), --collate Latin1_General_100_BIN2
, [PriceDetnExchangeRate] decimal(9,5)
, [ConditionQuantity] decimal(5)
, [ConditionQuantityUnit] nvarchar(3), --collate Latin1_General_100_BIN2
, [ConditionToBaseQtyNmrtr] decimal(10)
, [ConditionToBaseQtyDnmntr] decimal(10)
, [ConditionCategory] nvarchar(1), --collate Latin1_General_100_BIN2
, [ConditionIsForStatistics] nvarchar(1), --collate Latin1_General_100_BIN2
, [PricingScaleType] nvarchar(1), --collate Latin1_General_100_BIN2
, [IsRelevantForAccrual] nvarchar(1), --collate Latin1_General_100_BIN2
, [CndnIsRelevantForInvoiceList] nvarchar(1), --collate Latin1_General_100_BIN2
, [ConditionOrigin] nvarchar(1), --collate Latin1_General_100_BIN2
, [IsGroupCondition] nvarchar(1), --collate Latin1_General_100_BIN2
, [AccessNumberOfAccessSequence] char(3), --collate Latin1_General_100_BIN2
, [ConditionRecord] nvarchar(10), --collate Latin1_General_100_BIN2
, [ConditionSequentialNumber] char(3), --collate Latin1_General_100_BIN2
, [AccountKeyForGLAccount] nvarchar(3), --collate Latin1_General_100_BIN2
, [GLAccount] nvarchar(10), --collate Latin1_General_100_BIN2
, [TaxCode] nvarchar(2), --collate Latin1_General_100_BIN2
, [AcctKeyForAccrualsGLAccount] nvarchar(3), --collate Latin1_General_100_BIN2
, [AccrualsGLAccount] nvarchar(10), --collate Latin1_General_100_BIN2
, [WithholdingTaxCode] nvarchar(2), --collate Latin1_General_100_BIN2
, [FreightSupplier] nvarchar(10), --collate Latin1_General_100_BIN2
, [CndnRoundingOffDiffAmount] decimal(5,2)
, [ConditionAmount] decimal(15,2)
, [TransactionCurrency] nchar(5), --collate Latin1_General_100_BIN2
, [ConditionControl] nvarchar(1), --collate Latin1_General_100_BIN2
, [ConditionInactiveReason] nvarchar(1), --collate Latin1_General_100_BIN2
, [ConditionClass] nvarchar(1), --collate Latin1_General_100_BIN2
, [PrcgProcedureCounterForHeader] char(3), --collate Latin1_General_100_BIN2
, [FactorForConditionBasisValue] float
, [StructureCondition] nvarchar(1), --collate Latin1_General_100_BIN2
, [PeriodFactorForCndnBasisValue] float
, [PricingScaleBasis] nvarchar(3), --collate Latin1_General_100_BIN2
, [ConditionScaleBasisValue] decimal(24,9)
, [ConditionScaleBasisUnit] nvarchar(3), --collate Latin1_General_100_BIN2
, [ConditionScaleBasisCurrency] nchar(5), --collate Latin1_General_100_BIN2
, [ConditionAlternativeCurrency] nchar(5), --collate Latin1_General_100_BIN2
, [ConditionAmountInLocalCrcy] decimal(15,2)
, [CndnIsRelevantForIntcoBilling] nvarchar(1), --collate Latin1_General_100_BIN2
, [ConditionIsManuallyChanged] nvarchar(1), --collate Latin1_General_100_BIN2
, [BillingPriceSource] nvarchar(1), --collate Latin1_General_100_BIN2
, [TaxJurisdictionLevel] nvarchar(1), --collate Latin1_General_100_BIN2
, [ConditionByteSequence] binary(2)
, [CndnIsRelevantForLimitValue] nvarchar(1), --collate Latin1_General_100_BIN2
, [ConditionBasisLimitExceeded] nvarchar(1), --collate Latin1_General_100_BIN2
, [ConditionAmountLimitExceeded] nvarchar(1), --collate Latin1_General_100_BIN2
, [CumulatedConditionBasisValue] decimal(24,9)
, [CustomerRebateRecipient] nvarchar(10), --collate Latin1_General_100_BIN2
, [ConditionIsForConfiguration] nvarchar(1), --collate Latin1_General_100_BIN2
, [VariantCondition] nvarchar(26), --collate Latin1_General_100_BIN2
, [ConditionAcctAssgmtRelevance] nvarchar(1), --collate Latin1_General_100_BIN2
, [ConditionMatrixMaintRelevance] nvarchar(1), --collate Latin1_General_100_BIN2
, [ConfigblParametersAndFormulas] nvarchar(32), --collate Latin1_General_100_BIN2
, [ConditionAdjustedQuantity] decimal(31,14)
, [CndnValueZeroProcgCode] nvarchar(1), --collate Latin1_General_100_BIN2
, [CndnIsAcctDetnRelevant] nvarchar(1), --collate Latin1_General_100_BIN2
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]             DATETIME
, [t_jobBy]        NVARCHAR (128)
, [t_filePath]            NVARCHAR (1024)
, [t_extractionDtm]             DATETIME
, CONSTRAINT [PK_I_PricingElement] PRIMARY KEY NONCLUSTERED([MANDT],[PricingDocument],[PricingDocumentItem],[PricingProcedureStep],[PricingProcedureCounter]) NOT ENFORCED 
)
WITH ( 
  HEAP
)
