CREATE VIEW [edw].[vw_SalesOrderItemPricingElement]
AS
SELECT
  SDI.[sk_fact_SalesDocumentItem] AS [fk_SalesDocumentItem]
, [SalesOrder] 
, [SalesOrderItem]
, edw.svf_getNaturalKey (SalesOrder,SalesOrderItem,CR.CurrencyTypeID)             AS [nk_SalesOrderItem]
, CR.[CurrencyTypeID]
, CR.[CurrencyType]
, CASE 
        WHEN CCR.[CurrencyTypeID] = '10' THEN COALESCE(SDI.[CurrencyID],[TransactionCurrency] COLLATE Latin1_General_100_BIN2)
        ELSE CCR.[TargetCurrency]
  END                                                                             AS [CurrencyID]
, CASE 
        WHEN CCR.[CurrencyTypeID] = '10' THEN COALESCE(SDI.[ExchangeRate], 1)
        ELSE CCR.[ExchangeRate]
  END                                                                             AS [ExchangeRate]
, [PricingProcedureStep] 
, [PricingProcedureCounter] 
, [ConditionApplication] 
, [ConditionType] 
, [PricingDateTime] 
, [ConditionCalculationType] 
, CASE 
        WHEN CCR.CurrencyTypeID = '10' 
        THEN CONVERT(decimal(19,6), COALESCE([ConditionBaseValue] * SDI.[ExchangeRate],[ConditionBaseValue]))
        ELSE [ConditionBaseValue] * CCR.ExchangeRate
  END                                                                             AS [ConditionBaseValue]
, [ConditionRateValue] 
, [ConditionCurrency] 
, [ConditionQuantity] 
, [ConditionQuantityUnit] 
, [ConditionCategory] 
, [ConditionIsForStatistics] 
, [PricingScaleType] 
, [IsRelevantForAccrual] 
, [CndnIsRelevantForInvoiceList] 
, [ConditionOrigin] 
, [IsGroupCondition] 
, [ConditionRecord] 
, [ConditionSequentialNumber] 
, [TaxCode] 
, [WithholdingTaxCode] 
, [CndnRoundingOffDiffAmount] 
, CASE 
        WHEN CCR.CurrencyTypeID = '10' 
        THEN CONVERT(decimal(19,6), COALESCE([ConditionAmount] * SDI.[ExchangeRate],[ConditionAmount]))
        ELSE [ConditionAmount] * CCR.ExchangeRate
  END                                                                             AS [ConditionAmount] 
, [TransactionCurrency] as [TransactionCurrencyID] 
, [ConditionControl] 
, [ConditionInactiveReason] 
, [ConditionClass] 
, [PrcgProcedureCounterForHeader] 
, [FactorForConditionBasisValue] 
, [StructureCondition] 
, [PeriodFactorForCndnBasisValue]
, [PricingScaleBasis] 
, [ConditionScaleBasisValue] 
, [ConditionScaleBasisUnit] 
, [ConditionScaleBasisCurrency] 
, [CndnIsRelevantForIntcoBilling] 
, [ConditionIsManuallyChanged] 
, [ConditionIsForConfiguration] 
, [VariantCondition] 
, ISOIPE.[t_applicationId]
, ISOIPE.[t_jobDtm]   
FROM 
    [base_s4h_cax].[I_SalesOrderItemPricingElement] ISOIPE
LEFT JOIN [edw].[fact_SalesDocumentItem] SDI
    ON ISOIPE.SalesOrder = SDI.SalesDocument AND ISOIPE.SalesOrderItem = SDI.SalesDocumentItem AND SDI.CurrencyTypeID = '10'
LEFT JOIN [edw].[vw_CurrencyConversionRate] CCR   
    ON ISOIPE.TransactionCurrency = CCR.SourceCurrency    COLLATE DATABASE_DEFAULT
LEFT JOIN [edw].[dim_CurrencyType] CR
    ON CCR.CurrencyTypeID = CR.CurrencyTypeID
WHERE CCR.CurrencyTypeID <> '00'