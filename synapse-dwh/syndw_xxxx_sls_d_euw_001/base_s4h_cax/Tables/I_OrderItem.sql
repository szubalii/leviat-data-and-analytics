CREATE TABLE [base_s4h_cax].[I_OrderItem] (
    
    [MANDT] CHAR(3) NOT NULL  -- Client
  , [OrderID] NVARCHAR(12) NOT NULL  -- Order Number
  , [OrderItem] CHAR(4) NOT NULL  -- Order Item
  , [OrderCategory] CHAR(2)  -- Order Category
  , [OrderType] NVARCHAR(4)  -- Order Type
  , [IsMarkedForDeletion] NVARCHAR(1)  -- Deletion Flag
  , [OrderIsReleased] NVARCHAR(1)
  , [OrderItemIsNotRelevantForMRP] NVARCHAR(1)  -- Indicator: Order Item is not Relevant for MRP
  , [Material] NVARCHAR(40)  -- Material Number for Order
  , [ProductionPlant] NVARCHAR(4)  -- Production Plant in Planned Order
  , [MRPPlant] NVARCHAR(4)  -- Planning Plant for an Order
  , [ProductionVersion] NVARCHAR(4)  -- Production Version
  , [MRPArea] NVARCHAR(10)  -- MRP Area
  , [SalesOrder] NVARCHAR(10)  -- Sales Order
  , [SalesOrderItem] CHAR(6)  -- Sales Order Item
  , [WBSElementInternalID] CHAR(24)  -- Work Breakdown Structure Element Internal ID
  , [QuotaArrangement] NVARCHAR(10)  -- Quota Arrangement
  , [QuotaArrangementItem] CHAR(3)  -- Quota Arrangement Item
  , [SettlementReservation] CHAR(10)  -- Settlement Reservation
  , [SettlementReservationItem] CHAR(4)  -- Settlement Reservation Item
  , [CoProductReservation] CHAR(10)  -- Co-Prodcut Reservation
  , [CoProductReservationItem] CHAR(4)  -- Co-Prodcut Reservation Item
  , [MaterialProcurementCategory] NVARCHAR(1)  -- Material Procurement Category
  , [MaterialProcurementType] NVARCHAR(1)  -- Material Procurement Type
  , [BOMExplosionDateID] NVARCHAR(8)  -- Bill of Material Explosion Date ID
  , [SerialNumberAssgmtProfile] NVARCHAR(4)  -- Serial Number Profile
  , [NumberOfSerialNumbers] INT  -- Number of Serial Numbers
  , [MfgOrderItemReplnmtElmntType] NVARCHAR(1)  -- Kanban Indicator
  , [ProductConfiguration] CHAR(18)  -- Configuration (internal object number)
  , [ObjectInternalID] NVARCHAR(22)  -- Object Internal ID
  , [QuantityDistributionKey] NVARCHAR(4)  -- MRP Distribution Key
  , [EffectivityParameterVariant] NVARCHAR(12)  -- Parameter Variant/Standard Variant
  , [GoodsReceiptIsExpected] NVARCHAR(1)  -- Goods Receipt is Allowed and Expected
  , [GoodsReceiptIsNonValuated] NVARCHAR(1)  -- Goods Receipt is Non-Valuated
  , [MaterialGoodsReceiptDuration] DECIMAL(3)  -- Goods Receipt Processing Duration in Days
  , [UnderdelivTolrtdLmtRatioInPct] DECIMAL(3,1)  -- Underdelivery Tolerance
  , [OverdelivTolrtdLmtRatioInPct] DECIMAL(3,1)  -- Overdelivery Tolerance
  , [UnlimitedOverdeliveryIsAllowed] NVARCHAR(1)  -- Indicator: Unlimited Overdelivery Allowed
  , [IsCompletelyDelivered] NVARCHAR(1)  -- "Delivery Completed" Indicator
  , [StorageLocation] NVARCHAR(4)  -- Storage Location
  , [Batch] NVARCHAR(10)  -- Batch Number
  , [InventoryValuationType] NVARCHAR(10)  -- Inventory Valuation Type
  , [InventoryValuationCategory] NVARCHAR(1)  -- Valuation Category
  , [InventoryUsabilityCode] NVARCHAR(1)  -- Inventory Usability Code
  , [InventorySpecialStockType] NVARCHAR(1)  -- Inventory Special Stock Type
  , [InventorySpecialStockValnType] NVARCHAR(1)  -- Inventory Special Stock Valuation Type
  , [GoodsRecipientName] NVARCHAR(12)  -- Goods Recipient
  , [UnloadingPointName] NVARCHAR(25)  -- Unloading Point
  , [StockSegment] NVARCHAR(40)  -- Stock Segment
  , [PlannedEndDate] DATE  -- Basic finish date
  , [ScheduledBasicEndDate] DATE  -- Scheduled finish
  , [PlannedDeliveryDate] DATE  -- Delivery Date From Planned Order
  , [ActualDeliveryDate] DATE  -- Actual Delivery/Finish Date
  , [TotalCommitmentDate] DATE  -- Total Commitment Date
  , [PlannedOrder] NVARCHAR(10)  -- Planned Order
  , [PlndOrderPlannedStartDate] DATE  -- Planned Order Planned Start Date
  , [PlannedOrderOpeningDate] DATE  -- Opening Date of the Planned Order
  , [BaseUnit] NVARCHAR(3)  -- Base Unit of Measure
  , [OrderPlannedTotalQty] DECIMAL(13,3)  -- Planned Total Order Quantity
  , [OrderPlannedScrapQty] DECIMAL(13,3)  -- Planned Scrap Quantity
  , [MaterialQtyToBaseQtyNmrtr] DECIMAL(5)  -- Numerator for Conversion to Base Units of Measure
  , [MaterialQtyToBaseQtyDnmntr] DECIMAL(5)  -- Denominator for conversion to base units of measure
  , [ProductionUnit] NVARCHAR(3)  -- Production Unit of Measure
  , [ItemQuantity] DECIMAL(13,3)  -- Order Item Planned Total Quantity
  , [MfgOrderItemPlannedScrapQty] DECIMAL(13,3)  -- Order Item Planned Scrap Quantity
  , [MfgOrderItemGoodsReceiptQty] DECIMAL(13,3)  -- Quantity of Goods Received for the Order Item
  , [MfgOrderItemActualDeviationQty] DECIMAL(13,3)  -- Expected Surplus/Deficit For Goods Receipt
  , [MfgOrderItemOpenYieldQty] DECIMAL(16,3)
  , [BusinessArea] NVARCHAR(4)  -- Business Area
  , [CostEstimate] CHAR(12)  -- Cost Estimate Number for Cost Est. w/o Qty Structure
  , [AccountAssignmentCategory] NVARCHAR(1)  -- Account Assignment Category
  , [ConsumptionPosting] NVARCHAR(1)  -- Consumption posting
  , [t_applicationId] VARCHAR (32)  -- Application ID
  , [t_jobId] VARCHAR (36)  -- Job ID
  , [t_jobDtm] DATETIME  -- Job Date Time
  , [t_jobBy] VARCHAR (128)  -- Job executed by
  , [t_extractionDtm] DATETIME  -- Extraction Date Time
  , [t_filePath] NVARCHAR (1024)  -- Filepath
  , CONSTRAINT [PK_I_OrderItem] PRIMARY KEY NONCLUSTERED(
      
      [MANDT]
    , [OrderID]
    , [OrderItem]
  ) NOT ENFORCED
) 
WITH (
  HEAP
)
