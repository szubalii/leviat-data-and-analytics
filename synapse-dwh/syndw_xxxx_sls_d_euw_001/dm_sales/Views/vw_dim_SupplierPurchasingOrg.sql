CREATE VIEW [dm_sales].[vw_dim_SupplierPurchasingOrg]
  AS 
  SELECT 
    spo.[SupplierID],               
    spo.[PurchasingOrganizationID], 
    po.[PurchasingOrganizationName] AS [PurchasingOrganization],
    spo.[PurchasingGroupID],
    pg.[PurchasingGroupName]        AS [PurchasingGroup],
    spo.[t_applicationId],      
    spo.[t_extractionDtm]
  FROM 
    [edw].[dim_SupplierPurchasingOrg] spo
  LEFT JOIN
    [base_s4h_cax].[I_PurchasingOrganization] po 
    ON 
      spo.[PurchasingOrganizationID] = po.[PurchasingOrganization]
  LEFT JOIN
    [base_s4h_cax].[I_PurchasingGroup] pg 
    ON
      spo.[PurchasingGroupID] = pg.[PurchasingGroup]