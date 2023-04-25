CREATE TABLE [base_s4h_cax].[I_SalesQuotationItemPrcgElmnt] (
    
    [MANDT] CHAR(3) NOT NULL  -- Client
  , [SalesQuotation] NVARCHAR(10) NOT NULL  -- Sales Quotation
  , [SalesQuotationItem] CHAR(6) NOT NULL  -- Sales Quotation Item
  , [PricingProcedureStep] CHAR(3) NOT NULL  -- Step Number
  , [PricingProcedureCounter] CHAR(3) NOT NULL  -- Condition Counter
  , [ConditionApplication] NVARCHAR(2)  -- Application
  , [ConditionType] NVARCHAR(4)  -- Condition type
  , [PricingDateTime] NVARCHAR(14)  -- Timestamp for Pricing
  , [ConditionCalculationType] NVARCHAR(3)  -- Calculation Type for Condition
  , [ConditionBaseValue] DECIMAL(24,9)  -- Condition Basis Value
  , [ConditionRateValue] DECIMAL(24,9)  -- Rate (Amount or Percentage)
  , [ConditionCurrency] CHAR(5)  -- Currency Key
  , [ConditionQuantity] DECIMAL(5)  -- Condition Pricing Unit
  , [ConditionQuantityUnit] NVARCHAR(3)  -- Condition Unit in the Document
  , [ConditionCategory] NVARCHAR(1)  -- Condition Category (Examples: Tax, Freight, Price, Cost)
  , [ConditionIsForStatistics] NVARCHAR(1)  -- Condition is used for statistics
  , [PricingScaleType] NVARCHAR(1)  -- Scale Type
  , [IsRelevantForAccrual] NVARCHAR(1)  -- Condition is Relevant for Accrual  (e.g. Freight)
  , [CndnIsRelevantForInvoiceList] NVARCHAR(1)  -- Condition for Invoice List
  , [ConditionOrigin] NVARCHAR(1)  -- Origin of the Condition
  , [IsGroupCondition] NVARCHAR(1)  -- Group Condition
  , [ConditionRecord] NVARCHAR(10)  -- Number of the Condition Record
  , [ConditionSequentialNumber] CHAR(3)  -- Sequential Number of the Condition
  , [TaxCode] NVARCHAR(2)  -- Tax on sales/purchases code
  , [WithholdingTaxCode] NVARCHAR(2)  -- Withholding Tax Code
  , [CndnRoundingOffDiffAmount] DECIMAL(5,2)  -- Rounding-Off Difference of the Condition
  , [ConditionAmount] DECIMAL(15,2)  -- Condition Value
  , [TransactionCurrency] CHAR(5)  -- SD document currency
  , [ConditionControl] NVARCHAR(1)  -- Condition Control
  , [ConditionInactiveReason] NVARCHAR(1)  -- Condition is Inactive
  , [ConditionClass] NVARCHAR(1)  -- Condition Class
  , [PrcgProcedureCounterForHeader] CHAR(3)  -- Condition Counter (Header)
  , [FactorForConditionBasisValue] FLOAT  -- Factor for Condition Base Value
  , [StructureCondition] NVARCHAR(1)  -- Structure Condition
  , [PeriodFactorForCndnBasisValue] FLOAT  -- Factor for Condition Basis (Period)
  , [PricingScaleBasis] NVARCHAR(3)  -- Scale Basis Indicator
  , [ConditionScaleBasisValue] DECIMAL(24,9)  -- Scale Basis Value
  , [ConditionScaleBasisUnit] NVARCHAR(3)  -- Condition Scale Unit of Measure
  , [ConditionScaleBasisCurrency] CHAR(5)  -- Scale Currency
  , [CndnIsRelevantForIntcoBilling] NVARCHAR(1)  -- Condition for Intercompany Billing
  , [ConditionIsManuallyChanged] NVARCHAR(1)  -- Condition Changed Manually
  , [ConditionIsForConfiguration] NVARCHAR(1)  -- Condition Used for Variant Configuration
  , [VariantCondition] NVARCHAR(26)  -- Variant Condition
  , [t_applicationId] VARCHAR (32)  -- Application ID
  , [t_jobId] VARCHAR (36)  -- Job ID
  , [t_jobDtm] DATETIME  -- Job Date Time
  , [t_jobBy] VARCHAR (128)  -- Job executed by
  , [t_extractionDtm] DATETIME  -- Extraction Date Time
  , [t_filePath] NVARCHAR (1024)  -- Filepath
  , CONSTRAINT [PK_I_SalesQuotationItemPrcgElmnt] PRIMARY KEY NONCLUSTERED(
      
      [MANDT]
    , [SalesQuotation]
    , [SalesQuotationItem]
    , [PricingProcedureStep]
    , [PricingProcedureCounter]
  ) NOT ENFORCED
) WITH (
  HEAP
)
