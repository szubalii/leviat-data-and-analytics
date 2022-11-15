CREATE VIEW [dm_dq].[vw_dim_Product] AS 

SELECT 
	  P.[sk_dim_Product]
	, P.[ProductID]
	, P.[ProductExternalID]
	, P.[Product]
	, P.[ProductID_Name]
	, P.[CreationDate]
	, P.[MaterialTypeID]
	, P.[MaterialType]
	, P.[CrossPlantStatus]
	, P.[ProductGroup]
	, P.[ProductHierarchy]
	, P.[Product_L1_PillarID]
	, P.[Product_L2_GroupID]
	, P.[Product_L3_TypeID]
	, P.[Product_L4_FamilyID]
	, P.[Product_L5_SubFamilyID]
	, P.[Product_L1_Pillar]
	, P.[Product_L2_Group]
	, P.[Product_L3_Type]
	, P.[Product_L4_Family]
	, P.[Product_L5_SubFamily]
    , P.[GrossWeight]
    , P.[NetWeight]
    , P.[ProductManufacturerNumber]
    , P.[IndustrySector]
    , P.[WeightUnit]
    , P.[Division]
    , P.[TransportationGroup]
    , P.[ItemCategoryGroup]
	, P.[CreatedByUser]
	, PPr.[PurchasingAcknProfile]
FROM
    [edw].[dim_Product] P

LEFT JOIN 
    [base_s4h_cax].[I_Productprocurement]   PPr 
    ON
        PPr.[Product] =  P.[ProductID] 