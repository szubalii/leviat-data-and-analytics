﻿CREATE VIEW [edw].[vw_Supplier]
	AS SELECT 
	     Supplier.[Supplier]                                  AS [SupplierID]
      ,Supplier.[SupplierName]                              AS [Supplier] 
      ,Supplier.[SupplierAccountGroup]             AS [SupplierAccountGroupID]
      ,SupplierAccountGroupText.[AccountGroupName] AS [AccountGroup]
      ,Supplier.[SupplierFullName]
      ,Supplier.[IsBusinessPurposeCompleted]
      ,Supplier.[CreatedByUser]
      ,Supplier.[CreationDate]
      ,Supplier.[IsOneTimeAccount]
      ,Supplier.[AuthorizationGroup]
      ,Supplier.[VATRegistration]
      ,Supplier.[AccountIsBlockedForPosting]
      ,Supplier.[TaxJurisdiction]
      ,Supplier.[SupplierCorporateGroup]
      ,Supplier.[Customer]
      ,Supplier.[Industry]
      ,Supplier.[TaxNumber1]
      ,Supplier.[TaxNumber2]
      ,Supplier.[TaxNumber3]
      ,Supplier.[TaxNumber4]
      ,Supplier.[TaxNumber5]
      ,Supplier.[PostingIsBlocked]
      ,Supplier.[PurchasingIsBlocked]
      ,Supplier.[InternationalLocationNumber1]
      ,Supplier.[InternationalLocationNumber2]
      ,Supplier.[InternationalLocationNumber3]
      ,Supplier.[AddressID]
      ,Supplier.[Region]
      ,Supplier.[OrganizationBPName1]
      ,Supplier.[OrganizationBPName2]
      ,Supplier.[CityName]
      ,Supplier.[PostalCode]
      ,Supplier.[StreetName]
      ,Supplier.[Country]    AS [CountryID]
      ,Country.[CountryName] AS [Country]
      ,Supplier.[ConcatenatedInternationalLocNo]
      ,Supplier.[SupplierProcurementBlock]
      ,Supplier.[SuplrQualityManagementSystem]
      ,Supplier.[SuplrQltyInProcmtCertfnValidTo]
      ,Supplier.[SupplierLanguage]
      ,Supplier.[AlternativePayeeAccountNumber]
      ,Supplier.[PhoneNumber1]
      ,Supplier.[FaxNumber]
      ,Supplier.[IsNaturalPerson]
      ,Supplier.[TaxNumberResponsible]
      ,Supplier.[UK_ContractorBusinessType]
      ,Supplier.[UK_PartnerTradingName]
      ,Supplier.[UK_PartnerTaxReference]
      ,Supplier.[UK_VerificationStatus]
      ,Supplier.[UK_VerificationNumber]
      ,Supplier.[UK_CompanyRegistrationNumber]
      ,Supplier.[UK_VerifiedTaxStatus]
      ,Supplier.[FormOfAddress]
      ,Supplier.[ReferenceAccountGroup]
      ,Supplier.[VATLiability]
      ,Supplier.[ResponsibleType]
      ,Supplier.[TaxNumberType]
      ,Supplier.[FiscalAddress]
      ,Supplier.[BusinessType]
      ,Supplier.[BirthDate]
      ,Supplier.[PaymentIsBlockedForSupplier]
      ,Supplier.[SortField]
      ,Supplier.[PhoneNumber2]
      ,edw.svf_getBooleanIndicator(Supplier.[DeletionIndicator]) as DeletionIndicator
      ,Supplier.[TradingPartner]
      ,Supplier.[TaxInvoiceRepresentativeName]
      ,Supplier.[IndustryType]
      , CASE 
          WHEN COUNT(Org.Supplier) > 1
            THEN 'Global'
          WHEN COUNT(Org.Supplier) = 1
            THEN 'Local'
        ELSE 'Unassigned' END                      AS [Global_Local]
      ,Supplier.[t_applicationId]
      ,Supplier.[t_extractionDtm]
    FROM 
      [base_s4h_cax].[I_Supplier] Supplier
    LEFT JOIN 
      [base_s4h_cax].[I_SupplierAccountGroupText] SupplierAccountGroupText 
      ON 
        Supplier.[SupplierAccountGroup] = SupplierAccountGroupText.[SupplierAccountGroup]
        AND 
        SupplierAccountGroupText.[Language] = 'E'   
    LEFT JOIN 
      [base_s4h_cax].[I_CountryText] Country
      ON
        Supplier.[Country] = Country.[Country]
        AND 
        Country.[Language] = 'E'        
    LEFT JOIN 
      [base_s4h_cax].[I_SupplierPurchasingOrg] Org
      ON Supplier.Supplier = Org.Supplier
  --  WHERE Supplier.[MANDT] = 200 AND SupplierAccountGroupText.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
    GROUP BY
      Supplier.[Supplier]                                  
      ,Supplier.[SupplierName]                             
      ,Supplier.[SupplierAccountGroup]            
      ,SupplierAccountGroupText.[AccountGroupName]
      ,Supplier.[SupplierFullName]
      ,Supplier.[IsBusinessPurposeCompleted]
      ,Supplier.[CreatedByUser]
      ,Supplier.[CreationDate]
      ,Supplier.[IsOneTimeAccount]
      ,Supplier.[AuthorizationGroup]
      ,Supplier.[VATRegistration]
      ,Supplier.[AccountIsBlockedForPosting]
      ,Supplier.[TaxJurisdiction]
      ,Supplier.[SupplierCorporateGroup]
      ,Supplier.[Customer]
      ,Supplier.[Industry]
      ,Supplier.[TaxNumber1]
      ,Supplier.[TaxNumber2]
      ,Supplier.[TaxNumber3]
      ,Supplier.[TaxNumber4]
      ,Supplier.[TaxNumber5]
      ,Supplier.[PostingIsBlocked]
      ,Supplier.[PurchasingIsBlocked]
      ,Supplier.[InternationalLocationNumber1]
      ,Supplier.[InternationalLocationNumber2]
      ,Supplier.[InternationalLocationNumber3]
      ,Supplier.[AddressID]
      ,Supplier.[Region]
      ,Supplier.[OrganizationBPName1]
      ,Supplier.[OrganizationBPName2]
      ,Supplier.[CityName]
      ,Supplier.[PostalCode]
      ,Supplier.[StreetName]
      ,Supplier.[Country]   
      ,Country.[CountryName]
      ,Supplier.[ConcatenatedInternationalLocNo]
      ,Supplier.[SupplierProcurementBlock]
      ,Supplier.[SuplrQualityManagementSystem]
      ,Supplier.[SuplrQltyInProcmtCertfnValidTo]
      ,Supplier.[SupplierLanguage]
      ,Supplier.[AlternativePayeeAccountNumber]
      ,Supplier.[PhoneNumber1]
      ,Supplier.[FaxNumber]
      ,Supplier.[IsNaturalPerson]
      ,Supplier.[TaxNumberResponsible]
      ,Supplier.[UK_ContractorBusinessType]
      ,Supplier.[UK_PartnerTradingName]
      ,Supplier.[UK_PartnerTaxReference]
      ,Supplier.[UK_VerificationStatus]
      ,Supplier.[UK_VerificationNumber]
      ,Supplier.[UK_CompanyRegistrationNumber]
      ,Supplier.[UK_VerifiedTaxStatus]
      ,Supplier.[FormOfAddress]
      ,Supplier.[ReferenceAccountGroup]
      ,Supplier.[VATLiability]
      ,Supplier.[ResponsibleType]
      ,Supplier.[TaxNumberType]
      ,Supplier.[FiscalAddress]
      ,Supplier.[BusinessType]
      ,Supplier.[BirthDate]
      ,Supplier.[PaymentIsBlockedForSupplier]
      ,Supplier.[SortField]
      ,Supplier.[PhoneNumber2]
      ,Supplier.[DeletionIndicator]
      ,Supplier.[TradingPartner]
      ,Supplier.[TaxInvoiceRepresentativeName]
      ,Supplier.[IndustryType]
      ,Supplier.[t_applicationId]
      ,Supplier.[t_extractionDtm]
