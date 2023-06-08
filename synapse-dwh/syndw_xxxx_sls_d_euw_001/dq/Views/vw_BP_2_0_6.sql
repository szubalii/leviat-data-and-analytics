﻿CREATE VIEW [dq].[vw_BP_2_0_6]
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
    ,   '2.0.6' AS [RuleID]
    ,   1 AS [Count]
FROM
    [base_s4h_cax].[I_BusinessPartner] BP
WHERE
    (BP.[IsMarkedForArchiving] IS NOT NULL OR  BP.[IsMarkedForArchiving]<>'')
    AND
    (BP.[SearchTerm1] NOT LIKE '%DELETED%'
    AND
    BP.[SearchTerm1] NOT LIKE '%DUPLICATE%'
    AND
    BP.[SearchTerm1] NOT LIKE '%MERGED%'
    AND
    BP.[SearchTerm1] NOT LIKE '%CLOSED%'
    AND
    BP.[SearchTerm1] NOT LIKE '%DO NOT USE%')
