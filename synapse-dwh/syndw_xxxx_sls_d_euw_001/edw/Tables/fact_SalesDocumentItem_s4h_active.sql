CREATE TABLE [edw].[fact_SalesDocumentItem_s4h_active]
(
    [sk_fact_SalesDocumentItem]        int IDENTITY (1,1)                           NOT NULL,
    [nk_fact_SalesDocumentItem]        nvarchar(94)                                 NOT NULL,
    [SalesDocument]                    nvarchar(20)                                 NOT NULL,
    [SalesDocumentItem]                nvarchar(24) collate Latin1_General_100_BIN2 NOT NULL,
    [CurrencyTypeID]                   CHAR(2)                                      NOT NULL,
    [CurrencyType]                     NVARCHAR(20)                                 NOT NULL,
    [CurrencyID]                       CHAR(5)                                      NULL,
    [ExchangeRate]                     DECIMAL(15, 6)                               NULL,
    [SDDocumentCategoryID]             nvarchar(4),
    [SalesDocumentTypeID]              nvarchar(4),
    [SalesDocumentItemCategoryID]      nvarchar(4),
    [IsReturnsItemID]                  nvarchar(1),
    [CreationDate]                     DATETIME2,
    [CreationTime]                     time(0),
    [LastChangeDate]                   DATETIME2,
    [SalesOrganizationID]              nvarchar(4),
    [DistributionChannelID]            nvarchar(2),
    [DivisionID]                       nvarchar(2),
    [SalesGroupID]                     nvarchar(3),
    [SalesOfficeID]                    nvarchar(4),
    [InternationalArticleNumberID]     nvarchar(18),
    [BatchID]                          nvarchar(10),
    [MaterialID]                       nvarchar(40),
    [ProductSurrogateKey]              nvarchar(117),
    [OriginallyRequestedMaterialID]    nvarchar(40),
    [MaterialSubstitutionReasonID]     nvarchar(4),
    [MaterialGroupID]                  nvarchar(9),
    [BrandID]                          NVARCHAR(3),
    [AdditionalMaterialGroup2ID]       nvarchar(3),
    [AdditionalMaterialGroup3ID]       nvarchar(3),
    [AdditionalMaterialGroup4ID]       nvarchar(3),
    [AdditionalMaterialGroup5ID]       nvarchar(3),
    [SoldToPartyID]                    nvarchar(10),
    [AdditionalCustomerGroup1ID]       nvarchar(3),
    [AdditionalCustomerGroup2ID]       nvarchar(3),
    [AdditionalCustomerGroup3ID]       nvarchar(3),
    [AdditionalCustomerGroup4ID]       nvarchar(3),
    [AdditionalCustomerGroup5ID]       nvarchar(3),
    [ShipToPartyID]                    nvarchar(10),
    [PayerPartyID]                     nvarchar(10),
    [BillToPartyID]                    nvarchar(10),
    [SDDocumentReasonID]               nvarchar(3),
    [SalesDocumentDate]                DATETIME2,
    [OrderQuantity]                    decimal(15, 3),
    [OrderQuantityUnitID]              nvarchar(3) collate Latin1_General_100_BIN2,
    [TargetQuantity]                   decimal(13, 3),
    [TargetQuantityUnitID]             nvarchar(3) collate Latin1_General_100_BIN2,
    [TargetToBaseQuantityDnmntr]       decimal(5),
    [TargetToBaseQuantityNmrtr]        decimal(5),
    [OrderToBaseQuantityDnmntr]        decimal(5),
    [OrderToBaseQuantityNmrtr]         decimal(5),
    [ConfdDelivQtyInOrderQtyUnit]      decimal(15, 3),
    [TargetDelivQtyInOrderQtyUnit]     decimal(15, 3),
    [ConfdDeliveryQtyInBaseUnit]       decimal(15, 3),
    [BaseUnitID]                       nvarchar(3) collate Latin1_General_100_BIN2,
    [ItemGrossWeight]                  decimal(15, 3),
    [ItemNetWeight]                    decimal(15, 3),
    [ItemWeightUnitID]                 nvarchar(3) collate Latin1_General_100_BIN2,
    [ItemVolume]                       decimal(15, 3),
    [ItemVolumeUnitID]                 nvarchar(3) collate Latin1_General_100_BIN2,
    [ServicesRenderedDate]             DATETIME2,
    [SalesDistrictID]                  nvarchar(6),
    [CustomerGroupID]                  nvarchar(2),
    [HdrOrderProbabilityInPercentID]   char(3) collate Latin1_General_100_BIN2,
    [ItemOrderProbabilityInPercentID]  char(3) collate Latin1_General_100_BIN2,
    [SalesDocumentRjcnReasonID]        nvarchar(2),
    [PricingDate]                      DATETIME2,
    [ExchangeRateDate]                 DATETIME2,
    [PriceDetnExchangeRate]            decimal(9, 5),
    [StatisticalValueControlID]        nvarchar(1),
    [NetAmount]                        decimal(19, 6),
    [TransactionCurrencyID]            char(5) collate Latin1_General_100_BIN2,
    [SalesOrganizationCurrencyID]      char(5) collate Latin1_General_100_BIN2,
    [NetPriceAmount]                   decimal(19, 6),
    [NetPriceQuantity]                 decimal(5),
    [NetPriceQuantityUnitID]           nvarchar(3) collate Latin1_General_100_BIN2,
    [TaxAmount]                        decimal(19, 6),
    [CostAmount]                       decimal(19, 6),
    [Margin]                           decimal(19, 6),
    [Subtotal1Amount]                  decimal(19, 6),
    [Subtotal2Amount]                  decimal(19, 6),
    [Subtotal3Amount]                  decimal(19, 6),
    [Subtotal4Amount]                  decimal(19, 6),
    [Subtotal5Amount]                  decimal(19, 6),
    [Subtotal6Amount]                  decimal(19, 6),
    [ShippingPointID]                  nvarchar(4),
    [ShippingTypeID]                   nvarchar(2),
    [DeliveryPriorityID]               char(2) collate Latin1_General_100_BIN2,
    [InventorySpecialStockTypeID]      nvarchar(1),
    [RequestedDeliveryDate]            DATETIME2,
    [ShippingConditionID]              nvarchar(2),
    [DeliveryBlockReasonID]            nvarchar(2),
    [PlantID]                          nvarchar(4),
    [StorageLocationID]                nvarchar(4),
    [RouteID]                          nvarchar(6),
    [IncotermsClassificationID]        nvarchar(3),
    [IncotermsVersionID]               nvarchar(4),
    [IncotermsTransferLocationID]      nvarchar(28),
    [IncotermsLocation1ID]             nvarchar(70),
    [IncotermsLocation2ID]             nvarchar(70),
    [MinDeliveryQtyInBaseUnit]         decimal(13, 3),
    [UnlimitedOverdeliveryIsAllowedID] nvarchar(1),
    [OverdelivTolrtdLmtRatioInPct]     decimal(3, 1),
    [UnderdelivTolrtdLmtRatioInPct]    decimal(3, 1),
    [PartialDeliveryIsAllowedID]       nvarchar(1),
    [BindingPeriodValidityStartDate]   DATETIME2,
    [BindingPeriodValidityEndDate]     DATETIME2,
    [OutlineAgreementTargetAmount]     decimal(13, 2),
    [BillingDocumentDate]              DATETIME2,
    [BillingCompanyCodeID]             nvarchar(4),
    [HeaderBillingBlockReasonID]       nvarchar(2),
    [ItemBillingBlockReasonID]         nvarchar(2),
    [FiscalYearID]                     char(4) collate Latin1_General_100_BIN2,
    [FiscalPeriodID]                   char(3) collate Latin1_General_100_BIN2,
    [CustomerAccountAssignmentGroupID] nvarchar(2),
    [ExchangeRateTypeID]               nvarchar(4),
    [CompanyCodeCurrencyID]            char(5) collate Latin1_General_100_BIN2,
    [FiscalYearVariantID]              nvarchar(2),
    [BusinessAreaID]                   nvarchar(4),
    [ProfitCenterID]                   nvarchar(10),
    [OrderID]                          nvarchar(12),
    [ProfitabilitySegmentID]           char(10) collate Latin1_General_100_BIN2,
    [ControllingAreaID]                nvarchar(4),
    [ReferenceSDDocumentID]            nvarchar(10),
    [ReferenceSDDocumentItemID]        char(6) collate Latin1_General_100_BIN2,
    [ReferenceSDDocumentCategoryID]    nvarchar(4),
    [OriginSDDocumentID]               nvarchar(10),
    [OriginSDDocumentItemID]           char(6) collate Latin1_General_100_BIN2,
    [OverallSDProcessStatusID]         nvarchar(1),
    [OverallTotalDeliveryStatusID]     nvarchar(1),
    [OverallOrdReltdBillgStatusID]     nvarchar(1),
    [TotalCreditCheckStatusID]         nvarchar(1),
    [DeliveryBlockStatusID]            nvarchar(1),
    [BillingBlockStatusID]             nvarchar(1),
    [TotalSDDocReferenceStatusID]      nvarchar(1),
    [SDDocReferenceStatusID]           nvarchar(1),
    [OverallSDDocumentRejectionStsID]  nvarchar(1),
    [SDDocumentRejectionStatusID]      nvarchar(1),
    [OverallTotalSDDocRefStatusID]     nvarchar(1),
    [OverallSDDocReferenceStatusID]    nvarchar(1),
    [ItemGeneralIncompletionStatusID]  nvarchar(1),
    [ItemBillingIncompletionStatusID]  nvarchar(1),
    [PricingIncompletionStatusID]      nvarchar(1),
    [ItemDeliveryIncompletionStatusID] nvarchar(1),
    [ExternalSalesAgentID]             NVARCHAR(20)                                 NULL,
    [ExternalSalesAgent]               NVARCHAR(160)                                NULL,
    [GlobalParentID]                   NVARCHAR(20)                                 NULL,
    [GlobalParent]                     NVARCHAR(160)                                NULL,
    [LocalParentID]                    NVARCHAR(20)                                 NULL,
    [LocalParent]                      NVARCHAR(160)                                NULL,
    [ProjectID]                        NVARCHAR(20)                                 NULL,
    [Project]                          NVARCHAR(160)                                NULL,
    [SalesEmployeeID]                  NVARCHAR(20)                                 NULL,
    [SalesEmployee]                    NVARCHAR(160)                                NULL,
    [GlobalParentCalculatedID]         NVARCHAR(20)                                 NULL,
    [GlobalParentCalculated]           NVARCHAR(160)                                NULL,
    [LocalParentCalculatedID]          NVARCHAR(20)                                 NULL,
    [LocalParentCalculated]            NVARCHAR(160)                                NULL,
    [SDoc_ControllingObjectID]         NVARCHAR(22) collate Latin1_General_100_BIN2,
    [SDItem_ControllingObjectID]       NVARCHAR(22) collate Latin1_General_100_BIN2,
    [CorrespncExternalReference]       VARCHAR(12),
    [InOutID]                          CHAR(1) collate Latin1_General_100_BIN2      NULL,
    [t_applicationId]                  VARCHAR(32),
    [t_extractionDtm]                  DATETIME,
    [t_jobId]                          VARCHAR(36),
    [t_jobDtm]                         DATETIME,
    [t_jobBy]                          NVARCHAR(128),
    [t_lastActionBy]                   VARCHAR(128),
    [t_lastActionCd]                   CHAR(1),
    [t_lastActionDtm]                  DATETIME,
    CONSTRAINT [PK_fact_SalesDocumentItem_s4h_active] PRIMARY KEY NONCLUSTERED ([sk_fact_SalesDocumentItem]) NOT ENFORCED
)
WITH (
    DISTRIBUTION = HASH ([nk_fact_SalesDocumentItem]), CLUSTERED COLUMNSTORE INDEX
)
