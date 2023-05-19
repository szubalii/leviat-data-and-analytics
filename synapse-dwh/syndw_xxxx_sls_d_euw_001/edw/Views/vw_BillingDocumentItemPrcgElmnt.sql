CREATE VIEW [edw].[vw_BillingDocumentItemPrcgElmnt]
	AS
WITH IBDIPE_Local AS
(
   SELECT
		 IBDIPE.[BillingDocument]
		,IBDIPE.[BillingDocumentItem]
		,BDI.[CurrencyID]
		,BDI.[BillingDocumentDate]
		,COALESCE(BDI.[ExchangeRate], 1) AS [ExchangeRate]
		,[PricingProcedureStep]
		,[PricingProcedureCounter]
		,[ConditionApplication]
		,[ConditionType]
		,[PricingDateTime]
        ,[ConditionCalculationType]
		, CONVERT(decimal(19,6), 
			CASE 
			 		WHEN BDI.[ExchangeRate] IS NOT NULL 
					THEN [ConditionBaseValue] * BDI.[ExchangeRate] 
					ELSE [ConditionBaseValue] 
			END) 
					as [ConditionBaseValue]
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
		, CONVERT(decimal(19,6), 
			CASE 
					WHEN BDI.[ExchangeRate] IS NOT NULL 
					THEN [ConditionAmount] * BDI.[ExchangeRate] 
					ELSE [ConditionAmount] 
			END) 
					as [ConditionAmount]
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
),

IBDIPE_30 AS
(
   SELECT 
		 [BillingDocument]
		,[BillingDocumentItem]
		,'EUR' AS [CurrencyID]
		,[BillingDocumentDate]
	    ,ExchangeRate.[ExchangeRate] AS [ExchangeRate]
		,[PricingProcedureStep]
		,[PricingProcedureCounter]
		,[ConditionApplication]
		,[ConditionType]
		,[PricingDateTime]
		,[ConditionCalculationType]
		,[ConditionBaseValue]*ExchangeRate.[ExchangeRate] AS ConditionBaseValue
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
		,[ConditionAmount] * ExchangeRate.[ExchangeRate] as ConditionAmount
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
    FROM  IBDIPE_Local AS IBDIPE
    LEFT JOIN [edw].[vw_CurrencyConversionRate] ExchangeRate
        ON IBDIPE.[CurrencyID] = ExchangeRate.[SourceCurrency]
        AND IBDIPE.[BillingDocumentDate] BETWEEN ExchangeRate.[ExchangeRateEffectiveDate] AND ExchangeRate.[LastDay]   
    WHERE ExchangeRate.CurrencyTypeID ='30'
),

IBDIPE_40 AS
(
   SELECT 
		 [BillingDocument]
		,[BillingDocumentItem]
		,'USD' AS [CurrencyID]
		,[BillingDocumentDate]
	    ,ExchangeRate.[ExchangeRate] AS [ExchangeRate]
		,[PricingProcedureStep]
		,[PricingProcedureCounter]
		,[ConditionApplication]
		,[ConditionType]
		,[PricingDateTime]
		,[ConditionCalculationType]
		,[ConditionBaseValue]*ExchangeRate.[ExchangeRate] AS ConditionBaseValue
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
		,[ConditionAmount] * ExchangeRate.[ExchangeRate] as ConditionAmount
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
    FROM  IBDIPE_Local AS IBDIPE
    LEFT JOIN [edw].[vw_CurrencyConversionRate] ExchangeRate
        ON IBDIPE.[CurrencyID] = ExchangeRate.[SourceCurrency]
        AND IBDIPE.[BillingDocumentDate] BETWEEN ExchangeRate.[ExchangeRateEffectiveDate] AND ExchangeRate.[LastDay]   
    WHERE ExchangeRate.CurrencyTypeID ='40'
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
		    IBDIPE_Local as IBDIPE
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
		,IBDIPE_30.[t_applicationId]
    FROM  IBDIPE_30
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
		,IBDIPE_40.[t_applicationId]
    FROM  IBDIPE_40
    CROSS JOIN 
		    [edw].[dim_CurrencyType] CR
		WHERE 
		    CR.[CurrencyTypeID] = '40'
