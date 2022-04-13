CREATE VIEW [edw].[vw_SalesOrganization_US]
    AS 
SELECT
        CONCAT('US-',Comp.[COMP]) AS [SalesOrganizationID]
    ,   Comp.[CompName] AS [SalesOrganization]
    ,   'USD' AS [SalesOrganizationCurrency]
    ,   NULL AS [CompanyCode]
    ,   NULL AS [IntercompanyBillingCustomer]
    ,   NULL AS [ArgentinaDeliveryDateEvent]
    ,   'US' AS [CountryID]
    ,   'United States of America' AS [CountryName]
    ,   'US' AS [RegionID]
    ,   'United States of America' AS [RegionName]
    ,   'US' AS [Access_Control_Unit]
    ,   Comp.[t_applicationId] AS [t_applicationId]
    ,   Comp.[t_extractionDtm] AS [t_extractionDtm]
FROM
    [base_us_leviat_db].[COMPANIES] Comp