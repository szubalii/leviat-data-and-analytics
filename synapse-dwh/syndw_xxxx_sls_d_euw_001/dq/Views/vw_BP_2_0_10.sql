﻿CREATE VIEW [dq].[vw_BP_2_0_10]
  AS  

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
    ,   '2.0.10' AS [RuleID]
    ,   1 AS [Count]
FROM
    [base_s4h_cax].[I_BusinessPartner] BP
LEFT JOIN
    [base_s4h_cax].[I_Customer] C
    ON
        BP.[BusinessPartner] /*COLLATE SQL_Latin1_General_CP1_CS_AS*/ = C.[Customer]
LEFT JOIN
    [base_s4h_cax].[I_Address] A
    ON
        A.[AddressID] = C.[AddressID]
WHERE
    BP.[BusinessPartnerGrouping] IN ('Z001', 'Z002')
    AND
    UPPER(BP.[SearchTerm1] /*COLLATE SQL_Latin1_General_CP1_CS_AS*/) <> UPPER(CONCAT_WS(
        '',
        LEFT(edw.svf_removeSpecialCharacters(BP.[OrganizationBPName1] /*COLLATE SQL_Latin1_General_CP1_CS_AS*/), 5),
        LEFT(edw.svf_removeSpecialCharacters(A.[CityName]), 5)))