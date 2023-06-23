CREATE VIEW [dq].[vw_BP_2_2_8]
  AS

WITH SupOrg AS(
SELECT
        SPO.[Supplier]
FROM
    [base_s4h_cax].[I_SupplierPurchasingOrg] SPO
GROUP BY
     SPO.[Supplier]
HAVING
    COUNT(DISTINCT PaymentTerms)>1)
SELECT
        SPO.[Supplier]
    ,   SPO.[PurchasingOrganization]
    ,   SPO.[PurchasingGroup]
    ,   SPO.[MaterialPlannedDeliveryDurn]
    ,   SPO.[PurchasingIsBlockedForSupplier]
    ,   SPO.[SupplierRespSalesPersonName]
    ,   SPO.[SupplierPhoneNumber]
    ,   SPO.[PurchaseOrderCurrency]
    ,   SPO.[MinimumOrderAmount]
    ,   SPO.[CalculationSchemaGroupCode]
    ,   SPO.[PaymentTerms]
    ,   SPO.[PricingDateControl]
    ,   SPO.[SupplierABCClassificationCode]
    ,   SPO.[ShippingCondition]
    ,   SPO.[PurOrdAutoGenerationIsAllowed]
    ,   SPO.[InvoiceIsGoodsReceiptBased]
    ,   SPO.[IncotermsClassification]
    ,   SPO.[IncotermsTransferLocation]
    ,   SPO.[IncotermsVersion]
    ,   SPO.[IncotermsLocation1]
    ,   SPO.[IncotermsLocation2]
    ,   SPO.[DeletionIndicator]
    ,   SPO.[PlannedDeliveryDurationInDays]
    ,   SPO.[ContactPersonPhoneNumber]
    ,   SPO.[AuthorizationGroup]
    ,   '2.2.8' AS [RuleID]
    ,   1 AS [Count]
FROM
    SupOrg
JOIN
    [base_s4h_cax].[I_SupplierPurchasingOrg] SPO
    ON
        SupOrg.[Supplier] = SPO.[Supplier]