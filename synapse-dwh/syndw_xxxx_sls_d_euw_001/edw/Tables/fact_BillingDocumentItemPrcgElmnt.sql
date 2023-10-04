CREATE TABLE [edw].[fact_BillingDocumentItemPrcgElmnt] (
-- Billing Document Item Pricing Element 
-- 1:1 as base layer table
  [fk_BillingDocumentItem] bigint
, [BillingDocument] nvarchar(20) NOT NULL
, [BillingDocumentItem] char(6) NOT NULL --collate Latin1_General_100_BIN2 NOT NULL
, [nk_BillingDocumentItem] NVARCHAR(20) NOT NULL 
, [PricingProcedureStep] char(3) NOT NULL --collate Latin1_General_100_BIN2 NOT NULL
, [PricingProcedureCounter] char(3) NOT NULL --collate Latin1_General_100_BIN2 NOT NULL
, [ConditionApplication] nvarchar(4)
, [ConditionType] nvarchar(8)
, [PricingDateTime] nvarchar(28)
, [ConditionCalculationType] nvarchar(6)
, [ConditionBaseValue] decimal(24,9)
, [ConditionRateValue] decimal(24,9)
, [ConditionCurrency] char(5) -- collate Latin1_General_100_BIN2
, [ConditionQuantity] decimal(5)
, [ConditionQuantityUnit] nvarchar(6) -- collate Latin1_General_100_BIN2
, [ConditionCategory] nvarchar(2)
, [ConditionIsForStatistics] nvarchar(2)
, [PricingScaleType] nvarchar(2)
, [IsRelevantForAccrual] nvarchar(2)
, [CndnIsRelevantForInvoiceList] nvarchar(2)
, [ConditionOrigin] nvarchar(2)
, [IsGroupCondition] nvarchar(2)
, [ConditionRecord] nvarchar(20)
, [ConditionSequentialNumber] char(3) -- collate Latin1_General_100_BIN2
, [TaxCode] nvarchar(4)
, [WithholdingTaxCode] nvarchar(4)
, [CndnRoundingOffDiffAmount] decimal(5,2)
, [ConditionAmount] decimal(15,2)
, [ExchangeRate] DECIMAL(15,6) 
, [TransactionCurrencyID] char(5) -- collate Latin1_General_100_BIN2
, [CurrencyTypeID] CHAR(2)
, [CurrencyType] NVARCHAR(20) 
, [CurrencyID] CHAR(5)  
, [ConditionControl] nvarchar(2)
, [ConditionInactiveReason] nvarchar(2)
, [ConditionClass] nvarchar(2)
, [PrcgProcedureCounterForHeader] char(3) -- collate Latin1_General_100_BIN2
, [FactorForConditionBasisValue] float
, [StructureCondition] nvarchar(2)
, [PeriodFactorForCndnBasisValue] float
, [PricingScaleBasis] nvarchar(6)
, [ConditionScaleBasisValue] decimal(24,9)
, [ConditionScaleBasisUnit] nvarchar(6) -- collate Latin1_General_100_BIN2
, [ConditionScaleBasisCurrency] char(5) -- collate Latin1_General_100_BIN2
, [CndnIsRelevantForIntcoBilling] nvarchar(2)
, [ConditionIsManuallyChanged] nvarchar(2)
, [ConditionIsForConfiguration] nvarchar(2)
, [VariantCondition] nvarchar(52)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_lastActionCd]        VARCHAR(1)
, [t_jobBy]               NVARCHAR(128)
    CONSTRAINT [PK_fact_BillingDocumentItemPrcgElmnt] PRIMARY KEY NONCLUSTERED ([BillingDocument],[BillingDocumentItem],[PricingProcedureStep],[PricingProcedureCounter],[CurrencyTypeID]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = HASH (BillingDocument), CLUSTERED COLUMNSTORE INDEX
)
GO
