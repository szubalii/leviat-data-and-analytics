﻿CREATE VIEW [dq].[vw_Product_1_17] AS
WITH
Rule_1_17_duplicates AS (
    SELECT
        COUNT(*) as [CountDuplicates],
        [ProductType],
        [ProductManufacturerNumber]
    FROM
        [base_s4h_cax].[I_Product]
    WHERE
        ProductType IN ('ZVER','ZHAW')
    AND
        ProductManufacturerNumber != ''
    GROUP BY
        [ProductType],
        [ProductManufacturerNumber]
    HAVING COUNT(*) >1
)
,
Rule_1_17 AS (
    SELECT
        [Product],
        p.[ProductType],
        p.[ProductManufacturerNumber],
        1 AS [IsError],
        CONCAT('1.17_',p.[ProductType]) AS [RuleID],
        1 AS [Count]
    FROM
        [base_s4h_cax].[I_Product] AS p
    JOIN
        Rule_1_17_duplicates AS p_dpl
        ON
            p.[ProductType] = p_dpl.[ProductType]
)

SELECT
    [MANDT] 
    ,main.[Product] 
    ,[ProductExternalID] 
    ,main.[ProductType] 
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
    ,main.[ProductManufacturerNumber] 
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
    ,[DfsAmmunitionGroupCode] 
    ,[DfsRICIdentifier]
    ,[ZZ1_CustomFieldRiskMit_PRD] 
    ,[ZZ1_CustomFieldHighRis_PRD] 
    ,[ZZ1_CustomFieldRiskRea_PRD] 
    ,Rule_1_17.[IsError]
    ,Rule_1_17.[RuleID]
    ,Rule_1_17.[Count]
FROM   
    [base_s4h_cax].[I_Product] AS main
LEFT JOIN
    Rule_1_17
    ON
        main.[Product] = Rule_1_17.[Product]
WHERE
    Rule_1_17.[IsError] = 1