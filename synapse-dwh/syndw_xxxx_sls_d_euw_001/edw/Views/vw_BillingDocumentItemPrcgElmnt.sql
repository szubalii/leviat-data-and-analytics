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
		,case when CR.CurrencyTypeID = '00' then TransactionCurrency else CR.TargetCurrency end  as CurrencyID
		,case when CR.CurrencyTypeID = '10' then COALESCE(BDI.ExchangeRate, 1) else COALESCE(CR.[ExchangeRate], 1) end as ExchangeRate
		,[PricingProcedureStep]
		,[PricingProcedureCounter]
		,[ConditionApplication]
		,[ConditionType]
		,[PricingDateTime]
		,[ConditionCalculationType]
		,CONVERT(decimal(19,6),
                           case when CR.CurrencyTypeID = '00' then ConditionBaseValue
                                when CR.CurrencyTypeID = '10' then [ConditionBaseValue] * COALESCE(BDI.[ExchangeRate] ,1)
                               else [ConditionBaseValue] * COALESCE(BDI.[ExchangeRate] ,1)*COALESCE(CR.[ExchangeRate], 1)
                            end ) as ConditionBaseValue
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
		,CONVERT(decimal(19,6),
                          case when CR.CurrencyTypeID = '00' then ConditionAmount
                               when CR.CurrencyTypeID = '10' then [ConditionAmount] * COALESCE(BDI.[ExchangeRate] ,1)
                               else [ConditionAmount] * COALESCE(BDI.[ExchangeRate] ,1)*COALESCE(CR.[ExchangeRate], 1)
                           end ) as ConditionAmount
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
	LEFT JOIN  [edw].[fact_BillingDocumentItem] BDI
           ON edw.svf_getNaturalKey (IBDIPE.BillingDocument,IBDIPE.BillingDocumentItem,10) = BDI.[nk_fact_BillingDocumentItem] 
	INNER JOIN CurrencyRate CR
           ON BDI.CurrencyID = CR.SourceCurrency COLLATE DATABASE_DEFAULT
           AND BDI.BillingDocumentDate BETWEEN CR.ExchangeRateEffectiveDate and CR.LastDay
    INNER JOIN [edw].[dim_CurrencyType] CurrType
        ON CR.CurrencyTypeID = CurrType.CurrencyTypeID