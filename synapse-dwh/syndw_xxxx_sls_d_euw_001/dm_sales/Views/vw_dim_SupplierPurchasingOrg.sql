CREATE VIEW [dm_sales].[vw_dim_SupplierPurchasingOrg]
  AS 
  SELECT 
    [SupplierID],               
    [PurchasingOrganizationID], 
    [PurchasingGroupID],
    [t_applicationId],      
    [t_extractionDtm]
  FROM 
    [edw].[dim_SupplierPurchasingOrg]
