CREATE TABLE [base_s4h_cax].[I_Businesspartnersalesarea] (
    
    [MANDT] CHAR(3) NOT NULL  -- Client
  , [SalesOrganization] NVARCHAR(4) NOT NULL  -- Sales Organization
  , [DistributionChannel] NVARCHAR(2) NOT NULL  -- Distribution Channel
  , [Division] NVARCHAR(2) NOT NULL  -- Division
  , [BusinessPartner] NVARCHAR(10) NOT NULL  -- Business Partner Number
  , [BusinessPartnerUUID] BINARY(16)  -- Business Partner GUID
  , [Customer] NVARCHAR(10)  -- Customer Number
  , [CustomerGroup] NVARCHAR(2)  -- Customer Group
  , [SalesOffice] NVARCHAR(4)  -- Sales Office
  , [SalesGroup] NVARCHAR(3)  -- Sales Group
  , [AccountByCustomer] NVARCHAR(12)  -- Shipper's (Our) Account Number at the Customer or Vendor
  , [CustomerABCClassification] NVARCHAR(2)  -- Customer classification (ABC analysis)
  , [Currency] CHAR(5)  -- Currency
  , [CustomerPriceGroup] NVARCHAR(2)  -- Customer Price Group
  , [CustomerPricingProcedure] NVARCHAR(2)  -- Customer Classification for Pricing Procedure Determination
  , [DeliveryPriority] CHAR(2)  -- Delivery Priority
  , [OrderCombinationIsAllowed] NVARCHAR(1)  -- Order Combination Indicator
  , [ShippingCondition] NVARCHAR(2)  -- Shipping Conditions
  , [SupplyingPlant] NVARCHAR(4)  -- Delivering Plant (Own or External)
  , [DeliveryIsBlockedForCustomer] NVARCHAR(2)  -- Customer delivery block (sales area)
  , [BillingIsBlockedForCustomer] NVARCHAR(2)  -- Billing block for customer (sales and distribution)
  , [CompleteDeliveryIsDefined] NVARCHAR(1)  -- Complete Delivery Defined for Each Sales Order?
  , [PartialDeliveryIsAllowed] NVARCHAR(1)  -- Partial delivery at item level
  , [InvoiceDate] NVARCHAR(2)  -- Invoice Dates (Calendar Identification)
  , [IncotermsClassification] NVARCHAR(3)  -- Incoterms (Part 1)
  , [IncotermsTransferLocation] NVARCHAR(28)  -- Incoterms (Part 2)
  , [CustomerPaymentTerms] NVARCHAR(4)  -- Terms of Payment Key
  , [CustomerAccountAssignmentGroup] NVARCHAR(2)  -- Account Assignment Group for Customer
  , [SalesDistrict] NVARCHAR(6)  -- Sales District
  , [OrderIsBlockedForCustomer] NVARCHAR(2)  -- Customer order block (sales area)
  , [PriceListType] NVARCHAR(2)  -- Price List Type
  , [IncotermsVersion] NVARCHAR(4)  -- Incoterms Version
  , [IncotermsLocation1] NVARCHAR(70)  -- Incoterms Location 1
  , [IncotermsLocation2] NVARCHAR(70)  -- Incoterms Location 2
  , [AuthorizationGroup] NVARCHAR(4)  -- Authorization Group
  , [PaymentGuaranteeProcedure] NVARCHAR(4)  -- Customer payment guarantee procedure
  , [IsActiveEntity] NVARCHAR(1)  -- Draft - Indicator - Is active document
  , [IsBusinessPurposeCompleted] NVARCHAR(1)  -- Business Purpose Completed Flag
  , [InvoiceListSchedule] NVARCHAR(2)  -- Invoice List Schedule (calendar identification)
  , [ExchangeRateType] NVARCHAR(4)  -- Exchange Rate Type
  , [ItemOrderProbabilityInPercent] CHAR(3)  -- Order Probability of the Item
  , [AdditionalCustomerGroup1] NVARCHAR(3)  -- Expt MinVal Surcharge
  , [AdditionalCustomerGroup2] NVARCHAR(3)  -- Print net price only
  , [AdditionalCustomerGroup3] NVARCHAR(3)  -- Freight Rate
  , [AdditionalCustomerGroup4] NVARCHAR(3)  -- Freight prepaid limt
  , [AdditionalCustomerGroup5] NVARCHAR(3)  -- Customer Group 5
  , [UnderdelivTolrtdLmtRatioInPct] DECIMAL(3,1)  -- Underdelivery Tolerance
  , [OverdelivTolrtdLmtRatioInPct] DECIMAL(3,1)  -- Overdelivery Tolerance
  , [MaxNmbrOfPartialDelivery] DECIMAL(1)  -- Maximum Number of Partial Deliveries Allowed Per Item
  , [SuplrIsRlvtForSettlmtMgmt] NVARCHAR(1)  -- Indicator: Relevant for Settlement Management
  , [ProductUnitGroup] NVARCHAR(4)  -- Unit of Measure Group
  , [SlsDocIsRlvtForProofOfDeliv] NVARCHAR(1)  -- Relevant for POD processing
  , [SlsUnlmtdOvrdelivIsAllwd] NVARCHAR(1)  -- Unlimited Overdelivery Allowed
  , [CreditControlArea] NVARCHAR(4)  -- Credit Control Area
  , [CustomerIsRebateRelevant] NVARCHAR(1)  -- Indicator: Customer Is Rebate-Relevant
  , [InspSbstHasNoTimeOrQuantity] NVARCHAR(1)  -- Relevant for price determination ID
  , [ManualInvoiceMaintIsRelevant] NVARCHAR(1)  -- Manual Invoice Maintenance
  , [SalesItemProposal] NVARCHAR(10)  -- Item proposal
  , [CustProdProposalProcedure] NVARCHAR(2)  -- Customer procedure for product proposal
  , [ProofOfDeliveryTime] TIME(6)
  , [IncotermsSupChnLoc2AddlUUID] BINARY(16)  -- Location UUID
  , [IncotermsSupChnLoc1AddlUUID] BINARY(16)  -- Location UUID
  , [IncotermsSupChnDvtgLocAddlUUID] BINARY(16)  -- Location UUID
  , [t_applicationId] VARCHAR (32)  -- Application ID
  , [t_jobId] VARCHAR (36)  -- Job ID
  , [t_jobDtm] DATETIME  -- Job Date Time
  , [t_jobBy] VARCHAR (128)  -- Job executed by
  , [t_extractionDtm] DATETIME  -- Extraction Date Time
  , [t_filePath] NVARCHAR (1024)  -- Filepath
  , CONSTRAINT [PK_I_Businesspartnersalesarea] PRIMARY KEY NONCLUSTERED(
      
      [MANDT]
    , [SalesOrganization]
    , [DistributionChannel]
    , [Division]
    , [BusinessPartner]
  ) NOT ENFORCED
) WITH (
  HEAP
)