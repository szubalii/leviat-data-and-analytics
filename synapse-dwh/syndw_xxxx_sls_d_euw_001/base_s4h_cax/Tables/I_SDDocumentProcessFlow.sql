-- =============================================
-- Schema         : base_s4h_cax
-- CDS View       : I_SDDocumentProcessFlow
-- System Version : SAP S/4HANA 1909, SP 0002
-- Description    : Data from table ISDDOCPROCFLOW
-- Source:        : S/4HANA
-- Extraction_Mode: Full
-- Source Type    : Table
-- Source Name    : CAACLNT200

-- =============================================

CREATE TABLE [base_s4h_cax].[I_SDDocumentProcessFlow] (
    
    [MANDT] CHAR(3) NOT NULL  -- Client
  , [DOCRELATIONSHIPUUID] BINARY(16) NOT NULL  -- SD Unique Document Relationship Identification
  , [PrecedingDocument] NVARCHAR(10)  -- Preceding sales and distribution document
  , [PrecedingDocumentItem] CHAR(6)  -- Preceding Item of an SD Document
  , [PrecedingDocumentCategory] NVARCHAR(4)  -- Document Category of Preceding SD Document
  , [SubsequentDocument] NVARCHAR(10)  -- Subsequent Sales and Distribution Document
  , [SubsequentDocumentItem] CHAR(6)  -- Subsequent Item of an SD Document
  , [SubsequentDocumentCategory] NVARCHAR(4)  -- Document Category of Subsequent Document
  , [ProcessFlowLevel] CHAR(2)  -- Level of the document flow record
  , [CreationDate] DATE  -- Date on which the record was created
  , [CreationTime] TIME(6)  -- Entry time
  , [LastChangeDate] DATE  -- Date of Last Change
  , [QuantityInBaseUnit] DECIMAL(15,3)  -- Referenced quantity in base unit of measure
  , [RefQuantityInOrdQtyUnitAsFloat] FLOAT  -- Referenced quantity in sales unit (float)
  , [RefQuantityInBaseUnitAsFloat] FLOAT  -- Referenced quantity in base unit of measure (float)
  , [BaseUnit] NVARCHAR(3)  -- Base Unit of Measure
  , [OrderQuantityUnit] NVARCHAR(3)  -- Sales unit
  , [SDFulfillmentCalculationRule] NVARCHAR(1)  -- Quantity is calculated positively, negatively or not at all
  , [NetAmount] DECIMAL(15,2)  -- Reference Value
  , [StatisticsCurrency] CHAR(5)  -- Statistics currency
  , [TransferOrderInWrhsMgmtIsConfd] NVARCHAR(1)  -- ID: MM-WM Transfer Order Confirmed
  , [WarehouseNumber] NVARCHAR(3)  -- Warehouse Number / Warehouse Complex
  , [MaterialDocumentYear] CHAR(4)  -- Material Document Year
  , [BillingPlan] NVARCHAR(10)  -- Billing plan number / invoicing plan number
  , [BillingPlanItem] CHAR(6)  -- Item for billing plan/invoice plan/payment cards
  , [t_applicationId] VARCHAR (32)  -- Application ID
  , [t_jobId] VARCHAR (36)  -- Job ID
  , [t_jobDtm] DATETIME  -- Job Date Time
  , [t_jobBy] VARCHAR (128)  -- Job executed by
  , [t_extractionDtm] DATETIME  -- Extraction Date Time
  , [t_filePath] NVARCHAR (1024)  -- Filepath
  , CONSTRAINT [PK_I_SDDocumentProcessFlow] PRIMARY KEY NONCLUSTERED(
      
      [MANDT]
    , [DOCRELATIONSHIPUUID]
  ) NOT ENFORCED
) WITH (
  HEAP
)
