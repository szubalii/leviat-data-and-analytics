CREATE VIEW [dq].[vw_BP_2_0_4]
  AS  

WITH PhoneNumber AS(
SELECT
        A.[PhoneNumber]
    ,   COUNT(*) AS [COUNT]
FROM
    [base_s4h_cax].[I_Address] A
GROUP BY
    A.[PhoneNumber]
HAVING
    COUNT(*)>1)
SELECT
        A.[AddressID]
    ,   A.[CareOfName]
    ,   A.[AdditionalStreetSuffixName]
    ,   A.[CorrespondenceLanguage]
    ,   A.[PrfrdCommMediumType]
    ,   A.[POBox]
    ,   A.[POBoxIsWithoutNumber]
    ,   A.[POBoxPostalCode]
    ,   A.[POBoxLobbyName]
    ,   A.[POBoxDeviatingCityName]
    ,   A.[POBoxDeviatingRegion]
    ,   A.[POBoxDeviatingCountry]
    ,   A.[DeliveryServiceTypeCode]
    ,   A.[DeliveryServiceNumber]
    ,   A.[AddressTimeZone]
    ,   A.[FullName]
    ,   A.[CityName]
    ,   A.[District]
    ,   A.[CityCode]
    ,   A.[HomeCityName]
    ,   A.[PostalCode]
    ,   A.[CompanyPostalCode]
    ,   A.[StreetName]
    ,   A.[StreetPrefixName]
    ,   A.[AdditionalStreetPrefixName]
    ,   A.[StreetSuffixName]
    ,   A.[HouseNumber]
    ,   A.[HouseNumberSupplementText]
    ,   A.[Building]
    ,   A.[Floor]
    ,   A.[RoomNumber]
    ,   A.[Country]
    ,   A.[Region]
    ,   A.[County]
    ,   A.[CountyCode]
    ,   A.[FormOfAddress]
    ,   A.[BusinessPartnerName1]
    ,   A.[BusinessPartnerName2]
    ,   A.[Nation]
    ,   A.[PhoneNumber]
    ,   A.[FaxNumber]
    ,   A.[SearchTerm1]
    ,   A.[SearchTerm2]
    ,   A.[StreetSearch]
    ,   A.[CitySearch]
    ,   A.[BusinessPartnerName3]
    ,   A.[BusinessPartnerName4]
    ,   A.[TaxJurisdiction]
    ,   A.[TransportZone]
    ,   A.[Person]
    ,   '2.0.4' AS [RuleID]
    ,   1 AS [Count]
FROM
    PhoneNumber
JOIN
    [base_s4h_cax].[I_Address] A
    ON
        PhoneNumber.[PhoneNumber] = A.[PhoneNumber]
ORDER BY
    A.[PhoneNumber]
