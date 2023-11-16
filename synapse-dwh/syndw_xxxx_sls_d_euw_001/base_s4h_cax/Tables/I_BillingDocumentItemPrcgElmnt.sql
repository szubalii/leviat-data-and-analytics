CREATE TABLE [base_s4h_cax].[I_BillingDocumentItemPrcgElmnt](
  [MANDT] char(3) collate Latin1_General_100_BIN2 NOT NULL
, [BillingDocument] nvarchar(10) NOT NULL
, [BillingDocumentItem] char(6) collate Latin1_General_100_BIN2 NOT NULL
, [PricingProcedureStep] char(3) collate Latin1_General_100_BIN2 NOT NULL
, [PricingProcedureCounter] char(3) collate Latin1_General_100_BIN2 NOT NULL
, [ConditionApplication] nvarchar(2)
, [ConditionType] nvarchar(4)
, [PricingDateTime] nvarchar(14)
, [ConditionCalculationType] nvarchar(3)
, [ConditionBaseValue] decimal(24,9)
, [ConditionRateValue] decimal(24,9)
, [ConditionCurrency] char(5) collate Latin1_General_100_BIN2
, [ConditionQuantity] decimal(5)
, [ConditionQuantityUnit] nvarchar(3) collate Latin1_General_100_BIN2
, [ConditionCategory] nvarchar(1)
, [ConditionIsForStatistics] nvarchar(1)
, [PricingScaleType] nvarchar(1)
, [IsRelevantForAccrual] nvarchar(1)
, [CndnIsRelevantForInvoiceList] nvarchar(1)
, [ConditionOrigin] nvarchar(1)
, [IsGroupCondition] nvarchar(1)
, [ConditionRecord] nvarchar(10)
, [ConditionSequentialNumber] char(3) collate Latin1_General_100_BIN2
, [TaxCode] nvarchar(2)
, [WithholdingTaxCode] nvarchar(2)
, [CndnRoundingOffDiffAmount] decimal(5,2)
, [ConditionAmount] decimal(15,2)
, [TransactionCurrency] char(5) collate Latin1_General_100_BIN2
, [ConditionControl] nvarchar(1)
, [ConditionInactiveReason] nvarchar(1)
, [ConditionClass] nvarchar(1)
, [PrcgProcedureCounterForHeader] char(3) collate Latin1_General_100_BIN2
, [FactorForConditionBasisValue] float
, [StructureCondition] nvarchar(1)
, [PeriodFactorForCndnBasisValue] float
, [PricingScaleBasis] nvarchar(3)
, [ConditionScaleBasisValue] decimal(24,9)
, [ConditionScaleBasisUnit] nvarchar(3) collate Latin1_General_100_BIN2
, [ConditionScaleBasisCurrency] char(5) collate Latin1_General_100_BIN2
, [CndnIsRelevantForIntcoBilling] nvarchar(1)
, [ConditionIsManuallyChanged] nvarchar(1)
, [ConditionIsForConfiguration] nvarchar(1)
, [VariantCondition] nvarchar(26)
, [GLAccount] nvarchar(10)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_BillingDocumentItemPrcgElmnt] PRIMARY KEY NONCLUSTERED (
    [MANDT], [BillingDocument], [BillingDocumentItem], [PricingProcedureStep], [PricingProcedureCounter]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
