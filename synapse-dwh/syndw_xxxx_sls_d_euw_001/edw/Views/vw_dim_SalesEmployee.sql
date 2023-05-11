CREATE VIEW [edw].[vw_dim_SalesEmployee]
AS 
SELECT
          [SDDocument]
        , [PartnerFunction]
        , [PartnerFunctionName]
        , [AddressID]
        , [Customer]
        , [Personnel]
        , [FullName]
        , [CityName]
        , [StreetName]
        , [PostalCode]
        , [EmailAddress]
        , [PhoneNumber]
        , [MobilePhoneNumber] 
FROM [edw].[dim_BillingDocumentPartnerFs]
WHERE PartnerFunction = 'VE'
