CREATE PROC [base_s4h_uat_caa].[sp_load_OutboundDeliveryItem_base]
	@t_applicationId [varchar](7),
	@t_jobId [varchar](36),
	@t_lastDtm [datetime],
	@t_lastActionBy [nvarchar](20),
	@t_filePath [nvarchar](1024)
AS
BEGIN
	
	TRUNCATE TABLE [base_s4h_uat_caa].[I_OutboundDeliveryItem]

	INSERT INTO [base_s4h_uat_caa].[I_OutboundDeliveryItem](
		[OutboundDelivery]
		,[OutboundDeliveryItem]
		,[DeliveryDocumentItemCategory]
		,[SalesDocumentItemType]
		,[CreatedByUser]
		,[CreationDate]
		,[CreationTime]
		,[LastChangeDate]
		,[DistributionChannel]
		,[Division]
		,[SalesGroup]
		,[SalesOffice]
		,[DepartmentClassificationByCust]
		,[Material]
		,[Product]
		,[MaterialByCustomer]
		,[OriginallyRequestedMaterial]
		,[InternationalArticleNumber]
		,[Batch]
		,[BatchClassification]
		,[BatchBySupplier]
		,[MaterialIsIntBatchManaged]
		,[MaterialIsBatchManaged]
		,[MaterialGroup]
		,[ProductGroup]
		,[MaterialFreightGroup]
		,[AdditionalMaterialGroup1]
		,[AdditionalMaterialGroup2]
		,[AdditionalMaterialGroup3]
		,[AdditionalMaterialGroup4]
		,[AdditionalMaterialGroup5]
		,[Plant]
		,[Warehouse]
		,[StorageLocation]
		,[StorageBin]
		,[StorageType]
		--,[DeliveryItemResourceID] doesn't exist in source file
		,[InventorySpecialStockType]
		,[ShelfLifeExpirationDate]
		,[NumberOfSerialNumbers]
		,[ProductConfiguration]
		,[ProductHierarchyNode]
		,[ManufactureDate]
		--,[TransactionCurrency] doesn't exist in source file
		,[DeliveryDocumentItemText]
		,[HigherLevelItem]
		,[HigherLvlItmOfBatSpltItm]
		,[ActualDeliveryQuantity]
		,[QuantityIsFixed]
		,[OriginalDeliveryQuantity]
		,[DeliveryQuantityUnit]
		,[ActualDeliveredQtyInBaseUnit]
		,[BaseUnit]
		,[DeliveryToBaseQuantityDnmntr]
		,[DeliveryToBaseQuantityNmrtr]
		,[ProductAvailabilityDate]
		,[ProductAvailabilityTime]
		,[DeliveryGroup]
		,[ItemGrossWeight]
		,[ItemNetWeight]
		,[ItemWeightUnit]
		,[ItemVolume]
		,[ItemVolumeUnit]
		,[InspectionLot]
		,[InspectionPartialLot]
		,[PartialDeliveryIsAllowed]
		,[UnlimitedOverdeliveryIsAllowed]
		,[OverdelivTolrtdLmtRatioInPct]
		,[UnderdelivTolrtdLmtRatioInPct]
		,[BOMExplosion]
		,[WarehouseStagingArea]
		,[WarehouseStockCategory]
		,[StockType]
		,[GLAccount]
		,[GoodsMovementReasonCode]
		,[SubsequentMovementType]
		,[IsCompletelyDelivered]
		,[IsNotGoodsMovementsRelevant]
		,[PickingControl]
		,[LoadingGroup]
		,[GoodsMovementType]
		--,[LoadingPointForDelivery] doesn't exist in source file
		,[TransportationGroup]
		,[ReceivingPoint]
		,[FixedShipgProcgDurationInDays]
		,[VarblShipgProcgDurationInDays]
		,[ProofOfDeliveryRelevanceCode]
		,[ItemIsBillingRelevant]
		,[ItemBillingBlockReason]
		,[BusinessArea]
		,[ControllingArea]
		,[ProfitabilitySegment]
		,[ProfitCenter]
		,[InventoryValuationType]
		,[IsSeparateValuation]
		,[ConsumptionPosting]
		,[OrderID]
		,[OrderItem]
		,[CostCenter]
		,[ReferenceSDDocument]
		,[ReferenceSDDocumentItem]
		,[ReferenceSDDocumentCategory]
		,[ReferenceDocumentLogicalSystem]
		,[AdditionalCustomerGroup1]
		,[AdditionalCustomerGroup2]
		,[AdditionalCustomerGroup3]
		,[AdditionalCustomerGroup4]
		,[AdditionalCustomerGroup5]
		,[RetailPromotion]
		,[SDProcessStatus]
		,[PickingConfirmationStatus]
		,[PickingStatus]
		,[WarehouseActivityStatus]
		,[PackingStatus]
		,[GoodsMovementStatus]
		,[DeliveryRelatedBillingStatus]
		,[ProofOfDeliveryStatus]
		,[ItemGeneralIncompletionStatus]
		,[ItemDeliveryIncompletionStatus]
		,[ItemPickingIncompletionStatus]
		,[ItemGdsMvtIncompletionSts]
		,[ItemPackingIncompletionStatus]
		,[ItemBillingIncompletionStatus]
		,[IntercompanyBillingStatus]
		,[ChmlCmplncStatus]
		,[DangerousGoodsStatus]
		,[SafetyDataSheetStatus]
		,[RequirementSegment]
		,[StockSegment]
		,[ProductSeasonYear]
		,[ProductSeason]
		,[ProductCollection]
		,[ProductTheme]
		,[ProductCharacteristic1]
		,[ProductCharacteristic2]
		,[ProductCharacteristic3]
		,[OriginSDDocument]
		,[SDDocumentItem]
		,[SalesSDDocumentCategory]
		,[MaterialTypePrimary]
		,[CostInDocumentCurrency]
		,[Subtotal1Amount]
		,[Subtotal2Amount]
		,[Subtotal3Amount]
		,[Subtotal4Amount]
		,[Subtotal5Amount]
		,[Subtotal6Amount]
		,[OrderDocument]
		,[PlanningMaterial]
		,[PlanningPlant]
		,[ProductGroupBaseUnit]
		,[ConversionFactor]
		,[IsReturnsItem]
		,[ConditionUnit]
		,[NetPriceAmount]
		,[TotalNetAmount]
		,[QtyInPurchaseOrderPriceUnit]
		,[CreditRelatedPrice]
		--,[CreditRelatedPriceAmount] doesn't exist in source file
		,[DeliveryToBaseUnitCnvrsnFctr]
		,[FunctionalArea]
		,[Reservation]
		,[ReservationItem]
		--,[EU_DeliveryItemARCStatus] doesn't exist in source file
		,[t_applicationId]
		,[t_jobId]
		,[t_lastDtm]
		,[t_lastActionBy]
		,[t_filePath]
	)
	SELECT
		[OutboundDelivery]
		,CONVERT([char](6), [OutboundDeliveryItem]) AS [OutboundDeliveryItem]
		,[DeliveryDocumentItemCategory]
		,[SalesDocumentItemType]
		,[CreatedByUser]
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
		,[DistributionChannel]
		,[Division]
		,[SalesGroup]
		,[SalesOffice]
		,[DepartmentClassificationByCust]
		,[Material]
		,[Product]
		,[MaterialByCustomer]
		,[OriginallyRequestedMaterial]
		,[InternationalArticleNumber]
		,[Batch]
		,CONVERT([char](18), [BatchClassification]) AS [BatchClassification]
		,[BatchBySupplier]
		,[MaterialIsIntBatchManaged]
		,[MaterialIsBatchManaged]
		,[MaterialGroup]
		,[ProductGroup]
		,[MaterialFreightGroup]
		,[AdditionalMaterialGroup1]
		,[AdditionalMaterialGroup2]
		,[AdditionalMaterialGroup3]
		,[AdditionalMaterialGroup4]
		,[AdditionalMaterialGroup5]
		,[Plant]
		,[Warehouse]
		,[StorageLocation]
		,[StorageBin]
		,[StorageType]
		,[InventorySpecialStockType]
		,CASE [ShelfLifeExpirationDate]
			WHEN '00000000' THEN '19000101' 
			ELSE CONVERT([date], [ShelfLifeExpirationDate], 112) 
		 END AS [ShelfLifeExpirationDate]
		,CONVERT([int], [NumberOfSerialNumbers]) AS [NumberOfSerialNumbers]
		,CONVERT([char](18), [ProductConfiguration]) AS [ProductConfiguration]
		,[ProductHierarchyNode]
		,CASE [ManufactureDate]
			WHEN '00000000' THEN '19000101' 
			ELSE CONVERT([date], [ManufactureDate], 112) 
		 END AS [ManufactureDate]
		,[DeliveryDocumentItemText]
		,CONVERT([char](6), [HigherLevelItem]) AS [HigherLevelItem]
		,CONVERT([char](6), [HigherLvlItmOfBatSpltItm]) AS [HigherLvlItmOfBatSpltItm]
		,CONVERT([decimal](13,3), CASE 
									WHEN RIGHT(RTRIM([ActualDeliveryQuantity]), 1) = '-'
									THEN '-' + REPLACE([ActualDeliveryQuantity], '-','')
									ELSE [ActualDeliveryQuantity]
								  END) AS [ActualDeliveryQuantity]
		,[QuantityIsFixed]
		,CONVERT([decimal](13,3), CASE 
									WHEN RIGHT(RTRIM([OriginalDeliveryQuantity]), 1) = '-'
									THEN '-' + REPLACE([OriginalDeliveryQuantity], '-','')
									ELSE [OriginalDeliveryQuantity]
								  END) AS [OriginalDeliveryQuantity]
		,[DeliveryQuantityUnit]
		,CONVERT([decimal](13,3), CASE 
									WHEN RIGHT(RTRIM([ActualDeliveredQtyInBaseUnit]), 1) = '-'
									THEN '-' + REPLACE([ActualDeliveredQtyInBaseUnit], '-','')
									ELSE [ActualDeliveredQtyInBaseUnit]
								  END) AS [ActualDeliveredQtyInBaseUnit]
		,[BaseUnit]
		,CONVERT([decimal](5), CASE 
									WHEN RIGHT(RTRIM([DeliveryToBaseQuantityDnmntr]), 1) = '-'
									THEN '-' + REPLACE([DeliveryToBaseQuantityDnmntr], '-','')
									ELSE [DeliveryToBaseQuantityDnmntr]
								  END) AS [DeliveryToBaseQuantityDnmntr]
		,CONVERT([decimal](5), CASE 
									WHEN RIGHT(RTRIM([DeliveryToBaseQuantityNmrtr]), 1) = '-'
									THEN '-' + REPLACE([DeliveryToBaseQuantityNmrtr], '-','')
									ELSE [DeliveryToBaseQuantityNmrtr]
								  END) AS [DeliveryToBaseQuantityNmrtr]
		,CASE [ProductAvailabilityDate]
			WHEN '00000000' THEN '19000101' 
			ELSE CONVERT([date], [ProductAvailabilityDate], 112) 
		 END AS [ProductAvailabilityDate]
		,CASE LEN([ProductAvailabilityTime])
			WHEN 6 THEN CONVERT([time](0), LEFT([ProductAvailabilityTime], 2)+':'+SUBSTRING([ProductAvailabilityTime],3,2)+':'+SUBSTRING([ProductAvailabilityTime],5,2))
			WHEN 5 THEN CONVERT([time](0), LEFT([ProductAvailabilityTime], 1)+':'+SUBSTRING([ProductAvailabilityTime],2,2)+':'+SUBSTRING([ProductAvailabilityTime],4,2))
		 END AS [ProductAvailabilityTime]
		,CONVERT([char](3), [DeliveryGroup]) AS [DeliveryGroup]
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
		,CONVERT([char](12), [InspectionLot]) AS [InspectionLot]
		,CONVERT([char](6), [InspectionPartialLot]) AS [InspectionPartialLot]
		,[PartialDeliveryIsAllowed]
		,[UnlimitedOverdeliveryIsAllowed]
		,CONVERT([decimal](3,1), CASE 
									WHEN RIGHT(RTRIM([OverdelivTolrtdLmtRatioInPct]), 1) = '-'
									THEN '-' + REPLACE([OverdelivTolrtdLmtRatioInPct], '-','')
									ELSE [OverdelivTolrtdLmtRatioInPct]
								  END) AS [OverdelivTolrtdLmtRatioInPct]
		,CONVERT([decimal](3,1), CASE 
									WHEN RIGHT(RTRIM([UnderdelivTolrtdLmtRatioInPct]), 1) = '-'
									THEN '-' + REPLACE([UnderdelivTolrtdLmtRatioInPct], '-','')
									ELSE [UnderdelivTolrtdLmtRatioInPct]
								  END) AS [UnderdelivTolrtdLmtRatioInPct]
		,[BOMExplosion]
		,[WarehouseStagingArea]
		,[WarehouseStockCategory]
		,[StockType]
		,[GLAccount]
		,CONVERT([char](4), [GoodsMovementReasonCode]) AS [GoodsMovementReasonCode]
		,[SubsequentMovementType]
		,[IsCompletelyDelivered]
		,[IsNotGoodsMovementsRelevant]
		,[PickingControl]
		,[LoadingGroup]
		,[GoodsMovementType]
		,[TransportationGroup]
		,[ReceivingPoint]
		,CONVERT([decimal](5,2), CASE 
									WHEN RIGHT(RTRIM([FixedShipgProcgDurationInDays]), 1) = '-'
									THEN '-' + REPLACE([FixedShipgProcgDurationInDays], '-','')
									ELSE [FixedShipgProcgDurationInDays]
								  END) AS [FixedShipgProcgDurationInDays]
		,CONVERT([decimal](5,2), CASE 
									WHEN RIGHT(RTRIM([VarblShipgProcgDurationInDays]), 1) = '-'
									THEN '-' + REPLACE([VarblShipgProcgDurationInDays], '-','')
									ELSE [VarblShipgProcgDurationInDays]
								  END) AS [VarblShipgProcgDurationInDays]
		,[ProofOfDeliveryRelevanceCode]
		,[ItemIsBillingRelevant]
		,[ItemBillingBlockReason]
		,[BusinessArea]
		,[ControllingArea]
		,CONVERT([char](10), [ProfitabilitySegment]) AS [ProfitabilitySegment]
		,[ProfitCenter]
		,[InventoryValuationType]
		,[IsSeparateValuation]
		,[ConsumptionPosting]
		,[OrderID]
		,CONVERT([char](4), [OrderItem]) AS [OrderItem]
		,[CostCenter]
		,[ReferenceSDDocument]
		,CONVERT([char](6), [ReferenceSDDocumentItem]) AS [ReferenceSDDocumentItem]
		,[ReferenceSDDocumentCategory]
		,[ReferenceDocumentLogicalSystem]
		,[AdditionalCustomerGroup1]
		,[AdditionalCustomerGroup2]
		,[AdditionalCustomerGroup3]
		,[AdditionalCustomerGroup4]
		,[AdditionalCustomerGroup5]
		,[RetailPromotion]
		,[SDProcessStatus]
		,[PickingConfirmationStatus]
		,[PickingStatus]
		,[WarehouseActivityStatus]
		,[PackingStatus]
		,[GoodsMovementStatus]
		,[DeliveryRelatedBillingStatus]
		,[ProofOfDeliveryStatus]
		,[ItemGeneralIncompletionStatus]
		,[ItemDeliveryIncompletionStatus]
		,[ItemPickingIncompletionStatus]
		,[ItemGdsMvtIncompletionSts]
		,[ItemPackingIncompletionStatus]
		,[ItemBillingIncompletionStatus]
		,[IntercompanyBillingStatus]
		,[ChmlCmplncStatus]
		,[DangerousGoodsStatus]
		,[SafetyDataSheetStatus]
		,[RequirementSegment]
		,[StockSegment]
		,[ProductSeasonYear]
		,[ProductSeason]
		,[ProductCollection]
		,[ProductTheme]
		,[ProductCharacteristic1]
		,[ProductCharacteristic2]
		,[ProductCharacteristic3]
		,[OriginSDDocument]
		,CONVERT([char](6), [SDDocumentItem]) AS [SDDocumentItem]
		,[SalesSDDocumentCategory]
		,[MaterialTypePrimary]
		,CONVERT([decimal](13,2), CASE 
									WHEN RIGHT(RTRIM([CostInDocumentCurrency]), 1) = '-'
									THEN '-' + REPLACE([CostInDocumentCurrency], '-','')
									ELSE [CostInDocumentCurrency]
								  END) AS [CostInDocumentCurrency]
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
		,[OrderDocument]
		,[PlanningMaterial]
		,[PlanningPlant]
		,[ProductGroupBaseUnit]
		,CONVERT([float], [ConversionFactor]) AS [ConversionFactor]
		,[IsReturnsItem]
		,[ConditionUnit]
		,CONVERT([decimal](11,2), CASE 
									WHEN RIGHT(RTRIM([NetPriceAmount]), 1) = '-'
									THEN '-' + REPLACE([NetPriceAmount], '-','')
									ELSE [NetPriceAmount]
								  END) AS [NetPriceAmount]
		,CONVERT([decimal](15,2), CASE 
									WHEN RIGHT(RTRIM([TotalNetAmount]), 1) = '-'
									THEN '-' + REPLACE([TotalNetAmount], '-','')
									ELSE [TotalNetAmount]
								  END) AS [TotalNetAmount]
		,CONVERT([decimal](13,3), CASE 
									WHEN RIGHT(RTRIM([QtyInPurchaseOrderPriceUnit]), 1) = '-'
									THEN '-' + REPLACE([QtyInPurchaseOrderPriceUnit], '-','')
									ELSE [QtyInPurchaseOrderPriceUnit]
								  END) AS [QtyInPurchaseOrderPriceUnit]
		,CONVERT([float], [CreditRelatedPrice]) AS [CreditRelatedPrice]
		,CONVERT([float], [DeliveryToBaseUnitCnvrsnFctr]) AS [DeliveryToBaseUnitCnvrsnFctr]
		,[FunctionalArea]
		,CONVERT([char](10), [Reservation]) AS [Reservation]
		,CONVERT([char](4), [ReservationItem]) AS [ReservationItem]
		,@t_applicationId AS t_applicationId
		,@t_jobId AS t_jobId
		,@t_lastDtm AS t_lastDtm
		,@t_lastActionBy AS t_lastActionBy
		,@t_filePath AS t_filePath
	FROM [base_s4h_uat_caa].[I_OutboundDeliveryItem_staging]
END
