CREATE TABLE [base_s4h_cax].[I_Product](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [Product] nvarchar(40) NOT NULL
, [ProductExternalID] nvarchar(40)
, [ProductType] nvarchar(4)
, [CreationDate] date
, [CreationTime] time(0)
, [CreationDateTime] decimal(21,7)
, [CreatedByUser] nvarchar(12)
, [LastChangeDate] date
, [LastChangedByUser] nvarchar(12)
, [IsMarkedForDeletion] nvarchar(1)
, [CrossPlantStatus] nvarchar(2)
, [CrossPlantStatusValidityDate] date
, [ProductOldID] nvarchar(40)
, [GrossWeight] decimal(13,3)
, [PurchaseOrderQuantityUnit] nvarchar(3) -- collate Latin1_General_100_BIN2
, [SourceOfSupply] nvarchar(1)
, [WeightUnit] nvarchar(3) -- collate Latin1_General_100_BIN2
, [CountryOfOrigin] nvarchar(3)
, [CompetitorID] nvarchar(10)
, [ProductGroup] nvarchar(9)
, [BaseUnit] nvarchar(3) -- collate Latin1_General_100_BIN2
, [ItemCategoryGroup] nvarchar(4)
, [NetWeight] decimal(13,3)
, [ProductHierarchy] nvarchar(18)
, [Division] nvarchar(2)
, [VarblPurOrdUnitIsActive] nvarchar(1)
, [VolumeUnit] nvarchar(3) -- collate Latin1_General_100_BIN2
, [MaterialVolume] decimal(13,3)
, [SalesStatus] nvarchar(2)
, [TransportationGroup] nvarchar(4)
, [SalesStatusValidityDate] date
, [AuthorizationGroup] nvarchar(4)
, [ANPCode] char(9) -- collate Latin1_General_100_BIN2
, [ProductCategory] nvarchar(2)
, [Brand] nvarchar(4)
, [ProcurementRule] nvarchar(1)
, [ValidityStartDate] date
, [LowLevelCode] nvarchar(3)
, [ProdNoInGenProdInPrepackProd] nvarchar(40)
, [SerialIdentifierAssgmtProfile] nvarchar(4)
, [SizeOrDimensionText] nvarchar(32)
, [IndustryStandardName] nvarchar(18)
, [ProductStandardID] nvarchar(18)
, [InternationalArticleNumberCat] nvarchar(2)
, [ProductIsConfigurable] nvarchar(1)
, [IsBatchManagementRequired] nvarchar(1)
, [HasEmptiesBOM] nvarchar(1)
, [ExternalProductGroup] nvarchar(18)
, [CrossPlantConfigurableProduct] nvarchar(40)
, [SerialNoExplicitnessLevel] nvarchar(1)
, [ProductManufacturerNumber] nvarchar(40)
, [ManufacturerNumber] nvarchar(10)
, [ManufacturerPartProfile] nvarchar(4)
, [QltyMgmtInProcmtIsActive] nvarchar(1)
, [IsApprovedBatchRecordReqd] nvarchar(1)
, [HandlingIndicator] nvarchar(4)
, [WarehouseProductGroup] nvarchar(4)
, [WarehouseStorageCondition] nvarchar(2)
, [StandardHandlingUnitType] nvarchar(4)
, [SerialNumberProfile] nvarchar(4)
, [AdjustmentProfile] nvarchar(3)
, [PreferredUnitOfMeasure] nvarchar(3) -- collate Latin1_General_100_BIN2
, [IsPilferable] nvarchar(1)
, [IsRelevantForHzdsSubstances] nvarchar(1)
, [QuarantinePeriod] decimal(3)
, [TimeUnitForQuarantinePeriod] nvarchar(3) -- collate Latin1_General_100_BIN2
, [QualityInspectionGroup] nvarchar(4)
, [HandlingUnitType] nvarchar(4)
, [HasVariableTareWeight] nvarchar(1)
, [MaximumPackagingLength] decimal(15,3)
, [MaximumPackagingWidth] decimal(15,3)
, [MaximumPackagingHeight] decimal(15,3)
, [MaximumCapacity] decimal(15,3)
, [OvercapacityTolerance] decimal(3,1)
, [UnitForMaxPackagingDimensions] nvarchar(3) -- collate Latin1_General_100_BIN2
, [BaseUnitSpecificProductLength] decimal(13,3)
, [BaseUnitSpecificProductWidth] decimal(13,3)
, [BaseUnitSpecificProductHeight] decimal(13,3)
, [ProductMeasurementUnit] nvarchar(3) -- collate Latin1_General_100_BIN2
, [ProductValidStartDate] date
, [ArticleCategory] nvarchar(2)
, [ContentUnit] nvarchar(3) -- collate Latin1_General_100_BIN2
, [NetContent] decimal(13,3)
, [ComparisonPriceQuantity] decimal(5)
, [GrossContent] decimal(13,3)
, [ProductValidEndDate] date
, [AssortmentListType] nvarchar(1)
, [HasTextilePartsWthAnimalOrigin] nvarchar(1)
, [ProductSeasonUsageCategory] nvarchar(1)
, [IndustrySector] nvarchar(1)
, [ChangeNumber] nvarchar(12)
, [MaterialRevisionLevel] nvarchar(2)
, [IsActiveEntity] nvarchar(1)
, [LastChangeDateTime] decimal(21,7)
, [LastChangeTime] time(0)
, [DangerousGoodsIndProfile] nvarchar(3)
, [ProductUUID] binary(16)
, [ProdSupChnMgmtUUID22] nvarchar(22)
, [ProductDocumentChangeNumber] nvarchar(6)
, [ProductDocumentPageCount] char(3) -- collate Latin1_General_100_BIN2
, [ProductDocumentPageNumber] nvarchar(3)
, [OwnInventoryManagedProduct] nvarchar(40)
, [DocumentIsCreatedByCAD] nvarchar(1)
, [ProductionOrInspectionMemoTxt] nvarchar(18)
, [ProductionMemoPageFormat] nvarchar(4)
, [GlobalTradeItemNumberVariant] nvarchar(2)
, [ProductIsHighlyViscous] nvarchar(1)
, [TransportIsInBulk] nvarchar(1)
, [ProdAllocDetnProcedure] nvarchar(18)
, [ProdEffctyParamValsAreAssigned] nvarchar(1)
, [ProdIsEnvironmentallyRelevant] nvarchar(1)
, [LaboratoryOrDesignOffice] nvarchar(3)
, [PackagingMaterialGroup] nvarchar(4)
, [ProductIsLocked] nvarchar(1)
, [DiscountInKindEligibility] nvarchar(1)
, [SmartFormName] nvarchar(30)
, [PackingReferenceProduct] nvarchar(40)
, [BasicMaterial] nvarchar(48)
, [ProductDocumentNumber] nvarchar(22)
, [ProductDocumentVersion] nvarchar(2)
, [ProductDocumentType] nvarchar(3)
, [ProductDocumentPageFormat] nvarchar(4)
, [ProductConfiguration] char(18) -- collate Latin1_General_100_BIN2
, [SegmentationStrategy] nvarchar(8)
, [SegmentationIsRelevant] nvarchar(1)
, [IsChemicalComplianceRelevant] nvarchar(1)
, [LogisticalProductCategory] nvarchar(1)
, [SalesProduct] nvarchar(40)
, [DfsAmmunitionGroupCode] nvarchar(8)
, [DfsRICIdentifier] bigint
, [ZZ1_CustomFieldRiskMit_PRD] nvarchar(80)
, [ZZ1_CustomFieldHighRis_PRD] nvarchar(1)
, [ZZ1_CustomFieldRiskRea_PRD] nvarchar(80)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_Product] PRIMARY KEY NONCLUSTERED (
    [MANDT], [Product]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
