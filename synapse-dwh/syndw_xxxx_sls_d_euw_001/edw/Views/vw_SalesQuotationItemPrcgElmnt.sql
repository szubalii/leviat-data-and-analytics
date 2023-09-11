CREATE VIEW [edw].[vw_SalesQuotationItemPrcgElmnt]
AS
SELECT
    SDI.[sk_fact_SalesDocumentItem] AS [fk_SalesDocumentItem]
  , [SalesQuotation] 
  , [SalesQuotationItem] 
  , edw.svf_getNaturalKey (SalesQuotation,SalesQuotationItem,CR.CurrencyTypeID)     AS [nk_SalesQuotationItem]
  , CR.[CurrencyTypeID]
  , CR.[CurrencyType]
  , CASE 
        WHEN CCR.[CurrencyTypeID] = '10' THEN COALESCE(SDI.[CurrencyID],[TransactionCurrency]) COLLATE DATABASE_DEFAULT
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
    ON ISQIPE.TransactionCurrency = CCR.SourceCurrency    COLLATE DATABASE_DEFAULT
LEFT JOIN [edw].[dim_CurrencyType] CR
    ON CCR.CurrencyTypeID = CR.CurrencyTypeID
WHERE CCR.CurrencyTypeID <> '00'