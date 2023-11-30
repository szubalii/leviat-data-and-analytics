﻿CREATE VIEW [edw].[vw_ConfigurableProductHierarchy]
AS
SELECT
    vc.[ProductSurrogateKey] AS [sk_dim_ConfigurableProductHierarchy]
    , product.[Product] AS [ProductID]
    , product.[ProductExternalID]
    , pr_text.[ProductName] AS [Product]
    , product.[ProductExternalID] + '_' + pr_text.[ProductName] AS [ProductID_Name]
    , product.[ProductType] AS [MaterialTypeID]
    , type_text.[MaterialTypeName] AS [MaterialType]
    , product.[CreationDate]
    , product.[CreationTime]
    , product.[CreationDateTime]
    , product.[CreatedByUser]
    , product.[LastChangeDate]
    , product.[LastChangedByUser]
    , product.[IsMarkedForDeletion]
    , product.[CrossPlantStatus]
    , product.[CrossPlantStatusValidityDate]
    , product.[ProductOldID]
    , product.[GrossWeight]
    , product.[PurchaseOrderQuantityUnit]
    , product.[SourceOfSupply]
    , product.[WeightUnit]
    , product.[CountryOfOrigin]
    , product.[CompetitorID]
    , product.[ProductGroup]
    , product.[BaseUnit]
    , product.[ItemCategoryGroup]
    , product.[NetWeight]
    , vc.[CharValue] AS [ProductHierarchy]
    , prodhier.[Product_L1_PillarID]
    , prodhier.[Product_L2_GroupID]
    , prodhier.[Product_L3_TypeID]
    , prodhier.[Product_L4_FamilyID]
    , prodhier.[Product_L5_SubFamilyID]
    , prodhier.[Product_L1_Pillar]
    , prodhier.[Product_L2_Group]
    , prodhier.[Product_L3_Type]
    , prodhier.[Product_L4_Family]
    , prodhier.[Product_L5_SubFamily]
    , product.[Division]
    , product.[VarblPurOrdUnitIsActive]
    , product.[VolumeUnit]
    , product.[MaterialVolume]
    , product.[SalesStatus]
    , product.[TransportationGroup]
    , product.[SalesStatusValidityDate]
    , product.[AuthorizationGroup]
    , product.[ANPCode]
    , product.[ProductCategory]
    , product.[Brand]
    , product.[ProcurementRule]
    , product.[ValidityStartDate]
    , product.[LowLevelCode]
    , product.[ProdNoInGenProdInPrepackProd]
    , product.[SerialIdentifierAssgmtProfile]
    , product.[SizeOrDimensionText]
    , product.[IndustryStandardName]
    , product.[ProductStandardID]
    , product.[InternationalArticleNumberCat]
    , product.[ProductIsConfigurable]
    , product.[IsBatchManagementRequired]
    , product.[HasEmptiesBOM]
    , product.[ExternalProductGroup]
    , product.[CrossPlantConfigurableProduct]
    , product.[SerialNoExplicitnessLevel]
    , product.[ProductManufacturerNumber]
    , product.[ManufacturerNumber]
    , product.[ManufacturerPartProfile]
    , product.[QltyMgmtInProcmtIsActive]
    , product.[IsApprovedBatchRecordReqd]
    , product.[HandlingIndicator]
    , product.[WarehouseProductGroup]
    , product.[WarehouseStorageCondition]
    , product.[StandardHandlingUnitType]
    , product.[SerialNumberProfile]
    , product.[AdjustmentProfile]
    , product.[PreferredUnitOfMeasure]
    , product.[IsPilferable]
    , product.[IsRelevantForHzdsSubstances]
    , product.[QuarantinePeriod]
    , product.[TimeUnitForQuarantinePeriod]
    , product.[QualityInspectionGroup]
    , product.[HandlingUnitType]
    , product.[HasVariableTareWeight]
    , product.[MaximumPackagingLength]
    , product.[MaximumPackagingWidth]
    , product.[MaximumPackagingHeight]
    , product.[MaximumCapacity]
    , product.[OvercapacityTolerance]
    , product.[UnitForMaxPackagingDimensions]
    , product.[BaseUnitSpecificProductLength]
    , product.[BaseUnitSpecificProductWidth]
    , product.[BaseUnitSpecificProductHeight]
    , product.[ProductMeasurementUnit]
    , product.[ProductValidStartDate]
    , product.[ArticleCategory]
    , product.[ContentUnit]
    , product.[NetContent]
    , product.[ComparisonPriceQuantity]
    , product.[GrossContent]
    , product.[ProductValidEndDate]
    , product.[AssortmentListType]
    , product.[HasTextilePartsWthAnimalOrigin]
    , product.[ProductSeasonUsageCategory]
    , product.[IndustrySector]
    , product.[ChangeNumber]
    , product.[MaterialRevisionLevel]
    , product.[IsActiveEntity]
    , product.[LastChangeDateTime]
    , product.[LastChangeTime]
    , product.[DangerousGoodsIndProfile]
    , product.[ProductUUID]
    , product.[ProdSupChnMgmtUUID22]
    , product.[ProductDocumentChangeNumber]
    , product.[ProductDocumentPageCount]
    , product.[ProductDocumentPageNumber]
    , product.[OwnInventoryManagedProduct]
    , product.[DocumentIsCreatedByCAD]
    , product.[ProductionOrInspectionMemoTxt]
    , product.[ProductionMemoPageFormat]
    , product.[GlobalTradeItemNumberVariant]
    , product.[ProductIsHighlyViscous]
    , product.[TransportIsInBulk]
    , product.[ProdAllocDetnProcedure]
    , product.[ProdEffctyParamValsAreAssigned]
    , product.[ProdIsEnvironmentallyRelevant]
    , product.[LaboratoryOrDesignOffice]
    , product.[PackagingMaterialGroup]
    , product.[ProductIsLocked]
    , product.[DiscountInKindEligibility]
    , product.[SmartFormName]
    , product.[PackingReferenceProduct]
    , product.[BasicMaterial]
    , product.[ProductDocumentNumber]
    , product.[ProductDocumentVersion]
    , product.[ProductDocumentType]
    , product.[ProductDocumentPageFormat]
    , product.[ProductConfiguration]
    , product.[SegmentationStrategy]
    , product.[SegmentationIsRelevant]
    , product.[IsChemicalComplianceRelevant]
    , product.[LogisticalProductCategory]
    , product.[SalesProduct]
    , product.[DfsAmmunitionGroupCode]
    , product.[DfsRICIdentifier]
    , product.[ZZ1_CustomFieldRiskMit_PRD]
    , product.[ZZ1_CustomFieldHighRis_PRD]
    , product.[ZZ1_CustomFieldRiskRea_PRD]
    , vc.[t_applicationId]
FROM
    [edw].[vw_ProductHierarchyVariantConfigCharacteristic] AS vc
LEFT JOIN
    [base_s4h_cax].[I_Product] AS product
    ON
        vc.[ProductID] = product.[Product]
LEFT JOIN
    [base_s4h_cax].[I_ProductText] AS pr_text
    ON
        product.[Product] = pr_text.[Product]
        -- AND
        -- pr_text.[Language] = 'E'
LEFT JOIN
    [base_s4h_cax].[I_ProductTypeText] AS type_text
    ON
        product.[ProductType] = type_text.[ProductType]
        -- AND
        -- type_text.[Language] = 'E'
-- LEFT JOIN
--     [base_ff].[ProductHierarchyNode] map
--     ON
--         vc.[ProductID] = map.[ProductID]
--         AND
--         vc.[CharValue] = map.[old_ProductHierarchyNode]
LEFT JOIN
    [edw].[dim_ProductHierarchy] AS prodhier
    ON
        vc.[CharValue] = prodhier.[ProductHierarchyNode]
LEFT JOIN
    [base_ff].[ConfigurableProductCharacteristic] AS mcpc
    ON
        vc.[CharacteristicName] = mcpc.[CharacteristicName]
WHERE
    mcpc.[CharacteristicCategory] = 'ProductHierarchy'
GROUP BY
    vc.[ProductSurrogateKey]
    , product.[Product]
    , product.[ProductExternalID]
    , pr_text.[ProductName]
    , product.[ProductType]
    , type_text.[MaterialTypeName]
    , product.[CreationDate]
    , product.[CreationTime]
    , product.[CreationDateTime]
    , product.[CreatedByUser]
    , product.[LastChangeDate]
    , product.[LastChangedByUser]
    , product.[IsMarkedForDeletion]
    , product.[CrossPlantStatus]
    , product.[CrossPlantStatusValidityDate]
    , product.[ProductOldID]
    , product.[GrossWeight]
    , product.[PurchaseOrderQuantityUnit]
    , product.[SourceOfSupply]
    , product.[WeightUnit]
    , product.[CountryOfOrigin]
    , product.[CompetitorID]
    , product.[ProductGroup]
    , product.[ProductGroup]
    , product.[BaseUnit]
    , product.[ItemCategoryGroup]
    , product.[NetWeight]
    , [CharValue]
    , prodhier.[Product_L1_PillarID]
    , prodhier.[Product_L2_GroupID]
    , prodhier.[Product_L3_TypeID]
    , prodhier.[Product_L4_FamilyID]
    , prodhier.[Product_L5_SubFamilyID]
    , prodhier.[Product_L1_Pillar]
    , prodhier.[Product_L2_Group]
    , prodhier.[Product_L3_Type]
    , prodhier.[Product_L4_Family]
    , prodhier.[Product_L5_SubFamily]
    , product.[Division]
    , product.[VarblPurOrdUnitIsActive]
    , product.[VolumeUnit]
    , product.[MaterialVolume]
    , product.[SalesStatus]
    , product.[TransportationGroup]
    , product.[SalesStatusValidityDate]
    , product.[AuthorizationGroup]
    , product.[ANPCode]
    , product.[ProductCategory]
    , product.[Brand]
    , product.[ProcurementRule]
    , product.[ValidityStartDate]
    , product.[LowLevelCode]
    , product.[ProdNoInGenProdInPrepackProd]
    , product.[SerialIdentifierAssgmtProfile]
    , product.[SizeOrDimensionText]
    , product.[IndustryStandardName]
    , product.[ProductStandardID]
    , product.[InternationalArticleNumberCat]
    , product.[ProductIsConfigurable]
    , product.[IsBatchManagementRequired]
    , product.[HasEmptiesBOM]
    , product.[ExternalProductGroup]
    , product.[CrossPlantConfigurableProduct]
    , product.[SerialNoExplicitnessLevel]
    , product.[ProductManufacturerNumber]
    , product.[ManufacturerNumber]
    , product.[ManufacturerPartProfile]
    , product.[QltyMgmtInProcmtIsActive]
    , product.[IsApprovedBatchRecordReqd]
    , product.[HandlingIndicator]
    , product.[WarehouseProductGroup]
    , product.[WarehouseStorageCondition]
    , product.[StandardHandlingUnitType]
    , product.[SerialNumberProfile]
    , product.[AdjustmentProfile]
    , product.[PreferredUnitOfMeasure]
    , product.[IsPilferable]
    , product.[IsRelevantForHzdsSubstances]
    , product.[QuarantinePeriod]
    , product.[TimeUnitForQuarantinePeriod]
    , product.[QualityInspectionGroup]
    , product.[HandlingUnitType]
    , product.[HasVariableTareWeight]
    , product.[MaximumPackagingLength]
    , product.[MaximumPackagingWidth]
    , product.[MaximumPackagingHeight]
    , product.[MaximumCapacity]
    , product.[OvercapacityTolerance]
    , product.[UnitForMaxPackagingDimensions]
    , product.[BaseUnitSpecificProductLength]
    , product.[BaseUnitSpecificProductWidth]
    , product.[BaseUnitSpecificProductHeight]
    , product.[ProductMeasurementUnit]
    , product.[ProductValidStartDate]
    , product.[ArticleCategory]
    , product.[ContentUnit]
    , product.[NetContent]
    , product.[ComparisonPriceQuantity]
    , product.[GrossContent]
    , product.[ProductValidEndDate]
    , product.[AssortmentListType]
    , product.[HasTextilePartsWthAnimalOrigin]
    , product.[ProductSeasonUsageCategory]
    , product.[IndustrySector]
    , product.[ChangeNumber]
    , product.[MaterialRevisionLevel]
    , product.[IsActiveEntity]
    , product.[LastChangeDateTime]
    , product.[LastChangeTime]
    , product.[DangerousGoodsIndProfile]
    , product.[ProductUUID]
    , product.[ProdSupChnMgmtUUID22]
    , product.[ProductDocumentChangeNumber]
    , product.[ProductDocumentPageCount]
    , product.[ProductDocumentPageNumber]
    , product.[OwnInventoryManagedProduct]
    , product.[DocumentIsCreatedByCAD]
    , product.[ProductionOrInspectionMemoTxt]
    , product.[ProductionMemoPageFormat]
    , product.[GlobalTradeItemNumberVariant]
    , product.[ProductIsHighlyViscous]
    , product.[TransportIsInBulk]
    , product.[ProdAllocDetnProcedure]
    , product.[ProdEffctyParamValsAreAssigned]
    , product.[ProdIsEnvironmentallyRelevant]
    , product.[LaboratoryOrDesignOffice]
    , product.[PackagingMaterialGroup]
    , product.[ProductIsLocked]
    , product.[DiscountInKindEligibility]
    , product.[SmartFormName]
    , product.[PackingReferenceProduct]
    , product.[BasicMaterial]
    , product.[ProductDocumentNumber]
    , product.[ProductDocumentVersion]
    , product.[ProductDocumentType]
    , product.[ProductDocumentPageFormat]
    , product.[ProductConfiguration]
    , product.[SegmentationStrategy]
    , product.[SegmentationIsRelevant]
    , product.[IsChemicalComplianceRelevant]
    , product.[LogisticalProductCategory]
    , product.[SalesProduct]
    , product.[DfsAmmunitionGroupCode]
    , product.[DfsRICIdentifier]
    , product.[ZZ1_CustomFieldRiskMit_PRD]
    , product.[ZZ1_CustomFieldHighRis_PRD]
    , product.[ZZ1_CustomFieldRiskRea_PRD]
    , vc.[t_applicationId]
