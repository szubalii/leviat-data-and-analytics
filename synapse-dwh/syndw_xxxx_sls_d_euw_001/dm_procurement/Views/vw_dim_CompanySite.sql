CREATE VIEW [dm_procurement].[vw_dim_CompanySite]
AS

SELECT
    [PurchasingOrganization]        AS SiteId
    ,[PurchasingOrganizationName]   AS SiteName
    ,''                             AS CompanyLevel0
    ,''                             AS CompanyLevel1
    ,''                             AS CompanyLevel2
    ,''                             AS CompanyLevel3
    ,''                             AS StreetAddress
    ,''                             AS City
    ,''                             AS State
    ,''                             AS Country
    ,''                             AS PostalCode
    ,''                             AS Region
    ,''                             AS FlexField1
    ,''                             AS FlexField2
    ,''                             AS FlexField3
FROM [base_s4h_cax].[I_PurchasingOrganization]