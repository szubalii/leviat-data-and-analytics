CREATE VIEW [dq].[vw_BP_2_0_9_Intercompany]
  AS

SELECT DISTINCT
        S.[Supplier]
    ,   S.[SupplierAccountGroup]
    ,   S.[SupplierName]
    ,   S.[SupplierFullName]
    ,   S.[IsBusinessPurposeCompleted]
    ,   S.[CreatedByUser]
    ,   S.[CreationDate]
    ,   S.[IsOneTimeAccount]
    ,   S.[AuthorizationGroup]
    ,   S.[VATRegistration]
    ,   S.[AccountIsBlockedForPosting]
    ,   S.[TaxJurisdiction]
    ,   S.[SupplierCorporateGroup]
    ,   S.[Customer]
    ,   S.[Industry]
    ,   S.[TaxNumber1]
    ,   S.[TaxNumber2]
    ,   S.[TaxNumber3]
    ,   S.[TaxNumber4]
    ,   S.[TaxNumber5]
    ,   S.[PostingIsBlocked]
    ,   S.[PurchasingIsBlocked]
    ,   S.[InternationalLocationNumber1]
    ,   S.[InternationalLocationNumber2]
    ,   S.[InternationalLocationNumber3]
    ,   S.[AddressID]
    ,   S.[Region]
    ,   S.[OrganizationBPName1]
    ,   S.[OrganizationBPName2]
    ,   S.[CityName]
    ,   S.[PostalCode]
    ,   S.[StreetName]
    ,   S.[Country]
    ,   S.[ConcatenatedInternationalLocNo]
    ,   S.[SupplierProcurementBlock]
    ,   S.[SuplrQualityManagementSystem]
    ,   S.[SuplrQltyInProcmtCertfnValidTo]
    ,   S.[SupplierLanguage]
    ,   S.[AlternativePayeeAccountNumber]
    ,   S.[PhoneNumber1]
    ,   S.[FaxNumber]
    ,   S.[IsNaturalPerson]
    ,   S.[TaxNumberResponsible]
    ,   S.[UK_ContractorBusinessType]
    ,   S.[UK_PartnerTradingName]
    ,   S.[UK_PartnerTaxReference]
    ,   S.[UK_VerificationStatus]
    ,   S.[UK_VerificationNumber]
    ,   S.[UK_CompanyRegistrationNumber]
    ,   S.[UK_VerifiedTaxStatus]
    ,   S.[FormOfAddress]
    ,   S.[ReferenceAccountGroup]
    ,   S.[VATLiability]
    ,   S.[ResponsibleType]
    ,   S.[TaxNumberType]
    ,   S.[FiscalAddress]
    ,   S.[BusinessType]
    ,   S.[BirthDate]
    ,   S.[PaymentIsBlockedForSupplier]
    ,   S.[SortField]
    ,   S.[PhoneNumber2]
    ,   S.[DeletionIndicator]
    ,   S.[TradingPartner]
    ,   S.[TaxInvoiceRepresentativeName]
    ,   S.[IndustryType]
    ,   S.[IN_GSTSupplierClassification]
    ,   '2.0.9_Intercompany' AS [RuleID]
    ,   1 AS [Count]
FROM
    [base_s4h_cax].[I_Supplier] S
LEFT JOIN
    [base_s4h_cax].[I_SupplierCompany] SC
    ON
        S.[Supplier] = SC.[Supplier]
WHERE
    S.[SupplierAccountGroup] = 'Z099'
    AND
    (SC.[PaymentMethodsList] <> '' AND SC.[PaymentMethodsList] IS NOT NULL)
    AND
    S.[Supplier] NOT IN
    (SELECT
        [BUSINESSPARTNER]  COLLATE SQL_Latin1_General_CP1_CS_AS
     FROM
        [base_s4h_cax].[I_BusinessPartnerBank]
    )