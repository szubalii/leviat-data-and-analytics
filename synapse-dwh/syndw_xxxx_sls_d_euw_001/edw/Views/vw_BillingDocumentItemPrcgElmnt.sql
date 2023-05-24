CREATE VIEW [edw].[vw_BillingDocumentItemPrcgElmnt]
	AS
WITH IBDIPE AS
(
   SELECT
		 IBDIPE.[BillingDocument]
		,IBDIPE.[BillingDocumentItem]
		,BDI.[CurrencyID]
		,BDI.[BillingDocumentDate]
		,COALESCE(BDI.[ExchangeRate], 1) AS [ExchangeRate]
		,rate_eur.ExchangeRate as EURExchangeRate
        ,rate_usd.ExchangeRate as USDExchangeRate
		,[PricingProcedureStep]
		,[PricingProcedureCounter]
		,[ConditionApplication]
		,[ConditionType]
		,[PricingDateTime]
        ,[ConditionCalculationType]
		, CONVERT(decimal(19,6),[ConditionBaseValue] * COALESCE(BDI.[ExchangeRate] ,1)) as [ConditionBaseValue]
		,[ConditionRateValue]
		,[ConditionCurrency]
		,[ConditionQuantity]
		,[ConditionQuantityUnit]
		,[ConditionCategory]
		,[ConditionIsForStatistics]
		,[PricingScaleType]
		,[IsRelevantForAccrual]
		,[CndnIsRelevantForInvoiceList]
		,[ConditionOrigin]
		,[IsGroupCondition]
		,[ConditionRecord]
		,[ConditionSequentialNumber]
		,[TaxCode]
		,[WithholdingTaxCode]
		,[CndnRoundingOffDiffAmount] 
		, CONVERT(decimal(19,6),[ConditionAmount] * COALESCE(BDI.[ExchangeRate] ,1)) as [ConditionAmount]
		,[TransactionCurrency] as [TransactionCurrencyID]
		,[ConditionControl]
		,[ConditionInactiveReason]
		,[ConditionClass]
		,[PrcgProcedureCounterForHeader]
		,[FactorForConditionBasisValue]
		,[StructureCondition]
		,[PeriodFactorForCndnBasisValue]
		,[PricingScaleBasis]
		,[ConditionScaleBasisValue]
		,[ConditionScaleBasisUnit]
		,[ConditionScaleBasisCurrency]
		,[CndnIsRelevantForIntcoBilling]
		,[ConditionIsManuallyChanged]
		,[ConditionIsForConfiguration]
		,[VariantCondition]
		,IBDIPE.[t_applicationId]  
	FROM 
		 [base_s4h_cax].[I_BillingDocumentItemPrcgElmnt] IBDIPE
	LEFT JOIN
		   [edw].[fact_BillingDocumentItem] BDI
		   ON edw.svf_getNaturalKey ( IBDIPE.BillingDocument,IBDIPE.BillingDocumentItem,10) = BDI.[nk_fact_BillingDocumentItem] 
	JOIN [edw].[vw_CurrencyConversionRate] rate_eur
        ON BDI.CurrencyID = rate_eur.SourceCurrency COLLATE DATABASE_DEFAULT
        AND BDI.BillingDocumentDate BETWEEN rate_eur.ExchangeRateEffectiveDate and rate_eur.LastDay
        AND rate_eur.TargetCurrency = 'EUR'
        AND rate_eur.CurrencyTypeID=30
    JOIN [edw].[vw_CurrencyConversionRate] rate_usd
        ON BDI.CurrencyID = rate_usd.SourceCurrency COLLATE DATABASE_DEFAULT
        AND BDI.BillingDocumentDate BETWEEN rate_usd.ExchangeRateEffectiveDate and rate_usd.LastDay
        AND rate_usd.TargetCurrency = 'USD'
        AND rate_usd.CurrencyTypeID=40
)

/*
    Transaction currency data from S4H
*/
	SELECT 
		 [BillingDocument]
		,[BillingDocumentItem]
		,edw.svf_getNaturalKey (BillingDocument,BillingDocumentItem,CR.CurrencyTypeID) as nk_BillingDocumentItem
		,CR.[CurrencyTypeID]
		,CR.[CurrencyType]
		,[TransactionCurrency] as [CurrencyID]
		,1.0 as [ExchangeRate]
		,[PricingProcedureStep]
		,[PricingProcedureCounter]
		,[ConditionApplication]
		,[ConditionType]
		,[PricingDateTime]
		,[ConditionCalculationType]
		,[ConditionBaseValue]
		,[ConditionRateValue]
		,[ConditionCurrency]
		,[ConditionQuantity]
		,[ConditionQuantityUnit]
		,[ConditionCategory]
		,[ConditionIsForStatistics]
		,[PricingScaleType]
		,[IsRelevantForAccrual]
		,[CndnIsRelevantForInvoiceList]
		,[ConditionOrigin]
		,[IsGroupCondition]
		,[ConditionRecord]
		,[ConditionSequentialNumber]
		,[TaxCode]
		,[WithholdingTaxCode]
		,[CndnRoundingOffDiffAmount]
		,[ConditionAmount]
		,[TransactionCurrency] as [TransactionCurrencyID]
		,[ConditionControl]
		,[ConditionInactiveReason]
		,[ConditionClass]
		,[PrcgProcedureCounterForHeader]
		,[FactorForConditionBasisValue]
		,[StructureCondition]
		,[PeriodFactorForCndnBasisValue]
		,[PricingScaleBasis]
		,[ConditionScaleBasisValue]
		,[ConditionScaleBasisUnit]
		,[ConditionScaleBasisCurrency]
		,[CndnIsRelevantForIntcoBilling]
		,[ConditionIsManuallyChanged]
		,[ConditionIsForConfiguration]
		,[VariantCondition]
		,IBDIPE.[t_applicationId]
    FROM 
        [base_s4h_cax].[I_BillingDocumentItemPrcgElmnt] IBDIPE
		-- WHERE [MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
	CROSS JOIN 
    [edw].[dim_CurrencyType] CR
    WHERE 
    CR.[CurrencyTypeID] = '00'

	UNION ALL

/*
    Local Company Code currency data from S4H
*/
	SELECT
		 [BillingDocument]
		,[BillingDocumentItem]
		,edw.svf_getNaturalKey (BillingDocument,BillingDocumentItem,CR.CurrencyTypeID) as nk_BillingDocumentItem
		,CR.[CurrencyTypeID]
		,CR.[CurrencyType]
		,[CurrencyID]
		,[ExchangeRate]
		,[PricingProcedureStep]
		,[PricingProcedureCounter]
		,[ConditionApplication]
		,[ConditionType]
		,[PricingDateTime]
        ,[ConditionCalculationType]
		,[ConditionBaseValue]
		,[ConditionRateValue]
		,[ConditionCurrency]
		,[ConditionQuantity]
		,[ConditionQuantityUnit]
		,[ConditionCategory]
		,[ConditionIsForStatistics]
		,[PricingScaleType]
		,[IsRelevantForAccrual]
		,[CndnIsRelevantForInvoiceList]
		,[ConditionOrigin]
		,[IsGroupCondition]
		,[ConditionRecord]
		,[ConditionSequentialNumber]
		,[TaxCode]
		,[WithholdingTaxCode]
		,[CndnRoundingOffDiffAmount] 
		,[ConditionAmount]
		,[TransactionCurrencyID]
		,[ConditionControl]
		,[ConditionInactiveReason]
		,[ConditionClass]
		,[PrcgProcedureCounterForHeader]
		,[FactorForConditionBasisValue]
		,[StructureCondition]
		,[PeriodFactorForCndnBasisValue]
		,[PricingScaleBasis]
		,[ConditionScaleBasisValue]
		,[ConditionScaleBasisUnit]
		,[ConditionScaleBasisCurrency]
		,[CndnIsRelevantForIntcoBilling]
		,[ConditionIsManuallyChanged]
		,[ConditionIsForConfiguration]
		,[VariantCondition]
		,IBDIPE.[t_applicationId]  
		FROM 
		    IBDIPE
		CROSS JOIN 
		    [edw].[dim_CurrencyType] CR
		WHERE 
		    CR.[CurrencyTypeID] = '10'

    UNION ALL

/*
   Group Currency EUR  data from S4H
*/
    SELECT 
		 [BillingDocument]
		,[BillingDocumentItem]
		,edw.svf_getNaturalKey (BillingDocument,BillingDocumentItem,CR.CurrencyTypeID) as nk_BillingDocumentItem
		,CR.[CurrencyTypeID]
		,CR.[CurrencyType]
		,'EUR' AS [CurrencyID]
	    ,[EURExchangeRate] as ExchangeRate
		,[PricingProcedureStep]
		,[PricingProcedureCounter]
		,[ConditionApplication]
		,[ConditionType]
		,[PricingDateTime]
		,[ConditionCalculationType]
		,[ConditionBaseValue]*EURExchangeRate as ConditionBaseValue
		,[ConditionRateValue]
		,[ConditionCurrency]
		,[ConditionQuantity]
		,[ConditionQuantityUnit]
		,[ConditionCategory]
		,[ConditionIsForStatistics]
		,[PricingScaleType]
		,[IsRelevantForAccrual]
		,[CndnIsRelevantForInvoiceList]
		,[ConditionOrigin]
		,[IsGroupCondition]
		,[ConditionRecord]
		,[ConditionSequentialNumber]
		,[TaxCode]
		,[WithholdingTaxCode]
		,[CndnRoundingOffDiffAmount]
		,[ConditionAmount]*EURExchangeRate as ConditionAmount
		,[TransactionCurrencyID]
		,[ConditionControl]
		,[ConditionInactiveReason]
		,[ConditionClass]
		,[PrcgProcedureCounterForHeader]
		,[FactorForConditionBasisValue]
		,[StructureCondition]
		,[PeriodFactorForCndnBasisValue]
		,[PricingScaleBasis]
		,[ConditionScaleBasisValue]
		,[ConditionScaleBasisUnit]
		,[ConditionScaleBasisCurrency]
		,[CndnIsRelevantForIntcoBilling]
		,[ConditionIsManuallyChanged]
		,[ConditionIsForConfiguration]
		,[VariantCondition]
		,IBDIPE.[t_applicationId]
    FROM  IBDIPE
    CROSS JOIN 
		    [edw].[dim_CurrencyType] CR
		WHERE 
		    CR.[CurrencyTypeID] = '30'
UNION ALL

/*
   Group Currency USD  data from S4H
*/
    SELECT 
		 [BillingDocument]
		,[BillingDocumentItem]
		,edw.svf_getNaturalKey (BillingDocument,BillingDocumentItem,CR.CurrencyTypeID) as nk_BillingDocumentItem
		,CR.[CurrencyTypeID]
		,CR.[CurrencyType]
		,'USD' AS [CurrencyID]
	    ,[USDExchangeRate] as ExchangeRate
		,[PricingProcedureStep]
		,[PricingProcedureCounter]
		,[ConditionApplication]
		,[ConditionType]
		,[PricingDateTime]
		,[ConditionCalculationType]
		,[ConditionBaseValue]*USDExchangeRate as ConditionBaseValue
		,[ConditionRateValue]
		,[ConditionCurrency]
		,[ConditionQuantity]
		,[ConditionQuantityUnit]
		,[ConditionCategory]
		,[ConditionIsForStatistics]
		,[PricingScaleType]
		,[IsRelevantForAccrual]
		,[CndnIsRelevantForInvoiceList]
		,[ConditionOrigin]
		,[IsGroupCondition]
		,[ConditionRecord]
		,[ConditionSequentialNumber]
		,[TaxCode]
		,[WithholdingTaxCode]
		,[CndnRoundingOffDiffAmount]
		,[ConditionAmount]*USDExchangeRate as ConditionAmount
		,[TransactionCurrencyID]
		,[ConditionControl]
		,[ConditionInactiveReason]
		,[ConditionClass]
		,[PrcgProcedureCounterForHeader]
		,[FactorForConditionBasisValue]
		,[StructureCondition]
		,[PeriodFactorForCndnBasisValue]
		,[PricingScaleBasis]
		,[ConditionScaleBasisValue]
		,[ConditionScaleBasisUnit]
		,[ConditionScaleBasisCurrency]
		,[CndnIsRelevantForIntcoBilling]
		,[ConditionIsManuallyChanged]
		,[ConditionIsForConfiguration]
		,[VariantCondition]
		,IBDIPE.[t_applicationId]
    FROM  IBDIPE
    CROSS JOIN 
		    [edw].[dim_CurrencyType] CR
		WHERE 
		    CR.[CurrencyTypeID] = '40'
