﻿CREATE VIEW [edw].[vw_Product]
AS
SELECT
    product.[Product] AS [ProductID]
,   [ProductExternalID]
,   pr_text.[ProductName] AS [Product]
,   product.[ProductExternalID] + '_' + pr_text.[ProductName] AS [ProductID_Name]
,   product.[ProductType] AS [MaterialTypeID]
,   type_text.[MaterialTypeName] AS [MaterialType]
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
--    WHERE product.MANDT = 200 
--    AND pr_text.MANDT = 200 
--    AND type_text.MANDT = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
UNION ALL

SELECT 
    'ZZZDUMMY01' AS [ProductID]
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
    'ZZZDUMMY02'                                AS [ProductID]
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