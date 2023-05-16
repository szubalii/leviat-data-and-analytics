﻿CREATE VIEW [edw].[vw_Supplier]
	AS SELECT 
	     [Supplier]                                  AS [SupplierID]
      ,[SupplierName]                              AS [Supplier] 
      ,Supplier.[SupplierAccountGroup]             AS [SupplierAccountGroupID]
      ,SupplierAccountGroupText.[AccountGroupName] AS [AccountGroup]
      ,[SupplierFullName]
      ,[IsBusinessPurposeCompleted]
      ,[CreatedByUser]
      ,[CreationDate]
      ,[IsOneTimeAccount]
      ,[AuthorizationGroup]
      ,[VATRegistration]
      ,[AccountIsBlockedForPosting]
      ,[TaxJurisdiction]
      ,[SupplierCorporateGroup]
      ,[Customer]
      ,[Industry]
      ,[TaxNumber1]
      ,[TaxNumber2]
      ,[TaxNumber3]
      ,[TaxNumber4]
      ,[TaxNumber5]
      ,[PostingIsBlocked]
      ,[PurchasingIsBlocked]
      ,[InternationalLocationNumber1]
      ,[InternationalLocationNumber2]
      ,[InternationalLocationNumber3]
      ,[AddressID]
      ,[Region]
      ,[OrganizationBPName1]
      ,[OrganizationBPName2]
      ,[CityName]
      ,[PostalCode]
      ,[StreetName]
      ,Supplier.[Country]    AS [CountryID]
      ,Country.[CountryName] AS [Country]
      ,[ConcatenatedInternationalLocNo]
      ,[SupplierProcurementBlock]
      ,[SuplrQualityManagementSystem]
      ,[SuplrQltyInProcmtCertfnValidTo]
      ,[SupplierLanguage]
      ,[AlternativePayeeAccountNumber]
      ,[PhoneNumber1]
      ,[FaxNumber]
      ,[IsNaturalPerson]
      ,[TaxNumberResponsible]
      ,[UK_ContractorBusinessType]
      ,[UK_PartnerTradingName]
      ,[UK_PartnerTaxReference]
      ,[UK_VerificationStatus]
      ,[UK_VerificationNumber]
      ,[UK_CompanyRegistrationNumber]
      ,[UK_VerifiedTaxStatus]
      ,[FormOfAddress]
      ,[ReferenceAccountGroup]
      ,[VATLiability]
      ,[ResponsibleType]
      ,[TaxNumberType]
      ,[FiscalAddress]
      ,[BusinessType]
      ,[BirthDate]
      ,[PaymentIsBlockedForSupplier]
      ,[SortField]
      ,[PhoneNumber2]
      ,[DeletionIndicator]
      ,[TradingPartner]
      ,[TaxInvoiceRepresentativeName]
      ,[IndustryType]
      , CASE 
          WHEN (
            SELECT COUNT(*)
            FROM [base_s4h_cax].[I_SupplierPurchasingOrg] Org
            WHERE Supplier.Supplier = Org.Supplier
          ) > 1
            THEN 'Global'
          WHEN (
            SELECT COUNT(*)
            FROM [base_s4h_cax].[I_SupplierPurchasingOrg] Org
            WHERE Supplier.Supplier = Org.Supplier
          ) = 1
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
  --  WHERE Supplier.[MANDT] = 200 AND SupplierAccountGroupText.[MANDT] = 200 MPS 2021/11/01: commented out due to different client values between dev,qas, and prod
