CREATE VIEW [dq].[vw_BP_2_1_9]
  AS 

WITH CustSalesArea AS(
SELECT
        CSA.[Customer]
FROM
    [base_s4h_cax].[I_CustomerSalesArea] CSA
GROUP BY
     CSA.[Customer]
HAVING
    COUNT(DISTINCT [PaymentTerms])>1)
SELECT

        CSA.[Customer]
    ,   CSA.[SalesOrganization]
    ,   CSA.[DistributionChannel]
    ,   CSA.[Division]
    ,   CSA.[CustomerABCClassification]
    ,   CSA.[SalesOffice]
    ,   CSA.[SalesGroup]
    ,   CSA.[OrderIsBlockedForCustomer]
    ,   CSA.[Currency]
    ,   CSA.[CustomerPriceGroup]
    ,   CSA.[PriceListType]
    ,   CSA.[DeliveryPriority]
    ,   CSA.[ShippingCondition]
    ,   CSA.[IncotermsClassification]
    ,   CSA.[SupplyingPlant]
    ,   CSA.[CompleteDeliveryIsDefined]
    ,   CSA.[DeliveryIsBlockedForCustomer]
    ,   CSA.[BillingIsBlockedForCustomer]
    ,   CSA.[CustomerPaymentTerms]
    ,   CSA.[CustomerAccountAssignmentGroup]
    ,   CSA.[AccountByCustomer]
    ,   CSA.[CustomerGroup]
    ,   CSA.[CustomerPricingProcedure]
    ,   CSA.[OrderCombinationIsAllowed]
    ,   CSA.[PartialDeliveryIsAllowed]
    ,   CSA.[InvoiceDate]
    ,   CSA.[PaymentTerms]
    ,   CSA.[IncotermsTransferLocation]
    ,   CSA.[ItemOrderProbabilityInPercent]
    ,   CSA.[IncotermsLocation2]
    ,   CSA.[AuthorizationGroup]
    ,   CSA.[SalesDistrict]
    ,   CSA.[IncotermsVersion]
    ,   CSA.[IncotermsLocation1]
    ,   CSA.[DeletionIndicator]
    ,   CSA.[IsBusinessPurposeCompleted]
    ,   CSA.[SalesItemProposal]
    ,   CSA.[MaxNmbrOfPartialDelivery]
    ,   CSA.[UnderdelivTolrtdLmtRatioInPct]
    ,   CSA.[OverdelivTolrtdLmtRatioInPct]
    ,   CSA.[IsActiveEntity]
    ,   CSA.[AdditionalCustomerGroup1]
    ,   CSA.[AdditionalCustomerGroup2]
    ,   CSA.[AdditionalCustomerGroup3]
    ,   CSA.[AdditionalCustomerGroup4]
    ,   CSA.[AdditionalCustomerGroup5]
    ,   '2.1.9' AS [RuleID]
    ,   1 AS [Count]
FROM
    CustSalesArea
JOIN
    [base_s4h_cax].[I_CustomerSalesArea] CSA
    ON
        CustSalesArea.[Customer] = CSA.[Customer]