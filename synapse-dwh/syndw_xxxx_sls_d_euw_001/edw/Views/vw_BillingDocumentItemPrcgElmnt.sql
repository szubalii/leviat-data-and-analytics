CREATE VIEW [edw].[vw_BillingDocumentItemPrcgElmnt]
AS
SELECT 
    IBDIPE.[BillingDocument]
  , IBDIPE.[BillingDocumentItem]
  , edw.svf_getNaturalKey (IBDIPE.BillingDocument,IBDIPE.BillingDocumentItem,CR.CurrencyTypeID)  AS [nk_BillingDocumentItem]
  , CR.[CurrencyTypeID]
  , CR.[CurrencyType]
  , CASE 
    	WHEN CCR.[CurrencyTypeID] = '00' THEN IBDIPE.[TransactionCurrency] 
		WHEN CCR.[CurrencyTypeID] = '10' THEN BDI.[CurrencyID]
		ELSE CCR.[TargetCurrency]
	END                                                                                          AS [CurrencyID]
  , CASE 
		WHEN CCR.[CurrencyTypeID] = '00' THEN 1.0
  		WHEN CCR.[CurrencyTypeID] = '10' THEN COALESCE(BDI.[ExchangeRate], 1) 
		ELSE CCR.[ExchangeRate] 
	END                                                                                          AS [ExchangeRate]
  , IBDIPE.[PricingProcedureStep]
  , IBDIPE.[PricingProcedureCounter]
  , IBDIPE.[ConditionApplication]
  , IBDIPE.[ConditionType]
  , IBDIPE.[PricingDateTime]
  , IBDIPE.[ConditionCalculationType]
  , CASE 
        WHEN CCR.CurrencyTypeID = '10' 
        THEN CONVERT(decimal(19,6), COALESCE([ConditionBaseValue] * BDI.[ExchangeRate],[ConditionBaseValue]))
        ELSE [ConditionBaseValue]
    END                                                                                          AS [ConditionBaseValue]
  , CONVERT(decimal(19,6), [ConditionBaseValue] * CCR30.ExchangeRate)                            AS [BaseAmountEUR]
  , CONVERT(decimal(19,6), [ConditionBaseValue] * CCR40.ExchangeRate)                            AS [BaseAmountUSD]
  , IBDIPE.[ConditionRateValue]
  , IBDIPE.[ConditionCurrency]
  , IBDIPE.[ConditionQuantity]
  , IBDIPE.[ConditionQuantityUnit]
  , IBDIPE.[ConditionCategory]
  , IBDIPE.[ConditionIsForStatistics]
  , IBDIPE.[PricingScaleType]
  , IBDIPE.[IsRelevantForAccrual]
  , IBDIPE.[CndnIsRelevantForInvoiceList]
  , IBDIPE.[ConditionOrigin]
  , IBDIPE.[IsGroupCondition]
  , IBDIPE.[ConditionRecord]
  , IBDIPE.[ConditionSequentialNumber]
  , IBDIPE.[TaxCode]
  , IBDIPE.[WithholdingTaxCode]
  , IBDIPE.[CndnRoundingOffDiffAmount]
  , CASE 
        WHEN CCR.CurrencyTypeID = '10' 
        THEN CONVERT(decimal(19,6), COALESCE([ConditionAmount] * BDI.[ExchangeRate],[ConditionAmount]))
        ELSE [ConditionAmount]
    END                                                                                          AS [ConditionAmount] 
  , CONVERT(decimal(19,6), [ConditionAmount] * CCR30.ExchangeRate)                               AS [ConditionAmountEUR]
  , CONVERT(decimal(19,6), [ConditionAmount] * CCR40.ExchangeRate)                               AS [ConditionAmountUSD]
  , IBDIPE.[TransactionCurrency] as [TransactionCurrencyID]
  , IBDIPE.[ConditionControl]
  , IBDIPE.[ConditionInactiveReason]
  , IBDIPE.[ConditionClass]
  , IBDIPE.[PrcgProcedureCounterForHeader]
  , IBDIPE.[FactorForConditionBasisValue]
  , IBDIPE.[StructureCondition]
  , IBDIPE.[PeriodFactorForCndnBasisValue]
  , IBDIPE.[PricingScaleBasis]
  , IBDIPE.[ConditionScaleBasisValue]
  , IBDIPE.[ConditionScaleBasisUnit]
  , IBDIPE.[ConditionScaleBasisCurrency]
  , IBDIPE.[CndnIsRelevantForIntcoBilling]
  , IBDIPE.[ConditionIsManuallyChanged]
  , IBDIPE.[ConditionIsForConfiguration]
  , IBDIPE.[VariantCondition]
  , IBDIPE.[t_applicationId]
  , IBDIPE.[t_extractionDtm]
FROM 
	[base_s4h_cax].[I_BillingDocumentItemPrcgElmnt] IBDIPE
LEFT JOIN  [edw].[fact_BillingDocumentItem] BDI
    ON IBDIPE.BillingDocument = BDI.BillingDocument AND IBDIPE.BillingDocumentItem = BDI.BillingDocumentItem AND BDI.CurrencyTypeID = '10'
LEFT JOIN [edw].[vw_CurrencyConversionRate] CCR   
    ON ISQIPE.TransactionCurrency = CCR.SourceCurrency    COLLATE DATABASE_DEFAULT AND CCR.CurrencyTypeID IN ('00','10')
LEFT JOIN [edw].[vw_CurrencyConversionRate] CCR30  
    ON ISQIPE.TransactionCurrency = CCR30.SourceCurrency  COLLATE DATABASE_DEFAULT AND CCR30.CurrencyTypeID = '30'
LEFT JOIN [edw].[vw_CurrencyConversionRate] CCR40  
    ON ISQIPE.TransactionCurrency = CCR40.SourceCurrency  COLLATE DATABASE_DEFAULT AND CCR40.CurrencyTypeID = '40'
LEFT JOIN [edw].[dim_CurrencyType] CR
    ON CCR.CurrencyTypeID = CR.CurrencyTypeID