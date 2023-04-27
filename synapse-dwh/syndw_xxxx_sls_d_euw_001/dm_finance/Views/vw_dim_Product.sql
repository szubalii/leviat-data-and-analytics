CREATE VIEW [dm_finance].[vw_dim_Product] AS
SELECT
  [sk_dim_Product],
  [ProductID],
  [ProductExternalID],
  [Product],
  [ProductID_Name],
  [CreationDate],
  [MaterialTypeID],
  [MaterialType],
  [IsMarkedForDeletion],
  [CrossPlantStatusID],
  [CrossPlantStatus],
  [GrossWeight],
  [SourceOfSupply],
  [CountryOfOrigin],
  [CompetitorID],
  [ProductGroup] AS [MaterialGroup], -- So all PBI datasets keep working
  [BaseUnit],
  [ItemCategoryGroup],
  [ItemCategoryGroupName],
  [ProductHierarchy],
  [Product_L1_PillarID],
  [Product_L2_GroupID],
  [Product_L3_TypeID],
  [Product_L4_FamilyID],
  [Product_L5_SubFamilyID],
  [Product_L1_Pillar],
  [Product_L2_Group],
  [Product_L3_Type],
  [Product_L4_Family],
  [Product_L5_SubFamily],
  [ProductCategory],
  [Brand],
  [IndustryStandardName],
  [ProductStandardID],
  [InternationalArticleNumberCat],
  [ProductIsConfigurable],
  [IsBatchManagementRequired],
  [ExternalProductGroup],
  [CrossPlantConfigurableProduct],
  [ProductManufacturerNumber],
  [ManufacturerNumber],
  [MaximumPackagingLength],
  [MaximumPackagingWidth],
  [MaximumPackagingHeight],
  [MaximumCapacity],
  [OvercapacityTolerance],
  [UnitForMaxPackagingDimensions],
  [BaseUnitSpecificProductLength],
  [BaseUnitSpecificProductWidth],
  [BaseUnitSpecificProductHeight],
  [ArticleCategory],
  [ProductIsLocked],
  [BasicMaterial],
  [SalesProduct],
  [NetWeight],
  [IndustrySector],
  [WeightUnit],
  [Division],
  [TransportationGroup],
  [ZZ1_CustomFieldRiskMit_PRD],
  [ZZ1_CustomFieldHighRis_PRD],
  [ZZ1_CustomFieldRiskRea_PRD],
  [CreatedByUser],
  [t_jobDtm],
  [t_applicationId],
  [t_extractionDtm]
FROM
  [edw].[dim_Product]

UNION ALL

SELECT
  [ProductID] AS [sk_dim_Product],
  [ProductID],
  [ProductExternalID],
  [Product],
  [ProductID_Name],
  NULL AS [CreationDate],
  [MaterialTypeID],
  [MaterialType],
  NULL AS [IsMarkedForDeletion],
  NULL AS [CrossPlantStatusID],
  NULL AS [CrossPlantStatus],
  NULL AS [GrossWeight],
  NULL AS [SourceOfSupply],
  NULL AS [CountryOfOrigin],
  NULL AS [CompetitorID],
  NULL AS [MaterialGroup],
  NULL AS [BaseUnit],
  NULL AS [ItemCategoryGroup],
  NULL AS [ItemCategoryGroupName],
  [ProductHierarchy],
  [Product_L1_PillarID],
  [Product_L2_GroupID],
  [Product_L3_TypeID],
  [Product_L4_FamilyID],
  [Product_L5_SubFamilyID],
  [Product_L1_Pillar],
  [Product_L2_Group],
  [Product_L3_Type],
  [Product_L4_Family],
  [Product_L5_SubFamily],
  NULL AS [ProductCategory],
  NULL AS [Brand],
  NULL AS [IndustryStandardName],
  NULL AS [ProductStandardID],
  NULL AS [InternationalArticleNumberCat],
  NULL AS [ProductIsConfigurable],
  NULL AS [IsBatchManagementRequired],
  NULL AS [ExternalProductGroup],
  NULL AS [CrossPlantConfigurableProduct],
  NULL AS [ProductManufacturerNumber],
  NULL AS [ManufacturerNumber],
  NULL AS [MaximumPackagingLength],
  NULL AS [MaximumPackagingWidth],
  NULL AS [MaximumPackagingHeight],
  NULL AS [MaximumCapacity],
  NULL AS [OvercapacityTolerance],
  NULL AS [UnitForMaxPackagingDimensions],
  NULL AS [BaseUnitSpecificProductLength],
  NULL AS [BaseUnitSpecificProductWidth],
  NULL AS [BaseUnitSpecificProductHeight],
  NULL AS [ArticleCategory],
  NULL AS [ProductIsLocked],
  NULL AS [BasicMaterial],
  NULL AS [SalesProduct],
  NULL AS [NetWeight],
  NULL AS [IndustrySector],
  NULL AS [WeightUnit],
  NULL AS [Division],
  NULL AS [TransportationGroup],
  NULL AS [ZZ1_CustomFieldRiskMit_PRD],
  NULL AS [ZZ1_CustomFieldHighRis_PRD],
  NULL AS [ZZ1_CustomFieldRiskRea_PRD],
  NULL AS [CreatedByUser],
  [t_jobDtm],
  [t_applicationId],
  [t_extractionDtm]
FROM
  [edw].[dim_AXProductSAPHierarchy]

UNION ALL

SELECT
  d.[DummyID]               AS [sk_dim_Product],
  d.[DummyID]               AS [ProductID],
  d.[DummyID]               AS [ProductExternalID],
  d.[DummyName]             AS [Product],
  d.[DummyIDName]           AS [ProductID_Name],
  NULL                      AS [CreationDate],
  NULL                      AS [MaterialTypeID],
  'MA'                      AS [MaterialType],
  NULL                      AS [IsMarkedForDeletion],
  NULL                      AS [CrossPlantStatusID],
  NULL                      AS [CrossPlantStatus],
  NULL                      AS [GrossWeight],
  NULL                      AS [SourceOfSupply],
  NULL                      AS [CountryOfOrigin],
  NULL                      AS [CompetitorID],
  NULL                      AS [MaterialGroup],
  NULL                      AS [BaseUnit],
  NULL                      AS [ItemCategoryGroup],
  NULL                      AS [ItemCategoryGroupName],
  NULL                      AS [ProductHierarchy],
  'MA'                      AS [Product_L1_PillarID],
  d.[DummyID]               AS [Product_L2_GroupID],
  d.[DummyID]               AS [Product_L3_TypeID],
  d.[DummyID]               AS [Product_L4_FamilyID],
  d.[DummyID]               AS [Product_L5_SubFamilyID],
  'Manual Adjustment'       AS [Product_L1_Pillar],
  d.[DummyName]             AS [Product_L2_Group],    
  d.[DummyName]             AS [Product_L3_Type],     
  d.[DummyName]             AS [Product_L4_Family],   
  d.[DummyName]             AS [Product_L5_SubFamily],
  NULL                      AS [ProductCategory],
  NULL                      AS [Brand],
  NULL                      AS [IndustryStandardName],
  NULL                      AS [ProductStandardID],
  NULL                      AS [InternationalArticleNumberCat],
  NULL                      AS [ProductIsConfigurable],
  NULL                      AS [IsBatchManagementRequired],
  NULL                      AS [ExternalProductGroup],
  NULL                      AS [CrossPlantConfigurableProduct],
  NULL                      AS [ProductManufacturerNumber],
  NULL                      AS [ManufacturerNumber],
  NULL                      AS [MaximumPackagingLength],
  NULL                      AS [MaximumPackagingWidth],
  NULL                      AS [MaximumPackagingHeight],
  NULL                      AS [MaximumCapacity],
  NULL                      AS [OvercapacityTolerance],
  NULL                      AS [UnitForMaxPackagingDimensions],
  NULL                      AS [BaseUnitSpecificProductLength],
  NULL                      AS [BaseUnitSpecificProductWidth],
  NULL                      AS [BaseUnitSpecificProductHeight],
  NULL                      AS [ArticleCategory],
  NULL                      AS [ProductIsLocked],
  NULL                      AS [BasicMaterial],
  NULL                      AS [SalesProduct],
  NULL                      AS [NetWeight],
  NULL                      AS [IndustrySector],
  NULL                      AS [WeightUnit],
  NULL                      AS [Division],
  NULL                      AS [TransportationGroup],
  NULL                      AS [ZZ1_CustomFieldRiskMit_PRD],
  NULL                      AS [ZZ1_CustomFieldHighRis_PRD],
  NULL                      AS [ZZ1_CustomFieldRiskRea_PRD],
  NULL                      AS [CreatedByUser],
  NULL                      AS [t_jobDtm],
  NULL                      AS [t_applicationId],
  NULL                      AS [t_extractionDtm]
FROM [edw].[vw_ACDOCA_DummyRecords] d