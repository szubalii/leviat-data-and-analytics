CREATE VIEW [edw].[vw_SalesQuotationItemPrcgElmnt]
AS
SELECT
    [SalesQuotation] 
  , [SalesQuotationItem] 
  , edw.svf_getNaturalKey (SalesQuotation,SalesQuotationItem,CR.CurrencyTypeID)     AS [nk_SalesQuotationItem]
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
  , [TransactionCurrency] AS TransactionCurrencyID
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
  , ISQIPE.[t_applicationId] 
  , ISQIPE.[t_jobDtm]   
FROM 
    [base_s4h_cax].[I_SalesQuotationItemPrcgElmnt] ISQIPE
LEFT JOIN [edw].[fact_SalesDocumentItem] SDI
    ON ISQIPE.SalesQuotation = SDI.SalesDocument AND ISQIPE.SalesQuotationItem = SDI.SalesDocumentItem  COLLATE DATABASE_DEFAULT AND SDI.CurrencyTypeID = '10'
LEFT JOIN [edw].[vw_CurrencyConversionRate] CCR   
    ON ISQIPE.TransactionCurrency = CCR.SourceCurrency    COLLATE DATABASE_DEFAULT AND CCR.CurrencyTypeID IN ('00','10')
LEFT JOIN [edw].[vw_CurrencyConversionRate] CCR30  
    ON ISQIPE.TransactionCurrency = CCR30.SourceCurrency  COLLATE DATABASE_DEFAULT AND CCR30.CurrencyTypeID = '30'
LEFT JOIN [edw].[vw_CurrencyConversionRate] CCR40  
    ON ISQIPE.TransactionCurrency = CCR40.SourceCurrency  COLLATE DATABASE_DEFAULT AND CCR40.CurrencyTypeID = '40'
LEFT JOIN [edw].[dim_CurrencyType] CR
    ON CCR.CurrencyTypeID = CR.CurrencyTypeID