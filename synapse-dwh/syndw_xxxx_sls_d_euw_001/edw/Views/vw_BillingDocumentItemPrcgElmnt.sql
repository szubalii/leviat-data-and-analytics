CREATE VIEW [edw].[vw_BillingDocumentItemPrcgElmnt]
AS
SELECT
    BDI.[sk_fact_BillingDocumentItem] AS [fk_BillingDocumentItem]
  , IBDIPE.[BillingDocument]
  , IBDIPE.[BillingDocumentItem]
  , edw.svf_getNaturalKey (IBDIPE.BillingDocument,IBDIPE.BillingDocumentItem,CR.CurrencyTypeID)  AS [nk_BillingDocumentItem]
  , CR.[CurrencyTypeID]
  , CR.[CurrencyType]
  , CASE 
		  WHEN CCR.[CurrencyTypeID] = '10' THEN COALESCE(BDI.[CurrencyID],IBDIPE.[TransactionCurrency]) COLLATE DATABASE_DEFAULT
		  ELSE CCR.[TargetCurrency]
	  END                                                                                        AS [CurrencyID]
  , CASE 
  		WHEN CCR.[CurrencyTypeID] = '10' THEN COALESCE(BDI.[ExchangeRate], 1) 
		  ELSE CCR.[ExchangeRate] 
	  END                                                                                        AS [ExchangeRate]
  , IBDIPE.[PricingProcedureStep]
  , IBDIPE.[PricingProcedureCounter]
  , IBDIPE.[ConditionApplication]
  , IBDIPE.[ConditionType]
  , IBDIPE.[PricingDateTime]
  , IBDIPE.[ConditionCalculationType]
  , CASE 
        WHEN CCR.CurrencyTypeID = '10' 
        THEN CONVERT(decimal(19,6), COALESCE([ConditionBaseValue] * BDI.[ExchangeRate],[ConditionBaseValue]))
        ELSE [ConditionBaseValue] * CCR.ExchangeRate
    END                                                                                          AS [ConditionBaseValue]
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
        ELSE [ConditionAmount]* CCR.ExchangeRate
    END                                                                                          AS [ConditionAmount] 
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
    ON IBDIPE.TransactionCurrency = CCR.SourceCurrency  COLLATE DATABASE_DEFAULT
LEFT JOIN [edw].[dim_CurrencyType] CR
    ON CCR.CurrencyTypeID = CR.CurrencyTypeID
WHERE CCR.CurrencyTypeID <> '00'