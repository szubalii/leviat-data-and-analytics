CREATE VIEW [edw].[vw_BillingDocumentItemPrcgElmnt]
	AS
/*
    Transaction currency data from S4H
*/
	SELECT 
		 [BillingDocument]
		,[BillingDocumentItem]
		,CONCAT_WS('¦', [BillingDocument] COLLATE SQL_Latin1_General_CP1_CS_AS,[BillingDocumentItem] COLLATE SQL_Latin1_General_CP1_CS_AS,'00') as sk_BillingDocumentItem
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
		 IBDIPE.[BillingDocument]
		,IBDIPE.[BillingDocumentItem]
		,CONCAT_WS(
            '¦', 
            IBDIPE.[BillingDocument] COLLATE SQL_Latin1_General_CP1_CS_AS,
            IBDIPE.[BillingDocumentItem] COLLATE SQL_Latin1_General_CP1_CS_AS,
            '10') 
              as sk_BillingDocumentItem
		,CR.[CurrencyTypeID]
		,CR.[CurrencyType]
		,BDI.[CurrencyID]
		, (CASE
					 WHEN BDI.[ExchangeRate] IS NOT NULL
					 THEN BDI.[ExchangeRate]
					 ELSE 1
			END) 
					 as [ExchangeRate]
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
		        on CONCAT_WS('¦', IBDIPE.[BillingDocument] COLLATE SQL_Latin1_General_CP1_CS_AS,IBDIPE.[BillingDocumentItem] COLLATE SQL_Latin1_General_CP1_CS_AS,'10') = BDI.[nk_fact_BillingDocumentItem] 
		CROSS JOIN 
		    [edw].[dim_CurrencyType] CR
		WHERE 
		    CR.[CurrencyTypeID] = '10'




