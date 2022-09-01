CREATE VIEW [edw].[vw_SupplierPurchasingOrg]
  AS 
  SELECT 
    [Supplier]               AS [SupplierID],               
    [PurchasingOrganization] AS [PurchasingOrganizationID], 
    [PurchasingGroup]        AS [PurchasingGroupID],
    [t_applicationId],          
    [t_extractionDtm]          
  FROM  
    [base_s4h_cax].[I_SupplierPurchasingOrg]
