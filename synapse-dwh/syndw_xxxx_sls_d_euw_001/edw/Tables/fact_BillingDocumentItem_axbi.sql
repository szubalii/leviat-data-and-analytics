CREATE TABLE [edw].[fact_BillingDocumentItem_axbi]
(
    [BillingDocument]                       NVARCHAR(40)                                 NOT NULL,
    [BillingDocumentItem]                   CHAR(7) collate Latin1_General_100_BIN2      NOT NULL,
    [CurrencyTypeID]                        CHAR(2)                                      NOT NULL,
    [CurrencyType]                          NVARCHAR(20)                                 NOT NULL,
    [CurrencyID]                            CHAR(5) collate Latin1_General_100_BIN2      NULL,
    [ExchangeRate]                          DECIMAL(15, 6)                               NULL,
    [SalesDocumentItemCategoryID]           NVARCHAR(8)                                  NULL,
    [SalesDocumentItemTypeID]               NVARCHAR(2)                                  NULL,
    [ReturnItemProcessingType]              NVARCHAR(2)                                  NULL,
    [BillingDocumentTypeID]                 NVARCHAR(8)                                  NULL,
    [BillingDocumentCategoryID]             NVARCHAR(2)                                  NULL,
    [SDDocumentCategoryID]                  NVARCHAR(8)                                  NULL,
    [CreationDate]                          DATE                                         NULL,
    [CreationTime]                          TIME(0)                                      NULL,
    [LastChangeDate]                        DATE                                         NULL,
    [BillingDocumentDate]                   DATE                                         NULL,
    [BillingDocumentIsTemporary]            NVARCHAR(2)                                  NULL,
    [OrganizationDivision]                  NVARCHAR(4)                                  NULL,
    [Division]                              NVARCHAR(4)                                  NULL,
    [SalesOfficeID]                         NVARCHAR(8)                                  NULL,
    [SalesOrganizationID]                   NVARCHAR(8)                                  NULL,
    [DistributionChannelID]                 NVARCHAR(4)                                  NULL,
    [Material]                              NVARCHAR(80)                                 NULL,
    [OriginallyRequestedMaterial]           NVARCHAR(80)                                 NULL,
    [InternationalArticleNumber]            NVARCHAR(36)                                 NULL,
    [PricingReferenceMaterial]              NVARCHAR(80)                                 NULL,
    [LengthInMPer1]                         DECIMAL(38, 2),
    [LengthInM]                             DECIMAL(38, 2),
    [Batch]                                 NVARCHAR(20)                                 NULL,
    [MaterialGroupID]                       NVARCHAR(18)                                 NULL,
    [BrandID]                               NVARCHAR(3)                                  NULL,
    [AdditionalMaterialGroup2]              NVARCHAR(6)                                  NULL,
    [AdditionalMaterialGroup3]              NVARCHAR(6)                                  NULL,
    [AdditionalMaterialGroup4]              NVARCHAR(6)                                  NULL,
    [AdditionalMaterialGroup5]              NVARCHAR(6)                                  NULL,
    [MaterialCommissionGroup]               NVARCHAR(4)                                  NULL,
    [PlantID]                               NVARCHAR(8)                                  NULL,
    [StorageLocationID]                     NVARCHAR(8)                                  NULL,
    [BillingDocumentIsCancelled]            NVARCHAR(2)                                  NULL,
    [CancelledBillingDocument]              NVARCHAR(20)                                 NULL,
    [CancelledInvoiceEffect]                CHAR(1)                                      NULL,
    [BillingDocumentItemText]               NVARCHAR(80)                                 NULL,
    [ServicesRenderedDate]                  DATE                                         NULL,
    [BillingQuantity]                       DECIMAL(13, 3)                               NULL,
    [BillingQuantityUnitID]                 NVARCHAR(6) collate Latin1_General_100_BIN2  NULL,
    [BillingQuantityInBaseUnit]             DECIMAL(13, 3)                               NULL,
    [BaseUnit]                              NVARCHAR(6) collate Latin1_General_100_BIN2  NULL,
    [MRPRequiredQuantityInBaseUnit]         DECIMAL(13, 3)                               NULL,
    [BillingToBaseQuantityDnmntr]           DECIMAL(5)                                   NULL,
    [BillingToBaseQuantityNmrtr]            DECIMAL(5)                                   NULL,
    [ItemGrossWeight]                       DECIMAL(15, 3)                               NULL,
    [ItemNetWeight]                         DECIMAL(15, 3)                               NULL,
    [ItemWeightUnit]                        NVARCHAR(6) collate Latin1_General_100_BIN2  NULL,
    [ItemVolume]                            DECIMAL(15, 3)                               NULL,
    [ItemVolumeUnit]                        NVARCHAR(6) collate Latin1_General_100_BIN2  NULL,
    [BillToPartyCountry]                    NVARCHAR(6)                                  NULL,
    [BillToPartyRegion]                     NVARCHAR(6)                                  NULL,
    [BillingPlanRule]                       NVARCHAR(2)                                  NULL,
    [BillingPlan]                           NVARCHAR(20)                                 NULL,
    [BillingPlanItem]                       CHAR(6) collate Latin1_General_100_BIN2      NULL,
    [CustomerPriceGroupID]                  NVARCHAR(4)                                  NULL,
    [PriceListTypeID]                       NVARCHAR(4)                                  NULL,
    [TaxDepartureCountry]                   NVARCHAR(6)                                  NULL,
    [VATRegistration]                       NVARCHAR(40)                                 NULL,
    [VATRegistrationCountry]                NVARCHAR(6)                                  NULL,
    [VATRegistrationOrigin]                 NVARCHAR(2)                                  NULL,
    [CustomerTaxClassification1]            NVARCHAR(2)                                  NULL,
    [CustomerTaxClassification2]            NVARCHAR(2)                                  NULL,
    [CustomerTaxClassification3]            NVARCHAR(2)                                  NULL,
    [CustomerTaxClassification4]            NVARCHAR(2)                                  NULL,
    [CustomerTaxClassification5]            NVARCHAR(2)                                  NULL,
    [CustomerTaxClassification6]            NVARCHAR(2)                                  NULL,
    [CustomerTaxClassification7]            NVARCHAR(2)                                  NULL,
    [CustomerTaxClassification8]            NVARCHAR(2)                                  NULL,
    [CustomerTaxClassification9]            NVARCHAR(2)                                  NULL,
    [SDPricingProcedure]                    NVARCHAR(12)                                 NULL,
    [NetAmount]                             DECIMAL(19, 6)                               NULL,
    [TransactionCurrencyID]                 CHAR(5) collate Latin1_General_100_BIN2      NULL,
    [GrossAmount]                           DECIMAL(19, 6)                               NULL,
    [PricingDate]                           DATE                                         NULL,
    [PriceDetnExchangeRate]                 DECIMAL(9, 5)                                NULL,
    [PricingScaleQuantityInBaseUnit]        DECIMAL(13, 3)                               NULL,
    [TaxAmount]                             DECIMAL(19, 6)                               NULL,
    [CostAmount]                            DECIMAL(19, 6)                               NULL,
    [Subtotal1Amount]                       DECIMAL(19, 6)                               NULL,
    [Subtotal2Amount]                       DECIMAL(19, 6)                               NULL,
    [Subtotal3Amount]                       DECIMAL(19, 6)                               NULL,
    [Subtotal4Amount]                       DECIMAL(19, 6)                               NULL,
    [Subtotal5Amount]                       DECIMAL(19, 6)                               NULL,
    [Subtotal6Amount]                       DECIMAL(19, 6)                               NULL,
    [StatisticalValueControl]               NVARCHAR(2)                                  NULL,
    [StatisticsExchangeRate]                DECIMAL(9, 5)                                NULL,
    [StatisticsCurrency]                    CHAR(5) collate Latin1_General_100_BIN2      NULL,
    [SalesOrganizationCurrency]             CHAR(5) collate Latin1_General_100_BIN2      NULL,
    [EligibleAmountForCashDiscount]         DECIMAL(19, 6)                               NULL,
    [ContractAccount]                       NVARCHAR(24)                                 NULL,
    [CustomerPaymentTerms]                  NVARCHAR(8)                                  NULL,
    [PaymentMethod]                         NVARCHAR(2)                                  NULL,
    [PaymentReference]                      NVARCHAR(60)                                 NULL,
    [FixedValueDate]                        DATE                                         NULL,
    [AdditionalValueDays]                   CHAR(2) collate Latin1_General_100_BIN2      NULL,
    [PayerParty]                            NVARCHAR(20)                                 NULL,
    [CompanyCode]                           NVARCHAR(8)                                  NULL,
    [FiscalYear]                            CHAR(4) collate Latin1_General_100_BIN2      NULL,
    [FiscalPeriod]                          CHAR(3) collate Latin1_General_100_BIN2      NULL,
    [CustomerAccountAssignmentGroupID]      NVARCHAR(4)                                  NULL,
    [BusinessArea]                          NVARCHAR(8)                                  NULL,
    [ProfitCenter]                          NVARCHAR(20)                                 NULL,
    [OrderID]                               NVARCHAR(24)                                 NULL,
    [ControllingArea]                       NVARCHAR(8)                                  NULL,
    [ProfitabilitySegment]                  CHAR(10) collate Latin1_General_100_BIN2     NULL,
    [CostCenter]                            NVARCHAR(20)                                 NULL,
    [OriginSDDocument]                      NVARCHAR(20)                                 NULL,
    [OriginSDDocumentItem]                  CHAR(6) collate Latin1_General_100_BIN2      NULL,
    [PriceDetnExchangeRateDate]             DATE                                         NULL,
    [ExchangeRateTypeID]                    NVARCHAR(8)                                  NULL,
    [FiscalYearVariant]                     NVARCHAR(4)                                  NULL,
    [CompanyCodeCurrencyID]                 CHAR(5) collate Latin1_General_100_BIN2      NULL,
    [AccountingExchangeRate]                DECIMAL(9, 5)                                NULL,
    [AccountingExchangeRateIsSet]           NVARCHAR(2)                                  NULL,
    [ReferenceSDDocument]                   NVARCHAR(20)                                 NULL,
    [ReferenceSDDocumentItem]               CHAR(6) collate Latin1_General_100_BIN2      NULL,
    [ReferenceSDDocumentCategoryID]         NVARCHAR(8)                                  NULL,
    [SalesDocumentID]                       NVARCHAR(20)                                 NULL,
    [SalesDocumentItemID]                   CHAR(6) collate Latin1_General_100_BIN2      NULL,
    [SalesSDDocumentCategoryID]             NVARCHAR(8)                                  NULL,
    [HigherLevelItem]                       CHAR(6) collate Latin1_General_100_BIN2      NULL,
    [BillingDocumentItemInPartSgmt]         CHAR(6) collate Latin1_General_100_BIN2      NULL,
    [SalesGroup]                            NVARCHAR(6)                                  NULL,
    [AdditionalCustomerGroup1]              NVARCHAR(6)                                  NULL,
    [AdditionalCustomerGroup2]              NVARCHAR(6)                                  NULL,
    [AdditionalCustomerGroup3]              NVARCHAR(6)                                  NULL,
    [AdditionalCustomerGroup4]              NVARCHAR(6)                                  NULL,
    [AdditionalCustomerGroup5]              NVARCHAR(6)                                  NULL,
    [SDDocumentReasonID]                    NVARCHAR(6)                                  NULL,
    [ItemIsRelevantForCredit]               NVARCHAR(2)                                  NULL,
    [CreditRelatedPrice]                    DECIMAL(11, 2)                               NULL,
    [SalesDistrictID]                       NVARCHAR(12)                                 NULL,
    [CustomerGroupID]                       NVARCHAR(4)                                  NULL,
    [SoldToParty]                           NVARCHAR(20)                                 NULL,
    [CountryID]                             NVARCHAR(6)                                  NULL,
    [ShipToParty]                           NVARCHAR(20)                                 NULL,
    [BillToParty]                           NVARCHAR(20)                                 NULL,
    [ShippingPoint]                         NVARCHAR(8)                                  NULL,
    [IncotermsVersion]                      NVARCHAR(8)                                  NULL,
    [IncotermsClassification]               NVARCHAR(6)                                  NULL,
    [IncotermsTransferLocation]             NVARCHAR(56)                                 NULL,
    [IncotermsLocation1]                    NVARCHAR(140)                                NULL,
    [IncotermsLocation2]                    NVARCHAR(140)                                NULL,
    [ShippingCondition]                     NVARCHAR(4)                                  NULL,
    [QuantitySold]                          DECIMAL(15, 3)                               NULL,
    [GrossMargin]                           DECIMAL(19, 6)                               NULL,
    [ExternalSalesAgentID]                  NVARCHAR(20)                                 NULL,
    [ExternalSalesAgent]                    NVARCHAR(160)                                NULL,
    [ProjectID]                             NVARCHAR(20)                                 NULL,
    [Project]                               NVARCHAR(160)                                NULL,
    [SalesEmployeeID]                       NVARCHAR(20) collate Latin1_General_100_BIN2 NULL,
    [SalesEmployee]                         NVARCHAR(160)                                NULL,
    [GlobalParentID]                        NVARCHAR(20)                                 NULL,
    [GlobalParent]                          NVARCHAR(160)                                NULL,
    [GlobalParentCalculatedID]              NVARCHAR(20)                                 NULL,
    [GlobalParentCalculated]                NVARCHAR(160)                                NULL,
    [LocalParentID]                         NVARCHAR(20)                                 NULL,
    [LocalParent]                           NVARCHAR(160)                                NULL,
    [LocalParentCalculatedID]               NVARCHAR(20)                                 NULL,
    [LocalParentCalculated]                 NVARCHAR(160)                                NULL,
    [SalesOrderTypeID]                      NVARCHAR(4)                                  NULL,
    [BillToID]                              NVARCHAR(20)                                 NULL,
    [BillTo]                                NVARCHAR(160)                                NULL,
    [FinNetAmountRealProduct]               DECIMAL(19, 6)                               NULL,
    [FinNetAmountFreight]                   DECIMAL(19, 6)                               NULL,
    [FinNetAmountMinQty]                    DECIMAL(19, 6)                               NULL,
    [FinNetAmountEngServ]                   DECIMAL(19, 6)                               NULL,
    [FinNetAmountMisc]                      DECIMAL(19, 6)                               NULL,
    [FinNetAmountServOther]                 DECIMAL(19, 6)                               NULL,
    [FinNetAmountVerp]                      DECIMAL(19, 6)                               NULL,
    [FinRebateAccrual]                      DECIMAL(19, 6)                               NULL,
    [PaymentTermCashDiscountPercentageRate] DECIMAL(5, 3)                                NULL,
    [FinNetAmountOtherSales]                DECIMAL(19, 6)                               NULL,
    [FinReserveCashDiscount]                DECIMAL(19, 6)                               NULL,
    [FinNetAmountAllowances]                DECIMAL(19, 6)                               NULL,
    [FinSales100]                           DECIMAL(19, 6)                               NULL,
    [AccountingDate]                        DATETIME,
    [axbi_DataAreaID]                       NVARCHAR (8)                                 NULL,
    [axbi_DataAreaName]                     NVARCHAR (50)                                NULL,
    [axbi_DataAreaGroup]                    NVARCHAR (8)                                 NULL,
    [axbi_MaterialID]                       NVARCHAR (100)                               NULL,
    [axbi_CustomerID]                       NVARCHAR (100)                               NULL,
    [MaterialCalculated]                    NVARCHAR(80)                                 NULL,
    [SoldToPartyCalculated]                 NVARCHAR(100)                                NULL,
    [InOutID]                               CHAR(1) collate Latin1_General_100_BIN2      NULL,
    [axbi_ItemNoCalc]                       NVARCHAR(108)                                NULL,
    [t_applicationId]                       VARCHAR(32),
    [t_extractionDtm]                       DATETIME,
    [t_jobId]                               VARCHAR(36),
    [t_jobDtm]                              DATETIME,
    [t_lastActionCd]                        VARCHAR(1),    
    [t_jobBy]                               NVARCHAR(128),
    CONSTRAINT [PK_fact_BillingDocumentItem_axbi] PRIMARY KEY NONCLUSTERED ([BillingDocument], [BillingDocumentItem], [CurrencyTypeID]) NOT ENFORCED
) WITH
      (
      DISTRIBUTION = HASH (BillingDocument), CLUSTERED COLUMNSTORE INDEX
)