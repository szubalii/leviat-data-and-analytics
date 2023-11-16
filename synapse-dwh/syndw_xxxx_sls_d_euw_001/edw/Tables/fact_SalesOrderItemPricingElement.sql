CREATE TABLE [edw].[fact_SalesOrderItemPricingElement] 
(   
    [fk_SalesDocumentItem] BIGINT
  , [SalesOrder] NVARCHAR(10) NOT NULL  
  , [SalesOrderItem] CHAR(6) NOT NULL  
  , [nk_SalesOrderItem] NVARCHAR(20) NOT NULL 
  , [CurrencyTypeID] CHAR(2) NOT NULL
  , [CurrencyType] NVARCHAR(20) NOT NULL
  , [CurrencyID] CHAR(5) 
  , [ExchangeRate] DECIMAL(15,6) 
  , [PricingProcedureStep] CHAR(3) NOT NULL
  , [PricingProcedureCounter] CHAR(3) NOT NULL
  , [ConditionApplication] NVARCHAR(2)
  , [ConditionType] NVARCHAR(4) 
  , [PricingDateTime] NVARCHAR(14) 
  , [ConditionCalculationType] NVARCHAR(3) 
  , [ConditionBaseValue] DECIMAL(24,9) 
  , [ConditionRateValue] DECIMAL(24,9)  
  , [ConditionCurrency] CHAR(5) 
  , [ConditionQuantity] DECIMAL(5,0)
  , [ConditionQuantityUnit] NVARCHAR(3)
  , [ConditionCategory] NVARCHAR(1)
  , [ConditionIsForStatistics] NVARCHAR(1)
  , [PricingScaleType] NVARCHAR(1)
  , [IsRelevantForAccrual] NVARCHAR(1)
  , [CndnIsRelevantForInvoiceList] NVARCHAR(1)
  , [ConditionOrigin] NVARCHAR(1)
  , [IsGroupCondition] NVARCHAR(1)
  , [ConditionRecord] NVARCHAR(10)
  , [ConditionSequentialNumber] CHAR(3)
  , [TaxCode] NVARCHAR(2)
  , [WithholdingTaxCode] NVARCHAR(2)
  , [CndnRoundingOffDiffAmount] DECIMAL(5,2) 
  , [ConditionAmount] DECIMAL(15,2)  
  , [TransactionCurrencyID] CHAR(5)
  , [ConditionControl] NVARCHAR(1)
  , [ConditionInactiveReason] NVARCHAR(1)
  , [ConditionClass] NVARCHAR(1)
  , [PrcgProcedureCounterForHeader] CHAR(3)
  , [FactorForConditionBasisValue] float
  , [StructureCondition] NVARCHAR(1)
  , [PeriodFactorForCndnBasisValue] float
  , [PricingScaleBasis] NVARCHAR(3)
  , [ConditionScaleBasisValue] DECIMAL(24,9)
  , [ConditionScaleBasisUnit] NVARCHAR(3)
  , [ConditionScaleBasisCurrency] CHAR(5)
  , [CndnIsRelevantForIntcoBilling] NVARCHAR(1)
  , [ConditionIsManuallyChanged] NVARCHAR(1)
  , [ConditionIsForConfiguration] NVARCHAR(1)
  , [VariantCondition] NVARCHAR(26)
  , [GLAccount] NVARCHAR(10)
  , [t_applicationId]       VARCHAR (32)
  , [t_jobId]               VARCHAR (36)
  , [t_jobDtm]              DATETIME
  , [t_lastActionCd]        VARCHAR(1)
  , [t_jobBy]               NVARCHAR(128)  
    CONSTRAINT [PK_fact_SalesOrderItemPricingElement] PRIMARY KEY NONCLUSTERED ([SalesOrder], [SalesOrderItem],[PricingProcedureStep],[PricingProcedureCounter], [CurrencyTypeID]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = HASH (SalesOrder), CLUSTERED COLUMNSTORE INDEX
)
GO