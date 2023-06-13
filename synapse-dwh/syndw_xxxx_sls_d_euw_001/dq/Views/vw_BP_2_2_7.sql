﻿CREATE VIEW [dq].[vw_BP_2_2_7]
  AS

SELECT
        SC.[Supplier]                       
    ,   SC.[CompanyCode]                    
    ,   SC.[AuthorizationGroup]             
    ,   SC.[CompanyCodeName]                
    ,   SC.[PaymentBlockingReason]          
    ,   SC.[SupplierIsBlockedForPosting]    
    ,   SC.[IsBusinessPurposeCompleted]     
    ,   SC.[AccountingClerk]                
    ,   SC.[AccountingClerkFaxNumber]       
    ,   SC.[AccountingClerkPhoneNumber]     
    ,   SC.[AccountingClerkInternetAddress] 
    ,   SC.[SupplierClerk]                  
    ,   SC.[SupplierClerkURL]               
    ,   SC.[PaymentMethodsList]             
    ,   SC.[PaymentTerms]                   
    ,   SC.[ClearCustomerSupplier]          
    ,   SC.[IsToBeLocallyProcessed]         
    ,   SC.[ItemIsToBePaidSeparately]       
    ,   SC.[PaymentIsToBeSentByEDI]         
    ,   SC.[HouseBank]                      
    ,   SC.[CheckPaidDurationInDays]        
    ,   SC.[BillOfExchLmtAmtInCoCodeCrcy]   
    ,   SC.[SupplierClerkIDBySupplier]      
    ,   SC.[IsDoubleInvoice]                
    ,   SC.[CustomerSupplierClearingIsUsed] 
    ,   SC.[ReconciliationAccount]          
    ,   SC.[InterestCalculationCode]        
    ,   SC.[InterestCalculationDate]        
    ,   SC.[IntrstCalcFrequencyInMonths]    
    ,   SC.[SupplierHeadOffice]             
    ,   SC.[AlternativePayee]               
    ,   SC.[LayoutSortingRule]              
    ,   SC.[APARToleranceGroup]             
    ,   SC.[SupplierCertificationDate]      
    ,   SC.[SupplierAccountNote]            
    ,   SC.[WithholdingTaxCountry]          
    ,   SC.[DeletionIndicator]              
    ,   SC.[CashPlanningGroup]              
    ,   SC.[IsToBeCheckedForDuplicates]     
    ,   SC.[PersonnelNumber]                
    ,   SC.[PreviousAccountNumber]
    ,   '2.2.7' AS [RuleID]
    ,   1 AS [Count]
FROM
    [base_s4h_cax].[I_SupplierCompany] SC
LEFT JOIN
    [base_s4h_cax].[I_SupplierPurchasingOrg] SPO
    ON
        SC.[Supplier] = SPO.[Supplier]
WHERE
    SC.[PaymentTerms] = SPO.[PaymentTerms]
