CREATE VIEW [dm_sales].[vw_dim_Supplier]
AS
SELECT 
    [SupplierID],
    [Supplier],
    [SupplierAccountGroupID],
    [CreatedByUser],
    [PostingIsBlocked],
    [CityName],
    [PostalCode],
    [StreetName],
    [CountryID],
    [Country],
    [DeletionIndicator],
    [t_applicationId],
    [t_extractionDtm]    
FROM [edw].[dim_Supplier]
