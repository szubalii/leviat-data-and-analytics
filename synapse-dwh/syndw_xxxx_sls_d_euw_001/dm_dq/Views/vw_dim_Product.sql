CREATE VIEW [dm_dq].[vw_dim_Product] AS 

SELECT 
	[sk_dim_Product]
	, [ProductID]
	, [ProductExternalID]
	, [Product]
	, [ProductID_Name]
	, [CreationDate]
	, [MaterialTypeID]
	, [MaterialType]
	, [CrossPlantStatus]
	, [ProductGroup]
	, [ProductHierarchy]
	, [Product_L1_PillarID]
	, [Product_L2_GroupID]
	, [Product_L3_TypeID]
	, [Product_L4_FamilyID]
	, [Product_L5_SubFamilyID]
	, [Product_L1_Pillar]
	, [Product_L2_Group]
	, [Product_L3_Type]
	, [Product_L4_Family]
	, [Product_L5_SubFamily]
    , [GrossWeight]
    , [NetWeight]
    , [ProductManufacturerNumber]
    , [IndustrySector]
    , [WeightUnit]
    , [Division]
    , [TransportationGroup]
    , [ItemCategoryGroup]
	, [CreatedByUser]
FROM
    [edw].[dim_Product] P

LEFT JOIN 
    [base_s4h_cax].[I_Productprocurement]   PPr 
    ON
        PPr.[Product] =  P.[ProductID] 