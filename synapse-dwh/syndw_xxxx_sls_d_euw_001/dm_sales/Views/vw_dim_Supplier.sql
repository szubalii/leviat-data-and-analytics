CREATE VIEW [dm_sales].[vw_dim_Supplier]
AS
SELECT 
    [SupplierID],
    [Supplier],
    [SupplierAccountGroupID],
    [CreationDate],
    [AccountGroup], 
    [CreatedByUser],
    [PostingIsBlocked],
    [CountryID],
    [Country],
    [CityName],
    [PostalCode],
    [StreetName],
    [DeletionIndicator],
    [SupplierCorporateGroup],
    [Global_Local],
    edw.svf_getInOutID_s4h (SupplierID) AS InOutID,
    [t_applicationId],
    [t_extractionDtm]    
FROM [edw].[dim_Supplier]
