CREATE PROC [base_s4h_uat_caa].[sp_load_BillingDocumentPrcgElmnt_base]
	@t_applicationId [varchar](7),
	@t_jobId [varchar](36),
	@t_lastDtm [datetime],
	@t_lastActionBy [nvarchar](20),
	@t_filePath [nvarchar](1024)
AS
BEGIN
	
	TRUNCATE TABLE [base_s4h_uat_caa].[I_BillingDocumentPrcgElmnt]

	INSERT INTO [base_s4h_uat_caa].[I_BillingDocumentPrcgElmnt](
		[BillingDocument]
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
		,[TransactionCurrency]
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
		,[t_applicationId]
		,[t_jobId]
		,[t_lastDtm]
		,[t_lastActionBy]
		,[t_filePath]
	)
	SELECT
		[BillingDocument]
		,CONVERT([char](3), [PricingProcedureStep]) AS [PricingProcedureStep]
		,CONVERT([char](3), [PricingProcedureCounter]) AS [PricingProcedureCounter]
		,[ConditionApplication]
		,[ConditionType]
		,[PricingDateTime]
		,[ConditionCalculationType]
		,CONVERT([decimal](24,9), CASE 
									WHEN RIGHT(RTRIM([ConditionBaseValue]), 1) = '-'
									THEN '-' + REPLACE([ConditionBaseValue], '-','')
									ELSE [ConditionBaseValue]
								  END) AS [ConditionBaseValue]
		,CONVERT([decimal](24,9), CASE 
									WHEN RIGHT(RTRIM([ConditionRateValue]), 1) = '-'
									THEN '-' + REPLACE([ConditionRateValue], '-','')
									ELSE [ConditionRateValue]
								  END) AS [ConditionRateValue]
		,CONVERT([char](5), [ConditionCurrency]) AS [ConditionCurrency]
		,CONVERT([decimal](5), CASE 
									WHEN RIGHT(RTRIM([ConditionQuantity]), 1) = '-'
									THEN '-' + REPLACE([ConditionQuantity], '-','')
									ELSE [ConditionQuantity]
								  END) AS [ConditionQuantity]
		,[ConditionQuantityUnit]
		,[ConditionCategory]
		,[ConditionIsForStatistics]
		,[PricingScaleType]
		,[IsRelevantForAccrual]
		,[CndnIsRelevantForInvoiceList]
		,[ConditionOrigin]
		,[IsGroupCondition]
		,[ConditionRecord]
		,CONVERT([char](3), [ConditionSequentialNumber]) AS [ConditionSequentialNumber]
		,[TaxCode]
		,[WithholdingTaxCode]
		,CONVERT([decimal](5,2), CASE 
									WHEN RIGHT(RTRIM([CndnRoundingOffDiffAmount]), 1) = '-'
									THEN '-' + REPLACE([CndnRoundingOffDiffAmount], '-','')
									ELSE [CndnRoundingOffDiffAmount]
								  END) AS [CndnRoundingOffDiffAmount]
		,CONVERT([decimal](15,2), CASE 
									WHEN RIGHT(RTRIM([ConditionAmount]), 1) = '-'
									THEN '-' + REPLACE([ConditionAmount], '-','')
									ELSE [ConditionAmount]
								  END) AS [ConditionAmount]
		,CONVERT([char](5), [TransactionCurrency]) AS [TransactionCurrency]
		,[ConditionControl]
		,[ConditionInactiveReason]
		,[ConditionClass]
		,CONVERT([char](3), [PrcgProcedureCounterForHeader]) AS [PrcgProcedureCounterForHeader]
		,CONVERT([float], [FactorForConditionBasisValue]) AS [FactorForConditionBasisValue]
		,[StructureCondition]
		,CONVERT([float], [PeriodFactorForCndnBasisValue]) AS [PeriodFactorForCndnBasisValue]
		,[PricingScaleBasis]
		,CONVERT([decimal](24,9), CASE 
									WHEN RIGHT(RTRIM([ConditionScaleBasisValue]), 1) = '-'
									THEN '-' + REPLACE([ConditionScaleBasisValue], '-','')
									ELSE [ConditionScaleBasisValue]
								  END) AS [ConditionScaleBasisValue]
		,[ConditionScaleBasisUnit]
		,CONVERT([char](5), [ConditionScaleBasisCurrency]) AS [ConditionScaleBasisCurrency]
		,[CndnIsRelevantForIntcoBilling]
		,[ConditionIsManuallyChanged]
		,[ConditionIsForConfiguration]
		,[VariantCondition]
		,@t_applicationId AS t_applicationId
		,@t_jobId AS t_jobId
		,@t_lastDtm AS t_lastDtm
		,@t_lastActionBy AS t_lastActionBy
		,@t_filePath AS t_filePath
	FROM [base_s4h_uat_caa].[I_BillingDocumentPrcgElmnt_staging]
END
