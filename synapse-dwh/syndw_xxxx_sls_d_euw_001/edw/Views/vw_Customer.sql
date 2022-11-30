CREATE VIEW [edw].[vw_Customer] AS
SELECT 
    [Customer] AS [CustomerID]
    ,STUFF(Customer, 1, PATINDEX('%[^0+]%', Customer) -1, '') AS CustomerExternalID
    ,[CustomerName] AS [Customer]
    ,[Customer] + '_' + [CustomerName] AS [CustomerID_Name]
    ,[CustomerFullName]
    ,[CreatedByUser]
    ,[CreationDate]
    ,[AddressID]
    ,[CustomerClassification]
    ,[VATRegistration]
    ,customer.[CustomerAccountGroup] AS [CustomerAccountGroupID]
    ,account_group_text.[AccountGroupName] AS [AccountGroup]
    ,[AuthorizationGroup]
    ,[DeliveryIsBlocked]
    ,[PostingIsBlocked]
    ,[BillingIsBlockedForCustomer]
    ,[OrderIsBlockedForCustomer]
    ,[InternationalLocationNumber1]
    ,[IsOneTimeAccount]
    ,[TaxJurisdiction]
    ,[Industry]
    ,[TaxNumberType]
    ,[TaxNumber1]
    ,[TaxNumber2]
    ,[TaxNumber3]
    ,[TaxNumber4]
    ,[TaxNumber5]
    ,[CustomerCorporateGroup]
    ,[Supplier]
    ,[NielsenRegion]
    ,[IndustryCode1]
    ,[IndustryCode2]
    ,[IndustryCode3]
    ,[IndustryCode4]
    ,[IndustryCode5]
    ,customer.[Country] AS [CountryID]
    ,country_text.[CountryName] AS [Country]
    ,country_text.[NationalityName]
    ,country_text.[NationalityLongName]
    ,[OrganizationBPName1]
    ,[OrganizationBPName2]
    ,[CityName]
    ,[PostalCode]
    ,[StreetName]
    ,[SortField]
    ,[FaxNumber]
    ,[BR_SUFRAMACode]
    ,customer.[Region] AS [RegionID]
    ,region_text.[RegionName] AS [Region]
    ,[TelephoneNumber1]
    ,[TelephoneNumber2]
    ,[AlternativePayerAccount]
    ,[DataMediumExchangeIndicator]
    ,[VATLiability]
    ,[IsBusinessPurposeCompleted]
    ,[ResponsibleType]
    ,[FiscalAddress]
    ,[NFPartnerIsNaturalPerson]
    ,[DeletionIndicator]
    ,customer.[Language]
    ,[TradingPartner]
    ,[TaxInvoiceRepresentativeName]
    ,[BusinessType]
    ,[IndustryType]
    ,customer.[t_applicationId]
    ,customer.[t_extractionDtm]
FROM 
    [base_s4h_cax].[I_Customer] customer
LEFT JOIN 
    [base_s4h_cax].[I_CustomerAccountGroupText] account_group_text
    ON 
        customer.[CustomerAccountGroup] = account_group_text.[CustomerAccountGroup]
        AND
        account_group_text.[Language] = 'E'
        -- AND
        -- account_group_text.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
LEFT JOIN
    [base_s4h_cax].[I_CountryText] country_text
    ON
        customer.[Country] = country_text.[Country]
        AND
        country_text.[Language] = 'E'
        -- AND
        -- country_text.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
LEFT JOIN 
    [base_s4h_cax].[I_RegionText] region_text
    ON 
        customer.[Region] = region_text.[Region]
        AND
        customer.[Country] = region_text.[Country]
        AND
        region_text.[Language] = 'E'
        -- AND
        -- region_text.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
-- WHERE  customer.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
