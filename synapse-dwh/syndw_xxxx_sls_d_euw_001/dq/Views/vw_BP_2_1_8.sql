CREATE VIEW [dq].[vw_BP_2_1_8]
  AS  
--Each Ship-To customer (account group Z002) must be assigned to at least 1 Sold-To customer.
SELECT
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
    ,   '2.1.8' AS [RuleID]
    ,   1 AS [Count]
FROM   
    [base_s4h_cax].[I_Customer] C
WHERE
    C.[CustomerAccountGroup] = 'Z002'
    AND
    NOT EXISTS
    (SELECT 
        CSPF.[CUSTOMER]
    FROM
        [base_s4h_cax].[I_CustSalesPartnerFunc] CSPF
    INNER JOIN
        [base_s4h_cax].[I_Customer] IC
        ON
            CSPF.[CUSTOMER] = IC.[Customer]
    WHERE
        CSPF.[BPCustomerNumber] = C.[Customer]
        AND
        CSPF.[PartnerFunction] = 'Z1'
        AND
        IC.[CustomerAccountGroup] = 'Z001'
    )
