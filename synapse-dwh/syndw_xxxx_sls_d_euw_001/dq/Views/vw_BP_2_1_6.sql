﻿CREATE VIEW [dq].[vw_BP_2_1_6]
  AS  

SELECT DISTINCT
         CC.[Customer]
    ,    CC.[CompanyCode]
    ,    CC.[AccountingClerk]
    ,    CC.[ReconciliationAccount]
    ,    CC.[AuthorizationGroup]
    ,    CC.[CustomerHeadOffice]
    ,    CC.[AlternativePayerAccount]
    ,    CC.[PaymentBlockingReason]
    ,    CC.[InterestCalculationCode]
    ,    CC.[InterestCalculationDate]
    ,    CC.[IntrstCalcFrequencyInMonths]
    ,    CC.[CustomerAccountNote]
    ,    CC.[APARToleranceGroup]
    ,    CC.[HouseBank]
    ,    CC.[ItemIsToBePaidSeparately]
    ,    CC.[PaytAdviceIsSentbyEDI]
    ,    CC.[PhysicalInventoryBlockInd]
    ,    CC.[UserAtCustomer]
    ,    CC.[AccountingClerkPhoneNumber]
    ,    CC.[AccountingClerkFaxNumber]
    ,    CC.[AccountingClerkInternetAddress]
    ,    CC.[AccountByCustomer]
    ,    CC.[IsToBeLocallyProcessed]
    ,    CC.[CollectiveInvoiceVariant]
    ,    CC.[LayoutSortingRule]
    ,    CC.[PaymentTerms]
    ,    CC.[CustomerSupplierClearingIsUsed]
    ,    CC.[RecordPaymentHistoryIndicator]
    ,    CC.[PaymentMethodsList]
    ,    CC.[DeletionIndicator]
    ,    CC.[CreditMemoPaymentTerms]
    ,    CC.[DunningNoticeGroup]
    ,    CC.[LastInterestCalcRunDate]
    ,    CC.[CustPreviousMasterRecordNumber]
    ,    CC.[ValueAdjustmentKey]
    ,    CC.[IsBusinessPurposeCompleted]
    ,    CC.[LastDunnedOn]
    ,    CC.[DunningProcedure]
    ,    CC.[DunningLevel]
    ,    CC.[DunningBlock]
    ,    CC.[DunningRecipient]
    ,    CC.[LegDunningProcedureOn]
    ,   '2.1.6' AS [RuleID]
    ,   1 AS [Count]
FROM
    [base_s4h_cax].[I_CustomerCompany] CC
LEFT JOIN
    [base_s4h_cax].[I_BusinessPartnerBank] BPB
    ON
        CC.[Customer] = BPB.[BUSINESSPARTNER]
WHERE
    CC.[PaymentMethodsList] = 'F'
    AND
    (BPB.[CollectionAuthInd] IS NULL OR BPB.[CollectionAuthInd] = '')
