CREATE TABLE [base_s4h_cax].[I_ProductSalesDelivery](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [Product] nvarchar(40) NOT NULL
, [ProductSalesOrg] nvarchar(4) NOT NULL
, [ProductDistributionChnl] nvarchar(2) NOT NULL
, [MinimumOrderQuantity] decimal(13,3)
, [SupplyingPlant] nvarchar(4)
, [PriceSpecificationProductGroup] nvarchar(2)
, [AccountDetnProductGroup] nvarchar(2)
, [DeliveryNoteProcMinDelivQty] decimal(13,3)
, [ItemCategoryGroup] nvarchar(4)
, [DeliveryQuantityUnit] nvarchar(3) -- collate Latin1_General_100_BIN2
, [DeliveryQuantity] decimal(13,3)
, [ProductSalesStatus] nvarchar(2)
, [ProductSalesStatusValidityDate] date
, [SalesMeasureUnit] nvarchar(3) -- collate Latin1_General_100_BIN2
, [IsMarkedForDeletion] nvarchar(1)
, [ProductHierarchy] nvarchar(18)
, [FirstSalesSpecProductGroup] nvarchar(3)
, [SecondSalesSpecProductGroup] nvarchar(3)
, [ThirdSalesSpecProductGroup] nvarchar(3)
, [FourthSalesSpecProductGroup] nvarchar(3)
, [FifthSalesSpecProductGroup] nvarchar(3)
, [MinimumMakeToOrderOrderQty] decimal(13,3)
, [LogisticsStatisticsGroup] nvarchar(1)
, [VolumeRebateGroup] nvarchar(2)
, [ProductCommissionGroup] nvarchar(2)
, [CashDiscountIsDeductible] nvarchar(1)
, [PricingReferenceProduct] nvarchar(40)
, [AssortmentGrade] nvarchar(2)
, [StoreListingProcedure] nvarchar(2)
, [DistrCntrListingProcedure] nvarchar(2)
, [StoreListingStartDate] date
, [StoreListingEndDate] date
, [DistrCntrListingStartDate] date
, [DistrCntrListingEndDate] date
, [StoreSaleStartDate] date
, [StoreSaleEndDate] date
, [DistrCntrSaleStartDate] date
, [DistrCntrSaleEndDate] date
, [RoundingProfile] nvarchar(4)
, [ProductUnitGroup] nvarchar(4)
, [MaxDeliveryQtyStoreOrder] decimal(13,3)
, [PriceFixingCategory] nvarchar(1)
, [VariableSalesUnitIsNotAllowed] nvarchar(1)
, [CompetitionPressureCategory] nvarchar(1)
, [ProductHasAttributeID01] nvarchar(1)
, [ProductHasAttributeID02] nvarchar(1)
, [ProductHasAttributeID03] nvarchar(1)
, [ProductHasAttributeID04] nvarchar(1)
, [ProductHasAttributeID05] nvarchar(1)
, [ProductHasAttributeID06] nvarchar(1)
, [ProductHasAttributeID07] nvarchar(1)
, [ProductHasAttributeID08] nvarchar(1)
, [ProductHasAttributeID09] nvarchar(1)
, [ProductHasAttributeID10] nvarchar(1)
, [IsActiveEntity] nvarchar(1)
, [ProdExtAssortmentPriority] nvarchar(1)
, [SubscrpnContrDfltDuration] char(3) -- collate Latin1_General_100_BIN2
, [SubscrpnContrAltvDuration1] char(3) -- collate Latin1_General_100_BIN2
, [SubscrpnContrAltvDuration2] char(3) -- collate Latin1_General_100_BIN2
, [SubscrpnContrDurationUnit] nvarchar(1)
, [SubscrpnContrDfltExtnDurn] char(3) -- collate Latin1_General_100_BIN2
, [SubscrpnContrAltvExtnDurn1] char(3) -- collate Latin1_General_100_BIN2
, [SubscrpnContrAltvExtnDurn2] char(3) -- collate Latin1_General_100_BIN2
, [SubscrpnContrExtnDurnUnit] nvarchar(1)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_ProductSalesDelivery] PRIMARY KEY NONCLUSTERED (
    [MANDT], [Product], [ProductSalesOrg], [ProductDistributionChnl]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
