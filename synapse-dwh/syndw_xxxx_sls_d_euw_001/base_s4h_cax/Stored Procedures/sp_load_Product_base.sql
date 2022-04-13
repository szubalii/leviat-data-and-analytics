CREATE PROC [base_s4h_uat_caa].[sp_load_Product_base]
	@t_applicationId [varchar](7),
	@t_jobId [varchar](36),
	@t_lastDtm [datetime],
	@t_lastActionBy [nvarchar](20),
	@t_filePath [nvarchar](1024)
AS
BEGIN
	
	TRUNCATE TABLE [base_s4h_uat_caa].[I_Product]

	INSERT INTO [base_s4h_uat_caa].[I_Product](
		[Product]
		,[ProductExternalID]
		,[ProductType]
		,[CreationDate]
		,[CreationTime]
		,[CreationDateTime]
		,[CreatedByUser]
		,[LastChangeDate]
		,[LastChangedByUser]
		,[IsMarkedForDeletion]
		,[CrossPlantStatus]
		,[CrossPlantStatusValidityDate]
		,[ProductOldID]
		,[GrossWeight]
		,[PurchaseOrderQuantityUnit]
		,[SourceOfSupply]
		,[WeightUnit]
		,[CountryOfOrigin]
		,[CompetitorID]
		,[ProductGroup]
		,[BaseUnit]
		,[ItemCategoryGroup]
		,[NetWeight]
		,[ProductHierarchy]
		,[Division]
		,[VarblPurOrdUnitIsActive]
		,[VolumeUnit]
		,[MaterialVolume]
		,[SalesStatus]
		,[TransportationGroup]
		,[SalesStatusValidityDate]
		,[AuthorizationGroup]
		,[ANPCode]
		,[ProductCategory]
		,[Brand]
		,[ProcurementRule]
		,[ValidityStartDate]
		,[LowLevelCode]
		,[ProdNoInGenProdInPrepackProd]
		,[SerialIdentifierAssgmtProfile]
		,[SizeOrDimensionText]
		,[IndustryStandardName]
		,[ProductStandardID]
		,[InternationalArticleNumberCat]
		,[ProductIsConfigurable]
		,[IsBatchManagementRequired]
		,[HasEmptiesBOM]
		,[ExternalProductGroup]
		,[CrossPlantConfigurableProduct]
		,[SerialNoExplicitnessLevel]
		,[ProductManufacturerNumber]
		,[ManufacturerNumber]
		,[ManufacturerPartProfile]
		,[QltyMgmtInProcmtIsActive]
		,[IsApprovedBatchRecordReqd]
		,[HandlingIndicator]
		,[WarehouseProductGroup]
		,[WarehouseStorageCondition]
		,[StandardHandlingUnitType]
		,[SerialNumberProfile]
		,[AdjustmentProfile]
		,[PreferredUnitOfMeasure]
		,[IsPilferable]
		,[IsRelevantForHzdsSubstances]
		,[QuarantinePeriod]
		,[TimeUnitForQuarantinePeriod]
		,[QualityInspectionGroup]
		,[HandlingUnitType]
		,[HasVariableTareWeight]
		,[MaximumPackagingLength]
		,[MaximumPackagingWidth]
		,[MaximumPackagingHeight]
		,[MaximumCapacity]
		,[OvercapacityTolerance]
		,[UnitForMaxPackagingDimensions]
		,[BaseUnitSpecificProductLength]
		,[BaseUnitSpecificProductWidth]
		,[BaseUnitSpecificProductHeight]
		,[ProductMeasurementUnit]
		,[ProductValidStartDate]
		,[ArticleCategory]
		,[ContentUnit]
		,[NetContent]
		,[ComparisonPriceQuantity]
		,[GrossContent]
		,[ProductValidEndDate]
		,[AssortmentListType]
		,[HasTextilePartsWthAnimalOrigin]
		,[ProductSeasonUsageCategory]
		,[IndustrySector]
		,[ChangeNumber]
		,[MaterialRevisionLevel]
		,[IsActiveEntity]
		,[LastChangeDateTime]
		,[LastChangeTime]
		,[DangerousGoodsIndProfile]
		,[ProductUUID]
		,[ProdSupChnMgmtUUID22]
		,[ProductDocumentChangeNumber]
		,[ProductDocumentPageCount]
		,[ProductDocumentPageNumber]
		,[OwnInventoryManagedProduct]
		,[DocumentIsCreatedByCAD]
		,[ProductionOrInspectionMemoTxt]
		,[ProductionMemoPageFormat]
		,[GlobalTradeItemNumberVariant]
		,[ProductIsHighlyViscous]
		,[TransportIsInBulk]
		,[ProdAllocDetnProcedure]
		,[ProdEffctyParamValsAreAssigned]
		,[ProdIsEnvironmentallyRelevant]
		,[LaboratoryOrDesignOffice]
		,[PackagingMaterialGroup]
		,[ProductIsLocked]
		,[DiscountInKindEligibility]
		,[SmartFormName]
		,[PackingReferenceProduct]
		,[BasicMaterial]
		,[ProductDocumentNumber]
		,[ProductDocumentVersion]
		,[ProductDocumentType]
		,[ProductDocumentPageFormat]
		,[ProductConfiguration]
		,[SegmentationStrategy]
		,[SegmentationIsRelevant]
		,[IsChemicalComplianceRelevant]
		,[LogisticalProductCategory]
		,[SalesProduct]
		,[DfsRICIdentifier]
		/* don't exist in source file
		,[ProdCharc1InternalNumber]
		,[ProdCharc2InternalNumber]
		,[ProdCharc3InternalNumber]
		,[ProductCharacteristic1]
		,[ProductCharacteristic2]
		,[ProductCharacteristic3]
		,[DfsAmmunitionGroupCode]
		,[DfsProductSensitivity]
		,[DfsManufacturerPartLongNumber]
		,[DfsMatlConditionMgmt]
		,[DfsReturnDelivery]
		,[DfsLogisticsLevel]
		,[DfsNationalItemIdnNumber]
		,[ZZ1_CustomFieldRiskMit_PRD]
		,[ZZ1_CustomFieldHighRis_PRD]
		,[ZZ1_CustomFieldRiskRea_PRD]
		*/
		,[t_applicationId]
		,[t_jobId]
		,[t_lastDtm]
		,[t_lastActionBy]
		,[t_filePath]
	)
	SELECT 	
		[Product]
		,[ProductExternalID]
		,[ProductType]
		,CASE [CreationDate]
			WHEN '00000000' THEN '19000101' 
			ELSE CONVERT([date], [CreationDate], 112) 
		 END AS [CreationDate]
		,CASE LEN([CreationTime])
			WHEN 6 THEN CONVERT([time](0), LEFT([CreationTime], 2)+':'+SUBSTRING([CreationTime],3,2)+':'+SUBSTRING([CreationTime],5,2))
			WHEN 5 THEN CONVERT([time](0), LEFT([CreationTime], 1)+':'+SUBSTRING([CreationTime],2,2)+':'+SUBSTRING([CreationTime],4,2))
		 END AS [CreationTime]
		,CONVERT([decimal](21,7), CASE 
									WHEN RIGHT(RTRIM([CreationDateTime]), 1) = '-'
									THEN '-' + REPLACE([CreationDateTime], '-','')
									ELSE [CreationDateTime]
								  END) AS [CreationDateTime]
		,[CreatedByUser]
		,CASE [LastChangeDate]
			WHEN '00000000' THEN '19000101' 
			ELSE CONVERT([date], [LastChangeDate], 112) 
		 END AS [LastChangeDate]
		,[LastChangedByUser]
		,[IsMarkedForDeletion]
		,[CrossPlantStatus]
		,CASE [CrossPlantStatusValidityDate]
			WHEN '00000000' THEN '19000101' 
			ELSE CONVERT([date], [CrossPlantStatusValidityDate], 112) 
		 END AS [CrossPlantStatusValidityDate]
		,[ProductOldID]
		,CONVERT([decimal](13,3), CASE 
									WHEN RIGHT(RTRIM([GrossWeight]), 1) = '-'
									THEN '-' + REPLACE([GrossWeight], '-','')
									ELSE [GrossWeight]
								  END) AS [GrossWeight]
		,[PurchaseOrderQuantityUnit]
		,[SourceOfSupply]
		,[WeightUnit]
		,[CountryOfOrigin]
		,[CompetitorID]
		,[ProductGroup]
		,[BaseUnit]
		,[ItemCategoryGroup]
		,CONVERT([decimal](13,3), CASE 
									WHEN RIGHT(RTRIM([NetWeight]), 1) = '-'
									THEN '-' + REPLACE([NetWeight], '-','')
									ELSE [NetWeight]
								  END) AS [NetWeight]		
		,[ProductHierarchy]
		,[Division]
		,[VarblPurOrdUnitIsActive]
		,[VolumeUnit]
		,CONVERT([decimal](13,3), CASE 
									WHEN RIGHT(RTRIM([MaterialVolume]), 1) = '-'
									THEN '-' + REPLACE([MaterialVolume], '-','')
									ELSE [MaterialVolume]
								  END) AS [MaterialVolume]
		,[SalesStatus]
		,[TransportationGroup]
		,CASE [SalesStatusValidityDate]
			WHEN '00000000' THEN '19000101' 
			ELSE CONVERT([date], [SalesStatusValidityDate], 112) 
		 END AS [SalesStatusValidityDate]
		,[AuthorizationGroup]
		,CONVERT([char](9), [ANPCode]) AS [ANPCode]
		,[ProductCategory]
		,[Brand]
		,[ProcurementRule]
		,CASE [ValidityStartDate]
			WHEN '00000000' THEN '19000101' 
			ELSE CONVERT([date], [ValidityStartDate], 112) 
		 END AS [ValidityStartDate]
		,[LowLevelCode]
		,[ProdNoInGenProdInPrepackProd]
		,[SerialIdentifierAssgmtProfile]
		,[SizeOrDimensionText]
		,[IndustryStandardName]
		,[ProductStandardID]
		,[InternationalArticleNumberCat]
		,[ProductIsConfigurable]
		,[IsBatchManagementRequired]
		,[HasEmptiesBOM]
		,[ExternalProductGroup]
		,[CrossPlantConfigurableProduct]
		,[SerialNoExplicitnessLevel]
		,[ProductManufacturerNumber]
		,[ManufacturerNumber]
		,[ManufacturerPartProfile]
		,[QltyMgmtInProcmtIsActive]
		,[IsApprovedBatchRecordReqd]
		,[HandlingIndicator]
		,[WarehouseProductGroup]
		,[WarehouseStorageCondition]
		,[StandardHandlingUnitType]
		,[SerialNumberProfile]
		,[AdjustmentProfile]
		,[PreferredUnitOfMeasure]
		,[IsPilferable]
		,[IsRelevantForHzdsSubstances]
		,CONVERT([decimal](3), CASE 
									WHEN RIGHT(RTRIM([QuarantinePeriod]), 1) = '-'
									THEN '-' + REPLACE([QuarantinePeriod], '-','')
									ELSE [QuarantinePeriod]
								  END) AS [QuarantinePeriod]
		,[TimeUnitForQuarantinePeriod]
		,[QualityInspectionGroup]
		,[HandlingUnitType]
		,[HasVariableTareWeight]
		,CONVERT([decimal](15,3), CASE 
									WHEN RIGHT(RTRIM([MaximumPackagingLength]), 1) = '-'
									THEN '-' + REPLACE([MaximumPackagingLength], '-','')
									ELSE [MaximumPackagingLength]
								  END) AS [MaximumPackagingLength]
		,CONVERT([decimal](15,3), CASE 
									WHEN RIGHT(RTRIM([MaximumPackagingWidth]), 1) = '-'
									THEN '-' + REPLACE([MaximumPackagingWidth], '-','')
									ELSE [MaximumPackagingWidth]
								  END) AS [MaximumPackagingWidth]
		,CONVERT([decimal](15,3), CASE 
									WHEN RIGHT(RTRIM([MaximumPackagingHeight]), 1) = '-'
									THEN '-' + REPLACE([MaximumPackagingHeight], '-','')
									ELSE [MaximumPackagingHeight]
								  END) AS [MaximumPackagingHeight]
		,CONVERT([decimal](15,3), CASE 
									WHEN RIGHT(RTRIM([MaximumCapacity]), 1) = '-'
									THEN '-' + REPLACE([MaximumCapacity], '-','')
									ELSE [MaximumCapacity]
								  END) AS [MaximumCapacity]
		,CONVERT([decimal](3,1), CASE 
									WHEN RIGHT(RTRIM([OvercapacityTolerance]), 1) = '-'
									THEN '-' + REPLACE([OvercapacityTolerance], '-','')
									ELSE [OvercapacityTolerance]
								  END) AS [OvercapacityTolerance]
		,[UnitForMaxPackagingDimensions]
		,CONVERT([decimal](13,3), CASE 
									WHEN RIGHT(RTRIM([BaseUnitSpecificProductLength]), 1) = '-'
									THEN '-' + REPLACE([BaseUnitSpecificProductLength], '-','')
									ELSE [BaseUnitSpecificProductLength]
								  END) AS [BaseUnitSpecificProductLength]
		,CONVERT([decimal](13,3), CASE 
									WHEN RIGHT(RTRIM([BaseUnitSpecificProductWidth]), 1) = '-'
									THEN '-' + REPLACE([BaseUnitSpecificProductWidth], '-','')
									ELSE [BaseUnitSpecificProductWidth]
								  END) AS [BaseUnitSpecificProductWidth]
		,CONVERT([decimal](13,3), CASE 
									WHEN RIGHT(RTRIM([BaseUnitSpecificProductHeight]), 1) = '-'
									THEN '-' + REPLACE([BaseUnitSpecificProductHeight], '-','')
									ELSE [BaseUnitSpecificProductHeight]
								  END) AS [BaseUnitSpecificProductHeight]
		,[ProductMeasurementUnit]
		,CASE [ProductValidStartDate]
			WHEN '00000000' THEN '19000101' 
			ELSE CONVERT([date], [ProductValidStartDate], 112) 
		 END AS [ProductValidStartDate]
		,[ArticleCategory]
		,[ContentUnit]
		,CONVERT([decimal](13,3), CASE 
									WHEN RIGHT(RTRIM([NetContent]), 1) = '-'
									THEN '-' + REPLACE([NetContent], '-','')
									ELSE [NetContent]
								  END) AS [NetContent]
		,CONVERT([decimal](5), CASE 
									WHEN RIGHT(RTRIM([ComparisonPriceQuantity]), 1) = '-'
									THEN '-' + REPLACE([ComparisonPriceQuantity], '-','')
									ELSE [ComparisonPriceQuantity]
								  END) AS [ComparisonPriceQuantity]
		,CONVERT([decimal](13,3), CASE 
									WHEN RIGHT(RTRIM([GrossContent]), 1) = '-'
									THEN '-' + REPLACE([GrossContent], '-','')
									ELSE [GrossContent]
								  END) AS [GrossContent]
		,CASE [ProductValidEndDate]
			WHEN '00000000' THEN '19000101' 
			ELSE CONVERT([date], [ProductValidEndDate], 112) 
		 END AS [ProductValidEndDate]
		,[AssortmentListType]
		,[HasTextilePartsWthAnimalOrigin]
		,[ProductSeasonUsageCategory]
		,[IndustrySector]
		,[ChangeNumber]
		,[MaterialRevisionLevel]
		,[IsActiveEntity]
		,CONVERT([decimal](21,7), CASE 
									WHEN RIGHT(RTRIM([LastChangeDateTime]), 1) = '-'
									THEN '-' + REPLACE([LastChangeDateTime], '-','')
									ELSE [LastChangeDateTime]
								  END) AS [LastChangeDateTime]
		,CASE LEN([LastChangeTime])
			WHEN 6 THEN CONVERT([time](0), LEFT([LastChangeTime], 2)+':'+SUBSTRING([LastChangeTime],3,2)+':'+SUBSTRING([LastChangeTime],5,2))
			WHEN 5 THEN CONVERT([time](0), LEFT([LastChangeTime], 1)+':'+SUBSTRING([LastChangeTime],2,2)+':'+SUBSTRING([LastChangeTime],4,2))
		 END AS [LastChangeTime]
		,[DangerousGoodsIndProfile]
		,CONVERT([binary](16), [ProductUUID]) AS [ProductUUID]
		,[ProdSupChnMgmtUUID22]
		,[ProductDocumentChangeNumber]
		,CONVERT([char](3), [ProductDocumentPageCount]) AS [ProductDocumentPageCount]
		,[ProductDocumentPageNumber]
		,[OwnInventoryManagedProduct]
		,[DocumentIsCreatedByCAD]
		,[ProductionOrInspectionMemoTxt]
		,[ProductionMemoPageFormat]
		,[GlobalTradeItemNumberVariant]
		,[ProductIsHighlyViscous]
		,[TransportIsInBulk]
		,[ProdAllocDetnProcedure]
		,[ProdEffctyParamValsAreAssigned]
		,[ProdIsEnvironmentallyRelevant]
		,[LaboratoryOrDesignOffice]
		,[PackagingMaterialGroup]
		,[ProductIsLocked]
		,[DiscountInKindEligibility]
		,[SmartFormName]
		,[PackingReferenceProduct]
		,[BasicMaterial]
		,[ProductDocumentNumber]
		,[ProductDocumentVersion]
		,[ProductDocumentType]
		,[ProductDocumentPageFormat]
		,CONVERT([char](18), [ProductConfiguration]) AS [ProductConfiguration]
		,[SegmentationStrategy]
		,[SegmentationIsRelevant]
		,[IsChemicalComplianceRelevant]
		,[LogisticalProductCategory]
		,[SalesProduct]
		,CONVERT([bigint], [DfsRICIdentifier]) AS [DfsRICIdentifier]
		,@t_applicationId AS t_applicationId
		,@t_jobId AS t_jobId
		,@t_lastDtm AS t_lastDtm
		,@t_lastActionBy AS t_lastActionBy
		,@t_filePath AS t_filePath
	FROM [base_s4h_uat_caa].[I_Product_staging]
END
