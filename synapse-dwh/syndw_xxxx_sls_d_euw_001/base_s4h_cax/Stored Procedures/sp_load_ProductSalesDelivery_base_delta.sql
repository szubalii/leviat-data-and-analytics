CREATE PROC [base_s4h_uat_caa].[sp_load_ProductSalesDelivery_base_delta]
	@t_applicationId [varchar](7),
	@t_jobId [varchar](36),
	@t_lastDtm [datetime],
	@t_lastActionCd [varchar](1),
	@t_lastActionBy [nvarchar](20),
	@t_filePath [nvarchar](1024)

	-- TODO add output parameter for transaction sequence number 
	--		=> impact on loading multiple files at once?
	--		=> Apply enforcing unique key and delta in serverless setup, so that processed file contains complete new status that can directly be ingested in dedicated
	--		=> is this indeed best setup? better to load full data in one go or just delta into dedicated sql pool?
	--		=> Insert delta in base, and load delta to dedicated
	--		=> output to logging table that contains for each table latest loaded sequence number for which day, how many records etc.
	--		=> Update ADF pipelines so that multiple deltas can be loaded in sequence.
AS
BEGIN

	-- First check if transaction sequence number in staging table already exists in delta table

	-- If so, throw error
	IF EXISTS (
		
		SELECT 
			 psd_d.[TransactionSequenceNumber]
			,psd_s.[TransactionSequenceNumber]
		FROM
			[base_s4h_uat_caa].[I_ProductSalesDelivery_delta] AS psd_d
		INNER JOIN
			[base_s4h_uat_caa].[I_ProductSalesDelivery_staging] AS psd_s
			ON
				psd_d.[TransactionSequenceNumber] = psd_s.[TransactionSequenceNumber]
	)

	BEGIN
		-- TODO parameterize error message
		-- TODO include which values violate the constraint
		THROW 50000, 'Violation of PRIMARY KEY constraint ''[PK_I_ProductSalesDelivery_TransactionSequenceNumber_Product_ProductSalesOrg_ProductDistributionChnl]''. Cannot insert duplicate key in object ''[base_s4h_uat_caa].[I_ProductSalesDelivery_delta]'' .', 1;
	END

	-- If not, insert the new delta records
	ELSE

	BEGIN

		-- Insert new records from staging into delta
		INSERT INTO [base_s4h_uat_caa].[I_ProductSalesDelivery_delta](
			 [TransactionSequenceNumber]
			,[Product]
			,[ProductSalesOrg]
			,[ProductDistributionChnl]
			,[MinimumOrderQuantity]
			,[SupplyingPlant]
			,[PriceSpecificationProductGroup]
			,[AccountDetnProductGroup]
			,[DeliveryNoteProcMinDelivQty]
			,[ItemCategoryGroup]
			,[DeliveryQuantityUnit]
			,[DeliveryQuantity]
			,[ProductSalesStatus]
			,[ProductSalesStatusValidityDate]
			,[SalesMeasureUnit]
			,[IsMarkedForDeletion]
			,[ProductHierarchy]
			,[FirstSalesSpecProductGroup]
			,[SecondSalesSpecProductGroup]
			,[ThirdSalesSpecProductGroup]
			,[FourthSalesSpecProductGroup]
			,[FifthSalesSpecProductGroup]
			,[MinimumMakeToOrderOrderQty]
			,[LogisticsStatisticsGroup]
			,[VolumeRebateGroup]
			,[ProductCommissionGroup]
			,[CashDiscountIsDeductible]
			,[PricingReferenceProduct]
			,[AssortmentGrade]
			,[StoreListingProcedure]
			,[DistrCntrListingProcedure]
			,[StoreListingStartDate]
			,[StoreListingEndDate]
			,[DistrCntrListingStartDate]
			,[DistrCntrListingEndDate]
			,[StoreSaleStartDate]
			,[StoreSaleEndDate]
			,[DistrCntrSaleStartDate]
			,[DistrCntrSaleEndDate]
			,[RoundingProfile]
			,[ProductUnitGroup]
			,[MaxDeliveryQtyStoreOrder]
			,[PriceFixingCategory]
			,[VariableSalesUnitIsNotAllowed]
			,[CompetitionPressureCategory]
			,[ProductHasAttributeID01]
			,[ProductHasAttributeID02]
			,[ProductHasAttributeID03]
			,[ProductHasAttributeID04]
			,[ProductHasAttributeID05]
			,[ProductHasAttributeID06]
			,[ProductHasAttributeID07]
			,[ProductHasAttributeID08]
			,[ProductHasAttributeID09]
			,[ProductHasAttributeID10]
			,[IsActiveEntity]
			,[ProdExtAssortmentPriority]
			--,[BaseUnit]
			,[SubscrpnContrDfltDuration]
			,[SubscrpnContrAltvDuration1]
			,[SubscrpnContrAltvDuration2]
			,[SubscrpnContrDurationUnit]
			,[SubscrpnContrDfltExtnDurn]
			,[SubscrpnContrAltvExtnDurn1]
			,[SubscrpnContrAltvExtnDurn2]
			,[SubscrpnContrExtnDurnUnit]
			,[ChangeMode]
			,[t_applicationId]
			,[t_jobId]
			,[t_lastDtm]
			,[t_lastActionCd]
			,[t_lastActionBy]
			,[t_filePath]
		)
		SELECT 	
			 [TransactionSequenceNumber]
			,[Product]
			,[ProductSalesOrg]
			,[ProductDistributionChnl]
			,CONVERT([decimal](13,3), [MinimumOrderQuantity]) AS [MinimumOrderQuantity]
			,[SupplyingPlant]
			,[PriceSpecificationProductGroup]
			,[AccountDetnProductGroup]
			,CONVERT([decimal](13,3), [DeliveryNoteProcMinDelivQty]) AS [DeliveryNoteProcMinDelivQty]
			,[ItemCategoryGroup]
			,[DeliveryQuantityUnit]
			,CONVERT([decimal](13,3), [DeliveryQuantity]) AS [DeliveryQuantity]
			,[ProductSalesStatus]
			,CASE [ProductSalesStatusValidityDate]
				WHEN '00000000' THEN '19000101' 
				ELSE CONVERT([date], [ProductSalesStatusValidityDate], 112) 
			 END AS [ProductSalesStatusValidityDate]
			,[SalesMeasureUnit]
			,[IsMarkedForDeletion]
			,[ProductHierarchy]
			,[FirstSalesSpecProductGroup]
			,[SecondSalesSpecProductGroup]
			,[ThirdSalesSpecProductGroup]
			,[FourthSalesSpecProductGroup]
			,[FifthSalesSpecProductGroup]
			,CONVERT([decimal](13,3), [MinimumMakeToOrderOrderQty]) AS [MinimumMakeToOrderOrderQty]
			,[LogisticsStatisticsGroup]
			,[VolumeRebateGroup]
			,[ProductCommissionGroup]
			,[CashDiscountIsDeductible]
			,[PricingReferenceProduct]
			,[AssortmentGrade]
			,[StoreListingProcedure]
			,[DistrCntrListingProcedure]
			,CASE [StoreListingStartDate]
				WHEN '00000000' THEN '19000101' 
				ELSE CONVERT([date], [StoreListingStartDate], 112) 
			 END AS [StoreListingStartDate]
			,CASE [StoreListingEndDate]
				WHEN '00000000' THEN '19000101' 
				ELSE CONVERT([date], [StoreListingEndDate], 112) 
			 END AS [StoreListingEndDate]
			,CASE [DistrCntrListingStartDate]
				WHEN '00000000' THEN '19000101' 
				ELSE CONVERT([date], [DistrCntrListingStartDate], 112) 
			 END AS [DistrCntrListingStartDate]
			,CASE [DistrCntrListingEndDate]
				WHEN '00000000' THEN '19000101' 
				ELSE CONVERT([date], [DistrCntrListingEndDate], 112) 
			 END AS [DistrCntrListingEndDate]
			,CASE [StoreSaleStartDate]
				WHEN '00000000' THEN '19000101' 
				ELSE CONVERT([date], [StoreSaleStartDate], 112) 
			 END AS [StoreSaleStartDate]
			,CASE [StoreSaleEndDate]
				WHEN '00000000' THEN '19000101' 
				ELSE CONVERT([date], [StoreSaleEndDate], 112) 
			 END AS [StoreSaleEndDate]
			,CASE [DistrCntrSaleStartDate]
				WHEN '00000000' THEN '19000101' 
				ELSE CONVERT([date], [DistrCntrSaleStartDate], 112) 
			 END AS [DistrCntrSaleStartDate]
			,CASE [DistrCntrSaleEndDate]
				WHEN '00000000' THEN '19000101' 
				ELSE CONVERT([date], [DistrCntrSaleEndDate], 112) 
			 END AS [DistrCntrSaleEndDate]
			,[RoundingProfile]
			,[ProductUnitGroup]
			,CONVERT([decimal](13,3), [MaxDeliveryQtyStoreOrder]) AS [MaxDeliveryQtyStoreOrder]
			,[PriceFixingCategory]
			,[VariableSalesUnitIsNotAllowed]
			,[CompetitionPressureCategory]
			,[ProductHasAttributeID01]
			,[ProductHasAttributeID02]
			,[ProductHasAttributeID03]
			,[ProductHasAttributeID04]
			,[ProductHasAttributeID05]
			,[ProductHasAttributeID06]
			,[ProductHasAttributeID07]
			,[ProductHasAttributeID08]
			,[ProductHasAttributeID09]
			,[ProductHasAttributeID10]
			,[IsActiveEntity]
			,[ProdExtAssortmentPriority]
			--,[BaseUnit]
			,[SubscrpnContrDfltDuration]
			,[SubscrpnContrAltvDuration1]
			,[SubscrpnContrAltvDuration2]
			,[SubscrpnContrDurationUnit]
			,[SubscrpnContrDfltExtnDurn]
			,[SubscrpnContrAltvExtnDurn1]
			,[SubscrpnContrAltvExtnDurn2]
			,[SubscrpnContrExtnDurnUnit]
			,[ChangeMode]
			,@t_applicationId AS t_applicationId
			,@t_jobId AS t_jobId
			,@t_lastDtm AS t_lastDtm
			,@t_lastActionCd AS t_lastActionCd
			,@t_lastActionBy AS t_lastActionBy
			,@t_filePath AS t_filePath
		FROM [base_s4h_uat_caa].[I_ProductSalesDelivery_staging]
	END
END