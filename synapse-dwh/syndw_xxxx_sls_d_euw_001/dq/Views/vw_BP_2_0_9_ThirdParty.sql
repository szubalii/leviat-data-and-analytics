CREATE VIEW [dq].[vw_BP_2_0_9_ThirdParty]
  AS  

SELECT DISTINCT
        C.[Customer]
    ,   C.[CustomerName]
    ,   C.[CustomerFullName]
    ,   C.[CreatedByUser]
    ,   C.[CreationDate]
    ,   C.[AddressID]
    ,   C.[CustomerClassification]
    ,   C.[VATRegistration]
    ,   C.[CustomerAccountGroup]
    ,   C.[AuthorizationGroup]
    ,   C.[DeliveryIsBlocked]
    ,   C.[PostingIsBlocked]
    ,   C.[BillingIsBlockedForCustomer] 
    ,   C.[OrderIsBlockedForCustomer]
    ,   C.[InternationalLocationNumber1]
    ,   C.[IsOneTimeAccount]
    ,   C.[TaxJurisdiction]
    ,   C.[Industry]
    ,   C.[TaxNumberType]
    ,   C.[TaxNumber1]
    ,   C.[TaxNumber2]
    ,   C.[TaxNumber3]
    ,   C.[TaxNumber4]
    ,   C.[TaxNumber5]
    ,   C.[CustomerCorporateGroup]
    ,   C.[Supplier]
    ,   C.[NielsenRegion]
    ,   C.[IndustryCode1]
    ,   C.[IndustryCode2]
    ,   C.[IndustryCode3]
    ,   C.[IndustryCode4]
    ,   C.[IndustryCode5]
    ,   C.[Country]
    ,   C.[OrganizationBPName1]
    ,   C.[OrganizationBPName2]
    ,   C.[CityName]
    ,   C.[PostalCode]
    ,   C.[StreetName]
    ,   C.[SortField]
    ,   C.[FaxNumber]
    ,   C.[BR_SUFRAMACode]
    ,   C.[Region]
    ,   C.[TelephoneNumber1]
    ,   C.[TelephoneNumber2]
    ,   C.[AlternativePayerAccount]
    ,   C.[DataMediumExchangeIndicator]
    ,   C.[VATLiability]
    ,   C.[IsBusinessPurposeCompleted]
    ,   C.[ResponsibleType]
    ,   C.[FiscalAddress]
    ,   C.[NFPartnerIsNaturalPerson]
    ,   C.[DeletionIndicator]
    ,   C.[Language]
    ,   C.[TradingPartner]
    ,   C.[TaxInvoiceRepresentativeName]
    ,   C.[BusinessType]
    ,   C.[IndustryType]
    ,   '2.0.9_ThirdParty' AS [RuleID]
    ,   1 AS [Count]
FROM   
    [base_s4h_cax].[I_Customer] C
LEFT JOIN 
    [base_s4h_cax].[I_CustomerCompany] CC
    ON 
        C.[Customer] = CC.[Customer]
WHERE
    C.[CustomerAccountGroup] = 'Z011'
    AND
    (CC.[PaymentMethodsList]<>'' AND CC.[PaymentMethodsList] IS NOT NULL)
    AND 
    C.[Customer] NOT IN
    (SELECT
        [BUSINESSPARTNER]
     FROM
        [base_s4h_cax].[I_BusinessPartnerBank]
    )