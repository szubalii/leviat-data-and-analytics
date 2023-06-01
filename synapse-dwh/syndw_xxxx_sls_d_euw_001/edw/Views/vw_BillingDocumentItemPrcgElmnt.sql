CREATE VIEW [edw].[vw_BillingDocumentItemPrcgElmnt]
	AS
WITH CurrencyRate AS(
     SELECT 
     [SourceCurrency]
    ,[TargetCurrency]
    ,[ExchangeRateEffectiveDate]
    ,[LastDay]
    ,[ExchangeRate]
    ,CONVERT (nvarchar(2),CurrencyTypeID) as CurrencyTypeID
    FROM [edw].[vw_CurrencyConversionRate]
UNION ALL
    SELECT 
     [SourceCurrency]
    ,[TargetCurrency]
    ,[ExchangeRateEffectiveDate]
    ,[LastDay]
    ,[ExchangeRate]
    ,'00' as CurrencyTypeID
    FROM  [edw].[vw_CurrencyConversionRate] 
    WHERE CurrencyTypeID= '10'
    )

	SELECT 
		 IBDIPE.[BillingDocument]
		,IBDIPE.[BillingDocumentItem]
		,edw.svf_getNaturalKey (IBDIPE.BillingDocument,IBDIPE.BillingDocumentItem,CR.CurrencyTypeID) as nk_BillingDocumentItem
		,CR.CurrencyTypeID
		,CurrType.[CurrencyType]
		,case when CR.CurrencyTypeID = '00' then IBDIPE.TransactionCurrency else CR.TargetCurrency end  as CurrencyID
		,case when CR.CurrencyTypeID = '10' then COALESCE(BDI.ExchangeRate, 1) else CR.[ExchangeRate] end as ExchangeRate
		,IBDIPE.[PricingProcedureStep]
		,IBDIPE.[PricingProcedureCounter]
		,IBDIPE.[ConditionApplication]
		,IBDIPE.[ConditionType]
		,IBDIPE.[PricingDateTime]
		,IBDIPE.[ConditionCalculationType]
		,CONVERT(decimal(19,6),
                           case when CR.CurrencyTypeID = '00' then ConditionBaseValue
                                when CR.CurrencyTypeID = '10' then [ConditionBaseValue] * COALESCE(BDI.[ExchangeRate] ,1)
                               else [ConditionBaseValue] * COALESCE(BDI.[ExchangeRate] ,1)*CR.[ExchangeRate]
                            end ) as ConditionBaseValue
		,IBDIPE.[ConditionRateValue]
		,IBDIPE.[ConditionCurrency]
		,IBDIPE.[ConditionQuantity]
		,IBDIPE.[ConditionQuantityUnit]
		,IBDIPE.[ConditionCategory]
		,IBDIPE.[ConditionIsForStatistics]
		,IBDIPE.[PricingScaleType]
		,IBDIPE.[IsRelevantForAccrual]
		,IBDIPE.[CndnIsRelevantForInvoiceList]
		,IBDIPE.[ConditionOrigin]
		,IBDIPE.[IsGroupCondition]
		,IBDIPE.[ConditionRecord]
		,IBDIPE.[ConditionSequentialNumber]
		,IBDIPE.[TaxCode]
		,IBDIPE.[WithholdingTaxCode]
		,IBDIPE.[CndnRoundingOffDiffAmount]
		,CONVERT(decimal(19,6),
                          case when CR.CurrencyTypeID = '00' then ConditionAmount
                               when CR.CurrencyTypeID = '10' then [ConditionAmount] * COALESCE(BDI.[ExchangeRate] ,1)
                               else [ConditionAmount] * COALESCE(BDI.[ExchangeRate] ,1)*CR.[ExchangeRate]
                           end ) as ConditionAmount
		,IBDIPE.[TransactionCurrency] as [TransactionCurrencyID]
		,IBDIPE.[ConditionControl]
		,IBDIPE.[ConditionInactiveReason]
		,IBDIPE.[ConditionClass]
		,IBDIPE.[PrcgProcedureCounterForHeader]
		,IBDIPE.[FactorForConditionBasisValue]
		,IBDIPE.[StructureCondition]
		,IBDIPE.[PeriodFactorForCndnBasisValue]
		,IBDIPE.[PricingScaleBasis]
		,IBDIPE.[ConditionScaleBasisValue]
		,IBDIPE.[ConditionScaleBasisUnit]
		,IBDIPE.[ConditionScaleBasisCurrency]
		,IBDIPE.[CndnIsRelevantForIntcoBilling]
		,IBDIPE.[ConditionIsManuallyChanged]
		,IBDIPE.[ConditionIsForConfiguration]
		,IBDIPE.[VariantCondition]
		,IBDIPE.[t_applicationId]
		,IBDIPE.[t_extractionDtm]
   	FROM 
		 [base_s4h_cax].[I_BillingDocumentItemPrcgElmnt] IBDIPE
	LEFT JOIN  [edw].[fact_BillingDocumentItem] BDI
           ON edw.svf_getNaturalKey (IBDIPE.BillingDocument,IBDIPE.BillingDocumentItem,10) = BDI.[nk_fact_BillingDocumentItem] 
	INNER JOIN CurrencyRate CR
           ON BDI.CurrencyID = CR.SourceCurrency COLLATE DATABASE_DEFAULT
           AND BDI.[t_extractionDtm] BETWEEN CR.ExchangeRateEffectiveDate and CR.LastDay
         --AND BDI.BillingDocumentDate BETWEEN CR.ExchangeRateEffectiveDate and CR.LastDay
    INNER JOIN [edw].[dim_CurrencyType] CurrType
        ON CR.CurrencyTypeID = CurrType.CurrencyTypeID