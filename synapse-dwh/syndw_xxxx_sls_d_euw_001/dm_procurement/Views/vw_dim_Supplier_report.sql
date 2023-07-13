CREATE VIEW [dm_procurement].[vw_dim_Supplier_report]
AS
SELECT
    SupplierID
    ,SupplierLocationId
    ,SupplierName
    ,Replace(Replace(StreetAddress,'"',''),CHAR(10),'') AS StreetAddress
    ,City
    ,State
    ,Country
    ,PostalCode
    ,SupplierType
    ,ContactFirstName
    ,ContactLastName
    ,ContactPhoneNumber
    ,ContactEmail
    ,PreferredLanguage
    ,FaxNumber
    ,OrderRoutingType
    ,DUNSNumber
    ,ANNumber
    ,PaymentType
    ,Diversity
    ,MinorityOwned
    ,WomanOwned
    ,VeteranOwned
    ,DiversitySBA8A
    ,DiversityHUBZone
    ,DiversitySDB
    ,DiversityDVO
    ,DiversityEthnicity
    ,DiversityGLBTOwned
    ,DiversityDisabledOwned
    ,DiversityLaborSurplus
    ,DiversityHBCU
    ,DiversitySmallBusiness
    ,DiversityGreen
    ,CertifiedDiversity
    ,CertifiedMinorityOwned
    ,CertifiedWomanOwned
    ,CertifiedVeteranOwned
    ,CertifiedSBA8A
    ,CertifiedHUBZone
    ,CertifiedSDB
    ,CertifiedEthnicity
    ,CertifiedDisabledOwned
    ,CertifiedDisadvantaged
    ,DiversityEnterprise
    ,MinorityOwnedEnterprise
    ,WomanOwnedEnterprise
    ,VeteranOwnedEnterprise
    ,DVOEnterprise
    ,EthnicityEnterprise
    ,DisadvantagedEnterprise
    ,NumberOfEmployees
    ,FlexField1
    ,FlexField2
    ,FlexField3
FROM [dm_procurement].[vw_dim_Supplier]