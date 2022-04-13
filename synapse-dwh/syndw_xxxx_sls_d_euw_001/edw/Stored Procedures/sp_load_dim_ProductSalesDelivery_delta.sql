CREATE PROC [edw].[sp_load_dim_ProductSalesDelivery_delta]
       @t_applicationId varchar(7)
      ,@t_jobId [varchar](36)
      ,@t_jobDtm [datetime]
      ,@t_jobBy [nvarchar](128)
      ,@transaction_sequence_number decimal(23,0)
AS
BEGIN
	
	-- Drop temp table if already existing
	IF OBJECT_ID('tempdb..#I_ProductSalesDelivery_delta_insert') IS NOT NULL
		DROP TABLE #I_ProductSalesDelivery_delta_insert

	-- Create new table to use in IF...ELSE statement
	CREATE TABLE #I_ProductSalesDelivery_delta_insert
	WITH
	(
		DISTRIBUTION = ROUND_ROBIN,
		HEAP
	)
	AS SELECT
		--TODO change separator to broken pipe: ¦
		 CONCAT_WS('_',psd_d.[Product], [ProductSalesOrg], [ProductDistributionChnl]) AS nk_ProductSalesDelivery
		,psd_d.[Product] AS ProductID
		,psd_d.[ProductSalesOrg] AS [SalesOrganizationID]
		,psd_d.[ProductDistributionChnl] AS [DistributionChannelID]
		,pt.[Product]
		,st.[SalesOrganization]
		,dt.[DistributionChannel]
		,[MinimumOrderQuantity]
		,[SupplyingPlant]
		,[PriceSpecificationProductGroup]
		,[AccountDetnProductGroup]
		,[DeliveryNoteProcMinDelivQty]
		,psd_d.[ItemCategoryGroup]
		,[DeliveryQuantityUnit]
		,[DeliveryQuantity]
		,[ProductSalesStatus]
		,[ProductSalesStatusValidityDate]
		,[SalesMeasureUnit]
		,psd_d.[IsMarkedForDeletion]
		,psd_d.[ProductHierarchy]
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
		,psd_d.[IsActiveEntity]
		,[ProdExtAssortmentPriority]
		,[BaseUnit]
		,[SubscrpnContrDfltDuration]
		,[SubscrpnContrAltvDuration1]
		,[SubscrpnContrAltvDuration2]
		,[SubscrpnContrDurationUnit]
		,[SubscrpnContrDfltExtnDurn]
		,[SubscrpnContrAltvExtnDurn1]
		,[SubscrpnContrAltvExtnDurn2]
		,[SubscrpnContrExtnDurnUnit]
	    ,@t_applicationId as t_applicationId
		,@t_jobId AS t_jobId
		,@t_jobDtm AS t_jobDtm
		,[ChangeMode] AS t_lastActionCd
		,@t_jobBy AS t_jobBy
	FROM [base_s4h_cax].[I_ProductSalesDelivery_delta] AS psd_d
	LEFT JOIN
		[base_s4h_cax].[I_ProductText] AS pt
		ON 
			psd_d.Product = pt.Product
			AND
			pt.[Language] = 'E'
	LEFT JOIN
		[base_s4h_cax].[I_SalesOrganizationText] AS st
		ON 
			psd_d.[ProductSalesOrg] = st.[SalesOrganization]
			AND
			st.[Language] = 'E'
	LEFT JOIN
		[base_s4h_cax].[I_DistributionChannelText] AS dt
		ON 
			psd_d.[ProductDistributionChnl] = dt.[DistributionChannel]
			AND
			dt.[Language] = 'E'
	WHERE 
		[ChangeMode] = 'I'
		AND 
		psd_d.[TransactionSequenceNumber] = @transaction_sequence_number

	BEGIN TRY

		-- Manually check if the natural key of the records to be inserted already exists, violating the unique key constraint
		IF EXISTS (
			
			SELECT 
				 edw.nk_ProductSalesDelivery
				,#I_ProductSalesDelivery_delta_insert.nk_ProductSalesDelivery
			FROM
				[edw].[dim_ProductSalesDelivery] edw
			INNER JOIN 
				#I_ProductSalesDelivery_delta_insert
				ON
					edw.nk_ProductSalesDelivery = #I_ProductSalesDelivery_delta_insert.nk_ProductSalesDelivery
		)

		BEGIN 
			THROW 50000, 'Violation of PRIMARY KEY constraint ''[PK_dim_ProductSalesDelivery_sk_ProductSalesDelivery]''. Cannot insert duplicate key in object ''[edw].[dim_ProductSalesDelivery]'' .', 1;
		END
		ELSE 
		BEGIN
			
			-- Insert records
			INSERT INTO [edw].[dim_ProductSalesDelivery] (
				  [nk_ProductSalesDelivery]
				, [ProductID]
				, [SalesOrganizationID]
				, [DistributionChannelID]
				, [Product]
				, [SalesOrganization]
				, [DistributionChannel]
				, [MinimumOrderQuantity]
				, [SupplyingPlant]
				, [PriceSpecificationProductGroup]
				, [AccountDetnProductGroup]
				, [DeliveryNoteProcMinDelivQty]
				, [ItemCategoryGroup]
				, [DeliveryQuantityUnit]
				, [DeliveryQuantity]
				, [ProductSalesStatus]
				, [ProductSalesStatusValidityDate]
				, [SalesMeasureUnit]
				, [IsMarkedForDeletion]
				, [ProductHierarchy]
				, [FirstSalesSpecProductGroup]
				, [SecondSalesSpecProductGroup]
				, [ThirdSalesSpecProductGroup]
				, [FourthSalesSpecProductGroup]
				, [FifthSalesSpecProductGroup]
				, [MinimumMakeToOrderOrderQty]
				, [LogisticsStatisticsGroup]
				, [VolumeRebateGroup]
				, [ProductCommissionGroup]
				, [CashDiscountIsDeductible]
				, [PricingReferenceProduct]
				, [AssortmentGrade]
				, [StoreListingProcedure]
				, [DistrCntrListingProcedure]
				, [StoreListingStartDate]
				, [StoreListingEndDate]
				, [DistrCntrListingStartDate]
				, [DistrCntrListingEndDate]
				, [StoreSaleStartDate]
				, [StoreSaleEndDate]
				, [DistrCntrSaleStartDate]
				, [DistrCntrSaleEndDate]
				, [RoundingProfile]
				, [ProductUnitGroup]
				, [MaxDeliveryQtyStoreOrder]
				, [PriceFixingCategory]
				, [VariableSalesUnitIsNotAllowed]
				, [CompetitionPressureCategory]
				, [ProductHasAttributeID01]
				, [ProductHasAttributeID02]
				, [ProductHasAttributeID03]
				, [ProductHasAttributeID04]
				, [ProductHasAttributeID05]
				, [ProductHasAttributeID06]
				, [ProductHasAttributeID07]
				, [ProductHasAttributeID08]
				, [ProductHasAttributeID09]
				, [ProductHasAttributeID10]
				, [IsActiveEntity]
				, [ProdExtAssortmentPriority]
				--, [BaseUnit]
				, [SubscrpnContrDfltDuration]
				, [SubscrpnContrAltvDuration1]
				, [SubscrpnContrAltvDuration2]
				, [SubscrpnContrDurationUnit]
				, [SubscrpnContrDfltExtnDurn]
				, [SubscrpnContrAltvExtnDurn1]
				, [SubscrpnContrAltvExtnDurn2]
				, [SubscrpnContrExtnDurnUnit]
				, [t_applicationId]
				, [t_jobId]
				, [t_jobDtm]
				, [t_lastActionCd]
				, [t_jobBy]			
			)
			SELECT 
				  [nk_ProductSalesDelivery]
				, [ProductID]
				, [SalesOrganizationID]
				, [DistributionChannelID]
				, [Product]
				, [SalesOrganization]
				, [DistributionChannel]
				, [MinimumOrderQuantity]
				, [SupplyingPlant]
				, [PriceSpecificationProductGroup]
				, [AccountDetnProductGroup]
				, [DeliveryNoteProcMinDelivQty]
				, [ItemCategoryGroup]
				, [DeliveryQuantityUnit]
				, [DeliveryQuantity]
				, [ProductSalesStatus]
				, [ProductSalesStatusValidityDate]
				, [SalesMeasureUnit]
				, [IsMarkedForDeletion]
				, [ProductHierarchy]
				, [FirstSalesSpecProductGroup]
				, [SecondSalesSpecProductGroup]
				, [ThirdSalesSpecProductGroup]
				, [FourthSalesSpecProductGroup]
				, [FifthSalesSpecProductGroup]
				, [MinimumMakeToOrderOrderQty]
				, [LogisticsStatisticsGroup]
				, [VolumeRebateGroup]
				, [ProductCommissionGroup]
				, [CashDiscountIsDeductible]
				, [PricingReferenceProduct]
				, [AssortmentGrade]
				, [StoreListingProcedure]
				, [DistrCntrListingProcedure]
				, [StoreListingStartDate]
				, [StoreListingEndDate]
				, [DistrCntrListingStartDate]
				, [DistrCntrListingEndDate]
				, [StoreSaleStartDate]
				, [StoreSaleEndDate]
				, [DistrCntrSaleStartDate]
				, [DistrCntrSaleEndDate]
				, [RoundingProfile]
				, [ProductUnitGroup]
				, [MaxDeliveryQtyStoreOrder]
				, [PriceFixingCategory]
				, [VariableSalesUnitIsNotAllowed]
				, [CompetitionPressureCategory]
				, [ProductHasAttributeID01]
				, [ProductHasAttributeID02]
				, [ProductHasAttributeID03]
				, [ProductHasAttributeID04]
				, [ProductHasAttributeID05]
				, [ProductHasAttributeID06]
				, [ProductHasAttributeID07]
				, [ProductHasAttributeID08]
				, [ProductHasAttributeID09]
				, [ProductHasAttributeID10]
				, [IsActiveEntity]
				, [ProdExtAssortmentPriority]
				--, [BaseUnit]
				, [SubscrpnContrDfltDuration]
				, [SubscrpnContrAltvDuration1]
				, [SubscrpnContrAltvDuration2]
				, [SubscrpnContrDurationUnit]
				, [SubscrpnContrDfltExtnDurn]
				, [SubscrpnContrAltvExtnDurn1]
				, [SubscrpnContrAltvExtnDurn2]
				, [SubscrpnContrExtnDurnUnit]
			    , [t_applicationId]
				, [t_jobId]
				, [t_jobDtm]
				, [t_lastActionCd]
				, [t_jobBy]
			FROM 
				#I_ProductSalesDelivery_delta_insert

			--TODO add logging after succesfull insertion

			-- Delete records
			DELETE 
				psd
			FROM 
				[edw].[dim_ProductSalesDelivery] AS psd
			INNER JOIN 
				[base_s4h_cax].[I_ProductSalesDelivery_delta] AS psd_d
				ON 
					psd.[ProductID] = psd_d.[Product]
				AND 
					psd.[SalesOrganizationID] = psd_d.[ProductSalesOrg]
				AND 
					psd.[DistributionChannelID] = psd_d.[ProductDistributionChnl]
			WHERE 
				psd_d.ChangeMode = 'D'
				AND 
				psd_d.[TransactionSequenceNumber] = @transaction_sequence_number;

			--TODO add logging after succesfull deletion

			-- Update records
			UPDATE 
				psd
			SET 
				 psd.[MinimumOrderQuantity] = psd_d.[MinimumOrderQuantity]
				,psd.[SupplyingPlant] = psd_d.[SupplyingPlant]
				,psd.[PriceSpecificationProductGroup]	= psd_d.[PriceSpecificationProductGroup]
				,psd.[AccountDetnProductGroup]			= psd_d.[AccountDetnProductGroup]
				,psd.[DeliveryNoteProcMinDelivQty]		= psd_d.[DeliveryNoteProcMinDelivQty]
				,psd.[ItemCategoryGroup]				= psd_d.[ItemCategoryGroup]
				,psd.[DeliveryQuantityUnit]				= psd_d.[DeliveryQuantityUnit]
				,psd.[DeliveryQuantity]					= psd_d.[DeliveryQuantity]
				,psd.[ProductSalesStatus]				= psd_d.[ProductSalesStatus]
				,psd.[ProductSalesStatusValidityDate]	= psd_d.[ProductSalesStatusValidityDate]
				,psd.[SalesMeasureUnit] = psd_d.[SalesMeasureUnit]
				,psd.[IsMarkedForDeletion] = psd_d.[IsMarkedForDeletion]
				,psd.[ProductHierarchy] = psd_d.[ProductHierarchy]
				,psd.[FirstSalesSpecProductGroup] = psd_d.[FirstSalesSpecProductGroup]
				,psd.[SecondSalesSpecProductGroup] = psd_d.[SecondSalesSpecProductGroup]
				,psd.[ThirdSalesSpecProductGroup] = psd_d.[ThirdSalesSpecProductGroup]
				,psd.[FourthSalesSpecProductGroup] = psd_d.[FourthSalesSpecProductGroup]
				,psd.[FifthSalesSpecProductGroup] = psd_d.[FifthSalesSpecProductGroup]
				,psd.[MinimumMakeToOrderOrderQty] = psd_d.[MinimumMakeToOrderOrderQty]
				,psd.[LogisticsStatisticsGroup] = psd_d.[LogisticsStatisticsGroup]
				,psd.[VolumeRebateGroup] = psd_d.[VolumeRebateGroup]
				,psd.[ProductCommissionGroup] = psd_d.[ProductCommissionGroup]
				,psd.[CashDiscountIsDeductible] = psd_d.[CashDiscountIsDeductible]
				,psd.[PricingReferenceProduct] = psd_d.[PricingReferenceProduct]
				,psd.[AssortmentGrade] = psd_d.[AssortmentGrade]
				,psd.[StoreListingProcedure] = psd_d.[StoreListingProcedure]
				,psd.[DistrCntrListingProcedure] = psd_d.[DistrCntrListingProcedure]
				,psd.[StoreListingStartDate] = psd_d.[StoreListingStartDate]
				,psd.[StoreListingEndDate] = psd_d.[StoreListingEndDate]
				,psd.[DistrCntrListingStartDate] = psd_d.[DistrCntrListingStartDate]
				,psd.[DistrCntrListingEndDate] = psd_d.[DistrCntrListingEndDate]
				,psd.[StoreSaleStartDate] = psd_d.[StoreSaleStartDate]
				,psd.[StoreSaleEndDate] = psd_d.[StoreSaleEndDate]
				,psd.[DistrCntrSaleStartDate] = psd_d.[DistrCntrSaleStartDate]
				,psd.[DistrCntrSaleEndDate] = psd_d.[DistrCntrSaleEndDate]
				,psd.[RoundingProfile] = psd_d.[RoundingProfile]
				,psd.[ProductUnitGroup] = psd_d.[ProductUnitGroup]
				,psd.[MaxDeliveryQtyStoreOrder] = psd_d.[MaxDeliveryQtyStoreOrder]
				,psd.[PriceFixingCategory] = psd_d.[PriceFixingCategory]
				,psd.[VariableSalesUnitIsNotAllowed] = psd_d.[VariableSalesUnitIsNotAllowed]
				,psd.[CompetitionPressureCategory] = psd_d.[CompetitionPressureCategory]
				,psd.[ProductHasAttributeID01] = psd_d.[ProductHasAttributeID01]
				,psd.[ProductHasAttributeID02] = psd_d.[ProductHasAttributeID02]
				,psd.[ProductHasAttributeID03] = psd_d.[ProductHasAttributeID03]
				,psd.[ProductHasAttributeID04] = psd_d.[ProductHasAttributeID04]
				,psd.[ProductHasAttributeID05] = psd_d.[ProductHasAttributeID05]
				,psd.[ProductHasAttributeID06] = psd_d.[ProductHasAttributeID06]
				,psd.[ProductHasAttributeID07] = psd_d.[ProductHasAttributeID07]
				,psd.[ProductHasAttributeID08] = psd_d.[ProductHasAttributeID08]
				,psd.[ProductHasAttributeID09] = psd_d.[ProductHasAttributeID09]
				,psd.[ProductHasAttributeID10] = psd_d.[ProductHasAttributeID10]
				,psd.[IsActiveEntity] = psd_d.[IsActiveEntity]
				,psd.[ProdExtAssortmentPriority] = psd_d.[ProdExtAssortmentPriority]
				--,psd.[BaseUnit] = psd_d.[BaseUnit]
				,psd.[SubscrpnContrDfltDuration] = psd_d.[SubscrpnContrDfltDuration]
				,psd.[SubscrpnContrAltvDuration1] = psd_d.[SubscrpnContrAltvDuration1]
				,psd.[SubscrpnContrAltvDuration2] = psd_d.[SubscrpnContrAltvDuration2]
				,psd.[SubscrpnContrDurationUnit] = psd_d.[SubscrpnContrDurationUnit]
				,psd.[SubscrpnContrDfltExtnDurn] = psd_d.[SubscrpnContrDfltExtnDurn]
				,psd.[SubscrpnContrAltvExtnDurn1] = psd_d.[SubscrpnContrAltvExtnDurn1]
				,psd.[SubscrpnContrAltvExtnDurn2] = psd_d.[SubscrpnContrAltvExtnDurn2]
				,psd.[SubscrpnContrExtnDurnUnit] = psd_d.[SubscrpnContrExtnDurnUnit]
			  	,psd.[t_applicationId] = psd_d.[t_applicationId]
				,psd.[t_jobId] = psd_d.[t_jobId]
				,psd.[t_jobDtm] = psd_d.[t_jobDtm]
				,psd.[t_lastActionCd] = psd_d.[ChangeMode]
				,psd.[t_jobBy] = psd_d.[t_jobBy]
			FROM 
				[edw].[dim_ProductSalesDelivery] AS psd
			JOIN 
				[base_s4h_cax].[I_ProductSalesDelivery_delta] AS psd_d
				ON 
					psd.[ProductID] = psd_d.[Product]
				AND 
					psd.[SalesOrganizationID] = psd_d.[ProductSalesOrg]
				AND 
					psd.[DistributionChannelID] = psd_d.[ProductDistributionChnl]
			WHERE 
				psd_d.ChangeMode = 'U'
				AND 
				psd_d.[TransactionSequenceNumber] = @transaction_sequence_number;

			--TODO add logging after succesfull updating
		END
	END TRY
	BEGIN CATCH
		THROW
	END CATCH

	DROP TABLE #I_ProductSalesDelivery_delta_insert
END