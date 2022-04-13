﻿CREATE VIEW [edw].[vw_ProductSalesDelivery]
AS 
SELECT 
	CONCAT_WS('¦',psd.[Product], [ProductSalesOrg], [ProductDistributionChnl]) as [nk_ProductSalesDelivery]
	,psd.[Product] AS ProductID
	,psd.[ProductSalesOrg] AS [SalesOrganizationID]
	,psd.[ProductDistributionChnl] AS [DistributionChannelID]
	,pt.[Product]
	,st.[SalesOrganization]
	,dt.[DistributionChannel]
	,[MinimumOrderQuantity]
	,[SupplyingPlant]
	,[PriceSpecificationProductGroup]
	,[AccountDetnProductGroup]
	,[DeliveryNoteProcMinDelivQty]
	,psd.[ItemCategoryGroup]
	,[DeliveryQuantityUnit]
	,[DeliveryQuantity]
	,[ProductSalesStatus]
	,[ProductSalesStatusValidityDate]
	,[SalesMeasureUnit]
	,psd.[IsMarkedForDeletion]
	,psd.[ProductHierarchy]
	,[FirstSalesSpecProductGroup]
	,[SecondSalesSpecProductGroup]
	,[ThirdSalesSpecProductGroup]
	,[FourthSalesSpecProductGroup]
	,[FifthSalesSpecProductGroup]
	,[MinimumMakeToOrderOrderQty]
	,[LogisticsStatisticsGroup]
	,[VolumeRebateGroup]
	,[ProductCommissionGroup]
	,[CashDiscountIsDeductible]
	,[PricingReferenceProduct]
	,[AssortmentGrade]
	,[StoreListingProcedure]
	,[DistrCntrListingProcedure]
	,[StoreListingStartDate]
	,[StoreListingEndDate]
	,[DistrCntrListingStartDate]
	,[DistrCntrListingEndDate]
	,[StoreSaleStartDate]
	,[StoreSaleEndDate]
	,[DistrCntrSaleStartDate]
	,[DistrCntrSaleEndDate]
	,[RoundingProfile]
	,[ProductUnitGroup]
	,[MaxDeliveryQtyStoreOrder]
	,[PriceFixingCategory]
	,[VariableSalesUnitIsNotAllowed]
	,[CompetitionPressureCategory]
	,[ProductHasAttributeID01]
	,[ProductHasAttributeID02]
	,[ProductHasAttributeID03]
	,[ProductHasAttributeID04]
	,[ProductHasAttributeID05]
	,[ProductHasAttributeID06]
	,[ProductHasAttributeID07]
	,[ProductHasAttributeID08]
	,[ProductHasAttributeID09]
	,[ProductHasAttributeID10]
	,psd.[IsActiveEntity]
	,[ProdExtAssortmentPriority]
	,[SubscrpnContrDfltDuration]
	,[SubscrpnContrAltvDuration1]
	,[SubscrpnContrAltvDuration2]
	,[SubscrpnContrDurationUnit]
	,[SubscrpnContrDfltExtnDurn]
	,[SubscrpnContrAltvExtnDurn1]
	,[SubscrpnContrAltvExtnDurn2]
	,[SubscrpnContrExtnDurnUnit]
	,psd.[t_applicationId]
FROM [base_s4h_cax].[I_ProductSalesDelivery] AS psd
LEFT JOIN
	[base_s4h_cax].[I_ProductText] AS pt
	ON 
		psd.Product = pt.Product
		AND
		pt.[Language] = 'E'
LEFT JOIN
	[base_s4h_cax].[I_SalesOrganizationText] AS st
	ON 
		psd.[ProductSalesOrg] = st.[SalesOrganization]
		AND
		st.[Language] = 'E'
LEFT JOIN
	[base_s4h_cax].[I_DistributionChannelText] AS dt
	ON 
		psd.[ProductDistributionChnl] = dt.[DistributionChannel]
		AND
		dt.[Language] = 'E'
-- WHERE 
-- 	psd.[MANDT] = 200 
-- 	AND 
-- 	pt.[MANDT] = 200 
-- 	AND 
-- 	st.[MANDT] = 200 
-- 	AND 
-- 	dt.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
