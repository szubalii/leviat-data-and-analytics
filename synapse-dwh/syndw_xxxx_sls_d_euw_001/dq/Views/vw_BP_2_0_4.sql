CREATE VIEW [dq].[vw_BP_2_0_4]
  AS  

WITH PhoneNumber AS(
SELECT
        BPA.[PhoneNumber]
FROM
    [base_s4h_cax].[I_BusinessPartnerAddress] BPA
WHERE 
    BPA.[PhoneNumber] <> ''
GROUP BY
    BPA.[PhoneNumber]
HAVING
    COUNT(*)>1)
,BP_PhoneNumber AS(
SELECT
        Addr.[BUSINESSPARTNER]
    ,   Addr.[PhoneNumber]
FROM
    PhoneNumber
JOIN
    [base_s4h_cax].[I_BusinessPartnerAddress] Addr
    ON
        PhoneNumber.[PhoneNumber] = Addr.[PhoneNumber]
)
SELECT    
        BP.[BusinessPartner]
    ,   BP.[BusinessPartnerCategory]
    ,   BP.[AuthorizationGroup]
    ,   BP.[BusinessPartnerUUID]
    ,   BP.[PersonNumber]
    ,   BP.[ETag]
    ,   BP.[BusinessPartnerName]
    ,   BP.[BusinessPartnerFullName]
    ,   BP.[CreatedByUser]
    ,   BP.[CreationDate]
    ,   BP.[CreationTime]
    ,   BP.[LastChangedByUser]
    ,   BP.[LastChangeDate]
    ,   BP.[LastChangeTime]
    ,   BP.[BusinessPartnerIsBlocked]
    ,   BP.[IsBusinessPurposeCompleted]
    ,   BP.[FirstName]
    ,   BP.[LastName]
    ,   BP.[PersonFullName]
    ,   BP.[OrganizationBPName1]
    ,   BP.[OrganizationBPName2]
    ,   BP.[OrganizationBPName3]
    ,   BP.[OrganizationBPName4]
    ,   BP.[InternationalLocationNumber1]
    ,   BP.[InternationalLocationNumber2]
    ,   BP.[InternationalLocationNumber3]
    ,   BP.[LegalForm]
    ,   BP.[OrganizationFoundationDate]
    ,   BP.[OrganizationLiquidationDate]
    ,   BP.[Industry]
    ,   BP.[IsNaturalPerson]
    ,   BP.[IsFemale]
    ,   BP.[IsMale]
    ,   BP.[IsSexUnknown]
    ,   BP.[FormOfAddress]
    ,   BP.[AcademicTitle]
    ,   BP.[NameFormat]
    ,   BP.[NameCountry]
    ,   BP.[BusinessPartnerGrouping]
    ,   BP.[BusinessPartnerType]
    ,   BP.[MiddleName]
    ,   BP.[AdditionalLastName]
    ,   BP.[GroupBusinessPartnerName1]
    ,   BP.[GroupBusinessPartnerName2]
    ,   BP.[CorrespondenceLanguage]
    ,   BP.[Language]
    ,   BP.[SearchTerm1]
    ,   BP.[SearchTerm2]
    ,   BP.[BPLastNameSearchHelp]
    ,   BP.[BPFirstNameSearchHelp]
    ,   BP.[BusinessPartnerNicknameLabel]
    ,   BP.[IndependentAddressID]
    ,   BP.[IsActiveEntity]
    ,   BP.[BirthDate]
    ,   BP.[IsMarkedForArchiving]
    ,   BP.[ContactPermission]
    ,   BP.[BusinessPartnerIDByExtSystem]
    ,   BP.[LegalEntityOfOrganization]
    ,   BP.[TrdCmplncLicenseIsMilitarySctr]
    ,   BP.[TrdCmplncLicenseIsNuclearSctr]
    ,   BP.[BusinessPartnerPrintFormat]
    ,   BP.[BusinessPartnerDataOriginType]
    ,   BP.[BusinessPartnerIsNotReleased]
    ,   BP.[IsNotContractuallyCapable]
    ,   '2.0.4' AS [RuleID]
    ,   1 AS [Count]
FROM
    [base_s4h_cax].[I_BusinessPartner] BP 
INNER JOIN
    BP_PhoneNumber
    ON
        BP.[BusinessPartner] = BP_PhoneNumber.[BUSINESSPARTNER]
