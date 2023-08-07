CREATE VIEW [dq].[vw_BP_2_2_1_ThirdParty]
AS

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
    ,   '2.2.1_ThirdParty' AS [RuleID]
    ,   1 AS [Count]
FROM
    [base_s4h_cax].[I_SupplierPurchasingOrg] SPO
LEFT JOIN
    [base_s4h_cax].[I_Supplier] S
    ON
        S.[Supplier] = SPO.[Supplier]
WHERE
    S.[SupplierAccountGroup] = 'Z011'
    AND
    LEFT(SPO.[PaymentTerms],1)<>'L'