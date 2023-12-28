CREATE TABLE [edw].[dim_ProductSalesDelivery] (
-- Product Sales Delivery
  [sk_ProductSalesDelivery] int IDENTITY(1,1) NOT NULL
, [nk_ProductSalesDelivery] nvarchar(94) NOT NULL
, [ProductID] nvarchar(80) NOT NULL -- renamed (ex Product)
, [SalesOrganizationID] nvarchar(8) NOT NULL -- renamed (ex ProductSalesOrg)
, [DistributionChannelID] nvarchar(4) NOT NULL -- renamed (ex ProductDistributionChnl)
, [Product] nvarchar(80) -- from [base_s4h_cax].[I_ProductText].[ProductName]
, [SalesOrganization] nvarchar(40) -- from [base_s4h_cax].[I_SalesOrganizationText].[SalesOrganizationName]
, [DistributionChannel] nvarchar(40) -- from [base_s4h_cax].[I_DistributionChannelText].[DistributionChannelName]
, [MinimumOrderQuantity] decimal(13,3)
, [SupplyingPlant] nvarchar(8)
, [PriceSpecificationProductGroup] nvarchar(4)
, [AccountDetnProductGroup] nvarchar(4)
, [DeliveryNoteProcMinDelivQty] decimal(13,3)
, [ItemCategoryGroup] nvarchar(8)
, [DeliveryQuantityUnit] nvarchar(6) 
, [DeliveryQuantity] decimal(13,3)
, [ProductSalesStatus] nvarchar(4)
, [ProductSalesStatusValidityDate] date
, [SalesMeasureUnit] nvarchar(6) 
, [IsMarkedForDeletion] nvarchar(2)
, [ProductHierarchy] nvarchar(36)
, [FirstSalesSpecProductGroup] nvarchar(6)
, [SecondSalesSpecProductGroup] nvarchar(6)
, [ThirdSalesSpecProductGroup] nvarchar(6)
, [FourthSalesSpecProductGroup] nvarchar(6)
, [FifthSalesSpecProductGroup] nvarchar(6)
, [MinimumMakeToOrderOrderQty] decimal(13,3)
, [LogisticsStatisticsGroup] nvarchar(2)
, [VolumeRebateGroup] nvarchar(4)
, [ProductCommissionGroup] nvarchar(4)
, [CashDiscountIsDeductible] nvarchar(2)
, [PricingReferenceProduct] nvarchar(80)
, [AssortmentGrade] nvarchar(4)
, [StoreListingProcedure] nvarchar(4)
, [DistrCntrListingProcedure] nvarchar(4)
, [StoreListingStartDate] date
, [StoreListingEndDate] date
, [DistrCntrListingStartDate] date
, [DistrCntrListingEndDate] date
, [StoreSaleStartDate] date
, [StoreSaleEndDate] date
, [DistrCntrSaleStartDate] date
, [DistrCntrSaleEndDate] date
, [RoundingProfile] nvarchar(8)
, [ProductUnitGroup] nvarchar(8)
, [MaxDeliveryQtyStoreOrder] decimal(13,3)
, [PriceFixingCategory] nvarchar(2)
, [VariableSalesUnitIsNotAllowed] nvarchar(2)
, [CompetitionPressureCategory] nvarchar(2)
, [ProductHasAttributeID01] nvarchar(2)
, [ProductHasAttributeID02] nvarchar(2)
, [ProductHasAttributeID03] nvarchar(2)
, [ProductHasAttributeID04] nvarchar(2)
, [ProductHasAttributeID05] nvarchar(2)
, [ProductHasAttributeID06] nvarchar(2)
, [ProductHasAttributeID07] nvarchar(2)
, [ProductHasAttributeID08] nvarchar(2)
, [ProductHasAttributeID09] nvarchar(2)
, [ProductHasAttributeID10] nvarchar(2)
, [IsActiveEntity] nvarchar(2)
, [ProdExtAssortmentPriority] nvarchar(2)
--, [BaseUnit] nvarchar(6) 
, [SubscrpnContrDfltDuration] char(3) 
, [SubscrpnContrAltvDuration1] char(3) 
, [SubscrpnContrAltvDuration2] char(3) 
, [SubscrpnContrDurationUnit] nvarchar(2)
, [SubscrpnContrDfltExtnDurn] char(3) 
, [SubscrpnContrAltvExtnDurn1] char(3) 
, [SubscrpnContrAltvExtnDurn2] char(3) 
, [SubscrpnContrExtnDurnUnit] nvarchar(2)
, [IsConfigurable]            varchar(3)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_lastActionCd]        VARCHAR(1)
, [t_jobBy]               NVARCHAR(128)
 ,   CONSTRAINT [PK_dim_ProductSalesDelivery] PRIMARY KEY NONCLUSTERED ([sk_ProductSalesDelivery]) NOT ENFORCED
)
WITH
(
    DISTRIBUTION = REPLICATE,
    HEAP
)
GO
