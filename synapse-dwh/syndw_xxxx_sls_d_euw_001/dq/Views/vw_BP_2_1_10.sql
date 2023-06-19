CREATE VIEW [dq].[vw_BP_2_1_10]
  AS  

WITH CustCompany AS(
SELECT
        CC.[Customer]
    ,   COUNT(DISTINCT CC.[PaymentTerms]) AS [COUNT]
FROM
    [base_s4h_cax].[I_CustomerCompany] CC
LEFT JOIN
    [base_s4h_cax].[I_CustomerSalesArea] CSA
ON
    CC.Customer = CSA.Customer 
WHERE CC.[PaymentTerms]<>CSA.[PaymentTerms]
GROUP BY
     CC.[Customer]
HAVING
    COUNT(DISTINCT CC.[PaymentTerms])>1)
SELECT
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
    ,   '2.1.10' AS [RuleID]
    ,   1 AS [Count]
FROM
    CustCompany
JOIN
    [base_s4h_cax].[I_CustomerCompany] CC
    ON
        CustCompany.[Customer] = CC.[Customer]