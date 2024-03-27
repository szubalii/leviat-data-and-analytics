CREATE VIEW [dm_procurement].[vw_dim_Supplier]
AS
SELECT
    REPLACE(LTRIM(REPLACE(SupplierID,'0',' ')),' ','0')   
                                                AS SupplierID               --trim leading zeros
    ,NULL                                       AS SupplierLocationId
    ,Supplier                                   AS SupplierName
    ,Replace(Replace(Replace(StreetName,'"',''),CHAR(10),''),CHAR(13),'')                                 AS StreetAddress
    ,CityName                                   AS City
    ,''                                         AS State
    ,Country
    ,PostalCode
    ,''                                         AS SupplierType
    ,''                                         AS ContactFirstName
    ,''                                         AS ContactLastName
    ,''                                         AS ContactPhoneNumber
    ,''                                         AS ContactEmail
    ,''                                         AS PreferredLanguage
    ,''                                         AS FaxNumber
    ,''                                         AS OrderRoutingType
    ,''                                         AS DUNSNumber
    ,''                                         AS ANNumber
    ,''                                         AS PaymentType
    ,''                                         AS Diversity
    ,''                                         AS MinorityOwned
    ,''                                         AS WomanOwned
    ,''                                         AS VeteranOwned
    ,''                                         AS DiversitySBA8A
    ,''                                         AS DiversityHUBZone
    ,''                                         AS DiversitySDB
    ,''                                         AS DiversityDVO
    ,''                                         AS DiversityEthnicity
    ,''                                         AS DiversityGLBTOwned
    ,''                                         AS DiversityDisabledOwned
    ,''                                         AS DiversityLaborSurplus
    ,''                                         AS DiversityHBCU
    ,''                                         AS DiversitySmallBusiness
    ,''                                         AS DiversityGreen
    ,''                                         AS CertifiedDiversity
    ,''                                         AS CertifiedMinorityOwned
    ,''                                         AS CertifiedWomanOwned
    ,''                                         AS CertifiedVeteranOwned
    ,''                                         AS CertifiedSBA8A
    ,''                                         AS CertifiedHUBZone
    ,''                                         AS CertifiedSDB
    ,''                                         AS CertifiedEthnicity
    ,''                                         AS CertifiedDisabledOwned
    ,''                                         AS CertifiedDisadvantaged
    ,''                                         AS DiversityEnterprise
    ,''                                         AS MinorityOwnedEnterprise
    ,''                                         AS WomanOwnedEnterprise
    ,''                                         AS VeteranOwnedEnterprise
    ,''                                         AS DVOEnterprise
    ,''                                         AS EthnicityEnterprise
    ,''                                         AS DisadvantagedEnterprise
    ,''                                         AS NumberOfEmployees
    ,''                                         AS FlexField1
    ,''                                         AS FlexField2
    ,''                                         AS FlexField3
FROM [edw].[dim_Supplier]