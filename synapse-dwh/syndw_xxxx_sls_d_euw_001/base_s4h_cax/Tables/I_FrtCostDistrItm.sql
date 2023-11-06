-- =============================================
-- Schema         : base_s4h_cax
-- CDS View       : I_FrtCostDistrItm
-- System Version : SAP S/4HANA 2022, SP 0001
-- Description    : Data from table IFRTCDITM
-- Source:        : S/4HANA
-- Extraction_Mode: Full
-- Source Type    : Table
-- Source Name    : CADCLNT200

-- =============================================

CREATE TABLE [base_s4h_cax].[I_FrtCostDistrItm] (
    
    [MANDT] CHAR(3) NOT NULL  -- Client
  , [FrtCostDistrItemUUID] BINARY(16) NOT NULL  -- NodeID
  , [FrtCostDistrRootUUID] BINARY(16)  -- NodeID
  , [FrtCostDistrItmRefUUID] BINARY(16)  -- NodeID
  , [FrtCostDistrItemAmount] DECIMAL(31,2)
  , [FrtCostDistrItemAmtCrcy] CHAR(5)  -- Currency
  , [FrtCostDistrItmQty] DECIMAL(13,3)  -- Quantity
  , [FrtCostDistrItmQtyUnit] NVARCHAR(3)  -- Base Unit of Measure
  , [TransportationOrderUUID] BINARY(16)  -- NodeID
  , [t_applicationId] VARCHAR (32)  -- Application ID
  , [t_jobId] VARCHAR (36)  -- Job ID
  , [t_jobDtm] DATETIME  -- Job Date Time
  , [t_jobBy] VARCHAR (128)  -- Job executed by
  , [t_extractionDtm] DATETIME  -- Extraction Date Time
  , [t_filePath] NVARCHAR (1024)  -- Filepath
  , CONSTRAINT [PK_I_FrtCostDistrItm] PRIMARY KEY NONCLUSTERED(
      
      [MANDT]
    , [FrtCostDistrItemUUID]
  ) NOT ENFORCED
) WITH (
  HEAP
)
