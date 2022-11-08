CREATE VIEW [dq].[vw_Product_1_8] AS

WITH ErrorProducts AS (
SELECT
    [Product]
FROM   
    [base_s4h_cax].[I_Product]
WHERE
    [ProductType] = 'ZROH'
    AND
    [ItemCategoryGroup] != 'NORM'

UNION ALL

SELECT
    [Product]
FROM   
    [base_s4h_cax].[I_Product]
WHERE
    [ProductType] IN ('ZKMA', 'ZKMB', 'ZKMC')
    AND
    [ItemCategoryGroup] != '0002'

UNION ALL

SELECT
    [Product]
FROM   
    [base_s4h_cax].[I_Product]
WHERE
    [ProductType] = 'ZSER'
    AND
    [ItemCategoryGroup] != 'LEIS'
)

SELECT
    [MANDT] 
    ,p.[Product] 
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
    ,[DfsAmmunitionGroupCode] 
    ,[DfsRICIdentifier]
    ,[ZZ1_CustomFieldRiskMit_PRD] 
    ,[ZZ1_CustomFieldHighRis_PRD] 
    ,[ZZ1_CustomFieldRiskRea_PRD]
    ,CONCAT('1.8_', [ProductType]) AS [RuleID]
    ,1 AS [Count]
FROM
    [base_s4h_cax].[I_Product] AS p
INNER JOIN
    ErrorProducts AS errp
    ON
        p.[Product] = errp.[Product]
