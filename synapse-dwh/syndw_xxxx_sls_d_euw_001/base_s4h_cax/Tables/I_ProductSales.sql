CREATE TABLE [base_s4h_cax].[I_ProductSales](
  [MANDT] char(3) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL
, [Product] nvarchar(40) NOT NULL
, [SalesStatus] nvarchar(2)
, [SalesStatusValidityDate] date
, [TaxClassification] nvarchar(1)
, [TransportationGroup] nvarchar(4)
, [AllowedPackagingWeightQty] decimal(13,3)
, [AllowedPackagingWeightQtyUnit] nvarchar(3) -- collate Latin1_General_100_BIN2
, [AllowedPackagingVolumeQty] decimal(13,3)
, [AllowedPackagingVolumeQtyUnit] nvarchar(3) -- collate Latin1_General_100_BIN2
, [PricingReferenceProduct] nvarchar(40)
, [VariantsPricingProfile] nvarchar(1)
, [IsVariantPriceAllowed] nvarchar(1)
, [LoadingGroup] nvarchar(4)
, [IsActiveEntity] nvarchar(1)
, [ExcessWeightTolerance] decimal(3,1)
, [ExcessVolumeTolerance] decimal(3,1)
, [PackagingMaterialType] nvarchar(4)
, [IsClosedPackagingMaterial] nvarchar(1)
, [VolumeMaximumLevel] decimal(3)
, [AuthorizationGroup] nvarchar(4)
, [MaterialFreightGroup] nvarchar(8)
, [StackingFactor] smallint
, [ServiceDuration] decimal(13,3)
, [ServiceDurationUnit] nvarchar(3) -- collate Latin1_General_100_BIN2
, [ServiceProfile] nvarchar(10)
, [ResponseProfile] nvarchar(10)
, [CABillgCycle] nvarchar(4)
, [SubscrpnProdBillgCycDetn] nvarchar(4)
, [SubscrpnProdTechRsceSchema] nvarchar(2)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_ProductSales] PRIMARY KEY NONCLUSTERED (
    [MANDT], [Product]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
