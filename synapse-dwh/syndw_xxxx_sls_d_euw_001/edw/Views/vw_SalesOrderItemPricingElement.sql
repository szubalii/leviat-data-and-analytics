CREATE VIEW [edw].[vw_SalesOrderItemPricingElement]
AS
SELECT 
  [SalesOrder] 
, [SalesOrderItem]
, edw.svf_getNaturalKey (SalesOrder,SalesOrderItem,CR.CurrencyTypeID)             AS [nk_SalesOrderItem]
, CR.[CurrencyTypeID]
, CR.[CurrencyType]
, CASE 
        WHEN CCR.[CurrencyTypeID] = '00' THEN [TransactionCurrency] COLLATE Latin1_General_100_BIN2 
        WHEN CCR.[CurrencyTypeID] = '10' THEN COALESCE(SDI.[CurrencyID],[TransactionCurrency])
        ELSE CCR.[TargetCurrency]
  END                                                                             AS [CurrencyID]
, CASE 
        WHEN CCR.[CurrencyTypeID] = '00' THEN 1.0
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
        ELSE [ConditionBaseValue]
  END                                                                             AS [ConditionBaseValue]
, CONVERT(decimal(19,6), [ConditionBaseValue] * CCR30.ExchangeRate)               AS [BaseAmountEUR]
, CONVERT(decimal(19,6), [ConditionBaseValue] * CCR40.ExchangeRate)               AS [BaseAmountUSD]
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
        ELSE [ConditionAmount]
  END                                                                             AS [ConditionAmount] 
, CONVERT(decimal(19,6), [ConditionAmount] * CCR30.ExchangeRate)                  AS [ConditionAmountEUR]
, CONVERT(decimal(19,6), [ConditionAmount] * CCR40.ExchangeRate)                  AS [ConditionAmountUSD]
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
    ON ISOIPE.SalesOrder = SDI.SalesOrder AND ISOIPE.SalesOrderItem = SDI.SalesOrderItem AND SDI.CurrencyTypeID = '10'
LEFT JOIN [edw].[vw_CurrencyConversionRate] CCR   
    ON ISOIPE.TransactionCurrency = CCR.SourceCurrency    COLLATE DATABASE_DEFAULT AND CCR.CurrencyTypeID IN ('00','10')
LEFT JOIN [edw].[vw_CurrencyConversionRate] CCR30  
    ON ISOIPE.TransactionCurrency = CCR30.SourceCurrency  COLLATE DATABASE_DEFAULT AND CCR30.CurrencyTypeID = '30'
LEFT JOIN [edw].[vw_CurrencyConversionRate] CCR40  
    ON ISOIPE.TransactionCurrency = CCR40.SourceCurrency  COLLATE DATABASE_DEFAULT AND CCR40.CurrencyTypeID = '40'
LEFT JOIN [edw].[dim_CurrencyType] CR
    ON CCR.CurrencyTypeID = CR.CurrencyTypeID

