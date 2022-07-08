CREATE VIEW [dq].[vw_Product_1_11] AS

WITH deleted_ProductSalesDelivery AS
(
SELECT DISTINCT 
    psd1.Product
FROM
    [base_s4h_cax].[I_ProductSalesDelivery] psd1
LEFT JOIN
    [base_s4h_cax].[I_ProductSalesDelivery] psd2
    ON
        psd1.Product = psd2.Product
        AND
        psd2.[IsMarkedForDeletion] != 'X'  
WHERE
    psd2.Product IS NULL
),
deleted_ProductPlant AS
(
SELECT DISTINCT 
    pp1.Product
FROM
    [base_s4h_cax].[I_ProductPlant] pp1
LEFT JOIN
    [base_s4h_cax].[I_ProductPlant] pp2
    ON
        pp1.Product = pp2.Product
        AND
        pp2.[IsMarkedForDeletion] != 'X'  
WHERE
    pp2.Product IS NULL
)
SELECT 
	 P.[MANDT] 
    ,P.[Product] 
    ,P.[ProductExternalID] 
    ,P.[ProductType] 
    ,P.[CreationDate] 
    ,P.[CreationTime]
    ,P.[CreationDateTime]
    ,P.[CreatedByUser]
    ,P.[LastChangeDate] 
    ,P.[LastChangedByUser]
    ,P.[IsMarkedForDeletion] 
    ,P.[CrossPlantStatus] 
    ,P.[CrossPlantStatusValidityDate] 
    ,P.[ProductOldID] 
    ,P.[GrossWeight] 
    ,P.[PurchaseOrderQuantityUnit]
    ,P.[SourceOfSupply] 
    ,P.[WeightUnit]
    ,P.[CountryOfOrigin] 
    ,P.[CompetitorID] 
    ,P.[ProductGroup] 
    ,P.[BaseUnit]
    ,P.[ItemCategoryGroup] 
    ,P.[NetWeight] 
    ,P.[ProductHierarchy]
    ,P.[Division] 
    ,P.[VarblPurOrdUnitIsActive] 
    ,P.[VolumeUnit]
    ,P.[MaterialVolume] 
    ,P.[SalesStatus] 
    ,P.[TransportationGroup] 
    ,P.[SalesStatusValidityDate] 
    ,P.[AuthorizationGroup] 
    ,P.[ANPCode] 
    ,P.[ProductCategory] 
    ,P.[Brand] 
    ,P.[ProcurementRule] 
    ,P.[ValidityStartDate] 
    ,P.[LowLevelCode] 
    ,P.[ProdNoInGenProdInPrepackProd] 
    ,P.[SerialIdentifierAssgmtProfile] 
    ,P.[SizeOrDimensionText] 
    ,P.[IndustryStandardName] 
    ,P.[ProductStandardID] 
    ,P.[InternationalArticleNumberCat] 
    ,P.[ProductIsConfigurable] 
    ,P.[IsBatchManagementRequired] 
    ,P.[HasEmptiesBOM] 
    ,P.[ExternalProductGroup] 
    ,P.[CrossPlantConfigurableProduct] 
    ,P.[SerialNoExplicitnessLevel] 
    ,P.[ProductManufacturerNumber] 
    ,P.[ManufacturerNumber] 
    ,P.[ManufacturerPartProfile] 
    ,P.[QltyMgmtInProcmtIsActive] 
    ,P.[IsApprovedBatchRecordReqd] 
    ,P.[HandlingIndicator] 
    ,P.[WarehouseProductGroup] 
    ,P.[WarehouseStorageCondition] 
    ,P.[StandardHandlingUnitType] 
    ,P.[SerialNumberProfile] 
    ,P.[AdjustmentProfile] 
    ,P.[PreferredUnitOfMeasure]
    ,P.[IsPilferable] 
    ,P.[IsRelevantForHzdsSubstances] 
    ,P.[QuarantinePeriod] 
    ,P.[TimeUnitForQuarantinePeriod]
    ,P.[QualityInspectionGroup] 
    ,P.[HandlingUnitType] 
    ,P.[HasVariableTareWeight] 
    ,P.[MaximumPackagingLength] 
    ,P.[MaximumPackagingWidth] 
    ,P.[MaximumPackagingHeight] 
    ,P.[MaximumCapacity] 
    ,P.[OvercapacityTolerance] 
    ,P.[UnitForMaxPackagingDimensions]
    ,P.[BaseUnitSpecificProductLength] 
    ,P.[BaseUnitSpecificProductWidth] 
    ,P.[BaseUnitSpecificProductHeight] 
    ,P.[ProductMeasurementUnit]
    ,P.[ProductValidStartDate] 
    ,P.[ArticleCategory] 
    ,P.[ContentUnit]
    ,P.[NetContent] 
    ,P.[ComparisonPriceQuantity]
    ,P.[GrossContent] 
    ,P.[ProductValidEndDate] 
    ,P.[AssortmentListType] 
    ,P.[HasTextilePartsWthAnimalOrigin] 
    ,P.[ProductSeasonUsageCategory] 
    ,P.[IndustrySector] 
    ,P.[ChangeNumber]
    ,P.[MaterialRevisionLevel] 
    ,P.[IsActiveEntity] 
    ,P.[LastChangeDateTime] 
    ,P.[LastChangeTime] 
    ,P.[DangerousGoodsIndProfile] 
    ,P.[ProductUUID]
    ,P.[ProdSupChnMgmtUUID22] 
    ,P.[ProductDocumentChangeNumber] 
    ,P.[ProductDocumentPageCount] 
    ,P.[ProductDocumentPageNumber] 
    ,P.[OwnInventoryManagedProduct] 
    ,P.[DocumentIsCreatedByCAD] 
    ,P.[ProductionOrInspectionMemoTxt] 
    ,P.[ProductionMemoPageFormat] 
    ,P.[GlobalTradeItemNumberVariant] 
    ,P.[ProductIsHighlyViscous] 
    ,P.[TransportIsInBulk] 
    ,P.[ProdAllocDetnProcedure] 
    ,P.[ProdEffctyParamValsAreAssigned] 
    ,P.[ProdIsEnvironmentallyRelevant] 
    ,P.[LaboratoryOrDesignOffice] 
    ,P.[PackagingMaterialGroup] 
    ,P.[ProductIsLocked] 
    ,P.[DiscountInKindEligibility] 
    ,P.[SmartFormName] 
    ,P.[PackingReferenceProduct] 
    ,P.[BasicMaterial] 
    ,P.[ProductDocumentNumber]
    ,P.[ProductDocumentVersion] 
    ,P.[ProductDocumentType] 
    ,P.[ProductDocumentPageFormat] 
    ,P.[ProductConfiguration]
    ,P.[SegmentationStrategy]
    ,P.[SegmentationIsRelevant] 
    ,P.[IsChemicalComplianceRelevant] 
    ,P.[LogisticalProductCategory] 
    ,P.[SalesProduct] 
    ,P.[DfsAmmunitionGroupCode] 
    ,P.[DfsRICIdentifier]
    ,P.[ZZ1_CustomFieldRiskMit_PRD] 
    ,P.[ZZ1_CustomFieldHighRis_PRD] 
    ,P.[ZZ1_CustomFieldRiskRea_PRD] 
    ,'1.11_ALL' AS [RuleID]
    ,1 AS [Count]
FROM   
    [base_s4h_cax].[I_Product] P
INNER JOIN
    deleted_ProductSalesDelivery dpsd
ON
    P.Product = dpsd.Product
INNER JOIN
    deleted_ProductPlant dpp
ON
    P.Product = dpp.Product
WHERE
    P.[IsMarkedForDeletion] != 'X'
