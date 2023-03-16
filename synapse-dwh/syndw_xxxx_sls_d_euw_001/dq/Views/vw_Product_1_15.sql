CREATE VIEW [dq].[vw_Product_1_15] AS
WITH ProductEStatus AS (
SELECT
    pp.[Product]
    ,pp.[Plant]
    ,pp.[ProcurementType]
FROM
    [base_s4h_cax].[I_ProductPlant] AS pp
INNER JOIN
    [base_s4h_cax].[MSTA] AS msta
    ON
        pp.[Product] = msta.[MATNR]
        AND
        pp.[Plant] = msta.[WERKS]
WHERE   
    pp.[ProcurementType] IN ('F','X')
    AND
    msta.[STATM] = 'E'
)
,
ProductOtherStatus AS (
SELECT
    pp.[Product]
    ,pp.[Plant]
    ,pp.[ProcurementType]
FROM
    [base_s4h_cax].[I_ProductPlant] pp
INNER JOIN
    [base_s4h_cax].[MSTA] msta
    ON
        pp.[Product] = msta.[MATNR]
        AND
        pp.[Plant] = msta.[WERKS]
WHERE   
    pp.[ProcurementType] IN ('F','X')
)
,
ErrorProducts AS (
SELECT
    [Product]
    ,[Plant]
    ,[ProcurementType]
FROM
    ProductOtherStatus
EXCEPT
SELECT
    [Product]
    ,[Plant]
    ,[ProcurementType] 
FROM
    ProductEStatus
)

SELECT
    p.[MANDT] 
    ,p.[Product] 
    ,p.[ProductExternalID] 
    ,p.[ProductType] 
    ,p.[CreationDate] 
    ,p.[CreationTime]
    ,NULL AS [CreationDateTime]
    ,p.[CreatedByUser]
    ,p.[LastChangeDate] 
    ,p.[LastChangedByUser]
    ,p.[IsMarkedForDeletion] 
    ,p.[CrossPlantStatus] 
    ,p.[CrossPlantStatusValidityDate] 
    ,p.[ProductOldID] 
    ,p.[GrossWeight] 
    ,p.[PurchaseOrderQuantityUnit]
    ,p.[SourceOfSupply] 
    ,p.[WeightUnit]
    ,p.[CountryOfOrigin] 
    ,p.[CompetitorID] 
    ,p.[ProductGroup] 
    ,p.[BaseUnit]
    ,p.[ItemCategoryGroup] 
    ,p.[NetWeight] 
    ,p.[ProductHierarchy]
    ,p.[Division] 
    ,p.[VarblPurOrdUnitIsActive] 
    ,p.[VolumeUnit]
    ,p.[MaterialVolume] 
    ,p.[SalesStatus] 
    ,p.[TransportationGroup] 
    ,p.[SalesStatusValidityDate] 
    ,p.[AuthorizationGroup] 
    ,p.[ANPCode] 
    ,p.[ProductCategory] 
    ,p.[Brand] 
    ,p.[ProcurementRule] 
    ,p.[ValidityStartDate] 
    ,p.[LowLevelCode] 
    ,p.[ProdNoInGenProdInPrepackProd] 
    ,p.[SerialIdentifierAssgmtProfile] 
    ,p.[SizeOrDimensionText] 
    ,p.[IndustryStandardName] 
    ,p.[ProductStandardID] 
    ,p.[InternationalArticleNumberCat] 
    ,p.[ProductIsConfigurable] 
    ,p.[IsBatchManagementRequired] 
    ,p.[HasEmptiesBOM] 
    ,p.[ExternalProductGroup] 
    ,p.[CrossPlantConfigurableProduct] 
    ,p.[SerialNoExplicitnessLevel] 
    ,p.[ProductManufacturerNumber] 
    ,p.[ManufacturerNumber] 
    ,p.[ManufacturerPartProfile] 
    ,p.[QltyMgmtInProcmtIsActive] 
    ,p.[IsApprovedBatchRecordReqd] 
    ,p.[HandlingIndicator] 
    ,p.[WarehouseProductGroup] 
    ,p.[WarehouseStorageCondition] 
    ,p.[StandardHandlingUnitType] 
    ,p.[SerialNumberProfile] 
    ,p.[AdjustmentProfile] 
    ,p.[PreferredUnitOfMeasure]
    ,p.[IsPilferable] 
    ,p.[IsRelevantForHzdsSubstances] 
    ,p.[QuarantinePeriod] 
    ,p.[TimeUnitForQuarantinePeriod]
    ,p.[QualityInspectionGroup] 
    ,p.[HandlingUnitType] 
    ,p.[HasVariableTareWeight] 
    ,p.[MaximumPackagingLength] 
    ,p.[MaximumPackagingWidth] 
    ,p.[MaximumPackagingHeight] 
    ,p.[MaximumCapacity] 
    ,p.[OvercapacityTolerance] 
    ,p.[UnitForMaxPackagingDimensions]
    ,p.[BaseUnitSpecificProductLength] 
    ,p.[BaseUnitSpecificProductWidth] 
    ,p.[BaseUnitSpecificProductHeight] 
    ,p.[ProductMeasurementUnit]
    ,p.[ProductValidStartDate] 
    ,p.[ArticleCategory] 
    ,p.[ContentUnit]
    ,p.[NetContent] 
    ,p.[ComparisonPriceQuantity]
    ,p.[GrossContent] 
    ,p.[ProductValidEndDate] 
    ,p.[AssortmentListType] 
    ,p.[HasTextilePartsWthAnimalOrigin] 
    ,p.[ProductSeasonUsageCategory] 
    ,p.[IndustrySector] 
    ,p.[ChangeNumber]
    ,p.[MaterialRevisionLevel] 
    ,p.[IsActiveEntity] 
    ,NULL AS [LastChangeDateTime] 
    ,p.[LastChangeTime] 
    ,p.[DangerousGoodsIndProfile] 
    ,p.[ProductUUID]
    ,p.[ProdSupChnMgmtUUID22] 
    ,p.[ProductDocumentChangeNumber] 
    ,p.[ProductDocumentPageCount] 
    ,p.[ProductDocumentPageNumber] 
    ,p.[OwnInventoryManagedProduct] 
    ,p.[DocumentIsCreatedByCAD] 
    ,p.[ProductionOrInspectionMemoTxt] 
    ,p.[ProductionMemoPageFormat] 
    ,p.[GlobalTradeItemNumberVariant] 
    ,p.[ProductIsHighlyViscous] 
    ,p.[TransportIsInBulk] 
    ,p.[ProdAllocDetnProcedure] 
    ,p.[ProdEffctyParamValsAreAssigned] 
    ,p.[ProdIsEnvironmentallyRelevant] 
    ,p.[LaboratoryOrDesignOffice] 
    ,p.[PackagingMaterialGroup] 
    ,p.[ProductIsLocked] 
    ,p.[DiscountInKindEligibility] 
    ,p.[SmartFormName] 
    ,p.[PackingReferenceProduct] 
    ,p.[BasicMaterial] 
    ,p.[ProductDocumentNumber]
    ,p.[ProductDocumentVersion] 
    ,p.[ProductDocumentType] 
    ,p.[ProductDocumentPageFormat] 
    ,p.[ProductConfiguration]
    ,p.[SegmentationStrategy]
    ,p.[SegmentationIsRelevant] 
    ,p.[IsChemicalComplianceRelevant] 
    ,p.[LogisticalProductCategory] 
    ,p.[SalesProduct] 
    ,p.[DfsAmmunitionGroupCode] 
    ,p.[DfsRICIdentifier]
    ,NULL AS [ZZ1_CustomFieldRiskMit_PRD] 
    ,NULL AS [ZZ1_CustomFieldHighRis_PRD] 
    ,NULL AS [ZZ1_CustomFieldRiskRea_PRD]
    ,ep.[Plant]
    ,ep.[ProcurementType] 
    ,'1.15_ALL' AS [RuleID]
    ,1 AS [Count]
FROM
    ErrorProducts ep
INNER JOIN
    [base_s4h_cax].[I_Product] AS p
    ON
        ep.[Product] = p.[Product]