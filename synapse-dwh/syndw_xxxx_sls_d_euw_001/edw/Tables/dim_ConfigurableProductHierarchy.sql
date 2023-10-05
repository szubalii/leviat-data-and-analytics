CREATE TABLE [edw].[dim_ConfigurableProductHierarchy]
(
[sk_dim_ConfigurableProductHierarchy]   NVARCHAR(117) NOT NULL
,[ProductID]                            NVARCHAR(80) NOT NULL
,[ProductExternalID]                    NVARCHAR(80)
,[Product]                              NVARCHAR(80)
,[ProductID_Name]                       NVARCHAR(160)
,[MaterialTypeID]                       NVARCHAR(8)
,[MaterialType]                         NVARCHAR(50)
,[CreationDate]                         DATE
,[CreationTime]                         TIME(0)
,[CreationDateTime]                     DECIMAL(21, 7)
,[CreatedByUser]                        NVARCHAR(24)
,[LastChangeDate]                       DATE
,[LastChangedByUser]                    NVARCHAR(24)
,[IsMarkedForDeletion]                  NVARCHAR(2)
,[CrossPlantStatus]                     NVARCHAR(4)
,[CrossPlantStatusValidityDate]         DATE
,[ProductOldID]                         NVARCHAR(80)
,[GrossWeight]                          DECIMAL(13, 3)
,[PurchaseOrderQuantityUnit]            NVARCHAR(6) -- collate Latin1_General_100_BIN2
,[SourceOfSupply]                       NVARCHAR(2)
,[WeightUnit]                           NVARCHAR(6) -- collate Latin1_General_100_BIN2
,[CountryOfOrigin]                      NVARCHAR(6)
,[CompetitorID]                         NVARCHAR(20)
,[ProductGroup]                         NVARCHAR(9)
,[MaterialGroup]                        NVARCHAR(18)
,[BaseUnit]                             NVARCHAR(6) -- collate Latin1_General_100_BIN2
,[ItemCategoryGroup]                    NVARCHAR(8)
,[NetWeight]                            DECIMAL(13, 3)
,[ProductHierarchy]                     NVARCHAR(36)
,[Product_L1_PillarID]                  NVARCHAR(36) NULL
,[Product_L2_GroupID]                   NVARCHAR(36) NULL
,[Product_L3_TypeID]                    NVARCHAR(36) NULL
,[Product_L4_FamilyID]                  NVARCHAR(36) NULL
,[Product_L5_SubFamilyID]               NVARCHAR(36) NULL
,[Product_L1_Pillar]                    NVARCHAR(80) NULL
,[Product_L2_Group]                     NVARCHAR(80) NULL
,[Product_L3_Type]                      NVARCHAR(80) NULL
,[Product_L4_Family]                    NVARCHAR(80) NULL
,[Product_L5_SubFamily]                 NVARCHAR(80) NULL
,[Division]                             NVARCHAR(4)
,[VarblPurOrdUnitIsActive]              NVARCHAR(2)
,[VolumeUnit]                           NVARCHAR(6) -- collate Latin1_General_100_BIN2
,[MaterialVolume]                       DECIMAL(13, 3)
,[SalesStatus]                          NVARCHAR(4)
,[TransportationGroup]                  NVARCHAR(8)
,[SalesStatusValidityDate]              DATE
,[AuthorizationGroup]                   NVARCHAR(8)
,[ANPCode]                              CHAR(9) -- collate Latin1_General_100_BIN2
,[ProductCategory]                      NVARCHAR(4)
,[Brand]                                NVARCHAR(8)
,[ProcurementRule]                      NVARCHAR(2)
,[ValidityStartDate]                    DATE
,[LowLevelCode]                         NVARCHAR(6)
,[ProdNoInGenProdInPrepackProd]         NVARCHAR(80)
,[SerialIdentifierAssgmtProfile]        NVARCHAR(8)
,[SizeOrDimensionText]                  NVARCHAR(64)
,[IndustryStandardName]                 NVARCHAR(36)
,[ProductStandardID]                    NVARCHAR(36)
,[InternationalArticleNumberCat]        NVARCHAR(4)
,[ProductIsConfigurable]                NVARCHAR(2)
,[IsBatchManagementRequired]            NVARCHAR(2)
,[HasEmptiesBOM]                        NVARCHAR(2)
,[ExternalProductGroup]                 NVARCHAR(36)
,[CrossPlantConfigurableProduct]        NVARCHAR(80)
,[SerialNoExplicitnessLevel]            NVARCHAR(2)
,[ProductManufacturerNumber]            NVARCHAR(80)
,[ManufacturerNumber]                   NVARCHAR(20)
,[ManufacturerPartProfile]              NVARCHAR(8)
,[QltyMgmtInProcmtIsActive]             NVARCHAR(2)
,[IsApprovedBatchRecordReqd]            NVARCHAR(2)
,[HandlingIndicator]                    NVARCHAR(8)
,[WarehouseProductGroup]                NVARCHAR(8)
,[WarehouseStorageCondition]            NVARCHAR(4)
,[StandardHandlingUnitType]             NVARCHAR(8)
,[SerialNumberProfile]                  NVARCHAR(8)
,[AdjustmentProfile]                    NVARCHAR(6)
,[PreferredUnitOfMeasure]               NVARCHAR(6) -- collate Latin1_General_100_BIN2
,[IsPilferable]                         NVARCHAR(2)
,[IsRelevantForHzdsSubstances]          NVARCHAR(2)
,[QuarantinePeriod]                     DECIMAL(3)
,[TimeUnitForQuarantinePeriod]          NVARCHAR(6) -- collate Latin1_General_100_BIN2
,[QualityInspectionGroup]               NVARCHAR(8)
,[HandlingUnitType]                     NVARCHAR(8)
,[HasVariableTareWeight]                NVARCHAR(2)
,[MaximumPackagingLength]               DECIMAL(15, 3)
,[MaximumPackagingWidth]                DECIMAL(15, 3)
,[MaximumPackagingHeight]               DECIMAL(15, 3)
,[MaximumCapacity]                      DECIMAL(15, 3)
,[OvercapacityTolerance]                DECIMAL(3, 1)
,[UnitForMaxPackagingDimensions]        NVARCHAR(6) -- collate Latin1_General_100_BIN2
,[BaseUnitSpecificProductLength]        DECIMAL(13, 3)
,[BaseUnitSpecificProductWidth]         DECIMAL(13, 3)
,[BaseUnitSpecificProductHeight]        DECIMAL(13, 3)
,[ProductMeasurementUnit]               NVARCHAR(6) -- collate Latin1_General_100_BIN2
,[ProductValidStartDate]                DATE
,[ArticleCategory]                      NVARCHAR(4)
,[ContentUnit]                          NVARCHAR(6) -- collate Latin1_General_100_BIN2
,[NetContent]                           DECIMAL(13, 3)
,[ComparisonPriceQuantity]              DECIMAL(5)
,[GrossContent]                         DECIMAL(13, 3)
,[ProductValidEndDate]                  DATE
,[AssortmentListType]                   NVARCHAR(2)
,[HasTextilePartsWthAnimalOrigin]       NVARCHAR(2)
,[ProductSeasonUsageCategory]           NVARCHAR(2)
,[IndustrySector]                       NVARCHAR(2)
,[ChangeNumber]                         NVARCHAR(24)
,[MaterialRevisionLevel]                NVARCHAR(4)
,[IsActiveEntity]                       NVARCHAR(2)
,[LastChangeDateTime]                   DECIMAL(21, 7)
,[LastChangeTime]                       TIME(0)
,[DangerousGoodsIndProfile]             NVARCHAR(6)
,[ProductUUID]                          BINARY(16)
,[ProdSupChnMgmtUUID22]                 NVARCHAR(44)
,[ProductDocumentChangeNumber]          NVARCHAR(12)
,[ProductDocumentPageCount]             CHAR(3) -- collate Latin1_General_100_BIN2
,[ProductDocumentPageNumber]            NVARCHAR(6)
,[OwnInventoryManagedProduct]           NVARCHAR(80)
,[DocumentIsCreatedByCAD]               NVARCHAR(2)
,[ProductionOrInspectionMemoTxt]        NVARCHAR(36)
,[ProductionMemoPageFormat]             NVARCHAR(8)
,[GlobalTradeItemNumberVariant]         NVARCHAR(4)
,[ProductIsHighlyViscous]               NVARCHAR(2)
,[TransportIsInBulk]                    NVARCHAR(2)
,[ProdAllocDetnProcedure]               NVARCHAR(36)
,[ProdEffctyParamValsAreAssigned]       NVARCHAR(2)
,[ProdIsEnvironmentallyRelevant]        NVARCHAR(2)
,[LaboratoryOrDesignOffice]             NVARCHAR(6)
,[PackagingMaterialGroup]               NVARCHAR(8)
,[ProductIsLocked]                      NVARCHAR(2)
,[DiscountInKindEligibility]            NVARCHAR(2)
,[SmartFormName]                        NVARCHAR(60)
,[PackingReferenceProduct]              NVARCHAR(80)
,[BasicMaterial]                        NVARCHAR(96)
,[ProductDocumentNumber]                NVARCHAR(44)
,[ProductDocumentVersion]               NVARCHAR(4)
,[ProductDocumentType]                  NVARCHAR(6)
,[ProductDocumentPageFormat]            NVARCHAR(8)
,[ProductConfiguration]                 CHAR(18) -- collate Latin1_General_100_BIN2
,[SegmentationStrategy]                 NVARCHAR(16)
,[SegmentationIsRelevant]               NVARCHAR(2)
,[IsChemicalComplianceRelevant]         NVARCHAR(2)
,[LogisticalProductCategory]            NVARCHAR(2)
,[SalesProduct]                         NVARCHAR(80)
,[ProdCHARc1InternalNumber]             CHAR(10) -- collate Latin1_General_100_BIN2
,[ProdCHARc2InternalNumber]             CHAR(10) -- collate Latin1_General_100_BIN2
,[ProdCHARc3InternalNumber]             CHAR(10) -- collate Latin1_General_100_BIN2
,[ProductCHARacteristic1]               NVARCHAR(36)
,[ProductCHARacteristic2]               NVARCHAR(36)
,[ProductCHARacteristic3]               NVARCHAR(36)
,[DfsAmmunitionGroupCode]               NVARCHAR(16)
,[DfsRICIdentifier]                     BIGINT
,[DfsProductSensitivity]                NVARCHAR(8)
,[DfsManufacturerPartLongNumber]        NVARCHAR(120)
,[DfsMatlConditionMgmt]                 NVARCHAR(2)
,[DfsReturnDelivery]                    NVARCHAR(2)
,[DfsLogisticsLevel]                    NVARCHAR(2)
,[DfsNationalItemIdnNumber]             NVARCHAR(18)
,[ZZ1_CustomFieldRiskMit_PRD]           NVARCHAR(160)
,[ZZ1_CustomFieldHighRis_PRD]           NVARCHAR(2)
,[ZZ1_CustomFieldRiskRea_PRD]           NVARCHAR(160)
,[t_applicationId]                      VARCHAR(32)
,[t_jobId]                              VARCHAR(36)
,[t_jobDtm]                             DATETIME
,[t_lastActionCd]                       VARCHAR(1)
,[t_jobBy]                              NVARCHAR(128)
,[t_extractionDtm]                      DATETIME
,CONSTRAINT [PK_dim_ConfigurableProductHierarchy] PRIMARY KEY NONCLUSTERED (sk_dim_ConfigurableProductHierarchy) NOT ENFORCED
)
WITH
    (DISTRIBUTION = REPLICATE, HEAP )
GO
