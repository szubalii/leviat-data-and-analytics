﻿CREATE TABLE [edw].[dim_Product]
(
-- Product
    [sk_dim_Product]                 nvarchar(117) NOT NULL,
    [ProductID]                      nvarchar(80) NOT NULL, -- renamed (ex Product)
    [ProductExternalID]              nvarchar(80),
    [Product]                        nvarchar(80),
    [ProductID_Name]                 nvarchar(160),
    [MaterialTypeID]                 nvarchar(8),           -- renamed (ex ProductType) from [base_s4h_cax].[I_ProductTypeText]
    [MaterialType]                   nvarchar(50),          -- from [base_s4h_cax].[I_ProductTypeText]
    [CreationDate]                   date,
    [CreationTime]                   time(0),
    [CreationDateTime]               decimal(21, 7),
    [CreatedByUser]                  nvarchar(24),
    [LastChangeDate]                 date,
    [LastChangedByUser]              nvarchar(24),
    [IsMarkedForDeletion]            nvarchar(2),
    [CrossPlantStatusID]             nvarchar(4),
    [CrossPlantStatus]               nvarchar(25),
    [CrossPlantStatusValidityDate]   date,
    [ProductOldID]                   nvarchar(80),
    [GrossWeight]                    decimal(13, 3),
    [PurchaseOrderQuantityUnit]      nvarchar(6),
    [SourceOfSupply]                 nvarchar(2),
    [WeightUnit]                     nvarchar(6),
    [CountryOfOrigin]                nvarchar(6),
    [CompetitorID]                   nvarchar(20),
    [ProductGroup]                   nvarchar(9),
    [MaterialGroup]                  nvarchar(18),
    [BaseUnit]                       nvarchar(6),
    [ItemCategoryGroup]              nvarchar(8),
    [ItemCategoryGroupName]          nvarchar(20),
    [NetWeight]                      decimal(13, 3),
    [ProductHierarchy]               nvarchar(36),
    [Product_L1_PillarID]            nvarchar(36) NULL,
    [Product_L2_GroupID]             nvarchar(36) NULL,
    [Product_L3_TypeID]              nvarchar(36) NULL,
    [Product_L4_FamilyID]            nvarchar(36) NULL,
    [Product_L5_SubFamilyID]         nvarchar(36) NULL,
    [Product_L1_Pillar]              nvarchar(80) NULL,
    [Product_L2_Group]               nvarchar(80) NULL,
    [Product_L3_Type]                nvarchar(80) NULL,
    [Product_L4_Family]              nvarchar(80) NULL,
    [Product_L5_SubFamily]           nvarchar(80) NULL,
    [Division]                       nvarchar(4),
    [VarblPurOrdUnitIsActive]        nvarchar(2),
    [VolumeUnit]                     nvarchar(6),
    [MaterialVolume]                 decimal(13, 3),
    [SalesStatus]                    nvarchar(4),
    [TransportationGroup]            nvarchar(8),
    [SalesStatusValidityDate]        date,
    [AuthorizationGroup]             nvarchar(8),
    [ANPCode]                        char(9),
    [ProductCategory]                nvarchar(4),
    [Brand]                          nvarchar(8),
    [ProcurementRule]                nvarchar(2),
    [ValidityStartDate]              date,
    [LowLevelCode]                   nvarchar(6),
    [ProdNoInGenProdInPrepackProd]   nvarchar(80),
    [SerialIdentifierAssgmtProfile]  nvarchar(8),
    [SizeOrDimensionText]            nvarchar(64),
    [IndustryStandardName]           nvarchar(36),
    [ProductStandardID]              nvarchar(36),
    [InternationalArticleNumberCat]  nvarchar(4),
    [ProductIsConfigurable]          nvarchar(2),
    [IsBatchManagementRequired]      nvarchar(2),
    [HasEmptiesBOM]                  nvarchar(2),
    [ExternalProductGroup]           nvarchar(36),
    [CrossPlantConfigurableProduct]  nvarchar(80),
    [SerialNoExplicitnessLevel]      nvarchar(2),
    [ProductManufacturerNumber]      nvarchar(80),
    [ManufacturerNumber]             nvarchar(20),
    [ManufacturerPartProfile]        nvarchar(8),
    [QltyMgmtInProcmtIsActive]       nvarchar(2),
    [IsApprovedBatchRecordReqd]      nvarchar(2),
    [HandlingIndicator]              nvarchar(8),
    [WarehouseProductGroup]          nvarchar(8),
    [WarehouseStorageCondition]      nvarchar(4),
    [StandardHandlingUnitType]       nvarchar(8),
    [SerialNumberProfile]            nvarchar(8),
    [AdjustmentProfile]              nvarchar(6),
    [PreferredUnitOfMeasure]         nvarchar(6),
    [IsPilferable]                   nvarchar(2),
    [IsRelevantForHzdsSubstances]    nvarchar(2),
    [QuarantinePeriod]               decimal(3),
    [TimeUnitForQuarantinePeriod]    nvarchar(6),
    [QualityInspectionGroup]         nvarchar(8),
    [HandlingUnitType]               nvarchar(8),
    [HasVariableTareWeight]          nvarchar(2),
    [MaximumPackagingLength]         decimal(15, 3),
    [MaximumPackagingWidth]          decimal(15, 3),
    [MaximumPackagingHeight]         decimal(15, 3),
    [MaximumCapacity]                decimal(15, 3),
    [OvercapacityTolerance]          decimal(3, 1),
    [UnitForMaxPackagingDimensions]  nvarchar(6),
    [BaseUnitSpecificProductLength]  decimal(13, 3),
    [BaseUnitSpecificProductWidth]   decimal(13, 3),
    [BaseUnitSpecificProductHeight]  decimal(13, 3),
    [ProductMeasurementUnit]         nvarchar(6),
    [ProductValidStartDate]          date,
    [ArticleCategory]                nvarchar(4),
    [ContentUnit]                    nvarchar(6),
    [NetContent]                     decimal(13, 3),
    [ComparisonPriceQuantity]        decimal(5),
    [GrossContent]                   decimal(13, 3),
    [ProductValidEndDate]            date,
    [AssortmentListType]             nvarchar(2),
    [HasTextilePartsWthAnimalOrigin] nvarchar(2),
    [ProductSeasonUsageCategory]     nvarchar(2),
    [IndustrySector]                 nvarchar(2),
    [ChangeNumber]                   nvarchar(24),
    [MaterialRevisionLevel]          nvarchar(4),
    [IsActiveEntity]                 nvarchar(2),
    [LastChangeDateTime]             decimal(21, 7),
    [LastChangeTime]                 time(0),
    [DangerousGoodsIndProfile]       nvarchar(6),
    [ProductUUID]                    binary(16),
    [ProdSupChnMgmtUUID22]           nvarchar(44),
    [ProductDocumentChangeNumber]    nvarchar(12),
    [ProductDocumentPageCount]       char(3),
    [ProductDocumentPageNumber]      nvarchar(6),
    [OwnInventoryManagedProduct]     nvarchar(80),
    [DocumentIsCreatedByCAD]         nvarchar(2),
    [ProductionOrInspectionMemoTxt]  nvarchar(36),
    [ProductionMemoPageFormat]       nvarchar(8),
    [GlobalTradeItemNumberVariant]   nvarchar(4),
    [ProductIsHighlyViscous]         nvarchar(2),
    [TransportIsInBulk]              nvarchar(2),
    [ProdAllocDetnProcedure]         nvarchar(36),
    [ProdEffctyParamValsAreAssigned] nvarchar(2),
    [ProdIsEnvironmentallyRelevant]  nvarchar(2),
    [LaboratoryOrDesignOffice]       nvarchar(6),
    [PackagingMaterialGroup]         nvarchar(8),
    [ProductIsLocked]                nvarchar(2),
    [DiscountInKindEligibility]      nvarchar(2),
    [SmartFormName]                  nvarchar(60),
    [PackingReferenceProduct]        nvarchar(80),
    [BasicMaterial]                  nvarchar(96),
    [ProductDocumentNumber]          nvarchar(44),
    [ProductDocumentVersion]         nvarchar(4),
    [ProductDocumentType]            nvarchar(6),
    [ProductDocumentPageFormat]      nvarchar(8),
    [ProductConfiguration]           char(18),
    [SegmentationStrategy]           nvarchar(16),
    [SegmentationIsRelevant]         nvarchar(2),
    [IsChemicalComplianceRelevant]   nvarchar(2),
    [LogisticalProductCategory]      nvarchar(2),
    [SalesProduct]                   nvarchar(80),
    [DfsAmmunitionGroupCode]         nvarchar(16),
    [DfsRICIdentifier]               bigint,
    [MaterialGroupName]              nvarchar(20),
    [MaterialGroupText]              nvarchar(60),
    [EClassCode]                     NVARCHAR(8),
    [EClassCategory]                 NVARCHAR(64),
    [EClassCategoryDescription]      NVARCHAR(128),
    [Category_L1]                    NVARCHAR(128),
    [Category_L2]                    NVARCHAR(128),
    [Category_L3]                    NVARCHAR(128),
    [Category_L4]                    NVARCHAR(128),
    [Classification]                 NVARCHAR(8),
    [ZZ1_CustomFieldRiskMit_PRD]     nvarchar(160),
    [ZZ1_CustomFieldHighRis_PRD]     nvarchar(2),
    [ZZ1_CustomFieldRiskRea_PRD]     nvarchar(160),
    [t_applicationId]                VARCHAR(32),
    [t_jobId]                        VARCHAR(36),
    [t_jobDtm]                       DATETIME,
    [t_lastActionCd]                 VARCHAR(1),
    [t_jobBy]                        NVARCHAR(128),
    [t_extractionDtm]                DATETIME,
    CONSTRAINT [PK_dim_Product] PRIMARY KEY NONCLUSTERED ([sk_dim_Product]) NOT ENFORCED
)
    WITH
        (
        DISTRIBUTION = REPLICATE, HEAP )
GO