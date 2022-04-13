CREATE PROC [edw].[sp_load_dim_Customer] @t_jobId [varchar](36),@t_jobDtm [datetime],@t_lastActionCd [varchar](1),@t_jobBy [nvarchar](128) AS
BEGIN

    IF OBJECT_ID('syndw_xxxx_sls_d_euw_001.edw.dim_Customer', 'U') is not null TRUNCATE TABLE [edw].[dim_Customer]

    INSERT INTO [edw].[dim_Customer](
       [CustomerID]
      ,[Customer]
      ,[CustomerFullName]
      ,[CreatedByUser]
      ,[CreationDate]
      ,[AddressID]
      ,[CustomerClassification]
      ,[VATRegistration]
      ,[CustomerAccountGroupID]
      ,[AccountGroup]
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
      ,[CountryID]
      ,[Country]
      ,[NationalityName]
      ,[NationalityLongName]
      --,[CountryShortName]
      ,[OrganizationBPName1]
      ,[OrganizationBPName2]
      ,[CityName]
      ,[PostalCode]
      ,[StreetName]
      ,[SortField]
      ,[FaxNumber]
      ,[BR_SUFRAMACode]
      ,[RegionID]
      ,[Region]
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
      ,[Language]
      ,[TradingPartner]
      --,[DeliveryDateTypeRule]
      ,[TaxInvoiceRepresentativeName]
      ,[BusinessType]
      ,[IndustryType]
      --,[TW_CollvBillingIsSupported]
      --,[AlternativePayeeIsAllowed]
      ,[t_applicationId]
      ,[t_jobId]
      ,[t_jobDtm]
      ,[t_lastActionCd]
      ,[t_jobBy]
    )
    SELECT 
         [Customer] as [CustomerID]
        ,[CustomerName] as [Customer]
        ,[CustomerFullName]
        ,[CreatedByUser]
        ,[CreationDate]
        ,[AddressID]
        ,[CustomerClassification]
        ,[VATRegistration]
        ,customer.[CustomerAccountGroup] as [CustomerAccountGroupID]
        ,account_group_text.[AccountGroupName] as [AccountGroup]
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
        ,customer.[Country] as [CountryID]
        ,country_text.[CountryName]
        ,country_text.[NationalityName]
        ,country_text.[NationalityLongName]
        --,country_text.[CountryShortName] -- removed from  base layer 
        ,[OrganizationBPName1]
        ,[OrganizationBPName2]
        ,[CityName]
        ,[PostalCode]
        ,[StreetName]
        ,[SortField]
        ,[FaxNumber]
        ,[BR_SUFRAMACode]
        ,customer.[Region] as [RegionID]
        ,region_text.[RegionName] as [Region]
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
        --,[DeliveryDateTypeRule] -- removed from base layer
        ,[TaxInvoiceRepresentativeName]
        ,[BusinessType]
        ,[IndustryType]
        --,[TW_CollvBillingIsSupported]  -- removed from base layer
        --,[AlternativePayeeIsAllowed] -- removed from base layer
        ,customer.[t_applicationId]
        ,@t_jobId AS t_jobId
        ,@t_jobDtm AS t_jobDtm
        ,@t_lastActionCd AS t_lastActionCd
        ,@t_jobBy AS t_jobBy
    FROM 
        [base_s4h_uat_caa].[I_Customer] customer
    LEFT JOIN 
        [base_s4h_uat_caa].[I_CustomerAccountGroupText] account_group_text
        ON 
            customer.[CustomerAccountGroup] = account_group_text.[CustomerAccountGroup]
            AND
            account_group_text.[Language] = 'E'
            AND
            account_group_text.[MANDT] = 200 
    LEFT JOIN 
        [base_s4h_uat_caa].[I_CountryText] country_text
        ON 
            customer.[Country] = country_text.[Country]
            AND
            country_text.[Language] = 'E'
            AND
            country_text.[MANDT] = 200
    LEFT JOIN 
        [base_s4h_uat_caa].[I_RegionText] region_text
        ON 
            customer.[Region] = region_text.[Region]
            AND
            customer.[Country] = region_text.[Country]
            AND
            region_text.[Language] = 'E'
            AND
            region_text.[MANDT] = 200
        
    where  customer.[MANDT] = 200
END