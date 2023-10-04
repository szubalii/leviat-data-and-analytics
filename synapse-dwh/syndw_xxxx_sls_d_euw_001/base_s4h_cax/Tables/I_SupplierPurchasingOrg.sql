CREATE TABLE [base_s4h_cax].[I_SupplierPurchasingOrg]
-- SupplierPurchasingOrganization
(
    [MANDT]                          nchar(3) collate Latin1_General_100_BIN2     NOT NULL,
    [Supplier]                       nvarchar(10) NOT NULL -- collate Latin1_General_100_BIN2 NOT NULL,
    [PurchasingOrganization]         nvarchar(4) collate Latin1_General_100_BIN2  NOT NULL,
    [PurchasingGroup]                nvarchar(3) -- collate Latin1_General_100_BIN2,
    [MaterialPlannedDeliveryDurn]    decimal(3),
    [PurchasingIsBlockedForSupplier] nvarchar(1) -- collate Latin1_General_100_BIN2,
    [SupplierRespSalesPersonName]    nvarchar(30) -- collate Latin1_General_100_BIN2,
    [SupplierPhoneNumber]            nvarchar(16) -- collate Latin1_General_100_BIN2,
    [PurchaseOrderCurrency]          nchar(5) -- collate Latin1_General_100_BIN2,
    [MinimumOrderAmount]             decimal(13, 2),
    [CalculationSchemaGroupCode]     nvarchar(2) -- collate Latin1_General_100_BIN2,
    [PaymentTerms]                   nvarchar(4) -- collate Latin1_General_100_BIN2,
    [PricingDateControl]             nvarchar(1) -- collate Latin1_General_100_BIN2,
    [SupplierABCClassificationCode]  nvarchar(1) -- collate Latin1_General_100_BIN2,
    [ShippingCondition]              nvarchar(2) -- collate Latin1_General_100_BIN2,
    [PurOrdAutoGenerationIsAllowed]  nvarchar(1) -- collate Latin1_General_100_BIN2,
    [InvoiceIsGoodsReceiptBased]     nvarchar(1) -- collate Latin1_General_100_BIN2,
    [IncotermsClassification]        nvarchar(3) -- collate Latin1_General_100_BIN2,
    [IncotermsTransferLocation]      nvarchar(28) -- collate Latin1_General_100_BIN2,
    [IncotermsVersion]               nvarchar(4) -- collate Latin1_General_100_BIN2,
    [IncotermsLocation1]             nvarchar(70) -- collate Latin1_General_100_BIN2,
    [IncotermsLocation2]             nvarchar(70) -- collate Latin1_General_100_BIN2,
    [DeletionIndicator]              nvarchar(1) -- collate Latin1_General_100_BIN2,
    [PlannedDeliveryDurationInDays]  decimal(3),
    [ContactPersonPhoneNumber]       nvarchar(16) -- collate Latin1_General_100_BIN2,
    [AuthorizationGroup]             nvarchar(4) -- collate Latin1_General_100_BIN2,
    [t_applicationId]                VARCHAR(32),
    [t_jobId]                        VARCHAR(36),
    [t_jobDtm]                       DATETIME,
    [t_jobBy]                        NVARCHAR(128),
    [t_extractionDtm]                DATETIME,
    [t_filePath]                     NVARCHAR(1024),
    CONSTRAINT [PK_I_SupplierPurchasingOrg] PRIMARY KEY NONCLUSTERED ([MANDT], [Supplier], [PurchasingOrganization]) NOT ENFORCED
)
WITH (
    HEAP
    )