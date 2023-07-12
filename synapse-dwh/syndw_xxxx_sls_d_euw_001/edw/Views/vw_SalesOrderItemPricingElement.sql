CREATE VIEW [edw].[vw_SalesOrderItemPricingElement]
As
/*
    Transaction currency data from S4H
*/
SELECT 
  [SalesOrder] 
, [SalesOrderItem]
, edw.svf_getNaturalKey (SalesOrder,SalesOrderItem,CR.CurrencyTypeID) as nk_SalesOrderItem
, CR.[CurrencyTypeID]
, CR.[CurrencyType]
, [TransactionCurrency] COLLATE Latin1_General_100_BIN2 as [CurrencyID]
, 1.0 as [ExchangeRate]
, [PricingProcedureStep] 
, [PricingProcedureCounter] 
, [ConditionApplication] 
, [ConditionType] 
, [PricingDateTime] 
, [ConditionCalculationType] 
, [ConditionBaseValue] 
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
, [ConditionAmount] 
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
CROSS JOIN 
    [edw].[dim_CurrencyType] CR
WHERE 
    CR.[CurrencyTypeID] = '00' and ISOIPE.ConditionInactiveReason = ''

UNION ALL

/*
    Local Company Code currency data from S4H
*/
SELECT
  [SalesOrder] 
, [SalesOrderItem]
, edw.svf_getNaturalKey (SalesOrder,SalesOrderItem,CR.CurrencyTypeID) as nk_SalesOrderItem
, CR.[CurrencyTypeID]
, CR.[CurrencyType]
, SDI.[CurrencyID] COLLATE Latin1_General_100_BIN2 as CurrencyID
, COALESCE(SDI.[ExchangeRate], 1) AS [ExchangeRate]
, [PricingProcedureStep] 
, [PricingProcedureCounter] 
, [ConditionApplication] 
, [ConditionType] 
, [PricingDateTime] 
, [ConditionCalculationType] 
, CONVERT(decimal(19,6), 
	CASE 
	 		WHEN SDI.[ExchangeRate] IS NOT NULL 
			THEN [ConditionBaseValue] * SDI.[ExchangeRate] 
			ELSE [ConditionBaseValue] 
	END) 
			as [ConditionBaseValue]
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
, CONVERT(decimal(19,6), 
	CASE 
			WHEN SDI.[ExchangeRate] IS NOT NULL 
			THEN [ConditionAmount] * SDI.[ExchangeRate] 
			ELSE [ConditionAmount] 
	END) 
			as [ConditionAmount]
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
LEFT JOIN
   [edw].[fact_SalesDocumentItem] SDI
        on edw.svf_getNaturalKey (SalesOrder,SalesOrderItem,'10') = SDI.[nk_fact_SalesDocumentItem] 
CROSS JOIN 
    [edw].[dim_CurrencyType] CR
WHERE 
    CR.[CurrencyTypeID] = '10' and ISOIPE.ConditionInactiveReason = ''

