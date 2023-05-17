CREATE VIEW [dm_sales].[vw_dim_Supplier]
AS
SELECT 
    [SupplierID],
    [Supplier],
    [SupplierAccountGroupID],
    [AccountGroup], 
    [CreatedByUser],
    [PostingIsBlocked],
    [CountryID],
    [Country],
    [CityName],
    [PostalCode],
    [StreetName],
    [DeletionIndicator],
    [SupplierCorporateGroup]
    [t_applicationId],
    [t_extractionDtm]    
FROM [edw].[dim_Supplier]
