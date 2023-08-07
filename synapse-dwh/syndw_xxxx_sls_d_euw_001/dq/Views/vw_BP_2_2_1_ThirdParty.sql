CREATE VIEW [dq].[vw_BP_2_2_1_ThirdParty]
AS

SELECT
        [Supplier]
    ,   [PurchasingOrganization]
    ,   [PurchasingGroup]
    ,   [MaterialPlannedDeliveryDurn]
    ,   [PurchasingIsBlockedForSupplier]
    ,   [SupplierRespSalesPersonName]
    ,   [SupplierPhoneNumber]
    ,   [PurchaseOrderCurrency]
    ,   [MinimumOrderAmount]
    ,   [CalculationSchemaGroupCode]
    ,   [PaymentTerms]
    ,   [PricingDateControl]
    ,   [SupplierABCClassificationCode]
    ,   [ShippingCondition]
    ,   [PurOrdAutoGenerationIsAllowed]
    ,   [InvoiceIsGoodsReceiptBased]
    ,   [IncotermsClassification]
    ,   [IncotermsTransferLocation]
    ,   [IncotermsVersion]
    ,   [IncotermsLocation1]
    ,   [IncotermsLocation2]
    ,   [DeletionIndicator]
    ,   [PlannedDeliveryDurationInDays]
    ,   [ContactPersonPhoneNumber]
    ,   [AuthorizationGroup]
    ,   '2.2.1_ThirdParty' AS [RuleID]
    ,   1 AS [Count]
FROM
    [base_s4h_cax].[I_SupplierPurchasingOrg] SPO
WHERE
    S.[SupplierAccountGroup] = 'Z011'
    AND
    LEFT(SPO.[PaymentTerms],1)<>'L'