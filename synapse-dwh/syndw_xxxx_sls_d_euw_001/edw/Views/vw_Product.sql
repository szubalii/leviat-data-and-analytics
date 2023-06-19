﻿CREATE VIEW [edw].[vw_Product]
AS
WITH CTE_Product AS(
SELECT
    product.[Product] AS [sk_dim_Product]
,   product.[Product] AS [ProductID]
,   product.[ProductExternalID]
,   pr_text.[ProductName] AS [Product]
,   product.[ProductExternalID] + '_' + pr_text.[ProductName] AS [ProductID_Name]
,   product.[ProductType] AS [MaterialTypeID]
,   type_text.[MaterialTypeName] AS [MaterialType]
,   [CreationDate]
,   [CreationTime]
,   product.[CreationDateTime]
,   [CreatedByUser]
,   [LastChangeDate]
,   [LastChangedByUser]
,   [IsMarkedForDeletion]
,   [CrossPlantStatus]
,   [CrossPlantStatusValidityDate]
,   [ProductOldID]
,   [GrossWeight]
,   [PurchaseOrderQuantityUnit]
,   [SourceOfSupply]
,   [WeightUnit]
,   [CountryOfOrigin]
,   [CompetitorID]
,   [ProductGroup]
,   [BaseUnit]
,   [ItemCategoryGroup]
,   [NetWeight]
,   COALESCE(config_prodhier.[ProductHierarchyNode],prodhier.[ProductHierarchyNode]) AS [ProductHierarchy]
,   COALESCE(config_prodhier.[Product_L1_PillarID],prodhier.[Product_L1_PillarID]) AS [Product_L1_PillarID]
,   COALESCE(config_prodhier.[Product_L2_GroupID],prodhier.[Product_L2_GroupID]) AS [Product_L2_GroupID]
,   COALESCE(config_prodhier.[Product_L3_TypeID],prodhier.[Product_L3_TypeID]) AS [Product_L3_TypeID]
,   COALESCE(config_prodhier.[Product_L4_FamilyID],prodhier.[Product_L4_FamilyID]) AS [Product_L4_FamilyID]
,   COALESCE(config_prodhier.[Product_L5_SubFamilyID],prodhier.[Product_L5_SubFamilyID]) AS [Product_L5_SubFamilyID]
,   COALESCE(config_prodhier.[Product_L1_Pillar],prodhier.[Product_L1_Pillar],sapDummyProd.[Product_L1_Pillar]) AS [Product_L1_Pillar]
,   COALESCE(config_prodhier.[Product_L2_Group],prodhier.[Product_L2_Group],sapDummyProd.[Product_L2_Group]) AS [Product_L2_Group]
,   COALESCE(config_prodhier.[Product_L3_Type],prodhier.[Product_L3_Type],sapDummyProd.[Product_L3_Type]) AS [Product_L3_Type]
,   COALESCE(config_prodhier.[Product_L4_Family],prodhier.[Product_L4_Family],sapDummyProd.[Product_L4_Family]) AS [Product_L4_Family]
,   COALESCE(config_prodhier.[Product_L5_SubFamily],prodhier.[Product_L5_SubFamily],sapDummyProd.[Product_L5_SubFamily]) AS [Product_L5_SubFamily]
,   [Division]
,   [VarblPurOrdUnitIsActive]
,   [VolumeUnit]
,   [MaterialVolume]
,   [SalesStatus]
,   [TransportationGroup]
,   [SalesStatusValidityDate]
,   [AuthorizationGroup]
,   [ANPCode]
,   [ProductCategory]
,   [Brand]
,   [ProcurementRule]
,   [ValidityStartDate]
,   [LowLevelCode]
,   [ProdNoInGenProdInPrepackProd]
,   [SerialIdentifierAssgmtProfile]
,   [SizeOrDimensionText]
,   [IndustryStandardName]
,   [ProductStandardID]
,   [InternationalArticleNumberCat]
,   [ProductIsConfigurable]
,   [IsBatchManagementRequired]
,   [HasEmptiesBOM]
,   [ExternalProductGroup]
,   [CrossPlantConfigurableProduct]
,   [SerialNoExplicitnessLevel]
,   [ProductManufacturerNumber]
,   [ManufacturerNumber]
,   [ManufacturerPartProfile]
,   [QltyMgmtInProcmtIsActive]
,   [IsApprovedBatchRecordReqd]
,   [HandlingIndicator]
,   [WarehouseProductGroup]
,   [WarehouseStorageCondition]
,   [StandardHandlingUnitType]
,   [SerialNumberProfile]
,   [AdjustmentProfile]
,   [PreferredUnitOfMeasure]
,   [IsPilferable]
,   [IsRelevantForHzdsSubstances]
,   [QuarantinePeriod]
,   [TimeUnitForQuarantinePeriod]
,   [QualityInspectionGroup]
,   [HandlingUnitType]
,   [HasVariableTareWeight]
,   [MaximumPackagingLength]
,   [MaximumPackagingWidth]
,   [MaximumPackagingHeight]
,   [MaximumCapacity]
,   [OvercapacityTolerance]
,   [UnitForMaxPackagingDimensions]
,   [BaseUnitSpecificProductLength]
,   [BaseUnitSpecificProductWidth]
,   [BaseUnitSpecificProductHeight]
,   [ProductMeasurementUnit]
,   [ProductValidStartDate]
,   [ArticleCategory]
,   [ContentUnit]
,   [NetContent]
,   [ComparisonPriceQuantity]
,   [GrossContent]
,   [ProductValidEndDate]
,   [AssortmentListType]
,   [HasTextilePartsWthAnimalOrigin]
,   [ProductSeasonUsageCategory]
,   [IndustrySector]
,   [ChangeNumber]
,   [MaterialRevisionLevel]
,   [IsActiveEntity]
,   product.[LastChangeDateTime]
,   [LastChangeTime]
,   [DangerousGoodsIndProfile]
,   [ProductUUID]
,   [ProdSupChnMgmtUUID22]
,   [ProductDocumentChangeNumber]
,   [ProductDocumentPageCount]
,   [ProductDocumentPageNumber]
,   [OwnInventoryManagedProduct]
,   [DocumentIsCreatedByCAD]
,   [ProductionOrInspectionMemoTxt]
,   [ProductionMemoPageFormat]
,   [GlobalTradeItemNumberVariant]
,   [ProductIsHighlyViscous]
,   [TransportIsInBulk]
,   [ProdAllocDetnProcedure]
,   [ProdEffctyParamValsAreAssigned]
,   [ProdIsEnvironmentallyRelevant]
,   [LaboratoryOrDesignOffice]
,   [PackagingMaterialGroup]
,   [ProductIsLocked]
,   [DiscountInKindEligibility]
,   [SmartFormName]
,   [PackingReferenceProduct]
,   [BasicMaterial]
,   [ProductDocumentNumber]
,   [ProductDocumentVersion]
,   [ProductDocumentType]
,   [ProductDocumentPageFormat]
,   [ProductConfiguration]
,   [SegmentationStrategy]
,   [SegmentationIsRelevant]
,   [IsChemicalComplianceRelevant]
,   [LogisticalProductCategory]
,   [SalesProduct]
,   [DfsAmmunitionGroupCode]
,   [DfsRICIdentifier]
,   product.[ZZ1_CustomFieldRiskMit_PRD]
,   product.[ZZ1_CustomFieldHighRis_PRD]
,   product.[ZZ1_CustomFieldRiskRea_PRD]
,   product.[t_applicationId]
,   product.[t_extractionDtm]
FROM 
    [base_s4h_cax].[I_Product] product
LEFT JOIN 
    [base_s4h_cax].[I_ProductText] pr_text
    ON 
        product.[Product] = pr_text.[Product]
        AND
        pr_text.[Language] = 'E'
LEFT JOIN 
    [base_s4h_cax].[I_ProductTypeText] type_text
    ON
        product.[ProductType] = type_text.[ProductType]
        AND
        type_text.[Language] = 'E'
LEFT JOIN 
    [edw].[dim_ProductHierarchy] prodhier
    ON
            product.[ProductHierarchy] = prodhier.[ProductHierarchyNode]
LEFT JOIN
    [base_ff].[SAPDummyProduct] sapDummyProd
    ON
        product.[ProductExternalID] = sapDummyProd.[ProductExternalID]
LEFT JOIN
    [base_ff].[ConfigurableProduct] config_pr
    ON
        product.[Product] = config_pr.[ProductID]
LEFT JOIN 
    [edw].[dim_ProductHierarchy] config_prodhier
    ON
        config_pr.[ProductHierarchyNode] = config_prodhier.[ProductHierarchyNode]
--    WHERE product.MANDT = 200 
--    AND pr_text.MANDT = 200 
--    AND type_text.MANDT = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
UNION ALL

SELECT
    [sk_dim_ConfigurableProductHierarchy]
,   [ProductID]
,   [ProductExternalID]
,   [Product]
,   [ProductID_Name]
,   [MaterialTypeID]
,   [MaterialType]
,   [CreationDate]
,   [CreationTime]
,   [CreationDateTime]
,   [CreatedByUser]
,   [LastChangeDate]
,   [LastChangedByUser]
,   [IsMarkedForDeletion]
,   [CrossPlantStatus]
,   [CrossPlantStatusValidityDate]
,   [ProductOldID]
,   [GrossWeight]
,   [PurchaseOrderQuantityUnit]
,   [SourceOfSupply]
,   [WeightUnit]
,   [CountryOfOrigin]
,   [CompetitorID]
,   [ProductGroup]
,   [BaseUnit]
,   [ItemCategoryGroup]
,   [NetWeight]
,   [ProductHierarchy]
,   [Product_L1_PillarID]   
,   [Product_L2_GroupID]    
,   [Product_L3_TypeID]     
,   [Product_L4_FamilyID]   
,   [Product_L5_SubFamilyID]
,   [Product_L1_Pillar]     
,   [Product_L2_Group]      
,   [Product_L3_Type]       
,   [Product_L4_Family]     
,   [Product_L5_SubFamily]
,   [Division]
,   [VarblPurOrdUnitIsActive]
,   [VolumeUnit]
,   [MaterialVolume]
,   [SalesStatus]
,   [TransportationGroup]
,   [SalesStatusValidityDate]
,   [AuthorizationGroup]
,   [ANPCode]
,   [ProductCategory]
,   [Brand]
,   [ProcurementRule]
,   [ValidityStartDate]
,   [LowLevelCode]
,   [ProdNoInGenProdInPrepackProd]
,   [SerialIdentifierAssgmtProfile]
,   [SizeOrDimensionText]
,   [IndustryStandardName]
,   [ProductStandardID]
,   [InternationalArticleNumberCat]
,   [ProductIsConfigurable]
,   [IsBatchManagementRequired]
,   [HasEmptiesBOM]
,   [ExternalProductGroup]
,   [CrossPlantConfigurableProduct]
,   [SerialNoExplicitnessLevel]
,   [ProductManufacturerNumber]
,   [ManufacturerNumber]
,   [ManufacturerPartProfile]
,   [QltyMgmtInProcmtIsActive]
,   [IsApprovedBatchRecordReqd]
,   [HandlingIndicator]
,   [WarehouseProductGroup]
,   [WarehouseStorageCondition]
,   [StandardHandlingUnitType]
,   [SerialNumberProfile]
,   [AdjustmentProfile]
,   [PreferredUnitOfMeasure]
,   [IsPilferable]
,   [IsRelevantForHzdsSubstances]
,   [QuarantinePeriod]
,   [TimeUnitForQuarantinePeriod]
,   [QualityInspectionGroup]
,   [HandlingUnitType]
,   [HasVariableTareWeight]
,   [MaximumPackagingLength]
,   [MaximumPackagingWidth]
,   [MaximumPackagingHeight]
,   [MaximumCapacity]
,   [OvercapacityTolerance]
,   [UnitForMaxPackagingDimensions]
,   [BaseUnitSpecificProductLength]
,   [BaseUnitSpecificProductWidth]
,   [BaseUnitSpecificProductHeight]
,   [ProductMeasurementUnit]
,   [ProductValidStartDate]
,   [ArticleCategory]
,   [ContentUnit]
,   [NetContent]
,   [ComparisonPriceQuantity]
,   [GrossContent]
,   [ProductValidEndDate]
,   [AssortmentListType]
,   [HasTextilePartsWthAnimalOrigin]
,   [ProductSeasonUsageCategory]
,   [IndustrySector]
,   [ChangeNumber]
,   [MaterialRevisionLevel]
,   [IsActiveEntity]
,   [LastChangeDateTime]
,   [LastChangeTime]
,   [DangerousGoodsIndProfile]
,   [ProductUUID]
,   [ProdSupChnMgmtUUID22]
,   [ProductDocumentChangeNumber]
,   [ProductDocumentPageCount]
,   [ProductDocumentPageNumber]
,   [OwnInventoryManagedProduct]
,   [DocumentIsCreatedByCAD]
,   [ProductionOrInspectionMemoTxt]
,   [ProductionMemoPageFormat]
,   [GlobalTradeItemNumberVariant]
,   [ProductIsHighlyViscous]
,   [TransportIsInBulk]
,   [ProdAllocDetnProcedure]
,   [ProdEffctyParamValsAreAssigned]
,   [ProdIsEnvironmentallyRelevant]
,   [LaboratoryOrDesignOffice]
,   [PackagingMaterialGroup]
,   [ProductIsLocked]
,   [DiscountInKindEligibility]
,   [SmartFormName]
,   [PackingReferenceProduct]
,   [BasicMaterial]
,   [ProductDocumentNumber]
,   [ProductDocumentVersion]
,   [ProductDocumentType]
,   [ProductDocumentPageFormat]
,   [ProductConfiguration]
,   [SegmentationStrategy]
,   [SegmentationIsRelevant]
,   [IsChemicalComplianceRelevant]
,   [LogisticalProductCategory]
,   [SalesProduct]
,   [DfsAmmunitionGroupCode]
,   [DfsRICIdentifier]
,   [ZZ1_CustomFieldRiskMit_PRD]
,   [ZZ1_CustomFieldHighRis_PRD]
,   [ZZ1_CustomFieldRiskRea_PRD]
,   ProductHierarchy.[t_applicationId]
,   ProductHierarchy.[t_extractionDtm]
FROM 
    [edw].[dim_ConfigurableProductHierarchy] ProductHierarchy

UNION ALL

SELECT 
    'ZZZDUMMY01' AS [sk_dim_Product]
,   'ZZZDUMMY01' AS [ProductID]
,   'ZZZDUMMY01' AS [ProductExternalID]
,   'Non-SAP Undefined Service Item'            AS [Product]
,   'ZZZDUMMY01_Non-SAP Undefined Service Item' AS [ProductID_Name]
,   'ZSER'  AS [MaterialTypeID]
,   'Leviat Service Product' AS [MaterialType]
,   NULL    AS [CreationDate]
,   NULL    AS [CreationTime]
,   NULL    AS [CreationDateTime]
,   NULL    AS [CreatedByUser]
,   NULL    AS [LastChangeDate]
,   NULL    AS [LastChangedByUser]
,   NULL    AS [IsMarkedForDeletion]
,   NULL    AS [CrossPlantStatus]
,   NULL    AS [CrossPlantStatusValidityDate]
,   NULL    AS [ProductOldID]
,   NULL    AS [GrossWeight]
,   NULL    AS [PurchaseOrderQuantityUnit]
,   NULL    AS [SourceOfSupply]
,   NULL    AS [WeightUnit]
,   NULL    AS [CountryOfOrigin]
,   NULL    AS [CompetitorID]
,   NULL    AS [ProductGroup]
,   NULL    AS [BaseUnit]
,   NULL    AS [ItemCategoryGroup]
,   NULL    AS [NetWeight]
,   NULL    AS [ProductHierarchy]
,   'O'     AS [Product_L1_PillarID]
,   'OSER'  AS [Product_L2_GroupID]
,   NULL    AS [Product_L3_TypeID]
,   NULL    AS [Product_L4_FamilyID]
,   NULL    AS [Product_L5_SubFamilyID]
,   (
        SELECT
            [Product_L1_Pillar] 
        FROM
            [edw].[dim_ProductHierarchy]
        WHERE
            [Product_L1_PillarID] = 'O' 
        GROUP BY [Product_L1_Pillar]
    )       AS [Product_L1_Pillar]
,   (
        SELECT
            [Product_L2_Group] 
        FROM
            [edw].[dim_ProductHierarchy]
        WHERE
            [Product_L1_PillarID] = 'O' 
            AND 
            [Product_L2_GroupID] = 'OSER'
        GROUP BY [Product_L2_Group]
    )       AS [Product_L2_Group]
,   NULL    AS [Product_L3_Type]
,   NULL    AS [Product_L4_Family]
,   NULL    AS [Product_L5_SubFamily]
,   NULL    AS [Division]
,   NULL    AS [VarblPurOrdUnitIsActive]
,   NULL    AS [VolumeUnit]
,   NULL    AS [MaterialVolume]
,   NULL    AS [SalesStatus]
,   NULL    AS [TransportationGroup]
,   NULL    AS [SalesStatusValidityDate]
,   NULL    AS [AuthorizationGroup]
,   NULL    AS [ANPCode]
,   NULL    AS [ProductCategory]
,   NULL    AS [Brand]
,   NULL    AS [ProcurementRule]
,   NULL    AS [ValidityStartDate]
,   NULL    AS [LowLevelCode]
,   NULL    AS [ProdNoInGenProdInPrepackProd]
,   NULL    AS [SerialIdentifierAssgmtProfile]
,   NULL    AS [SizeOrDimensionText]
,   NULL    AS [IndustryStandardName]
,   NULL    AS [ProductStandardID]
,   NULL    AS [InternationalArticleNumberCat]
,   NULL    AS [ProductIsConfigurable]
,   NULL    AS [IsBatchManagementRequired]
,   NULL    AS [HasEmptiesBOM]
,   NULL    AS [ExternalProductGroup]
,   NULL    AS [CrossPlantConfigurableProduct]
,   NULL    AS [SerialNoExplicitnessLevel]
,   NULL    AS [ProductManufacturerNumber]
,   NULL    AS [ManufacturerNumber]
,   NULL    AS [ManufacturerPartProfile]
,   NULL    AS [QltyMgmtInProcmtIsActive]
,   NULL    AS [IsApprovedBatchRecordReqd]
,   NULL    AS [HandlingIndicator]
,   NULL    AS [WarehouseProductGroup]
,   NULL    AS [WarehouseStorageCondition]
,   NULL    AS [StandardHandlingUnitType]
,   NULL    AS [SerialNumberProfile]
,   NULL    AS [AdjustmentProfile]
,   NULL    AS [PreferredUnitOfMeasure]
,   NULL    AS [IsPilferable]
,   NULL    AS [IsRelevantForHzdsSubstances]
,   NULL    AS [QuarantinePeriod]
,   NULL    AS [TimeUnitForQuarantinePeriod]
,   NULL    AS [QualityInspectionGroup]
,   NULL    AS [HandlingUnitType]
,   NULL    AS [HasVariableTareWeight]
,   NULL    AS [MaximumPackagingLength]
,   NULL    AS [MaximumPackagingWidth]
,   NULL    AS [MaximumPackagingHeight]
,   NULL    AS [MaximumCapacity]
,   NULL    AS [OvercapacityTolerance]
,   NULL    AS [UnitForMaxPackagingDimensions]
,   NULL    AS [BaseUnitSpecificProductLength]
,   NULL    AS [BaseUnitSpecificProductWidth]
,   NULL    AS [BaseUnitSpecificProductHeight]
,   NULL    AS [ProductMeasurementUnit]
,   NULL    AS [ProductValidStartDate]
,   NULL    AS [ArticleCategory]
,   NULL    AS [ContentUnit]
,   NULL    AS [NetContent]
,   NULL    AS [ComparisonPriceQuantity]
,   NULL    AS [GrossContent]
,   NULL    AS [ProductValidEndDate]
,   NULL    AS [AssortmentListType]
,   NULL    AS [HasTextilePartsWthAnimalOrigin]
,   NULL    AS [ProductSeasonUsageCategory]
,   NULL    AS [IndustrySector]
,   NULL    AS [ChangeNumber]
,   NULL    AS [MaterialRevisionLevel]
,   NULL    AS [IsActiveEntity]
,   NULL    AS [LastChangeDateTime]
,   NULL    AS [LastChangeTime]
,   NULL    AS [DangerousGoodsIndProfile]
,   NULL    AS [ProductUUID]
,   NULL    AS [ProdSupChnMgmtUUID22]
,   NULL    AS [ProductDocumentChangeNumber]
,   NULL    AS [ProductDocumentPageCount]
,   NULL    AS [ProductDocumentPageNumber]
,   NULL    AS [OwnInventoryManagedProduct]
,   NULL    AS [DocumentIsCreatedByCAD]
,   NULL    AS [ProductionOrInspectionMemoTxt]
,   NULL    AS [ProductionMemoPageFormat]
,   NULL    AS [GlobalTradeItemNumberVariant]
,   NULL    AS [ProductIsHighlyViscous]
,   NULL    AS [TransportIsInBulk]
,   NULL    AS [ProdAllocDetnProcedure]
,   NULL    AS [ProdEffctyParamValsAreAssigned]
,   NULL    AS [ProdIsEnvironmentallyRelevant]
,   NULL    AS [LaboratoryOrDesignOffice]
,   NULL    AS [PackagingMaterialGroup]
,   NULL    AS [ProductIsLocked]
,   NULL    AS [DiscountInKindEligibility]
,   NULL    AS [SmartFormName]
,   NULL    AS [PackingReferenceProduct]
,   NULL    AS [BasicMaterial]
,   NULL    AS [ProductDocumentNumber]
,   NULL    AS [ProductDocumentVersion]
,   NULL    AS [ProductDocumentType]
,   NULL    AS [ProductDocumentPageFormat]
,   NULL    AS [ProductConfiguration]
,   NULL    AS [SegmentationStrategy]
,   NULL    AS [SegmentationIsRelevant]
,   NULL    AS [IsChemicalComplianceRelevant]
,   NULL    AS [LogisticalProductCategory]
,   NULL    AS [SalesProduct]
,   NULL    AS [DfsAmmunitionGroupCode]
,   NULL    AS [DfsRICIdentifier]
,   NULL    AS [ZZ1_CustomFieldRiskMit_PRD]
,   NULL    AS [ZZ1_CustomFieldHighRis_PRD]
,   NULL    AS [ZZ1_CustomFieldRiskRea_PRD]
,   'synapse-dwh'AS [t_applicationId]
,   NULL    AS [t_extractionDtm]

UNION ALL
 
SELECT
    'ZZZDUMMY02'                                AS [sk_dim_Product]
,   'ZZZDUMMY02'                                AS [ProductID]
,   'ZZZDUMMY02'                                AS [ProductExternalID]
,   'SAP Undefined Service Item'                AS [Product]
,   'ZZZDUMMY02_SAP Undefined Service Item'     AS [ProductID_Name]
,   'ZSER'                                      AS [MaterialTypeID]
,   'Leviat Service Product'                    AS [MaterialType]
,   NULL    AS [CreationDate]
,   NULL    AS [CreationTime]
,   NULL    AS [CreationDateTime]
,   NULL    AS [CreatedByUser]
,   NULL    AS [LastChangeDate]
,   NULL    AS [LastChangedByUser]
,   NULL    AS [IsMarkedForDeletion]
,   NULL    AS [CrossPlantStatus]
,   NULL    AS [CrossPlantStatusValidityDate]
,   NULL    AS [ProductOldID]
,   NULL    AS [GrossWeight]
,   NULL    AS [PurchaseOrderQuantityUnit]
,   NULL    AS [SourceOfSupply]
,   NULL    AS [WeightUnit]
,   NULL    AS [CountryOfOrigin]
,   NULL    AS [CompetitorID]
,   NULL    AS [ProductGroup]
,   NULL    AS [BaseUnit]
,   NULL    AS [ItemCategoryGroup]
,   NULL    AS [NetWeight]
,   NULL    AS [ProductHierarchy]
,   'O'     AS [Product_L1_PillarID]
,   'OSER'  AS [Product_L2_GroupID]
,   NULL    AS [Product_L3_TypeID]
,   NULL    AS [Product_L4_FamilyID]
,   NULL    AS [Product_L5_SubFamilyID]
,   (
        SELECT
            [Product_L1_Pillar] 
        FROM
            [edw].[dim_ProductHierarchy]
        WHERE
            [Product_L1_PillarID] = 'O' 
        GROUP BY [Product_L1_Pillar]
    )       AS [Product_L1_Pillar]
,   (
        SELECT
            [Product_L2_Group] 
        FROM
            [edw].[dim_ProductHierarchy]
        WHERE
            [Product_L1_PillarID] = 'O' 
            AND 
            [Product_L2_GroupID] = 'OSER'
        GROUP BY [Product_L2_Group]
    )       AS [Product_L2_Group]
,   NULL    AS [Product_L3_Type]
,   NULL    AS [Product_L4_Family]
,   NULL    AS [Product_L5_SubFamily]
,   NULL    AS [Division]
,   NULL    AS [VarblPurOrdUnitIsActive]
,   NULL    AS [VolumeUnit]
,   NULL    AS [MaterialVolume]
,   NULL    AS [SalesStatus]
,   NULL    AS [TransportationGroup]
,   NULL    AS [SalesStatusValidityDate]
,   NULL    AS [AuthorizationGroup]
,   NULL    AS [ANPCode]
,   NULL    AS [ProductCategory]
,   NULL    AS [Brand]
,   NULL    AS [ProcurementRule]
,   NULL    AS [ValidityStartDate]
,   NULL    AS [LowLevelCode]
,   NULL    AS [ProdNoInGenProdInPrepackProd]
,   NULL    AS [SerialIdentifierAssgmtProfile]
,   NULL    AS [SizeOrDimensionText]
,   NULL    AS [IndustryStandardName]
,   NULL    AS [ProductStandardID]
,   NULL    AS [InternationalArticleNumberCat]
,   NULL    AS [ProductIsConfigurable]
,   NULL    AS [IsBatchManagementRequired]
,   NULL    AS [HasEmptiesBOM]
,   NULL    AS [ExternalProductGroup]
,   NULL    AS [CrossPlantConfigurableProduct]
,   NULL    AS [SerialNoExplicitnessLevel]
,   NULL    AS [ProductManufacturerNumber]
,   NULL    AS [ManufacturerNumber]
,   NULL    AS [ManufacturerPartProfile]
,   NULL    AS [QltyMgmtInProcmtIsActive]
,   NULL    AS [IsApprovedBatchRecordReqd]
,   NULL    AS [HandlingIndicator]
,   NULL    AS [WarehouseProductGroup]
,   NULL    AS [WarehouseStorageCondition]
,   NULL    AS [StandardHandlingUnitType]
,   NULL    AS [SerialNumberProfile]
,   NULL    AS [AdjustmentProfile]
,   NULL    AS [PreferredUnitOfMeasure]
,   NULL    AS [IsPilferable]
,   NULL    AS [IsRelevantForHzdsSubstances]
,   NULL    AS [QuarantinePeriod]
,   NULL    AS [TimeUnitForQuarantinePeriod]
,   NULL    AS [QualityInspectionGroup]
,   NULL    AS [HandlingUnitType]
,   NULL    AS [HasVariableTareWeight]
,   NULL    AS [MaximumPackagingLength]
,   NULL    AS [MaximumPackagingWidth]
,   NULL    AS [MaximumPackagingHeight]
,   NULL    AS [MaximumCapacity]
,   NULL    AS [OvercapacityTolerance]
,   NULL    AS [UnitForMaxPackagingDimensions]
,   NULL    AS [BaseUnitSpecificProductLength]
,   NULL    AS [BaseUnitSpecificProductWidth]
,   NULL    AS [BaseUnitSpecificProductHeight]
,   NULL    AS [ProductMeasurementUnit]
,   NULL    AS [ProductValidStartDate]
,   NULL    AS [ArticleCategory]
,   NULL    AS [ContentUnit]
,   NULL    AS [NetContent]
,   NULL    AS [ComparisonPriceQuantity]
,   NULL    AS [GrossContent]
,   NULL    AS [ProductValidEndDate]
,   NULL    AS [AssortmentListType]
,   NULL    AS [HasTextilePartsWthAnimalOrigin]
,   NULL    AS [ProductSeasonUsageCategory]
,   NULL    AS [IndustrySector]
,   NULL    AS [ChangeNumber]
,   NULL    AS [MaterialRevisionLevel]
,   NULL    AS [IsActiveEntity]
,   NULL    AS [LastChangeDateTime]
,   NULL    AS [LastChangeTime]
,   NULL    AS [DangerousGoodsIndProfile]
,   NULL    AS [ProductUUID]
,   NULL    AS [ProdSupChnMgmtUUID22]
,   NULL    AS [ProductDocumentChangeNumber]
,   NULL    AS [ProductDocumentPageCount]
,   NULL    AS [ProductDocumentPageNumber]
,   NULL    AS [OwnInventoryManagedProduct]
,   NULL    AS [DocumentIsCreatedByCAD]
,   NULL    AS [ProductionOrInspectionMemoTxt]
,   NULL    AS [ProductionMemoPageFormat]
,   NULL    AS [GlobalTradeItemNumberVariant]
,   NULL    AS [ProductIsHighlyViscous]
,   NULL    AS [TransportIsInBulk]
,   NULL    AS [ProdAllocDetnProcedure]
,   NULL    AS [ProdEffctyParamValsAreAssigned]
,   NULL    AS [ProdIsEnvironmentallyRelevant]
,   NULL    AS [LaboratoryOrDesignOffice]
,   NULL    AS [PackagingMaterialGroup]
,   NULL    AS [ProductIsLocked]
,   NULL    AS [DiscountInKindEligibility]
,   NULL    AS [SmartFormName]
,   NULL    AS [PackingReferenceProduct]
,   NULL    AS [BasicMaterial]
,   NULL    AS [ProductDocumentNumber]
,   NULL    AS [ProductDocumentVersion]
,   NULL    AS [ProductDocumentType]
,   NULL    AS [ProductDocumentPageFormat]
,   NULL    AS [ProductConfiguration]
,   NULL    AS [SegmentationStrategy]
,   NULL    AS [SegmentationIsRelevant]
,   NULL    AS [IsChemicalComplianceRelevant]
,   NULL    AS [LogisticalProductCategory]
,   NULL    AS [SalesProduct]
,   NULL    AS [DfsAmmunitionGroupCode]
,   NULL    AS [DfsRICIdentifier]
,   NULL    AS [ZZ1_CustomFieldRiskMit_PRD]
,   NULL    AS [ZZ1_CustomFieldHighRis_PRD]
,   NULL    AS [ZZ1_CustomFieldRiskRea_PRD]
,   'synapse-dwh'AS [t_applicationId]
,   NULL    AS [t_extractionDtm]
),

EClassMapping AS (
SELECT 
    sk_dim_Product
,   ProductGroup
,   CASE 
        WHEN (ISNUMERIC(LEFT(CTE_Product.ProductGroup,2)) = 1 AND LEFT(CTE_Product.ProductGroup,2) NOT IN ('01', '02'))
            THEN LEFT(CTE_Product.ProductGroup,8)
        ELSE ECC.EClassCode
        END AS EClassCode
,   CASE
        WHEN (ISNUMERIC(LEFT(CTE_Product.ProductGroup,2)) = 1 AND LEFT(CTE_Product.ProductGroup,2) NOT IN ('01', '02'))
            THEN MAX(ECC2.EClassCategory)
        ELSE ECC.EClassCategory
        END AS EClassCategory
,   CASE 
        WHEN (ISNUMERIC(LEFT(CTE_Product.ProductGroup,2)) = 1 AND LEFT(CTE_Product.ProductGroup,2) NOT IN ('01', '02'))
            THEN MAX(ECC2.EClassCategoryDescription)
        ELSE ECC.EClassCategoryDescription
        END AS EClassCategoryDescription 
,   [Category_L1]
,   [Category_L2]
,   [Category_L3]
,   [Category_L4]

FROM CTE_Product

    LEFT OUTER JOIN base_ff.EClassCodes ECC 
    ON CTE_Product.ProductGroup = ECC.MaterialGroupID

    LEFT OUTER JOIN base_ff.EClassCodes ECC2
    ON LEFT(CTE_Product.ProductGroup,8) = ECC2.EClassCode

GROUP BY sk_dim_Product, ProductGroup, ECC.EClassCode, ECC.EClassCategory, ECC.EClassCategoryDescription
)

SELECT
    
    CTE_Product.[sk_dim_Product]
,   [ProductID]
,   [ProductExternalID]
,   [Product]
,   [ProductID_Name]
,   [MaterialTypeID]
,   [MaterialType]
,   [CreationDate]
,   [CreationTime]
,   [CreationDateTime]
,   [CreatedByUser]
,   [LastChangeDate]
,   [LastChangedByUser]
,   [IsMarkedForDeletion]
,   CTE_Product.[CrossPlantStatus] AS [CrossPlantStatusID]
,   MS.[CrossPlantStatus]
,   [CrossPlantStatusValidityDate]
,   [ProductOldID]
,   [GrossWeight]
,   [PurchaseOrderQuantityUnit]
,   [SourceOfSupply]
,   [WeightUnit]
,   [CountryOfOrigin]
,   [CompetitorID]
,   CTE_Product.[ProductGroup]
,   [BaseUnit]
,   CTE_Product.[ItemCategoryGroup] AS [ItemCategoryGroup]
,   ItemCategoryGroup.[ItemCategoryGroupName]
,   [NetWeight]
,   [ProductHierarchy]
,   [Product_L1_PillarID]
,   [Product_L2_GroupID]
,   [Product_L3_TypeID]
,   [Product_L4_FamilyID]
,   [Product_L5_SubFamilyID]
,   [Product_L1_Pillar]
,   [Product_L2_Group]
,   [Product_L3_Type]
,   [Product_L4_Family]
,   [Product_L5_SubFamily]
,   [Division]
,   [VarblPurOrdUnitIsActive]
,   [VolumeUnit]
,   [MaterialVolume]
,   [SalesStatus]
,   [TransportationGroup]
,   [SalesStatusValidityDate]
,   [AuthorizationGroup]
,   [ANPCode]
,   [ProductCategory]
,   [Brand]
,   [ProcurementRule]
,   [ValidityStartDate]
,   [LowLevelCode]
,   [ProdNoInGenProdInPrepackProd]
,   [SerialIdentifierAssgmtProfile]
,   [SizeOrDimensionText]
,   [IndustryStandardName]
,   [ProductStandardID]
,   [InternationalArticleNumberCat]
,   [ProductIsConfigurable]
,   [IsBatchManagementRequired]
,   [HasEmptiesBOM]
,   [ExternalProductGroup]
,   [CrossPlantConfigurableProduct]
,   [SerialNoExplicitnessLevel]
,   [ProductManufacturerNumber]
,   [ManufacturerNumber]
,   [ManufacturerPartProfile]
,   [QltyMgmtInProcmtIsActive]
,   [IsApprovedBatchRecordReqd]
,   [HandlingIndicator]
,   [WarehouseProductGroup]
,   [WarehouseStorageCondition]
,   [StandardHandlingUnitType]
,   [SerialNumberProfile]
,   [AdjustmentProfile]
,   [PreferredUnitOfMeasure]
,   [IsPilferable]
,   [IsRelevantForHzdsSubstances]
,   [QuarantinePeriod]
,   [TimeUnitForQuarantinePeriod]
,   [QualityInspectionGroup]
,   [HandlingUnitType]
,   [HasVariableTareWeight]
,   [MaximumPackagingLength]
,   [MaximumPackagingWidth]
,   [MaximumPackagingHeight]
,   [MaximumCapacity]
,   [OvercapacityTolerance]
,   [UnitForMaxPackagingDimensions]
,   [BaseUnitSpecificProductLength]
,   [BaseUnitSpecificProductWidth]
,   [BaseUnitSpecificProductHeight]
,   [ProductMeasurementUnit]
,   [ProductValidStartDate]
,   [ArticleCategory]
,   [ContentUnit]
,   [NetContent]
,   [ComparisonPriceQuantity]
,   [GrossContent]
,   [ProductValidEndDate]
,   [AssortmentListType]
,   [HasTextilePartsWthAnimalOrigin]
,   [ProductSeasonUsageCategory]
,   [IndustrySector]
,   [ChangeNumber]
,   [MaterialRevisionLevel]
,   [IsActiveEntity]
,   [LastChangeDateTime]
,   [LastChangeTime]
,   [DangerousGoodsIndProfile]
,   [ProductUUID]
,   [ProdSupChnMgmtUUID22]
,   [ProductDocumentChangeNumber]
,   [ProductDocumentPageCount]
,   [ProductDocumentPageNumber]
,   [OwnInventoryManagedProduct]
,   [DocumentIsCreatedByCAD]
,   [ProductionOrInspectionMemoTxt]
,   [ProductionMemoPageFormat]
,   [GlobalTradeItemNumberVariant]
,   [ProductIsHighlyViscous]
,   [TransportIsInBulk]
,   [ProdAllocDetnProcedure]
,   [ProdEffctyParamValsAreAssigned]
,   [ProdIsEnvironmentallyRelevant]
,   [LaboratoryOrDesignOffice]
,   [PackagingMaterialGroup]
,   [ProductIsLocked]
,   [DiscountInKindEligibility]
,   [SmartFormName]
,   [PackingReferenceProduct]
,   [BasicMaterial]
,   [ProductDocumentNumber]
,   [ProductDocumentVersion]
,   [ProductDocumentType]
,   [ProductDocumentPageFormat]
,   [ProductConfiguration]
,   [SegmentationStrategy]
,   [SegmentationIsRelevant]
,   [IsChemicalComplianceRelevant]
,   [LogisticalProductCategory]
,   [SalesProduct]
,   [DfsAmmunitionGroupCode]
,   [DfsRICIdentifier]
,   PT.[MaterialGroupName]
,   PT.[MaterialGroupText]
,   ECM.[EClassCode]               
,   ECM.[EClassCategory]           
,   ECM.[EClassCategoryDescription]
,   ECM.[Category_L1]
,   ECM.[Category_L2]
,   ECM.[Category_L3]
,   ECM.[Category_L4]
,   C.[Classification]
,   [ZZ1_CustomFieldRiskMit_PRD]
,   [ZZ1_CustomFieldHighRis_PRD]
,   [ZZ1_CustomFieldRiskRea_PRD]
,   CTE_Product.[t_applicationId]
,   CTE_Product.[t_extractionDtm]
FROM
    CTE_Product
LEFT JOIN [edw].[vw_MaterialStatus] MS
    ON
        CTE_Product.[CrossPlantStatus] = MS.[MaterialStatusID] COLLATE Latin1_General_100_BIN2
        AND
        MS.[Language] = 'E'
LEFT JOIN
    [base_s4h_cax].[I_ItemCategoryGroupText] ItemCategoryGroup
    ON
        CTE_Product.[ItemCategoryGroup] = ItemCategoryGroup.[ItemCategoryGroup]
        AND
        ItemCategoryGroup.[Language] = 'E'
LEFT JOIN 
    base_s4h_cax.I_ProductGroupText PT
    ON
        CTE_Product.ProductGroup = PT.MaterialGroup
        AND PT.Language = 'E'
LEFT JOIN
    EClassMapping ECM
    ON
    CTE_Product.sk_dim_Product = ECM.sk_dim_Product
LEFT JOIN
    base_ff.MaterialGroupClassification C
    ON
        PT.MaterialGroupName = C.MaterialGroupName