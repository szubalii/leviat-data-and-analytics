-- =============================================
-- Schema         : base_s4h_cax
-- CDS View       : I_TransportationOrder
-- System Version : SAP S/4HANA 2022, SP 0001
-- Description    : Data from table ITRANSPORDER
-- Source:        : S/4HANA
-- Extraction_Mode: Full
-- Source Type    : Table
-- Source Name    : CADCLNT200

-- =============================================

CREATE TABLE [base_s4h_cax].[I_TransportationOrder] (
    
    [MANDT] CHAR(3) NOT NULL  -- Client
  , [TransportationOrderUUID] BINARY(16) NOT NULL  -- Transportation Order UUID
  , [TransportationOrder] NVARCHAR(20)  -- Document
  , [TransportationOrderCategory] NVARCHAR(2)  -- Business Document Category
  , [TransportationOrderType] NVARCHAR(4)  -- Business Document Type
  , [DangerousGoodsAreContained] NVARCHAR(1)  -- Dangerous Goods
  , [TransportationServiceLevel] NVARCHAR(2)  -- Transportation Service Level - Carrier
  , [TranspOrdResponsiblePerson] NVARCHAR(12)  -- Person Responsible
  , [TranspOrdPartnerReference] NVARCHAR(35)  -- Partner Reference Number
  , [MasterBillOfLading] NVARCHAR(35)  -- Carrier's Master Bill of Lading Number
  , [TranspOrdPlanningBlock] NVARCHAR(1)  -- Planning Block
  , [TranspOrdExecutionIsBlocked] NVARCHAR(1)  -- Execution Block
  , [InvoicingIsBlocked] NVARCHAR(1)  -- Freight Settlement Document Block
  , [CarrierUUID] BINARY(16)  -- Business Partner GUID
  , [Carrier] NVARCHAR(10)  -- Carrier
  , [StandardCarrierAlphaCode] NVARCHAR(4)  -- Standard Carrier Alpha Code
  , [TranspOrdAirlineIATACode] NVARCHAR(3)  -- IATA Airline Code
  , [TranspOrdAirWayBill] NVARCHAR(3)  -- Air Waybill Prefix
  , [CarrierAddressID] NVARCHAR(40)  -- Unique Identifier for Address (APC_V_ADDRESS_ID)
  , [CarrierOriginOfEntry] NVARCHAR(2)  -- Origin of Entry
  , [ShipperUUID] BINARY(16)  -- Business Partner GUID
  , [Shipper] NVARCHAR(10)  -- Shipper
  , [ShipperAddressID] NVARCHAR(40)  -- Unique Identifier for Address (APC_V_ADDRESS_ID)
  , [ConsigneeUUID] BINARY(16)  -- Business Partner GUID
  , [Consignee] NVARCHAR(10)  -- Ship-to Party
  , [ConsigneeAddressID] NVARCHAR(40)  -- Unique Identifier for Address (APC_V_ADDRESS_ID)
  , [TranspOrdShippingType] NVARCHAR(3)  -- Shipping Type
  , [MovementType] NVARCHAR(3)  -- Movement Type
  , [TranspOrdTrafficDirection] NVARCHAR(3)  -- Traffic Direction
  , [PlngAndExecOrganization] CHAR(8)  -- Planning and Execution Organization
  , [PlngAndExecGroup] CHAR(8)  -- Planning and Execution Group
  , [PurchasingOrganization] CHAR(8)  -- Purchasing Organization
  , [PurchasingOrgExternalID] NVARCHAR(20)  -- Organizational Unit: External ID
  , [PurchasingGroup] CHAR(8)  -- Purchasing Group
  , [PurchasingGroupExternalID] NVARCHAR(20)  -- Organizational Unit: External ID
  , [PurgOrgCompanyCode] NVARCHAR(4)  -- Company Code Procuring the Transportation Service
  , [TranspOrdLifeCycleStatus] NVARCHAR(2)  -- Life Cycle Status
  , [TranspOrdPlanningStatus] NVARCHAR(2)  -- Planning Status
  , [TransportationOrderExecSts] NVARCHAR(2)  -- Execution Status
  , [TranspOrderDngrsGdsSts] NVARCHAR(1)  -- Dangerous Goods Status
  , [TransportationOrderConfSts] NVARCHAR(2)  -- Confirmation Status
  , [TranspOrderSubcontrgSts] NVARCHAR(2)  -- Subcontracting Status
  , [MeansOfTransport] NVARCHAR(10)  -- Means of Transport
  , [TransportationMode] NVARCHAR(2)  -- Transportation Mode
  , [TransportationModeCategory] NVARCHAR(1)  -- Transportation Mode Category
  , [TranspOrdMaxUtilznRatio] DECIMAL(16,2)  -- Maximum Utilization
  , [TransportationRequestCategory] NVARCHAR(2)  -- Category (Forwarding Order/Quotation or Trsp. Reqt)
  , [FrtDsputCaseStatus] NVARCHAR(2)  -- Dispute Case Status
  , [TranspOrdMaxUtilznMassRatio] DECIMAL(16,2)  -- Transportation Order Max Utilization Mass Ratio
  , [TranspOrdMaxUtilznVolumeRatio] DECIMAL(16,2)  -- Transportation Order Max Utilization Volume Ratio
  , [TranspOrdMaxUtilznLengthRatio] DECIMAL(16,2)  -- Transportation Order Maximum Utilization Length Ratio
  , [TranspOrdGrossWeight] DECIMAL(31,14)  -- Gross Weight
  , [TranspOrdGrossWeightUnit] NVARCHAR(3)  -- Gross Weight Unit of Measure
  , [TranspOrdGrossVolume] DECIMAL(31,14)  -- Gross Volume
  , [TranspOrdGrossVolumeUnit] NVARCHAR(3)  -- Gross Volume Unit of Measure
  , [TranspOrdNetWeight] DECIMAL(31,14)  -- Net Weight
  , [TranspOrdNetWeightUnit] NVARCHAR(3)  -- Net Weight Unit of Measure
  , [TranspOrdQuantity] DECIMAL(31,14)  -- Quantity
  , [TranspOrdQuantityUnit] NVARCHAR(3)  -- Quantity Unit of Measure
  , [TranspOrdAlternativeQty] DECIMAL(31,14)  -- Alternative Quantity
  , [TranspOrdAlternativeQtyUnit] NVARCHAR(3)  -- Alternative Quantity 2 Unit of Measure
  , [TranspOrdBaseQuantity] DECIMAL(31,14)  -- Base Quantity
  , [TranspOrdBaseQuantityUnit] NVARCHAR(3)  -- Base Unit of Measure
  , [TranspOrdTareWeight] DECIMAL(31,14)  -- Tare Weight
  , [TranspOrdTareWeightUnit] NVARCHAR(3)  -- Tare Weight Unit of Measure
  , [TranspOrdNumberOfCtns] DECIMAL(31,14)  -- Number of Twenty-Foot Equivalent Units
  , [TranspOrdNumberOfCtnsUnit] NVARCHAR(3)  -- Number of TEU Unit of Measure
  , [TranspOrdDngrsGdsExmpPts] DECIMAL(31,14)  -- ADR 1.1.3.6 DG Exemption Points
  , [TranspOrdDngrsGdsExmpPtsUnit] NVARCHAR(3)  -- Unit of Measure for ADR 1.1.3.6 DG Exemption Points
  , [TranspOrdDistance] DECIMAL(28,6)  -- Total Distance in km
  , [TranspOrdDistanceUnit] NVARCHAR(3)  -- Display Length Unit
  , [TranspOrdNetDuration] DECIMAL(11)  -- Transportation Time of a Transportation Lane (in hhmmss)
  , [TranspOrdNetDurationUnit] NVARCHAR(3)  -- Display Time Unit of Measure
  , [CreatedByUser] NVARCHAR(12)  -- Created By
  , [CreationDateTime] DECIMAL(15)  -- Created on Timestamp
  , [LastChangedByUser] NVARCHAR(12)  -- Changed By
  , [ChangedDateTime] DECIMAL(15)  -- Created on Timestamp
  , [TranspOrdLfcycStsChgDteTime] DECIMAL(15)  -- Created on Timestamp
  , [TranspOrdOrderDateTime] DECIMAL(15)  -- Created on Timestamp
  , [BusinessTransactionDocument] NVARCHAR(35)  -- Base Business Transaction Document
  , [BusinessTransactionDocType] NVARCHAR(5)  -- Base Document Type for Business Transaction
  , [t_applicationId] VARCHAR (32)  -- Application ID
  , [t_jobId] VARCHAR (36)  -- Job ID
  , [t_jobDtm] DATETIME  -- Job Date Time
  , [t_jobBy] VARCHAR (128)  -- Job executed by
  , [t_extractionDtm] DATETIME  -- Extraction Date Time
  , [t_filePath] NVARCHAR (1024)  -- Filepath
  , CONSTRAINT [PK_I_TransportationOrder] PRIMARY KEY NONCLUSTERED(
      
      [MANDT]
    , [TransportationOrderUUID]
  ) NOT ENFORCED
) WITH (
  HEAP
)
