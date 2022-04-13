CREATE PROC [base_s4h_uat_caa].[sp_load_BillingDocumentItemBasicDEX_base]
	@t_applicationId [varchar](7),
	@t_jobId [varchar](36),
	@t_lastDtm [datetime],
	@t_lastActionBy [nvarchar](20),
	@t_filePath [nvarchar](1024)
AS
BEGIN
	
	TRUNCATE TABLE [base_s4h_uat_caa].[C_BillingDocumentItemBasicDEX]

	INSERT INTO [base_s4h_uat_caa].[C_BillingDocumentItemBasicDEX](
		[BillingDocument]
		,[BillingDocumentItem]
		,[SalesDocumentItemCategory]
		,[SalesDocumentItemType]
		,[ReturnItemProcessingType]
		,[BillingDocumentType]
		,[BillingDocumentCategory]
		,[SDDocumentCategory]
		,[CreationDate]
		,[CreationTime]
		,[LastChangeDate]
		,[BillingDocumentDate]
		,[BillingDocumentIsTemporary]
		,[OrganizationDivision]
		,[Division]
		,[SalesOffice]
		,[SalesOrganization]
		,[DistributionChannel]
		,[Material]
		--,[Product] doesn't exist in source file
		,[OriginallyRequestedMaterial]
		,[InternationalArticleNumber]
		,[PricingReferenceMaterial]
		,[Batch]
		,[MaterialGroup]
		--,[ProductGroup] doesn't exist in source file
		,[AdditionalMaterialGroup1]
		,[AdditionalMaterialGroup2]
		,[AdditionalMaterialGroup3]
		,[AdditionalMaterialGroup4]
		,[AdditionalMaterialGroup5]
		,[MaterialCommissionGroup]
		,[Plant]
		,[StorageLocation]
		,[BillingDocumentIsCancelled]
		,[CancelledBillingDocument]
		,[BillingDocumentItemText]
		,[ServicesRenderedDate]
		,[BillingQuantity]
		,[BillingQuantityUnit]
		,[BillingQuantityInBaseUnit]
		,[BaseUnit]
		,[MRPRequiredQuantityInBaseUnit]
		,[BillingToBaseQuantityDnmntr]
		,[BillingToBaseQuantityNmrtr]
		,[ItemGrossWeight]
		,[ItemNetWeight]
		,[ItemWeightUnit]
		,[ItemVolume]
		,[ItemVolumeUnit]
		,[BillToPartyCountry]
		,[BillToPartyRegion]
		,[BillingPlanRule]
		,[BillingPlan]
		,[BillingPlanItem]
		,[CustomerPriceGroup]
		,[PriceListType]
		,[TaxDepartureCountry]
		,[VATRegistration]
		,[VATRegistrationCountry]
		,[VATRegistrationOrigin]
		,[CustomerTaxClassification1]
		,[CustomerTaxClassification2]
		,[CustomerTaxClassification3]
		,[CustomerTaxClassification4]
		,[CustomerTaxClassification5]
		,[CustomerTaxClassification6]
		,[CustomerTaxClassification7]
		,[CustomerTaxClassification8]
		,[CustomerTaxClassification9]
		,[SDPricingProcedure]
		,[NetAmount]
		,[TransactionCurrency]
		,[GrossAmount]
		,[PricingDate]
		,[PriceDetnExchangeRate]
		,[PricingScaleQuantityInBaseUnit]
		,[TaxAmount]
		,[CostAmount]
		,[Subtotal1Amount]
		,[Subtotal2Amount]
		,[Subtotal3Amount]
		,[Subtotal4Amount]
		,[Subtotal5Amount]
		,[Subtotal6Amount]
		,[StatisticalValueControl]
		,[StatisticsExchangeRate]
		,[StatisticsCurrency]
		,[SalesOrganizationCurrency]
		,[EligibleAmountForCashDiscount]
		,[ContractAccount]
		,[CustomerPaymentTerms]
		,[PaymentMethod]
		,[PaymentReference]
		,[FixedValueDate]
		,[AdditionalValueDays]
		,[PayerParty]
		,[CompanyCode]
		,[FiscalYear]
		,[FiscalPeriod]
		,[CustomerAccountAssignmentGroup]
		,[BusinessArea]
		,[ProfitCenter]
		,[OrderID]
		,[ControllingArea]
		,[ProfitabilitySegment]
		,[CostCenter]
		,[OriginSDDocument]
		,[OriginSDDocumentItem]
		,[PriceDetnExchangeRateDate]
		,[ExchangeRateType]
		,[FiscalYearVariant]
		,[Currency]
		,[AccountingExchangeRate]
		,[AccountingExchangeRateIsSet]
		,[ReferenceSDDocument]
		,[ReferenceSDDocumentItem]
		,[ReferenceSDDocumentCategory]
		,[SalesDocument]
		,[SalesDocumentItem]
		,[SalesSDDocumentCategory]
		,[HigherLevelItem]
		,[BillingDocumentItemInPartSgmt]
		,[SalesGroup]
		,[AdditionalCustomerGroup1]
		,[AdditionalCustomerGroup2]
		,[AdditionalCustomerGroup3]
		,[AdditionalCustomerGroup4]
		,[AdditionalCustomerGroup5]
		,[SDDocumentReason]
		,[ItemIsRelevantForCredit]
		,[CreditRelatedPrice]
		,[SalesDistrict]
		,[CustomerGroup]
		,[SoldToParty]
		,[Country]
		,[ShipToParty]
		,[BillToParty]
		,[ShippingPoint]
		,[IncotermsVersion]
		,[IncotermsClassification]
		,[IncotermsTransferLocation]
		,[IncotermsLocation1]
		,[IncotermsLocation2]
		,[ShippingCondition]
		/*  don't exist in source file
		,[OverallSDProcessStatus]
		,[OverallBillingStatus]
		,[AccountingPostingStatus]
		,[AccountingTransferStatus]
		,[BillingIssueType]
		,[InvoiceListStatus]
		,[OvrlItmGeneralIncompletionSts]
		,[OverallPricingIncompletionSts]
		*/
		,[t_applicationId]
		,[t_jobId]
		,[t_lastDtm]
		,[t_lastActionBy]
		,[t_filePath]
	)
	SELECT 	
		[BillingDocument]
		,CONVERT([char](6), [BillingDocumentItem]) AS [BillingDocumentItem]
		,[SalesDocumentItemCategory]
		,[SalesDocumentItemType]
		,[ReturnItemProcessingType]
		,[BillingDocumentType]
		,[BillingDocumentCategory]
		,[SDDocumentCategory]
		,CASE [CreationDate]
			WHEN '00000000' THEN '19000101' 
			ELSE CONVERT([date], [CreationDate], 112) 
		 END AS [CreationDate]
		,CASE LEN([CreationTime])
			WHEN 6 THEN CONVERT([time](0), LEFT([CreationTime], 2)+':'+SUBSTRING([CreationTime],3,2)+':'+SUBSTRING([CreationTime],5,2))
			WHEN 5 THEN CONVERT([time](0), LEFT([CreationTime], 1)+':'+SUBSTRING([CreationTime],2,2)+':'+SUBSTRING([CreationTime],4,2))
		 END AS [CreationTime]
		,CASE [LastChangeDate]
			WHEN '00000000' THEN '19000101' 
			ELSE CONVERT([date], [LastChangeDate], 112) 
		 END AS [LastChangeDate]
		,[BillingDocumentDate]
		,[BillingDocumentIsTemporary]
		,[OrganizationDivision]
		,[Division]
		,[SalesOffice]
		,[SalesOrganization]
		,[DistributionChannel]
		,[Material]
		,[OriginallyRequestedMaterial]
		,[InternationalArticleNumber]
		,[PricingReferenceMaterial]
		,[Batch]
		,[MaterialGroup]
		,[AdditionalMaterialGroup1]
		,[AdditionalMaterialGroup2]
		,[AdditionalMaterialGroup3]
		,[AdditionalMaterialGroup4]
		,[AdditionalMaterialGroup5]
		,[MaterialCommissionGroup]
		,[Plant]
		,[StorageLocation]
		,[BillingDocumentIsCancelled]
		,[CancelledBillingDocument]
		,[BillingDocumentItemText]
		,CASE [ServicesRenderedDate]
			WHEN '00000000' THEN '19000101' 
			ELSE CONVERT([date], [ServicesRenderedDate], 112) 
		 END AS [ServicesRenderedDate]
		,CONVERT([decimal](13,3), CASE 
									WHEN RIGHT(RTRIM([BillingQuantity]), 1) = '-'
									THEN '-' + REPLACE([BillingQuantity], '-','')
									ELSE [BillingQuantity]
								  END) AS [BillingQuantity] --in files from s4h negative decimal columns contain '-' character at the end: '833.18-'
		,[BillingQuantityUnit]
		,CONVERT([decimal](13,3), CASE 
									WHEN RIGHT(RTRIM([BillingQuantityInBaseUnit]), 1) = '-'
									THEN '-' + REPLACE([BillingQuantityInBaseUnit], '-','')
									ELSE [BillingQuantityInBaseUnit]
								  END) AS [BillingQuantityInBaseUnit]
		,[BaseUnit]
		,CONVERT([decimal](13,3), CASE 
									WHEN RIGHT(RTRIM([MRPRequiredQuantityInBaseUnit]), 1) = '-'
									THEN '-' + REPLACE([MRPRequiredQuantityInBaseUnit], '-','')
									ELSE [MRPRequiredQuantityInBaseUnit]
								  END) AS [MRPRequiredQuantityInBaseUnit]
		,CONVERT([decimal](5,0), CASE 
									WHEN RIGHT(RTRIM([BillingToBaseQuantityDnmntr]), 1) = '-'
									THEN '-' + REPLACE([BillingToBaseQuantityDnmntr], '-','')
									ELSE [BillingToBaseQuantityDnmntr]
								  END) AS [BillingToBaseQuantityDnmntr]
		,CONVERT([decimal](5,0), CASE 
									WHEN RIGHT(RTRIM([BillingToBaseQuantityNmrtr]), 1) = '-'
									THEN '-' + REPLACE([BillingToBaseQuantityNmrtr], '-','')
									ELSE [BillingToBaseQuantityNmrtr]
								  END) AS [BillingToBaseQuantityNmrtr]
		,CONVERT([decimal](15,3), CASE 
									WHEN RIGHT(RTRIM([ItemGrossWeight]), 1) = '-'
									THEN '-' + REPLACE([ItemGrossWeight], '-','')
									ELSE [ItemGrossWeight]
								  END) AS [ItemGrossWeight]
		,CONVERT([decimal](15,3), CASE 
									WHEN RIGHT(RTRIM([ItemNetWeight]), 1) = '-'
									THEN '-' + REPLACE([ItemNetWeight], '-','')
									ELSE [ItemNetWeight]
								  END) AS [ItemNetWeight]
		,[ItemWeightUnit]
		,CONVERT([decimal](15,3), CASE 
									WHEN RIGHT(RTRIM([ItemVolume]), 1) = '-'
									THEN '-' + REPLACE([ItemVolume], '-','')
									ELSE [ItemVolume]
								  END) AS [ItemVolume]
		,[ItemVolumeUnit]
		,[BillToPartyCountry]
		,[BillToPartyRegion]
		,[BillingPlanRule]
		,[BillingPlan]
		,CONVERT([char](6), [BillingPlanItem]) AS [BillingPlanItem]
		,[CustomerPriceGroup]
		,[PriceListType]
		,[TaxDepartureCountry]
		,[VATRegistration]
		,[VATRegistrationCountry]
		,[VATRegistrationOrigin]
		,[CustomerTaxClassification1]
		,[CustomerTaxClassification2]
		,[CustomerTaxClassification3]
		,[CustomerTaxClassification4]
		,[CustomerTaxClassification5]
		,[CustomerTaxClassification6]
		,[CustomerTaxClassification7]
		,[CustomerTaxClassification8]
		,[CustomerTaxClassification9]
		,[SDPricingProcedure]
		,CONVERT([decimal](15,2), CASE 
									WHEN RIGHT(RTRIM([NetAmount]), 1) = '-'
									THEN '-' + REPLACE([NetAmount], '-','')
									ELSE [NetAmount]
								  END) AS [NetAmount]
		,CONVERT([char](5), [TransactionCurrency]) AS [TransactionCurrency]
		,CONVERT([decimal](15,2), CASE 
									WHEN RIGHT(RTRIM([GrossAmount]), 1) = '-'
									THEN '-' + REPLACE([GrossAmount], '-','')
									ELSE [GrossAmount]
								  END) AS [GrossAmount]
		,CASE [PricingDate]
			WHEN '00000000' THEN '19000101' 
			ELSE CONVERT([date], [PricingDate], 112) 
		 END AS [PricingDate]
		,CONVERT([decimal](9,5), CASE 
									WHEN RIGHT(RTRIM([PriceDetnExchangeRate]), 1) = '-'
									THEN '-' + REPLACE([PriceDetnExchangeRate], '-','')
									ELSE [PriceDetnExchangeRate]
								  END) AS [PriceDetnExchangeRate]
		,CONVERT([decimal](13,3), CASE 
									WHEN RIGHT(RTRIM([PricingScaleQuantityInBaseUnit]), 1) = '-'
									THEN '-' + REPLACE([PricingScaleQuantityInBaseUnit], '-','')
									ELSE [PricingScaleQuantityInBaseUnit]
								  END) AS [PricingScaleQuantityInBaseUnit]
		,CONVERT([decimal](13,2), CASE 
									WHEN RIGHT(RTRIM([TaxAmount]), 1) = '-'
									THEN '-' + REPLACE([TaxAmount], '-','')
									ELSE [TaxAmount]
								  END) AS [TaxAmount]
		,CONVERT([decimal](13,2), CASE 
									WHEN RIGHT(RTRIM([CostAmount]), 1) = '-'
									THEN '-' + REPLACE([CostAmount], '-','')
									ELSE [CostAmount]
								  END) AS [CostAmount]
		,CONVERT([decimal](13,2), CASE 
									WHEN RIGHT(RTRIM([Subtotal1Amount]), 1) = '-'
									THEN '-' + REPLACE([Subtotal1Amount], '-','')
									ELSE [Subtotal1Amount]
								  END) AS [Subtotal1Amount]
		,CONVERT([decimal](13,2), CASE 
									WHEN RIGHT(RTRIM([Subtotal2Amount]), 1) = '-'
									THEN '-' + REPLACE([Subtotal2Amount], '-','')
									ELSE [Subtotal2Amount]
								  END) AS [Subtotal2Amount]
		,CONVERT([decimal](13,2), CASE 
									WHEN RIGHT(RTRIM([Subtotal3Amount]), 1) = '-'
									THEN '-' + REPLACE([Subtotal3Amount], '-','')
									ELSE [Subtotal3Amount]
								  END) AS [Subtotal3Amount]
		,CONVERT([decimal](13,2), CASE 
									WHEN RIGHT(RTRIM([Subtotal4Amount]), 1) = '-'
									THEN '-' + REPLACE([Subtotal4Amount], '-','')
									ELSE [Subtotal4Amount]
								  END) AS [Subtotal4Amount]
		,CONVERT([decimal](13,2), CASE 
									WHEN RIGHT(RTRIM([Subtotal5Amount]), 1) = '-'
									THEN '-' + REPLACE([Subtotal5Amount], '-','')
									ELSE [Subtotal5Amount]
								  END) AS [Subtotal5Amount]
		,CONVERT([decimal](13,2), CASE 
									WHEN RIGHT(RTRIM([Subtotal6Amount]), 1) = '-'
									THEN '-' + REPLACE([Subtotal6Amount], '-','')
									ELSE [Subtotal6Amount]
								  END) AS [Subtotal6Amount]
		,[StatisticalValueControl]
		,CONVERT([decimal](9,5), CASE 
									WHEN RIGHT(RTRIM([StatisticsExchangeRate]), 1) = '-'
									THEN '-' + REPLACE([StatisticsExchangeRate], '-','')
									ELSE [StatisticsExchangeRate]
								  END) AS [StatisticsExchangeRate]
		,CONVERT([char](5), [StatisticsCurrency]) AS [StatisticsCurrency]
		,CONVERT([char](5), [SalesOrganizationCurrency]) AS [SalesOrganizationCurrency]
		,CONVERT([decimal](13,2), CASE 
									WHEN RIGHT(RTRIM([EligibleAmountForCashDiscount]), 1) = '-'
									THEN '-' + REPLACE([EligibleAmountForCashDiscount], '-','')
									ELSE [EligibleAmountForCashDiscount]
								  END) AS [EligibleAmountForCashDiscount]
		,[ContractAccount]
		,[CustomerPaymentTerms]
		,[PaymentMethod]
		,[PaymentReference]
		,CASE [FixedValueDate]
			WHEN '00000000' THEN '19000101' 
			ELSE CONVERT([date], [FixedValueDate], 112) 
		 END AS [FixedValueDate]
		,CONVERT([char](2), [AdditionalValueDays]) AS [AdditionalValueDays]
		,[PayerParty]
		,[CompanyCode]
		,CONVERT([char](4), [FiscalYear]) AS [FiscalYear]
		,CONVERT([char](3), [FiscalPeriod]) AS [FiscalPeriod]
		,[CustomerAccountAssignmentGroup]
		,[BusinessArea]
		,[ProfitCenter]
		,[OrderID]
		,[ControllingArea]
		,CONVERT([char](10), [ProfitabilitySegment]) AS [ProfitabilitySegment]
		,[CostCenter]
		,[OriginSDDocument]
		,CONVERT([char](6), [OriginSDDocumentItem]) AS [OriginSDDocumentItem]
		,CASE [PriceDetnExchangeRateDate]
			WHEN '00000000' THEN '19000101' 
			ELSE CONVERT([date], [PriceDetnExchangeRateDate], 112) 
		 END AS [PriceDetnExchangeRateDate]
		,[ExchangeRateType]
		,[FiscalYearVariant]
		,CONVERT([char](5), [Currency]) AS [Currency]
		,CONVERT([decimal](9,5), CASE 
									WHEN RIGHT(RTRIM([AccountingExchangeRate]), 1) = '-'
									THEN '-' + REPLACE([AccountingExchangeRate], '-','')
									ELSE [AccountingExchangeRate]
								  END) AS [AccountingExchangeRate]
		,[AccountingExchangeRateIsSet]
		,[ReferenceSDDocument]
		,CONVERT([char](6), [ReferenceSDDocumentItem]) AS [ReferenceSDDocumentItem]
		,[ReferenceSDDocumentCategory]
		,[SalesDocument]
		,CONVERT([char](6), [SalesDocumentItem]) AS [SalesDocumentItem]
		,[SalesSDDocumentCategory]
		,CONVERT([char](6), [HigherLevelItem]) AS [HigherLevelItem]
		,[BillingDocumentItemInPartSgmt]
		,[SalesGroup]
		,[AdditionalCustomerGroup1]
		,[AdditionalCustomerGroup2]
		,[AdditionalCustomerGroup3]
		,[AdditionalCustomerGroup4]
		,[AdditionalCustomerGroup5]
		,[SDDocumentReason]
		,[ItemIsRelevantForCredit]
		,CONVERT([decimal](11,2), CASE 
									WHEN RIGHT(RTRIM([CreditRelatedPrice]), 1) = '-'
									THEN '-' + REPLACE([CreditRelatedPrice], '-','')
									ELSE [CreditRelatedPrice]
								  END) AS [CreditRelatedPrice]
		,[SalesDistrict]
		,[CustomerGroup]
		,[SoldToParty]
		,[Country]
		,[ShipToParty]
		,[BillToParty]
		,[ShippingPoint]
		,[IncotermsVersion]
		,[IncotermsClassification]
		,[IncotermsTransferLocation]
		,[IncotermsLocation1]
		,[IncotermsLocation2]
		,[ShippingCondition]
		,@t_applicationId AS t_applicationId
		,@t_jobId AS t_jobId
		,@t_lastDtm AS t_lastDtm
		,@t_lastActionBy AS t_lastActionBy
		,@t_filePath AS t_filePath
	FROM [base_s4h_uat_caa].[C_BillingDocumentItemBasicDEX_staging]
END
