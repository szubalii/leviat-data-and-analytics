-- =============================================
-- Schema         : base_s4h_cax
-- CDS View       : I_TransportationOrderItem
-- System Version : SAP S/4HANA 2022, SP 0001
-- Description    : Data from table ITORITEM
-- Source:        : S/4HANA
-- Extraction_Mode: Full
-- Source Type    : Table
-- Source Name    : CADCLNT200

-- =============================================

CREATE TABLE [base_s4h_cax].[I_TransportationOrderItem] (
    
    [MANDT] CHAR(3) NOT NULL  -- Client
   ,[TransportationOrderItemUUID] BINARY(16) NOT NULL  -- UUID of Transportation Order Item with Conversion Exit
  --, [TransportationOrderUUID] BINARY(16)  -- Transportation Order UUID
  --, [TranspOrdItem] NVARCHAR(10)  -- Item
  --, [TranspOrdItemType] NVARCHAR(4)  -- Transportation Order Item Type
  --, [IsMultiItem] NVARCHAR(1)  -- Multi-Item
  --, [TranspOrdItemParentItemUUID] BINARY(16)  -- Key of Transportation Order Item
  --, [SourceStopUUID] BINARY(16)  -- Key of a Stop of a Transportation Order
  --, [DestinationStopUUID] BINARY(16)  -- Key of a Stop of a Transportation Order
  --, [TranspOrdItemDesc] NVARCHAR(40)  -- Item Description
  --, [TranspOrdItemCategory] NVARCHAR(3)  -- Item Category
  --, [IsMainCargoItem] NVARCHAR(1)  -- Main Cargo Item
  --, [PredecessorTransportationOrder] BINARY(16)  -- NodeID
  --, [Shipper] NVARCHAR(10)  -- Shipper
  --, [Consignee] NVARCHAR(10)  -- Ship-to Party
  --, [TransportationMode] NVARCHAR(2)  -- Transportation Mode
  --, [TransportationModeCategory] NVARCHAR(1)  -- Transportation Mode Category
  --, [MeansOfTransport] NVARCHAR(10)  -- Means of Transport
  --, [TranspOrdActvVehRscePltNmbr] NVARCHAR(20)  -- Registration Number
  --, [TranspOrdItemGrossWeight] DECIMAL(31,14)  -- Transportation Order Item Gross Weight
  --, [TranspOrdItemGrossWeightUnit] NVARCHAR(3)  -- Transportation Order Item Gross Weight Unit
  --, [TranspOrdItemGrossVolume] DECIMAL(31,14)  -- Transp Order Item Gross Volume
  --, [TranspOrdItemGrossVolumeUnit] NVARCHAR(3)  -- Transportation Order Item Gross Volume Unit
  --, [TranspOrdItemNetWeight] DECIMAL(31,14)  -- Transportation Order Item Net Weight
  --, [TranspOrdItemNetWeightUnit] NVARCHAR(3)  -- Transportation Order Item Net Weight Unit
  --, [TranspOrdItemQuantity] DECIMAL(31,14)  -- Transportation Order Item Quantity
  --, [TranspOrdItemQuantityUnit] NVARCHAR(3)  -- Transportation Order Item Quantity Unit
  --, [TranspOrdItemAltvQty] DECIMAL(31,14)  -- Transportation Order Item Alternative Quantity
  --, [TranspOrdItemAltvQtyUnit] NVARCHAR(3)  -- Transportation Order Item Alternative Quantity Unit
  --, [TranspOrdItemBaseQty] DECIMAL(31,14)  -- Transportation Order Item Base Quantity
  --, [TranspOrdItemBaseQtyUnit] NVARCHAR(3)  -- Transp Orde Item Base Quantity UoM
  --, [TranspOrdItemTareWeight] DECIMAL(31,14)  -- Transportation Order Item Tare Weight
  --, [TranspOrdItemTareWeightUnit] NVARCHAR(3)  -- Transportation Order Item Tare Weight Unit
  --, [TranspOrdItemNumberOfCtns] DECIMAL(31,14)  -- Transportation Order Item Number Of Containers
  --, [TranspOrdItemNumberOfCtnsUnit] NVARCHAR(3)  -- Transportation Order Item Number Of Containers Unit
  --, [TranspOrdItemLength] DECIMAL(13,3)  -- Length
  --, [TranspOrdItemWidth] DECIMAL(13,3)  -- Width
  --, [TranspOrdItemHeight] DECIMAL(13,3)  -- Height
  --, [TranspOrdItemLengthUnit] NVARCHAR(3)  -- Unit of measure for length, width and height
  --, [TranspOrdItemGoodsValue] DECIMAL(31,2)
  --, [TranspOrdItemGoodsValueCrcy] CHAR(5)  -- Goods Value Currency
  --, [TranspOrdItemIsDangerousGood] NVARCHAR(1)  -- Dangerous Goods
  --, [TranspOrdItemDngrsGdsSts] NVARCHAR(1)  -- Dangerous Goods Status
  --, [MaterialFreightGroup] NVARCHAR(8)  -- Material freight group
  --, [MaterialFreightGroupName] NVARCHAR(20)  -- Description
  --, [TransportationGroup] NVARCHAR(4)  -- Transportation Group
  --, [TransportationGroupName] NVARCHAR(20)  -- Description
  --, [ProductID] NVARCHAR(40)  -- Product
  --, [ProductName] NVARCHAR(40)  -- Product Description
  , [TranspOrdDocReferenceID] NVARCHAR(35)  -- Base Business Transaction Document
  , [TranspOrdDocReferenceItmID] NVARCHAR(10)  -- Base Document Item for Business Transaction
  --, [TranspOrdDocReferenceType] NVARCHAR(5)  -- Base Document Type for Business Transaction
  --, [TranspOrdDocReferenceItmType] NVARCHAR(5)  -- Base Document Item Type Code for Business Transaction
  --, [TranspOrdItemSorting] NVARCHAR(6)  -- Sorting ID of Business Document Item
  --, [ShipperUUID] BINARY(16)  -- Shipper Universally Unique Identifier
  --, [ConsigneeAddressID] NVARCHAR(40)  -- Unique Identifier for Address (APC_V_ADDRESS_ID)
  --, [ConsigneeUUID] BINARY(16)  -- Ship-to Party UUID
  --, [ProductUUID] BINARY(16)  -- Product GUID
  --, [IncotermsClassification] NVARCHAR(3)  -- Incoterm
  --, [TranspOrdItemVoyage] NVARCHAR(10)  -- Voyage / Train Number
  --, [TranspOrdItemFlight] NVARCHAR(6)  -- Airline Code and Flight Number
  --, [TranspOrdItemVessel] NVARCHAR(35)  -- Vessel
  --, [TranspOrdItemIMOShip] NVARCHAR(11)  -- IMO Ship Identification Number
  --, [TranspOrdFlightNumber] NVARCHAR(5)  -- Flight Number (Numerical)
  --, [TranspOrdBookingConfSts] NVARCHAR(1)  -- Booking Confirmation Status
  --, [CargoIsHighValue] NVARCHAR(1)  -- High-Value Cargo
  --, [Plant] NVARCHAR(4)  -- Plant
  --, [TranspOrdItmWhseNmbr] NVARCHAR(4)  -- Warehouse Number
  --, [TranspOrdShippingCondition] NVARCHAR(2)  -- Transportation Service Level - Sales
  , [t_applicationId] VARCHAR (32)  -- Application ID
  , [t_jobId] VARCHAR (36)  -- Job ID
  , [t_jobDtm] DATETIME  -- Job Date Time
  , [t_jobBy] VARCHAR (128)  -- Job executed by
  , [t_extractionDtm] DATETIME  -- Extraction Date Time
  , [t_filePath] NVARCHAR (1024)  -- Filepath
  , CONSTRAINT [PK_I_TransportationOrderItem] PRIMARY KEY NONCLUSTERED(
      
    [MANDT]
    , [TransportationOrderItemUUID]
  ) NOT ENFORCED
) WITH (
  HEAP
)
