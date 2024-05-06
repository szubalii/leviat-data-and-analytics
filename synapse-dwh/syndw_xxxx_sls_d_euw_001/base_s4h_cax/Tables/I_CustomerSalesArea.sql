CREATE TABLE [base_s4h_cax].[I_CustomerSalesArea](
  [MANDT] char(3) collate Latin1_General_100_BIN2 NOT NULL
, [Customer] nvarchar(10) NOT NULL
, [SalesOrganization] nvarchar(4) NOT NULL
, [DistributionChannel] nvarchar(2) NOT NULL
, [Division] nvarchar(2) NOT NULL
, [CustomerABCClassification] nvarchar(2)
, [SalesOffice] nvarchar(4)
, [SalesGroup] nvarchar(3)
, [OrderIsBlockedForCustomer] nvarchar(2)
, [Currency] char(5) collate Latin1_General_100_BIN2
, [CustomerPriceGroup] nvarchar(2)
, [PriceListType] nvarchar(2)
, [DeliveryPriority] char(2) collate Latin1_General_100_BIN2
, [ShippingCondition] nvarchar(2)
, [IncotermsClassification] nvarchar(3)
, [SupplyingPlant] nvarchar(4)
, [CompleteDeliveryIsDefined] nvarchar(1)
, [DeliveryIsBlockedForCustomer] nvarchar(2)
, [BillingIsBlockedForCustomer] nvarchar(2)
, [CustomerPaymentTerms] nvarchar(4)
, [CustomerAccountAssignmentGroup] nvarchar(2)
, [AccountByCustomer] nvarchar(12)
, [CustomerGroup] nvarchar(2)
, [CustomerPricingProcedure] nvarchar(2)
, [OrderCombinationIsAllowed] nvarchar(1)
, [PartialDeliveryIsAllowed] nvarchar(1)
, [InvoiceDate] nvarchar(2)
, [PaymentTerms] nvarchar(4)
, [IncotermsTransferLocation] nvarchar(28)
, [ItemOrderProbabilityInPercent] char(3) collate Latin1_General_100_BIN2
, [IncotermsLocation2] nvarchar(70)
, [AuthorizationGroup] nvarchar(4)
, [SalesDistrict] nvarchar(6)
, [IncotermsVersion] nvarchar(4)
, [IncotermsLocation1] nvarchar(70)
, [DeletionIndicator] nvarchar(1)
, [IsBusinessPurposeCompleted] nvarchar(1)
, [SalesItemProposal] nvarchar(10)
, [MaxNmbrOfPartialDelivery] decimal(1)
, [UnderdelivTolrtdLmtRatioInPct] decimal(3,1)
, [OverdelivTolrtdLmtRatioInPct] decimal(3,1)
, [IsActiveEntity] nvarchar(1)
, [AdditionalCustomerGroup1] nvarchar(3)
, [AdditionalCustomerGroup2] nvarchar(3)
, [AdditionalCustomerGroup3] nvarchar(3)
, [AdditionalCustomerGroup4] nvarchar(3)
, [AdditionalCustomerGroup5] nvarchar(3)
, [SlsDocIsRlvtForProofOfDeliv] nvarchar(1)
, [t_applicationId]       VARCHAR (32)
, [t_jobId]               VARCHAR (36)
, [t_jobDtm]              DATETIME
, [t_jobBy]        		  NVARCHAR (128)
, [t_extractionDtm]		  DATETIME
, [t_filePath]            NVARCHAR (1024)
, CONSTRAINT [PK_I_CustomerSalesArea] PRIMARY KEY NONCLUSTERED (
    [MANDT], [Customer], [SalesOrganization], [DistributionChannel], [Division]
  ) NOT ENFORCED
)
WITH (
  HEAP
)
